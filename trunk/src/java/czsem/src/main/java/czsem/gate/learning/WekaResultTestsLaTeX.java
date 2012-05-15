package czsem.gate.learning;

import java.io.PrintStream;
import java.util.Locale;

import org.apache.commons.lang.StringUtils;

import weka.core.Range;

public class WekaResultTestsLaTeX extends WekaResultTests {

	public WekaResultTestsLaTeX(PrintStream out) {
		super(out);
	}
	
	protected boolean first_row_in_dataset = false;
	protected boolean na_val = false;

	public static void main(String[] args) throws Exception {
		Locale.setDefault(Locale.ENGLISH);
		WekaResultTestsLaTeX t = new WekaResultTestsLaTeX(System.err);
		
		t.loadInstances("gate-learning/acquisitions-v1.1/results/weka_results_acq_complete.csv");
		
		t.printBasicStats();
		
		System.err.println();
		t.performAllTests();

		//overall
		System.err.println("\n\n\n---------------------- overall ----------------------");
		t.m_TTester.setDatasetKeyColumns(new Range("5"));
		t.performAllTests();

		
		//t.testsAttr(6);
		
		System.err.println("done");

	}

	@Override
	protected void printSignificance(int significance) {
		if (! na_val)
		{		
			switch (significance) {
			case 1: out.print("$\\circ$"); break;
			case 2: out.print("$\\bullet$");	break;
			}
		}
		
		out.println(" \\\\");
		
		first_row_in_dataset = false;
	}

	@Override
	protected void printDatasetHeader(String dataset) {
		out.format("\\hline\n\\hline\n\\multirow{11}{*}{\\begin{sideways}%s\\end{sideways} }\n", 
				filterAttrName(dataset));
		
		first_row_in_dataset = true;
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
		int cline = 2;
		
		if (commonPrefix.length() > 0 && commonPrefixForNextRows == 0) cline = 3;
		
		if (! first_row_in_dataset) out.format("\\cline{%d-10} ", cline);
		else out.print("             ");

		
		out.print("& ");
		if (commonPrefixForNextRows>0)
			out.format("\\multirow{%d}{*}{%10s} ", commonPrefixForNextRows+1, finall_prefix);
		else
			out.format("%27s ", finall_prefix);
		
		out.format("& %15s & ", finall_sufix);
/**/
		
		//out.format("'%s'\t\t'%s'\t\t%d\t", finall_prefix, finall_sufix, commonPrefixForNextRows);
		
		na_val = false;
	}

	@Override
	protected void printAttrValue(double avg, double stdev) {
		if (avg < 0)
		{
			out.print("   \\multicolumn{3}{c|}{n/a}         & ");
			na_val = true;
		} else if (avg > 9000)
			out.format("%11.0f &  $\\pm$  & %11.0f & ", avg, stdev);				
		else
			out.format("%11.3f &  $\\pm$  & %11.3f & ", avg, stdev);				
	}

}
