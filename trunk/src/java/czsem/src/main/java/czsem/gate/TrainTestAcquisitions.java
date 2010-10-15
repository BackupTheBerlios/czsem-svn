package czsem.gate;

import gate.creole.ml.MachineLearningPR;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.jdom.JDOMException;

import czsem.gate.MachineLearningExperimenter.ExperimentSetup;
import czsem.gate.MachineLearningExperimenter.PRSetup;
import czsem.gate.plugins.CreateMentions;

public class TrainTestAcquisitions extends ExperimentSetup
{

	private static final boolean runILP = true;
	private URL ILP_config_file;

	public TrainTestAcquisitions() throws MalformedURLException
	{
		super(	"file:/C:/Users/dedek/AppData/GATE/Acquisitions-v1.1",
				"Acquisitions-v1.1___1284475684516___2218");
//				"test_1___1286870552992___7184");
		
		
		ILP_config_file = new File("gate-learning/acquisitions-v1.1/ILP_config.xml").toURI().toURL();

	}

	@Override
	public List<PRSetup> getTrainControllerSetup() throws JDOMException, IOException
	{
		List<PRSetup> prs = new ArrayList<PRSetup>();
		
		//Create mentions
		prs.add(new PRSetup(CreateMentions.class)
			.putFeature("inputASName", "Key")
			.putFeature("outputASName", "TectoMT")
			.putFeatureList("inputAnnotationTypeNames",
					ILPSerializer.parseClassAttributeValuesFromSettingsFile(ILP_config_file)));
//					"acquired", "acqabr", "purchaser", "purchabr", "seller", "sellerabr", "dlramt"));
		if (runILP)
		{
			//ILP train
			prs.add(new PRSetup(MachineLearningPR.class)
				.putFeature("inputASName", "TectoMT")
				.putFeature("configFileURL", ILP_config_file)
				.putFeature("training", true));
		}
		return prs;
	}

	@Override
	public List<PRSetup> getTestControllerSetup() {
		return new ArrayList<MachineLearningExperimenter.PRSetup>();
	}

}
