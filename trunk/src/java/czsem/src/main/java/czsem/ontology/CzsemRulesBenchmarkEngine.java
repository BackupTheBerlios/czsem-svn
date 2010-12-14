package czsem.ontology;


public interface CzsemRulesBenchmarkEngine
{

	void newEngineFromRules(String rules_file_path) throws Exception;

	void addOntology(String ontology_path) throws Exception;

	void attachReasoner() throws Exception;

	int printResults();

}
