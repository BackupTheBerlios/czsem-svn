package czsem.gate.applet;

import gate.Document;
import gate.Factory;
import gate.Gate;
import gate.creole.ResourceInstantiationException;
import gate.mimir.tool.WebUtils;
import gate.util.GateException;
import gate.util.InvalidOffsetException;

import java.awt.Container;
import java.awt.HeadlessException;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ComponentEvent;
import java.awt.event.ComponentListener;
import java.io.IOException;
import java.net.URL;
import java.util.Set;

import javax.swing.JOptionPane;
import javax.swing.JTabbedPane;

import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;

public class MainFrame {

	private DefaultDocumentEditor documentEditor;
	private URL documentUrl;
	private String asName;
	private Container parent;

	public MainFrame(URL documentUrl, String asName, Container parent)
			throws HeadlessException {
		this.documentUrl = documentUrl;
		this.asName = asName;
		this.parent = parent;
	}

	public static void initGate() throws GateException {
		if (Gate.isInitialised()) return;
		
		Logger logger = Logger.getRootLogger();
	    logger.setLevel(Level.OFF);
		BasicConfigurator.configure();

		Gate.runInSandbox(true);
		Gate.init();		
	}
	
	public static Document downloadGateDocument(URL documentUrl) throws ResourceInstantiationException {
		Document doc;
		
		WebUtils wu = new WebUtils();
		
		try {
			doc = (Document) wu.getObject(documentUrl.toString());
			//doc = Factory.newDocument(documentUrl, "utf8");
		} catch (Exception e)
		{
			doc = Factory.newDocument(
					String.format("Requested document could not be initialized.\nurl: %s\nerror message: %s",
							documentUrl.toString(), e.getLocalizedMessage()));
			
		}
		return doc;
	}


	/**
	 * @return null is succeeds
	 */
	public static Exception uploadGateDocuemnt(Document document, URL url) {
		WebUtils wu = new WebUtils();
				
		try {
			wu.postObject(url.toString(), document);
			/*		
			URLConnection conn = url.openConnection();
			conn.setDoOutput(true);
			DocumentHandler.writeGateDocXml(document, conn.getOutputStream());
	
			// Get the response
			BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line;
			while ((line = rd.readLine()) != null) {
				System.err.println(line);
			}
			rd.close();
*/		
		} catch (Exception e)
		{
			return e;
		}
		return null;
	}

	
	
	public void initDocuemtEditor() throws ResourceInstantiationException,
			InvalidOffsetException, IOException {												
				documentEditor = new DefaultDocumentEditor();
			
				Document doc = downloadGateDocument(documentUrl);
				documentEditor.setTarget(doc);
				
				documentEditor.setSize(parent.getSize());
				documentEditor.setPreferredSize(parent.getSize());
				documentEditor.init();
						
				parent.add(new JTabbedPane().add(documentEditor));
				
				parent.addComponentListener(new ComponentListener() {			
					public void componentShown(ComponentEvent e) {
						Set<String> types = documentEditor.getDocument().getAnnotations(asName).getAllTypes();
						for (String annType : types) {
							documentEditor.selectAnnotationType(asName, annType, true);
						}
					
						documentEditor.addSaveButtonListener(new ActionListener() {			
							public void actionPerformed(ActionEvent e) {
								try {
									saveDocuemnt();
								} catch (IOException exception) {
									throw new RuntimeException(exception);
								}
							}
						});
					}			
					public void componentResized(ComponentEvent e) {}			
					public void componentMoved(ComponentEvent e) {}			
					public void componentHidden(ComponentEvent e) {}
				});
				
			}



	protected void saveDocuemnt() throws IOException {
		
		Exception ret = uploadGateDocuemnt(documentEditor.getDocument(), documentUrl);
		
		if (ret != null)
		{
			JOptionPane.showMessageDialog(parent, ret, ret.getLocalizedMessage(), JOptionPane.ERROR_MESSAGE);
			
		}		
	}

	public void initGui() {		
		try {
			initDocuemtEditor();
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

}