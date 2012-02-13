package czsem.khresmoi;

import java.util.Collection;

@Deprecated
public class TermStats {
	
	int terms;
	int uniqueTerms;
	int termsWithSeoprator;
	int uniqueTermsWithSeoprator;
		
	public void fillFrom(Collection<String> meshIDs)
	{
		
	}

	public void setTerms(int terms) {
		this.terms = terms;
	}

	public void setUniqueTerms(int uniqueTerms) {
		this.uniqueTerms = uniqueTerms;
	}

	public void setTermsWithSeoprator(int termsWithSeoprator) {
		this.termsWithSeoprator = termsWithSeoprator;
	}

	public void setUniqueTermsWithSeoprator(int uniqueTermsWithSeoprator) {
		this.uniqueTermsWithSeoprator = uniqueTermsWithSeoprator;
	}

}
