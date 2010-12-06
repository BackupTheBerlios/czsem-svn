package czsem.ontology;

import java.io.File;
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
import org.semanticweb.owlapi.reasoner.ConsoleProgressMonitor;
import org.semanticweb.owlapi.reasoner.IllegalConfigurationException;
import org.semanticweb.owlapi.reasoner.Node;
import org.semanticweb.owlapi.reasoner.NodeSet;
import org.semanticweb.owlapi.reasoner.OWLReasoner;
import org.semanticweb.owlapi.reasoner.OWLReasonerConfiguration;
import org.semanticweb.owlapi.reasoner.OWLReasonerFactory;
import org.semanticweb.owlapi.reasoner.SimpleConfiguration;
import org.semanticweb.owlapi.util.OWLOntologyMerger;

import com.clarkparsia.pellet.owlapiv3.PelletReasonerFactory;


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
		return attachReasoner(PelletReasonerFactory.getInstance());
	}
	
	public OWLReasoner attachReasoner(OWLReasonerFactory reasonerFactory) throws IllegalConfigurationException, OWLOntologyCreationException
	{
        ConsoleProgressMonitor progressMonitor = new ConsoleProgressMonitor();
        OWLReasonerConfiguration config = new SimpleConfiguration(progressMonitor);
        return reasoner = reasonerFactory.createReasoner(getMergedOntology(null), config);        
	}
	
	public void doInference()
	{
		reasoner.precomputeInferences();
	}
	
	public void printClassInstances(IRI className)
	{
		OWLDataFactory fac = manager.getOWLDataFactory();
        OWLClass cls = fac.getOWLClass(className);

        NodeSet<OWLNamedIndividual> instances = reasoner.getInstances(cls, false);

        for (Node<OWLNamedIndividual> instace : instances)
        {
            System.out.println(instace.getRepresentativeElement().getIRI());        	  			
		}		
	}

	public static void main(String[] args) throws OWLOntologyCreationException
	{
		Pml2GateReasoning r = new Pml2GateReasoning(new File("gate-learning/czech_fireman/rules/learned_rules_test1.owl"));
		r.addOntology(new File("czsem_GATE_plugins/TmT_serializations/owl/jihomoravsky47443.txt.xml_00034.tmt.owl"));
		
		r.attachReasoner();
		
		r.printClassInstances(IRI.create("http://czsem.berlios.de/ontologies/PMT2GATE_ontology_utils.owl#MentionRoot"));
	
	}
}