package czsem.ILP;

import java.io.FileNotFoundException;
import java.io.PrintStream;
import java.io.UnsupportedEncodingException;
import java.text.CharacterIterator;
import java.text.StringCharacterIterator;
import java.util.*;

public class Serializer {
	public static class Type
	{
		private String name;
		private Set<String> values = new HashSet<String>();		

		public Type(String typeName) {name = typeName;}
		public boolean addValue(String value) {return values.add(value);}
	}
	
	public static class Relation
	{
		private String name;
		private Type[] argTypes;
		
		private Relation(String name, Type[] argTypes) {
			this.name = name;
			this.argTypes = argTypes;
		}		
	}
	
	private PrintStream output = System.out;
	private Map<String, Relation> relationList = new HashMap<String, Relation>();
	private Map<String, Type> typeList = new HashMap<String, Type>();
	
	public Serializer(String output_filename) throws FileNotFoundException, UnsupportedEncodingException
	{
		output = new PrintStream(output_filename);
	/**	
		output = new PrintStream(output_filename, "UTF8");
		output.println(":- encoding(utf8).");
	/**/
	}
	
	public Serializer() {
		// TODO Auto-generated constructor stub
	}

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
		return addRealtion(relationName, 
				new String[] {arg1TypeName, arg2TypeName});
	}

	public void putBinTuple(Relation rel, String value1, String value2)
	{
		putTypedTuple(rel, 
				new String[] {value1, value2});
	}

	public void putTuple(String relationName, String[] values)
	{
		//TODO jmeno relace a hodnoty musi zacinat malym pismenem?
		output.print(relationName);
		
		char sep = '(';
		for (int i=0; i<values.length; i++)
		{
			output.print(sep);
			output.print(values[i]);
			sep=',';
		}		
		output.println(").");		
	}

	public static String encodeValue(String value)
	{
		boolean all_digits = true;
		boolean all_lo_alpha = true;

		StringBuilder sb = new StringBuilder();
		sb.append('\'');
		StringCharacterIterator iter = new StringCharacterIterator(value);
		for (char ch = iter.first(); ch != CharacterIterator.DONE; ch = iter.next())
		{
			all_digits = all_digits & Character.isDigit(ch);
			all_lo_alpha = all_lo_alpha & Character.isLowerCase(ch);
			
			switch (ch) {
			case '\'':
			case '\\':
				sb.append('\\');
			default:
				sb.append(ch);				
			}
		}

		if (all_digits || all_lo_alpha) return "μμ"+value;
//		if (all_digits || all_lo_alpha) return "μμ"+value;
		
		sb.append('\'');
		return sb.toString();
	}
	
	public void putTypedTuple(Relation rel, String[] values)
	{		
		for (int i=0; i<rel.argTypes.length; i++)
		{
			values[i] = encodeValue(values[i]); 
			rel.argTypes[i].addValue(values[i]);
		}
		
		putTuple(rel.name, values);
	}
	
	protected void putType(Type type)
	{
		for (String value : type.values) {
			putTuple(type.name, new String[]{value});
		}
	}
	
	public void outputAllTypes()
	{
		for (Type type : typeList.values()) {
			putType(type);
		}
	}

	public void putDetermination(Relation targetRealtion, Relation backgroundRealtion)
	{
		//:- determination(eastbound/1,has_car/2).

		output.print(":- determination(");
		output.print(targetRealtion.name);
		output.print('/');
		output.print(targetRealtion.argTypes.length);
		output.print(',');
		output.print(backgroundRealtion.name);
		output.print('/');
		output.print(backgroundRealtion.argTypes.length);
		output.println(").");		
	}

	/**
	 * @see Serializer#putMode(czsem.ILP.Serializer.Relation, String, char[]) 
	 */
	public void putBinaryMode(Relation rel, String recallNumber, char argument1Mode, char argument2Mode)
	{
		putMode(rel, recallNumber, new char[] {argument1Mode, argument2Mode});
	}

	/**
	 * 
	 * @param rel
	 * @param recallNumber bounds the non-determinacy of a form of predicate call.
	 * RecallNumber can be either (a) a number specifying the number of successful calls to the predicate; or (b) * specifying that the predicate has bounded non-determinacy. It is usually easiest to specify RecallNumber as *.
	 * @param argumentModes specifies a legal form for calling a predicate. For each argument of the relation there should be single character: '+' , '-' or '#'.  
	 * A simple argument mode character is one of: (a) '+'T specifying that when a literal with predicate symbol p appears in a hypothesised clause, the corresponding argument should be an "input" variable of type T; (b) '-'T specifying that the argument is an "output" variable of type T; or (c) '#'T specifying that it should be a constant of type T.
	 */
	public void putMode(Relation rel, String recallNumber, char [] argumentModes)
	{
		//:- mode(1,plus(+integer,+integer,-integer)).
		output.print(":- mode(");
		output.print(recallNumber);
		output.print(',');
		output.print(rel.name);
		
		char delim = '(';
		
		for (int i=0; i<rel.argTypes.length; i++)
		{
			output.print(delim);
			delim = ',';
			output.print(argumentModes[i]);
			output.print(rel.argTypes[i].name);
		}
		
		output.println(")).");		
	}

	public void putCommentLn(String comment)
	{
		output.print("% ");
		output.println(comment);
	}
	
	public static void main(String[] argv)
	{
		Serializer ser = new Serializer();
		
		Relation rel = ser.addBinRelation("edge", "node", "node");
		ser.putBinTuple(rel, "node01", "node002");
		ser.putBinTuple(rel, "node01", "node003");
		ser.outputAllTypes();
		ser.putDetermination(rel, rel);
		ser.putBinaryMode(rel, "10", '+', '-');
		ser.putBinaryMode(rel, "*", '+', '#');
	}

}
