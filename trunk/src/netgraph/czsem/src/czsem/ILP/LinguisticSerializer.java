package czsem.ILP;

import java.io.FileNotFoundException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import czsem.ILP.Serializer.Relation;

public class LinguisticSerializer 
{
	Serializer ser_bkg;
	Serializer ser_pos;
	Serializer ser_neg;
	
	List<Relation> featRels;
	List<Relation> treeDepRels;
	List<Relation> one2oneDepRels;

	public LinguisticSerializer(String projectDir, String projectName) throws FileNotFoundException, UnsupportedEncodingException
	{
		String path_name_perfix = projectDir + projectName;
		
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
		Relation rel = ser_bkg.addBinRelation("has_" + featureName, annotationType, featureName);
		featRels.add(index, rel);
		ser_bkg.putBinaryMode(rel, "1", '+', '#');
	};
	
	
	public void putDependency(int dependencyIndex, String parentId, String childId)
	{
		ser_bkg.putBinTuple(featRels.get(dependencyIndex), parentId, childId);
	};
	
	
	public void putFeature(int featureIndex, String annotationId, String featureValue)
	{
		ser_bkg.putBinTuple(featRels.get(featureIndex), annotationId, featureValue);
	};
	
	public void putDeterminations()
	{
		Relation target = null;
		
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
		
	}


	public void putPositiveExample(String instanceId, String instanceTypeName)
	{
    	ser_pos.putTuple(instanceTypeName, new String[]{instanceId});        		
	};
	public void putNegativeExample(String instanceId, String instanceTypeName)
	{
    	ser_neg.putTuple(instanceTypeName, new String[]{instanceId});        				
	}

}
