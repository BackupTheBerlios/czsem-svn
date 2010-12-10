package czsem.gate.learning;

import gate.creole.annotdelete.AnnotationDeletePR;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jdom.JDOMException;

import czsem.gate.learning.MachineLearningExperimenter.ExperimentSetup;
import czsem.gate.learning.MachineLearningExperimenter.PRSetup;
import czsem.gate.learning.MachineLearningExperimenter.SinglePRSetup;
import czsem.gate.plugins.CreateMentions;

public class TrainTestAcquisitions extends ExperimentSetup
{
	private static final String config_directory = "gate-learning/acquisitions-v1.1";


	public TrainTestAcquisitions(MLEngine ... engines) throws JDOMException, IOException
	{
		super(	"file:/C:/Users/dedek/AppData/GATE/Acquisitions-v1.1",
				"Acquisitions-v1.1___1284475684516___2218",
				engines);
//				"test_1___1286870552992___7184");
		
		
		initEngines(config_directory);
	}

	@Override
	public List<PRSetup> getTrainControllerSetup() throws JDOMException, IOException
	{
		List<PRSetup> prs = new ArrayList<PRSetup>();
		
		//Create mentions
		prs.add(new SinglePRSetup(CreateMentions.class)
			.putFeature("inputASName", "Key")
			.putFeature("outputASName", "TectoMT")
//			.putFeatureList("inputAnnotationTypeNames", new String [0]));
			.putFeatureList("inputAnnotationTypeNames", inputAnnotationTypeNames));
//					ILPSerializer.parseClassAttributeValuesFromSettingsFile(
//							new File(config_directory + '/' + new ILPEngine().getConfigFilenaMame()).toURI().toURL()))); 			
//					"acquired", "acqabr", "purchaser", "purchabr", "seller", "sellerabr", "dlramt"));
		
		return addTrainMLEngines(prs);
	}


	@Override
	public List<PRSetup> getTestControllerSetup() throws JDOMException, IOException {
		List<PRSetup> prs = new ArrayList<PRSetup>();
		
		//TectoMT reset
		prs.add(new SinglePRSetup(AnnotationDeletePR.class)
			.putFeatureList("annotationTypes", learninigAnnotType, learninigAnnotType + "_root")
			.putFeatureList("setsToRemove", "TectoMT"));		
		//Reset Paum & ILP
		prs.add(new SinglePRSetup(AnnotationDeletePR.class)
			.putFeatureList("setsToRemove", "ILP", "Paum"));		
		

		return addTestMLEngines(prs);
	}

}
