package czsem.utils;

import java.io.PrintStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class MultiSet<T> implements Iterable<T>
{
	private Map<T, Integer> map = new HashMap<T, Integer>();
	
	public String toFormatedString(String separator)
	{
		StringBuilder sb = new StringBuilder();
		
		for (T k : this)
		{
			int i = get(k);
			String outstr = "null";
			if (k != null) outstr = k.toString();
			sb.append(outstr);
			sb.append(": ");
			sb.append(i);
			sb.append(separator);
		}
		
		return sb.toString();
	}

	public void print(PrintStream out)
	{
		out.print(toFormatedString(", "));
	}

	public int size() {
		return map.keySet().size();
	}

	public boolean isEmpty() {
		return map.isEmpty();
	}

	public int get(T o) {
		Integer i = map.get(o);
		if (i == null) return 0;
		else return i;
	}

	public Iterator<T> iterator() {
		return map.keySet().iterator();
	}


	public int add(T e) {
		Integer i = get(e);		
		map.put(e, ++i);
		return i;
	}

	public int remove(T o) {
		Integer i = map.get(o);
		if (--i<=0)
		{
			map.remove(o);
			return 0;
		}
		else
		{
			map.put(o,i);
			return i;
		}
	}

	public Object[] toArray() {
		return map.keySet().toArray();
	}

	public T[] toArray(T[] a) {
		return map.keySet().toArray(a);
	}

	public void clear() {
		map.clear();		
	}
}
