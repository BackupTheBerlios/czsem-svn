package czsem.ILP;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import czsem.ILP.Serializer.Relation;

public class LinguisticSerializer 
{
	protected Serializer ser_bkg;
	protected Serializer ser_pos;
	protected Serializer ser_neg;
	
	protected List<Relation> featRels;
	protected List<Relation> treeDepRels;
	protected List<Relation> one2oneDepRels;
	
	protected File workingDirectory;
	protected String projectName;
	
	public LinguisticSerializer(String projectDir, String projectName) throws FileNotFoundException, UnsupportedEncodingException
	{
		workingDirectory = new File(projectDir + "/savedFiles");
		workingDirectory.mkdir();
		
		this.projectName = projectName;
		
		String path_name_perfix = projectDir + "/savedFiles/" +projectName;
		
		ser_bkg = new Serializer(path_name_perfix + ".b");
		ser_pos = new Serializer(path_name_perfix + ".f");
		ser_neg = new Serializer(path_name_perfix + ".n");
		
		featRels = new ArrayList<Relation>();
		treeDepRels = new ArrayList<Relation>(5);
		one2oneDepRels = new ArrayList<Relation>(3);
	}

	
	public void createTreeDependencyType(int index, String dependencyName, String parentType, String childType)
	{
		Relation rel = createDependencyType(index, dependencyName, parentType, childType);
		treeDepRels.add(index, rel);
		ser_bkg.putBinaryMode(rel, "*", '+', '-');
		ser_bkg.putBinaryMode(rel, "1", '-', '+');		
	};
	public void createOneToOneDependencyType(int index, String dependencyName, String parentType, String childType)
	{
		Relation rel = createDependencyType(index, dependencyName, parentType, childType);
		one2oneDepRels.add(index, rel);
		ser_bkg.putBinaryMode(rel, "1", '+', '-');
		ser_bkg.putBinaryMode(rel, "1", '-', '+');
	};
	
	protected Relation createDependencyType(int index, String dependencyName, String parentType, String childType)
	{
		Relation rel = ser_bkg.addBinRelation(dependencyName, parentType, childType);
		return rel;
	};

	public void createFeatureType(int index, String annotationType, String featureName)
	{
		Relation rel = ser_bkg.addBinRelation("has_" + featureName, annotationType, featureName+'T');
		featRels.add(index, rel);
		ser_bkg.putBinaryMode(rel, "1", '+', '#');
	};
	
	
	public void putTreeDependency(int dependencyIndex, String parentId, String childId)
	{
		ser_bkg.putBinTuple(treeDepRels.get(dependencyIndex), parentId, childId);
	};
	
	public void putOneToOneDependency(int dependencyIndex, String parentId, String childId)
	{
		ser_bkg.putBinTuple(one2oneDepRels.get(dependencyIndex), parentId, childId);
	};
	
	public void putFeature(int featureIndex, String annotationId, String featureValue)
	{
		ser_bkg.putBinTuple(featRels.get(featureIndex), annotationId, featureValue);
	};
	
	public void putDeterminations(String relationName, String relationArgTypeName)
	{
		Relation target = ser_bkg.addRealtion(relationName, new String[]{relationArgTypeName});
		ser_bkg.putMode(target, "1", new char[] {'+'});


		ser_bkg.putCommentLn("-------------------- Determinations --------------------");
		
		for (Relation rel : featRels)
		{
			ser_bkg.putDetermination(target, rel);			
		}
		
		for (Relation rel : one2oneDepRels)
		{
			ser_bkg.putDetermination(target, rel);			
		}

		for (Relation rel : treeDepRels)
		{
			ser_bkg.putDetermination(target, rel);			
		}
		ser_bkg.putCommentLn("-------------------- Determinations END --------------------");
		
	}


	public void putPositiveExample(String instanceId, String instanceTypeName)
	{
    	ser_pos.putTuple(instanceTypeName, new String[]{instanceId});        		
	};
	public void putNegativeExample(String instanceId, String instanceTypeName)
	{
    	ser_neg.putTuple(instanceTypeName, new String[]{instanceId});        				
	}


	public void flushAndClose()
	{
		ser_bkg.putCommentLn("-------------------- outputAllTypes --------------------");
		ser_bkg.outputAllTypes();
		ser_bkg.close();
		
		ser_pos.close();
		ser_neg.close();		
	}


	public void train() throws IOException, InterruptedException
	{
		ILPExec ilp_exec = new ILPExec(workingDirectory, projectName);
		ilp_exec.startILPProcess();
		ilp_exec.startReaderThreads();
		ilp_exec.induceAndWriteRules();
		ilp_exec.close();
		
		
		
		//TODO:
		ILPExec test = new ILPExec(workingDirectory, projectName);
		test.initBeforeApplyRules();
		
		System.out.println(test.applyRules("injuries('id_jihomoravsky48461.txt.xml_00046_804')"));
		System.out.println(test.applyRules("injuries('id_jihomoravsky48461.txt.xml_00046_805')"));
		test.close();
	}

}
