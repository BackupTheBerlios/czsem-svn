package czsem.gate;
import gate.Annotation;
import gate.AnnotationSet;
import gate.DataStore;
import gate.Document;
import gate.Gate;
import gate.creole.AbstractVisualResource;
import gate.creole.AnnotationVisualResource;
import gate.creole.metadata.CreoleResource;
import gate.gui.ResizableVisualResource;
import gate.util.GateException;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.io.ByteArrayOutputStream;
import java.io.PrintStream;
import java.net.URL;
import java.util.Iterator;

import javax.swing.DefaultListModel;
import javax.swing.JFrame;
import javax.swing.JScrollPane;
import javax.swing.JSplitPane;
import javax.swing.JTable;
import javax.swing.table.AbstractTableModel;
import javax.swing.table.TableColumn;

import cz.cuni.mff.mirovsky.trees.NGForest;
import cz.cuni.mff.mirovsky.trees.NGForestDisplay;
import cz.cuni.mff.mirovsky.trees.NGTree;
import cz.cuni.mff.mirovsky.trees.NGTreeHead;
import cz.cuni.mff.mirovsky.trees.TNode;


@CreoleResource(name = "netgraph TreeViewer")
public class NetgraphTreeViewer extends AbstractVisualResource
    implements  AnnotationVisualResource, ResizableVisualResource {

	private static final long serialVersionUID = -369474822338049027L;
	
	private NGForestDisplay forestDisplay;
	private NGTableModel dataModel;
	      
	
	public NetgraphTreeViewer()
	{
		initComponents();                
	}
	
	public void initComponents()
	{
        forestDisplay = new NGForestDisplay(null);
        JScrollPane forestScrollpane = new JScrollPane(forestDisplay);
        forestDisplay.addMouseListener(new MouseListener() {
			@Override
			public void mouseReleased(MouseEvent e) {}
			@Override
			public void mousePressed(MouseEvent e) {forestDisplay.selectNode(e); repaint();}			
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
        
	}

	public void setForest(NGForest forest)
	{
		forestDisplay.setForest(forest);
		forestDisplay.getTreeProperties().setShowHiddenNodes(true);
		forestDisplay.getTreeProperties().setShowNullValues(false);
		forestDisplay.getTreeProperties().setShowMultipleSets(true);
		forestDisplay.getTreeProperties().setShowAttrNames(false);

		dataModel.setForestDisplay(forestDisplay);
				
		forestDisplay.repaint();
	}

	@Override
	public void editAnnotation(Annotation annotation, AnnotationSet annotation_set)
	{  
	    Annotation sentence = annotation;
		
		NGTree tree = new NGTree(null);
		NGForest ngf = new NGForest(null);

		AnnotationSet sentence_set = annotation_set.getContained(
				sentence.getStartNode().getOffset(), sentence.getEndNode().getOffset());
		
		ByteArrayOutputStream os = new ByteArrayOutputStream();
		
		SentenceFSWriter wr = new SentenceFSWriter(sentence_set, new PrintStream(os));
		wr.printTree(2);
		
		System.err.println(os.toString());
		

		
		NGTreeHead th = wr.createTreeHead();
		tree.readTree(th, os.toString().toCharArray(), 0, th.getSize());
		ngf.setHead(th);
		ngf.addTree(tree);
		ngf.getVybraneAtributy().add(0, "id");
		ngf.getVybraneAtributy().add(0, "t_lemma");
		ngf.getVybraneAtributy().add(0, "form");
		ngf.getVybraneAtributy().add(0, "string");
		ngf.getVybraneAtributy().add(0, FSFileWriter.ORD_FEATURENAME);

			
		setForest(ngf);		
	}

	
  /**
    * Checks whether this viewer/editor can handle a specific annotation type.
    * @param annotationType represents the annotation type being questioned.If
    * it is <b>null</b> then the method will return false.
    * @return true if the SchemaAnnotationEditor can handle the annotationType
    * or false otherwise.
    */
  public boolean canDisplayAnnotationType(String annotationType){
    // Returns true only if the there is an AnnotationSchema with the same type
    // as annotationType.
    if (annotationType == null) return false;
    boolean found = false;

    java.util.List<String> specificEditors = Gate.getCreoleRegister().
                                     getAnnotationVRs(annotationType);
    Iterator<String> editorIter = specificEditors.iterator();
    while(editorIter.hasNext() && !found){
      String editorClass = (String)editorIter.next();

//      Out.println(editorClass);
      if (editorClass.equals(this.getClass().getCanonicalName())) {
//        textAnnotationType = annotationType;
        found = true;
      }
    }

    return found;
  }// canDisplayAnnotationType();

  
  public static void main(String[] args) throws Exception {
    Gate.init();
    Gate.getCreoleRegister().registerDirectories(new URL("file:/C:/Program%20Files/GATE-5.1/plugins/Parser_Stanford/"));

    final NetgraphTreeViewer syntaxTreeViewer1 =    new NetgraphTreeViewer();
    JFrame frame = new JFrame();

    //INITIALISE THE FRAME, ETC.
    frame.setEnabled(true);
    frame.setTitle("SyntaxTree Viewer");
    frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);

    frame.getContentPane().add(syntaxTreeViewer1, BorderLayout.CENTER);

    //Put the bean in a scroll pane.
    JScrollPane scroller = new JScrollPane(syntaxTreeViewer1);
    scroller.setPreferredSize(syntaxTreeViewer1.getPreferredSize());
    frame.getContentPane().add(scroller, BorderLayout.CENTER);

    //DISPLAY FRAME
    frame.pack();
    frame.setVisible(true);

    
    
    
    
    
    

    DataStore ds = TectoMTAnalyser.openDataStore("file:/C:/Users/dedek/AppData/GATE/data_store/");
    ds.open();
    CorpusTester.printStoredIds(ds);
    
//    Document doc = TectoMTAnalyser.loadDocumentFormDatastore(ds, "jihomoravsky58029.txt.xml_00A36___1268383940724___4619");
//    AnnotationSet as = doc.getAnnotations("TectoMT");
    Document doc = TectoMTAnalyser.loadDocumentFormDatastore(ds, "english___1268833529545___270");
    AnnotationSet as = doc.getAnnotations();
    
    Annotation sentece_annot = as.get("Sentence").iterator().next();
    
    syntaxTreeViewer1.editAnnotation(sentece_annot, as);
    
    ds.close();

  }// public static void main

@Override
public void cancelAction() throws GateException {
	// TODO Auto-generated method stub
	
}

@Override
public boolean editingFinished() {
	// TODO Auto-generated method stub
	return false;
}

@Override
public Annotation getAnnotationCurrentlyEdited() {
	// TODO Auto-generated method stub
	return null;
}

@Override
public AnnotationSet getAnnotationSetCurrentlyEdited() {
	// TODO Auto-generated method stub
	return null;
}

@Override
public boolean isActive() {
	// TODO Auto-generated method stub
	return false;
}

@Override
public void okAction() throws GateException {
	// TODO Auto-generated method stub
	
}

@Override
public boolean supportsCancel() {
	// TODO Auto-generated method stub
	return false;
}

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
