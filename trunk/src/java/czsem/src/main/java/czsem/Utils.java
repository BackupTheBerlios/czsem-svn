package czsem;

import gate.util.reporting.exceptions.BenchmarkReportInputFileFormatException;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import java.util.Set;

public class Utils {

	public static String [] arrayConcatenate(String [] first, String [] second)
	{
		String [] ret = new String[first.length + second.length];
		System.arraycopy(first, 0, ret, 0, first.length);
		System.arraycopy(second, 0, ret, first.length, second.length);
		return ret;		
	}

	public static <ElementType> Evidence<ElementType>[] createRandomPermutation(Collection<ElementType> collection)
	{
		Random rand = new Random();
		
		@SuppressWarnings("unchecked")
		Evidence<ElementType>[] ret = new Evidence[collection.size()];
		
		int i = 0;
		for (Iterator<ElementType> iterator = collection.iterator(); iterator.hasNext();i++)
		{
			ElementType element = iterator.next();
			ret[i] = new Evidence<ElementType>(element, rand.nextInt());						
		}
				
		Arrays.sort(ret);
		
		return ret;
	}

	public static int [] createRandomPermutation(int length)
	{
		Integer [] input = new Integer[length];
		int [] ret = new int[length];
		for (int i = 0; i < input.length; i++) {
			input[i]=i;
		}
		
		Evidence<Integer>[] perm = createRandomPermutation(Arrays.asList(input));
		for (int i = 0; i < input.length; i++) {
			ret[i]=perm[i].element;
		}
		
		return ret;		
	}


	public static class Evidence<EvidenceElement> implements Comparable<Evidence<EvidenceElement>>
	{
		public Evidence(EvidenceElement doc, int random) {
			this.element = doc;
			this.random = random;
		}
		public EvidenceElement element;
		int random;
		
		@Override
		public int compareTo(Evidence<EvidenceElement> o)
		{
			return new Integer(random).compareTo(o.random);
		}
	}
	
	public static void main(String [] args) throws BenchmarkReportInputFileFormatException, URISyntaxException, IOException
	{
		System.err.println(Arrays.toString(createRandomPermutation(10)));
	}

	public static String findAvailableFileName(String destFileURI)
	{
	    String destFileName = destFileURI.substring(0,destFileURI.lastIndexOf("."));
	    String destFileExt = destFileURI.substring(destFileURI.lastIndexOf(".")+1);
	    int count = 1;      
	    File f;
	    while ((f=new File(destFileURI)).exists())
	    {
	        destFileURI=destFileName+"("+(count++)+")"+"."+destFileExt;
	    }            
	    String fName = f.getName();
	    String fPath = f.getParent();
	    destFileURI = destFileURI.replaceAll(" ", "_");
	    // Now we need to check if given file name is valid for file system, and if it isn't we need to convert it to valid form
	    if (!(testIfFileNameIsValid(destFileURI))) {
	        List<String> forbiddenCharsPatterns = new ArrayList<String>();
	        forbiddenCharsPatterns.add("[:]+"); // Mac OS, but it looks that also Windows XP
	        forbiddenCharsPatterns.add("[\\*\"/\\\\\\[\\]\\:\\;\\|\\=\\,]+");  // Windows
	        forbiddenCharsPatterns.add("[^\\w\\d\\.]+");  // last chance... only latin letters and digits
	        for (String pattern:forbiddenCharsPatterns) {
	            String nameToTest = fName;
	            nameToTest = nameToTest.replaceAll(pattern, "_");
	            destFileURI=fPath+"/"+nameToTest;
	            count=1;
	            destFileName = destFileURI.substring(0,destFileURI.lastIndexOf("."));
	            destFileExt = destFileURI.substring(destFileURI.lastIndexOf(".")+1);
	            while ((f=new File(destFileURI)).exists()) {
	                destFileURI=destFileName+"("+(count++)+")"+"."+destFileExt;
	                }
	                if (testIfFileNameIsValid(destFileURI)) break;
	        }
	    }         
	    return destFileURI;
	}

	private static boolean testIfFileNameIsValid(String destFileURI) {
		    boolean valid = false;
		    try {
		        File candidate = new File(destFileURI);                
	//	        String canonicalPath = candidate.getCanonicalPath();                
		        boolean b = candidate.createNewFile();
		        if (b) {
		            candidate.delete();
		        }
		        valid = true;
		    } catch (IOException ioEx) { }
		    return valid;
		}

	public static File URLToFile(URL url) throws IOException, URISyntaxException
	{
		return new File(url.toURI());		
	}

	public static String URLToFilePath(URL url) throws IOException, URISyntaxException
	{
		return URLToFile(url).getCanonicalPath();		
	}

	public static void copyArrayToSet(int[] src, Set<Integer> dest)
	{
		for (int i = 0; i < src.length; i++) {
			dest.add(src[i]);
		}
	}
	
	public static void copyArrayToSetExceptListed(int[] src, Set<Integer> dest, Set<Integer> except)
	{
		for (int i = 0; i < src.length; i++)
		{
			if (!except.contains(src[i]))
			{			
				dest.add(src[i]);
			}
		}
	}


	public static Set<String> setFromArray(String[] array)
	{		
		return setFromList(Arrays.asList(array));
	}

	public static Set<String> setFromList(List<String> list)
	{		
		return new HashSet<String>(list);
	}
	
	public static int[] intArrayFromCollection(Collection<Integer> l)
	{
		int[] ret = new int[l.size()];
		Iterator<Integer> i = l.iterator();
		for (int a=0; a<ret.length; a++)
			ret[a] = i.next(); 
		return ret;
	}


}
