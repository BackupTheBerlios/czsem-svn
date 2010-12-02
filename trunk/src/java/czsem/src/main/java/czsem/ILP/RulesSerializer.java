package czsem.ILP;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;

import czsem.utils.Config;
import czsem.utils.ProjectSetup;

public class RulesSerializer extends ILPExec
{
	protected String xml_rules_file_name;
	protected String prolog_serialzation_script = "/rule_xml_serializer.yap";
	
	protected void setDefaults()
	{
		xml_rules_file_name = getRulesFileName() + ".xml"; 		
	}
	
	public RulesSerializer(File working_directory, String project_name)
	{super(working_directory, project_name); setDefaults();}

	public RulesSerializer(ProjectSetup ps)
	{super(ps); setDefaults();}

	public void serializeToXml() throws IOException, URISyntaxException
	{
		startPrologProcess(Config.getConfig().getCzsemPluginDir() + prolog_serialzation_script);
//		startReaderThreads("RulesSerializer");
		startStdoutReaderThreads();
		
		callRuleSrialization(getRulesFileName(), xml_rules_file_name);

		
	}
	
	private void callRuleSrialization(String rulesFileName,	String xmlRulesFileName)
	{
		output_writer.print("serialize_rule_file('");		
		output_writer.print(rulesFileName);		
		output_writer.print("','");		
		output_writer.print(xmlRulesFileName);		
		output_writer.println("').");		
		output_writer.flush();				
	}

	public static void main(String[] args) throws IOException, URISyntaxException, InterruptedException
	{
		RulesSerializer rs = new RulesSerializer(new File("gate-learning/acquisitions-v1.1/savedFiles"), "RulesSerializer");
		rs.serializeToXml();
		rs.close();

	}

}
