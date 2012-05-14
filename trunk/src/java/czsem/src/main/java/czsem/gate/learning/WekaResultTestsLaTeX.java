package czsem.gate.learning;

import java.io.PrintStream;
import java.util.Locale;

import org.apache.commons.lang.StringUtils;

public class WekaResultTestsLaTeX extends WekaResultTests {

	public WekaResultTestsLaTeX(PrintStream out) {
		super(out);
	}

	public static void main(String[] args) throws Exception {
		Locale.setDefault(Locale.ENGLISH);
		WekaResultTestsLaTeX t = new WekaResultTestsLaTeX(System.err);
		
		t.loadInstances("gate-learning/acquisitions-v1.1/results/weka_results_acq_complete.csv");
		
		t.printBasicStats();
		
		System.err.println();
		t.performAllTests();
		
		//t.testsAttr(6);
		
		System.err.println("done");

	}

	@Override
	protected void printSignificance(int significance) {
		switch (significance) {
		case 1: out.print("$\\circ$"); break;
		case 2: out.print("$\\bullet$");	break;
		}
		
		out.println(" \\\\");
	}

	@Override
	protected void printDatasetHeader(String dataset) {
		out.format("\\hline\n\\hline\n\\multirow{11}{*}{\\begin{sideways}%s\\end{sideways} }\n", 
				filterAttrName(dataset.substring(1, dataset.length()-1)));		
	}

	@Override
	protected void printAttrName(String name, String commonPrefix, int commonPrefixForNextRows) {
		//super.printAttrName(name, commonPrefix, commonPrefixForNextRows);
		String array[] = new String [] {name, commonPrefix};
		String finall_prefix = StringUtils.getCommonPrefix(array);
		String finall_sufix = name.substring(finall_prefix.length());
		

		if (commonPrefix.equals(""))
		{
			String[] split = name.split(" ");
			if (split.length > 1)
			{
				finall_prefix = split[0];
				finall_sufix = name.substring(finall_prefix.length());
			}
			
		} else if (commonPrefixForNextRows <= 0) finall_prefix = "";



		
/**/
		out.print("& ");
		if (commonPrefixForNextRows>0)
			out.format("\\multirow{%d}{*}{%10s} ", commonPrefixForNextRows+1, finall_prefix);
		else
			out.format("%27s ", finall_prefix);
		
		out.format("& %15s & ", finall_sufix);
/**/
		
		//out.format("'%s'\t\t'%s'\t\t%d\t", finall_prefix, finall_sufix, commonPrefixForNextRows); 
	}

	@Override
	protected void printAttrValue(double avg, double stdev) {
		out.format("%11.3f &  $\\pm$  & %11.3f & ", avg, stdev);				
	}

}
