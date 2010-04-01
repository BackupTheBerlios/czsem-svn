package czsem.gate;
import gate.Annotation;
import gate.AnnotationSet;
import gate.DataStore;
import gate.Document;
import gate.Gate;
import gate.Resource;
import gate.creole.AbstractVisualResource;
import gate.creole.ResourceInstantiationException;
import gate.creole.metadata.CreoleResource;
import gate.gui.MainFrame;
import gate.gui.annedit.AnnotationData;
import gate.gui.annedit.AnnotationEditorOwner;
import gate.gui.annedit.OwnedAnnotationEditor;
import gate.util.GateException;

import java.awt.BorderLayout;
import java.awt.Dialog;
import java.awt.Dimension;
import java.awt.Frame;
import java.awt.Window;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.io.ByteArrayOutputStream;
import java.io.PrintStream;
import java.net.URL;
import java.util.Iterator;

import javax.swing.DefaultListModel;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JScrollPane;
import javax.swing.JSplitPane;
import javax.swing.JTable;
import javax.swing.JTextArea;
import javax.swing.SwingUtilities;
import javax.swing.table.AbstractTableModel;
import javax.swing.table.TableColumn;
import javax.swing.text.JTextComponent;

import cz.cuni.mff.mirovsky.trees.NGForest;
import cz.cuni.mff.mirovsky.trees.NGForestDisplay;
import cz.cuni.mff.mirovsky.trees.NGTree;
import cz.cuni.mff.mirovsky.trees.NGTreeHead;
import cz.cuni.mff.mirovsky.trees.TNode;
import czsem.utils.CZSemTree;


@CreoleResource(name = "Netgraph TreeViewer")
public class NetgraphTreeViewer extends AbstractVisualResource implements  OwnedAnnotationEditor 
{

	private static final long serialVersionUID = -369474822338049027L;
	
	private AnnotationEditorOwner owner;
	protected JDialog dialog;


	private NGForestDisplay forestDisplay;
	private NGTableModel dataModel;
	private Annotation annotation; 
	private AnnotationSet annotation_set;

	
	
	public static void main(String[] args) throws Exception {
		Gate.init();
		Gate.getCreoleRegister()
			.registerDirectories(new URL("file:/C:/Program%20Files/GATE-5.1/plugins/Parser_Stanford/"));

		JFrame frame = new JFrame();

		// INITIALISE THE FRAME, ETC.
		frame.setEnabled(true);
		frame.setTitle("SyntaxTree Viewer");
		frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		frame.setPreferredSize(new Dimension(400, 400));
		final JTextArea textt_area = new JTextArea();
		frame.getContentPane().add(textt_area, BorderLayout.CENTER);


		// DISPLAY FRAME
		frame.pack();
		frame.setVisible(true);

		NetgraphTreeViewer syntaxTreeViewer1 = new NetgraphTreeViewer();
		syntaxTreeViewer1.setOwner(	new AnnotationEditorOwner()
		{
			@Override
			public void selectAnnotation(AnnotationData aData) {}
			@Override
			public JTextComponent getTextComponent() {return textt_area;}
			@Override
			public Annotation getPreviousAnnotation() {return null;}
			@Override
			public Annotation getNextAnnotation() {return null;}
			@Override
			public Document getDocument() {return null;}
			@Override
			public void annotationChanged(Annotation ann, AnnotationSet set, String oldType) {}
		});
		syntaxTreeViewer1.init();

		DataStore ds = CorpusTester.openDataStore("file:/C:/Users/dedek/AppData/GATE/data_store/");
		ds.open();
		CorpusTester.printStoredIds(ds);

		// Document doc = TectoMTAnalyser.loadDocumentFormDatastore(ds,
		// "jihomoravsky58029.txt.xml_00A36___1268383940724___4619");
		// AnnotationSet as = doc.getAnnotations("TectoMT");
		Document doc = CorpusTester.loadDocumentFormDatastore(ds, "english___1268833529545___270");
		AnnotationSet as = doc.getAnnotations();

		Iterator<Annotation> sentences_iterator = as.get("Token").iterator();
		Annotation sentece_annot = sentences_iterator.next();

		syntaxTreeViewer1.editAnnotation(sentece_annot, as);

		Annotation sentece_annot2 = sentences_iterator.next();

		syntaxTreeViewer1.editAnnotation(sentece_annot2, as);

		ds.close();

	}// public static void main

	  
	  
	
	
	
	public void initComponents()
	{    //make the dialog
	    Window parentWindow =
	        SwingUtilities.windowForComponent(owner.getTextComponent());
	      if(parentWindow != null){
	        dialog = parentWindow instanceof Frame ?
	                  new JDialog((Frame)parentWindow, 
	                          "Netgraph Tree Viewer", false) :
	                  new JDialog((Dialog)parentWindow, 
	                          "Netgraph Tree Viewer", false);
	        dialog.setDefaultCloseOperation(JDialog.HIDE_ON_CLOSE);
	        MainFrame.getGuiRoots().add(dialog);
	        
	      }

	      setLayout(new BorderLayout());

        forestDisplay = new NGForestDisplay(null);
        JScrollPane forestScrollpane = new JScrollPane(forestDisplay);
        forestDisplay.addMouseListener(new MouseListener() {
			@Override
			public void mouseReleased(MouseEvent e) {}
			@Override
			public void mousePressed(MouseEvent e)
			{
				forestDisplay.selectNode(e);
				owner.selectAnnotation(new AnnotationData() {					
					@Override
					public AnnotationSet getAnnotationSet() {return annotation_set;}					
					@Override
					public Annotation getAnnotation()
					{
						assert FSFileWriter.ID_INDEX == 0;
						String id = forestDisplay.getForest().getChosenNode().getValue(0, 0, 0);
						return annotation_set.get(Integer.parseInt(id)); 
					}
				});
				repaint();
			}			
			@Override
			public void mouseExited(MouseEvent e) {}
			@Override
			public void mouseEntered(MouseEvent e) {}
			@Override
			public void mouseClicked(MouseEvent e) {}
		});
        
        dataModel = new NGTableModel();        
        JTable table = new JTable(dataModel);
        TableColumn column = table.getColumnModel().getColumn(0);
        column.setMinWidth(21);
        column.setMaxWidth(21);
        column.setPreferredWidth(21);
        column.setResizable(false);

        JScrollPane tableScrollpane = new JScrollPane(table);
           


        JSplitPane split = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT, tableScrollpane, forestScrollpane);
        split.setDividerLocation(200);
        add(split);
        
        
        dialog.add(this);
        dialog.pack();        
	}

	private void checkAttributes(NGForest new_forest)
	{
		NGForest old = forestDisplay.getForest();
		if (old == null) return;
		
		new_forest.getVybraneAtributy().clear();
		
		DefaultListModel old_attrs = old.getVybraneAtributy();
		DefaultListModel new_attrs = new_forest.getVybraneAtributy();
		for (int i=0; i<old_attrs.size(); i++)
		{
			new_attrs.add(i, old_attrs.get(i));
		}
		
		
		/*
		ngf.getVybraneAtributy().add(0, "id");
		ngf.getVybraneAtributy().add(0, "t_lemma");
		ngf.getVybraneAtributy().add(0, "form");
		ngf.getVybraneAtributy().add(0, "string");
		ngf.getVybraneAtributy().add(0, FSFileWriter.ORD_FEATURENAME);
*/

	}
	
	public void setForest(NGForest forest)
	{		
		checkAttributes(forest);
		forestDisplay.setForest(forest);
		forestDisplay.getTreeProperties().setShowHiddenNodes(true);
		forestDisplay.getTreeProperties().setShowNullValues(false);
		forestDisplay.getTreeProperties().setShowMultipleSets(true);
		forestDisplay.getTreeProperties().setShowAttrNames(false);

		dataModel.setForestDisplay(forestDisplay);
				
		repaint();
	}

	@Override
	public void editAnnotation(Annotation annotation, AnnotationSet annotation_set)
	{
		this.annotation = annotation;
		this.annotation_set = annotation_set;
		
		Annotation sentence = annotation; 

		if (! annotation.getType().equals("Sentence"))
		{
			AnnotationSet sentences = annotation_set.getCovering("Sentence", 
					annotation.getStartNode().getOffset(), 
					annotation.getEndNode().getOffset());
			
			Iterator<Annotation> iter = sentences.iterator();
			if (iter.hasNext())	sentence = iter.next();
		}

		
		NGTree tree = new NGTree(null);
		NGForest ngf = new NGForest(null);

		AnnotationSet sentence_set = annotation_set.getContained(
				sentence.getStartNode().getOffset(), sentence.getEndNode().getOffset());
		
		ByteArrayOutputStream os = new ByteArrayOutputStream();
		
		SentenceFSWriter wr = new SentenceFSWriter(sentence_set, new PrintStream(os));
		
		boolean printed = false; 
		for (int a=0; a<FSFileWriter.dependency_annotation_types.length; a++)
		{
			if (printed = wr.printTree(a)) break;
		}
		
		if (!printed ) return;
		
//		System.err.println(annotation.getId());
				
		NGTreeHead th = wr.createTreeHead();
		tree.readTree(th, os.toString().toCharArray(), 0, th.getSize());
		
		CZSemTree czstree = new CZSemTree(tree);
		int deep_ord = czstree.findFirstNodeByAttributeValue(FSFileWriter.ID_INDEX, annotation.getId().toString());
		tree.setMatchingNodes(Integer.toString(deep_ord));
		tree.setChosenNodeByDepthOrder(deep_ord+1);
		
		ngf.setHead(th);
		ngf.addTree(tree);
			
		setForest(ngf);
		
		placeDialog(0,0);        
	}

	  
  
public boolean canDisplayAnnotationType(String annotationType){return true;}  
@Override
public boolean editingFinished() {
	return true;
}
@Override
public Annotation getAnnotationCurrentlyEdited() {
	return annotation;
}
@Override
public AnnotationSet getAnnotationSetCurrentlyEdited() {
	return annotation_set;
}
@Override
public boolean isActive() {
    return dialog.isVisible();
}
@Override
public void okAction() throws GateException {}
@Override
public void cancelAction() throws GateException {}
@Override
public boolean supportsCancel() {return false;}
@Override
public Resource init() throws ResourceInstantiationException {
	super.init();
	initComponents();                
	return this;
}
@Override
public AnnotationEditorOwner getOwner() {return owner;}
@Override
public void setOwner(AnnotationEditorOwner owner) {this.owner = owner;}
@Override
public void placeDialog(int start, int end)
{
	dialog.setVisible(true);
}
@Override
public void setEditingEnabled(boolean isEditingEnabled) {}
@Override
public void setPinnedMode(boolean pinned) {}




public static class NGTableModel extends AbstractTableModel
{
	private static final long serialVersionUID = 1L;
	private NGForestDisplay forestDisplay;
	private NGForest forest;
	private NGTreeHead head;
	
	private int rowCount = 0;
	
	@Override
	public void setValueAt(Object aValue, int rowIndex, int columnIndex)
	{
		if (columnIndex == 0)
		{
			String attr = head.getAttributeAt(rowIndex).getName();
			DefaultListModel selected_attrs = forest.getVybraneAtributy();
			if (selected_attrs.contains(attr))
				selected_attrs.remove(selected_attrs.indexOf(attr));
			else
				selected_attrs.add(0, attr);

			forest.setFlagWholeForestChanged(true);
			forestDisplay.repaint();
		}
	}
	@Override
    public int getColumnCount() { return 3; }
    public void setForestDisplay(NGForestDisplay forestDisplay)
    {
    	this.forestDisplay = forestDisplay;
    	forest = forestDisplay.getForest();
    	head = forest.getHead(); 
    	
    	rowCount = head.getSize();
	}
	@Override
    public int getRowCount() { return rowCount; }
    @Override
    public Object getValueAt(int row, int col)
    {
    	switch (col) {
		case 0:
			return forest.getVybraneAtributy().contains(head.getAttributeAt(row).getName());
		case 1:
			return head.getAttributeAt(row).getName();
		case 2:
			TNode node = forest.getChosenNode();
			if (node == null) return null;
			if (node.values.AHTable[row] == null) return null;
			return node.values.AHTable[row].Value;
		}
    	return -1; 
    }			
    @Override
	public boolean isCellEditable(int rowIndex, int columnIndex) {
		return columnIndex == 0;
	}
	@Override
	public String getColumnName(int column)
    {
    	switch (column) {
		case 0:	return ">"; 
		case 1:	return "Attribute"; 
		default:
		case 2:	return "Value"; 
		}
	}
	@Override
	public Class<?> getColumnClass(int columnIndex) {
    	switch (columnIndex) {
		case 0:
			return Boolean.class;
		default:
			return String.class;
		}
	}		
}
}
