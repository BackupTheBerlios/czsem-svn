package czsem.gate.learning;

import java.io.PrintStream;
import java.util.Locale;

public class WekaResultTestsLaTeX extends WekaResultTests {

	public WekaResultTestsLaTeX(PrintStream out) {
		super(out);
	}

	public static void main(String[] args) throws Exception {
		Locale.setDefault(Locale.ENGLISH);
		WekaResultTestsLaTeX t = new WekaResultTestsLaTeX(System.err);
		
		t.loadInstances("gate-learning/results/weka_results_acq_complete.csv");
		
		t.printBasicStats();
		
		System.err.println();
		t.performAllTests();
		
		//t.testsAttr(6);
		
		System.err.println("done");

	}

}
