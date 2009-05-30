package czsem.ILP;

import java.io.PrintStream;
import java.util.*;

public class Serializer {
	public static class Type
	{
		public Type(String typeName) {name = typeName;}
		private String name;
		private Set<String> values = new HashSet<String>();		
	}
	
	public static class Relation
	{
		private String name;
		private Type[] argTypes;
		//TODO: kardinalita argumentu
		
		private Relation(String name, Type[] argTypes) {
			this.name = name;
			this.argTypes = argTypes;
		}		
	}
	
	private PrintStream output = System.out;
	private Map<String, Relation> relationList = new HashMap<String, Relation>();
	private Map<String, Type> typeList = new HashMap<String, Type>();
	
	private Type getType(String typeName)
	{
		return typeList.get(typeName);
	}

	private Type addType(String typeName)
	{
		Type type = new Type(typeName);
		typeList.put(typeName, type);
		return type;
	}
	
	public Relation addRealtion(String relationName, String[] typeNames)
	{
		Relation ret = relationList.get(relationName); 
		if (ret != null) return ret;
		
		Type [] types = new Type[typeNames.length];
		
		for (int i=0; i<typeNames.length; i++) {
			Type type = getType(typeNames[i]);
			if (type == null) type = addType(typeNames[i]);
			types[i] = type;
		}
		
		ret = new Relation(relationName, types);
		relationList.put(relationName, ret);
		return ret;
	}
	
	public Relation addBinRelation(String relationName, String arg1TypeName, String arg2TypeName)
	{
		String[] args = new String[2];
		args[0] = arg1TypeName;
		args[1] = arg2TypeName;		
		return addRealtion(relationName, args);
	}

	public void putBinTuple(Relation rel, String value1, String value2)
	{
		String [] values = new String[2];
		values[0] = value1;		
		values[1] = value2;		
		putTuple(rel, values);
	}

	public void putTuple(Relation rel, String[] values)
	{
		output.print(rel.name);
		
		char sep = '(';
		
		for (int i=0; i<rel.argTypes.length; i++)
		{
			output.print(sep);
			output.print(values[i]);
			sep=',';
		}		
		output.println(").");
	}
	
	public static void main(String[] argv)
	{
		Serializer ser = new Serializer();
		
		Relation rel = ser.addBinRelation("Edge", "Node", "Node");
		ser.putBinTuple(rel, "node01", "node002");		
	}

}
