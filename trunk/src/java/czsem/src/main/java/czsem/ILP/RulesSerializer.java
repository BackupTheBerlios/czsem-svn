package czsem.ILP;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;

import czsem.utils.Config;
import czsem.utils.ProjectSetup;

public class RulesSerializer extends ILPExec
{
	private String output_rules_file_name;
	protected String prolog_serialzation_script = "/rule_xml_serializer.yap";
	
	protected void setDefaults()
	{}
	
	public RulesSerializer(File working_directory, String project_name)
	{super(working_directory, project_name); setDefaults();}

	public RulesSerializer(ProjectSetup ps)
	{super(ps); setDefaults();}

	public void serializeToSwrlx(String [] objectProperties) throws IOException, URISyntaxException
	{
		startPrologProcess(Config.getConfig().getCzsemPluginDir() + prolog_serialzation_script);
//		startReaderThreads("RulesSerializer");
		startStdoutReaderThreads();
		
		callRuleSrialization(getRulesFileName(), getOutputRulesFileName(), objectProperties);

		
	}
	
	private void callRuleSrialization(String rulesFileName,	String xmlRulesFileName, String[] objectProperties)
	{
		output_writer.print("serialize_rule_file('");		
		output_writer.print(rulesFileName);		
		output_writer.print("','");		
		output_writer.print(xmlRulesFileName);		
		output_writer.print("','");		
		output_writer.print('/');		
		output_writer.print(xmlRulesFileName);		
		output_writer.print("',[");
		
		for (int i = 0; i < objectProperties.length; i++)
		{
			output_writer.print(objectProperties[i]);
			if (i < objectProperties.length-1)
				output_writer.print(',');
		} 
		
		output_writer.println("]).");		
		output_writer.flush();				
	}

	public static void main(String[] args) throws IOException, URISyntaxException, InterruptedException
	{
		RulesSerializer rs = new RulesSerializer(new File("gate-learning"), "RulesSerializer");
		rs.setRulesFileName("acquisitions-v1.1/rules/learned_rules");
		rs.setOutputRulesFileName("acquisitions-v1.1/rules/learned_rules_test1.owl");
		String[] object_props = {"lex_rf", "tDependency"};
		rs.serializeToSwrlx(object_props);
		rs.close();

	}

	public void setOutputRulesFileName(String output_rules_file_name) {
		this.output_rules_file_name = output_rules_file_name;
	}

	public String getOutputRulesFileName() {
		return output_rules_file_name;
	}

}
