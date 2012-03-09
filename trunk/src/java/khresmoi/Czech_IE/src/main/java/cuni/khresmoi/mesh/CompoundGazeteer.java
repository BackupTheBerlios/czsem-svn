package cuni.khresmoi.mesh;

import gate.util.GateException;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import cuni.khresmoi.mesh.MeshAnnieGazeteer.Outputter;
import cuni.khresmoi.mesh.MeshRecordDB.MeshRecord;
import czsem.utils.Config;

public class CompoundGazeteer {
	
	/**
	 * @param nosep MeSH term tokens not including separators
	 * @see MeshStatistics#isSeparator(String)
	 */
	public static boolean shouldPermutate(List<String> nosep)
	{
/*
		List<String> nosep = new ArrayList<String>(tokens.size());
		for (String t: tokens)
		{
			if (! MeshStatistics.isSeparator(t)) nosep.add(t);
		}
*/		
		if (nosep.size() <= 1) return false;
		if (nosep.size() > 2) return false;

		for (String t: nosep)
		{
			if (t.length() <= 2) return false;
		}
		return true;
	}
	
	public static class CompoundGazeteerOutputter implements Outputter
	{
		private List<String>[] mesh_lemmas;
		public CompoundGazeteerOutputter() throws GateException, URISyntaxException, IOException
		{
			mesh_lemmas = MeshAnnieGazeteer.loadMeshLemmas();
			System.err.println("mesh lemmas loaded");			
		}		

				
		private void putLine(PrintWriter out, String term, String meshID, String czTerm, String enTerm, String permutID)
		{
			out.format("%s:meshID=%s:czTerm=%s:enTerm=%s:permut=%s\n", term, meshID, czTerm, enTerm, permutID);									
		}

		@Override
		public void outputRecord(PrintWriter out, MeshRecord rec, int ord_num)
		{
			List<String> all_tocs = mesh_lemmas[ord_num];
			List<String> nosep = new ArrayList<String>(all_tocs.size());
			for (String lemma : all_tocs) {
				if (! MeshStatistics.isSeparator(lemma))
					nosep.add(lemma);
			}
		
			String all_tocs_str = czsem.Utils.listToStr(all_tocs, " ");
			
			if (shouldPermutate(nosep))
			{
				String firstperm = (all_tocs.size() == nosep.size()) ? "0" : "delim" ;
				putLine(out, all_tocs_str, rec.meshID, rec.czTerm, rec.enTerm, firstperm);
				int perm_num = 0;
				for (List<String> perm : czsem.Utils.allPermutations(nosep))
				{
					String perm_str = czsem.Utils.listToStr(perm, " ");
					if (all_tocs_str.equals(perm_str))
					{
						perm_num++;
						continue;
					}

					putLine(out, perm_str, rec.meshID, rec.czTerm, rec.enTerm, Integer.toString(perm_num++));
				}
			}
			else
			{
				putLine(out, all_tocs_str, rec.meshID, rec.czTerm, rec.enTerm, "no");
			}									
		}		
	}
	
	public static void main(String[] args) throws GateException, URISyntaxException, IOException, ParserConfigurationException, SAXException, ClassNotFoundException
	{
		System.err.println("start");		
		
		MeshAnnieGazeteer g = new MeshAnnieGazeteer(
	    		Config.getConfig().getCzsemPluginDir() + 
	    		"/resources/gazetteer/meshcz_lemmas_compound_short.lst",
	    		new CompoundGazeteerOutputter());
	    		
				
		
		g.loadMeshDB();
		
		g.writeGazeteerList();

	    System.err.print("end, record written: ");
	    System.err.println(g.records.size());

	}
}
