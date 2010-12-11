package czsem.ontology;

import java.io.File;
import java.io.FilenameFilter;
import java.io.InputStream;

import org.apache.log4j.Logger;
import org.semanticweb.owlapi.apibinding.OWLManager;
import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLClass;
import org.semanticweb.owlapi.model.OWLDataFactory;
import org.semanticweb.owlapi.model.OWLNamedIndividual;
import org.semanticweb.owlapi.model.OWLOntology;
import org.semanticweb.owlapi.model.OWLOntologyCreationException;
import org.semanticweb.owlapi.model.OWLOntologyManager;
import org.semanticweb.owlapi.reasoner.IllegalConfigurationException;
import org.semanticweb.owlapi.reasoner.Node;
import org.semanticweb.owlapi.reasoner.NodeSet;
import org.semanticweb.owlapi.reasoner.NullReasonerProgressMonitor;
import org.semanticweb.owlapi.reasoner.OWLReasoner;
import org.semanticweb.owlapi.reasoner.OWLReasonerConfiguration;
import org.semanticweb.owlapi.reasoner.OWLReasonerFactory;
import org.semanticweb.owlapi.reasoner.ReasonerProgressMonitor;
import org.semanticweb.owlapi.reasoner.SimpleConfiguration;
import org.semanticweb.owlapi.util.OWLOntologyMerger;

import uk.ac.manchester.cs.factplusplus.owlapiv3.FaCTPlusPlusReasonerFactory;


public class Pml2GateReasoning
{
	static Logger logger = Logger.getLogger(Pml2GateReasoning.class);
	
	private OWLOntologyManager manager;

	private OWLReasoner reasoner;

	public Pml2GateReasoning()
	{
        manager = OWLManager.createOWLOntologyManager();
		
	}

	public Pml2GateReasoning(File rules_onto_file) throws OWLOntologyCreationException
	{
		this();
		
		addOntology(Pml2GateReasoning.class.getResourceAsStream("PMT2GATE_ontology_utils.owl"));
		addOntology(rules_onto_file);
	}

	public void addOntology(InputStream onto_stream) throws OWLOntologyCreationException
	{
        OWLOntology ont = manager.loadOntologyFromOntologyDocument(onto_stream);      		  
        logger.debug("Loaded " + ont.getOntologyID());		
	}

	public void addOntology(File onto_file) throws OWLOntologyCreationException
	{
        OWLOntology ont = manager.loadOntologyFromOntologyDocument(onto_file);      		  
        logger.debug("Loaded " + ont.getOntologyID());		
	}
	
	/**
	 * @param mergedOntologyIRI - can be null.
	 */
	public OWLOntology getMergedOntology(IRI mergedOntologyIRI) throws OWLOntologyCreationException
	{
        OWLOntologyMerger merger = new OWLOntologyMerger(manager);
        return merger.createMergedOntology(manager, mergedOntologyIRI);		
	}
	
	public OWLReasoner attachReasoner() throws IllegalConfigurationException, OWLOntologyCreationException
	{
//		return attachReasoner(PelletReasonerFactory.getInstance()); //Pellet
//		return attachReasoner(new Reasoner.ReasonerFactory()); //HermiT
		return attachReasoner(new FaCTPlusPlusReasonerFactory()); //FaCTpp
	}
	
	public OWLReasoner attachReasoner(OWLReasonerFactory reasonerFactory) throws IllegalConfigurationException, OWLOntologyCreationException
	{
		ReasonerProgressMonitor progressMonitor = new NullReasonerProgressMonitor();
        OWLReasonerConfiguration config = new SimpleConfiguration(progressMonitor);
        return reasoner = reasonerFactory.createReasoner(getMergedOntology(null), config);        
	}
	
	public void doInference()
	{
		reasoner.precomputeInferences();
	}
	
	/**
	 * @return number of all matching instances
	 */
	public int printClassInstances(IRI className)
	{
		OWLDataFactory fac = manager.getOWLDataFactory();
        OWLClass cls = fac.getOWLClass(className);

        NodeSet<OWLNamedIndividual> instances = reasoner.getInstances(cls, false);

        int count = 0;
        for (Node<OWLNamedIndividual> instace : instances)
        {
            System.out.println(instace.getRepresentativeElement().getIRI());
            count ++;
		}
        
        return count;        
	}

	public static void processDirectory(String directory_path, String rules_fiel_path) throws OWLOntologyCreationException
	{
		File dir = new File(directory_path);
		String[] file_list = dir.list(new FilenameFilter() {
			@Override
			public boolean accept(File dir, String file_name) {
				return file_name.endsWith("owl");
			}
		});
		
		int instance_count = 0;
		for (int i = 0; i < file_list.length; i++)
		{
			String file = file_list[i];
			logger.info(
					String.format("Reasoning on file %d/%d: %s",
					i+1, file_list.length,
					file));
					 
			Pml2GateReasoning r = new Pml2GateReasoning(new File(rules_fiel_path));
			r.addOntology(new File(directory_path +'/'+ file));
			
			r.attachReasoner();
			
			instance_count += r.printClassInstances(IRI.create("http://czsem.berlios.de/ontologies/PMT2GATE_ontology_utils.owl#MentionRoot"));	
		}
		
		System.out.format("total number of instances: %d", instance_count);
	}

	public static void main(String[] args) throws OWLOntologyCreationException
	{
		processDirectory("czsem_GATE_plugins/TmT_serializations/owl", "gate-learning/acquisitions-v1.1/rules/ILP_config_rules_noise30.owl");
		
		/*
		Pml2GateReasoning r = new Pml2GateReasoning(new File("gate-learning/czech_fireman/rules/learned_rules_test1.owl"));
		r.addOntology(new File("czsem_GATE_plugins/TmT_serializations/owl/jihomoravsky47443.txt.xml_00034.tmt.owl"));
		
		r.attachReasoner();
		
		r.printClassInstances(IRI.create("http://czsem.berlios.de/ontologies/PMT2GATE_ontology_utils.owl#MentionRoot"));
		*/
	
	}
}