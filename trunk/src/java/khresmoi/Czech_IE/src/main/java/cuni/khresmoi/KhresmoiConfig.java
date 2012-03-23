package cuni.khresmoi;

import gate.util.GateException;

import java.io.IOException;
import java.net.URISyntaxException;

import czsem.utils.AbstractConfig;

public class KhresmoiConfig extends AbstractConfig {
	private static KhresmoiConfig config = null;
	private static final String config_filename = "khresmoi_config.xml";
	
	
	
	private String outputDirBmcOrig 	;
	private String outputDirBmcFilterInlude 	;
	private String outputDirBmcFilterExclude 	;
	private String outputDirBmcAnalyzedTmp_Morce 	;
	private String outputDirBmcAnalyzed 	;
	private String outputDirBmcAnalyzedCompound 	;
	private String outputDirBmcCrash 	;
	private String outputDirBmcFitered 	;
	private String outputDirBmcPlainTextExport 	;

	private String inputDirFileInfo 	;
	private String inputDirLinkExport 	;
	private String inputDirStatistics 	;
	private String inputDirMimirIndexFeeder 	;

	private String serializedResourcesDir 	;
	private String gazetteerResourcesDir 	;


	private String bmcIsoFilePath 	;
	private String meshXmlFilePath 	;
	private String meshCzLammatizationAnalysisOutput 	;

	private String gateAppCompoundAnalysis 	;
	private String gateAppIeAnalysis 	;

	private String mimirIndexUrl 	;

	
	
	public static KhresmoiConfig getConfig() throws URISyntaxException, IOException
	{
		if (config == null) loadConfig();

		return config;
	}

	protected static void loadConfig() throws IOException {
		config = (KhresmoiConfig) loadAbstaractConfigFromFile(config_filename, null);		
	}


	
	
	
	public static void main(String[] args) throws IOException, GateException, URISyntaxException
	{
		KhresmoiConfig c = new KhresmoiConfig();
		c.setDefaults();
		c.saveToFile(config_filename);
	}

	
	
	
	
	
	
	public void setMyWinDefaults() {
		 outputDirBmcOrig = "C:\\Users\\dedek\\Desktop\\bmc\\bmc\\";
		 outputDirBmcFilterInlude = "C:\\Users\\dedek\\Desktop\\bmc\\filter_include\\";
		 outputDirBmcFilterExclude = "C:\\Users\\dedek\\Desktop\\bmc\\filter_exclude\\";
		 outputDirBmcAnalyzedTmp_Morce = "C:\\Users\\dedek\\Desktop\\bmc\\morce_analyzed\\";
		 outputDirBmcAnalyzed = "C:\\Users\\dedek\\Desktop\\bmc\\analyzed\\";
		 outputDirBmcAnalyzedCompound = "C:\\Users\\dedek\\Desktop\\bmc\\compound\\";
		 outputDirBmcCrash = "C:\\Users\\dedek\\Desktop\\bmc\\flex_crash\\";
		 outputDirBmcFitered = "C:\\Users\\dedek\\Desktop\\bmc\\filter_include\\";
		 outputDirBmcPlainTextExport = "C:\\Users\\dedek\\Desktop\\bmc\\plain_text_export\\";
		
		 inputDirFileInfo = "C:\\Users\\dedek\\Desktop\\bmc\\bmc_samples\\gate-xml-analyzed\\";
		 inputDirLinkExport = "C:\\Users\\dedek\\Desktop\\bmc\\analyzed";
		 inputDirStatistics = "C:\\Users\\dedek\\Desktop\\bmc\\compound\\";
		 inputDirMimirIndexFeeder = "C:\\Users\\dedek\\Desktop\\bmc\\analyzed\\";
		
		 serializedResourcesDir = "./resources/serialized/";
		 gazetteerResourcesDir = "./resources/gazetteer/";

		
		 bmcIsoFilePath = "C:\\data\\Khresmoi\\BMC\\bmc-2011-01.iso";
		 meshXmlFilePath = "C:\\data\\Khresmoi\\czmesh\\mesh2011.xml";
		 meshCzLammatizationAnalysisOutput = "./resources/gazetteer/meshcz_analysed_gate.xml";
		
		 gateAppCompoundAnalysis = "./resources/gapp/Compound_only.gapp";
		 gateAppIeAnalysis = "./resources/gapp/CzechMeshAnalysis_IE_only.gapp";
			
		 mimirIndexUrl = "http://localhost:8080/mimir-demo/mesh_final";
	}

	public void setDefaults() {
		 outputDirBmcOrig = "./bmc/bmc/";
		 outputDirBmcFilterInlude = "./bmc/filter_include/";
		 outputDirBmcFilterExclude = "./bmc/filter_exclude/";
		 outputDirBmcAnalyzedTmp_Morce = "./bmc/morce_analyzed/";
		 outputDirBmcAnalyzed = "./bmc/analyzed/";
		 outputDirBmcAnalyzedCompound = "./bmc/compound/";
		 outputDirBmcCrash = "./bmc/flex_crash/";
		 outputDirBmcFitered = "./bmc/filter_include/";
		 outputDirBmcPlainTextExport = "./bmc/plain_text_export/";
		
		 inputDirFileInfo = "./bmc/bmc_samples/gate-xml-analyzed/";
		 inputDirLinkExport = "./bmc/analyzed/";
		 inputDirStatistics = "./bmc/compound/";
		 inputDirMimirIndexFeeder = "./bmc/analyzed/";
		
		 serializedResourcesDir = "./resources/serialized/";
		 gazetteerResourcesDir = "./resources/gazetteer/";

		
		 bmcIsoFilePath = "C:\\data\\Khresmoi\\BMC\\bmc-2011-01.iso";
		 meshXmlFilePath = "C:\\data\\Khresmoi\\czmesh\\mesh2011.xml";
		 meshCzLammatizationAnalysisOutput = "./resources/gazetteer/meshcz_analysed_gate.xml";
		
		 gateAppCompoundAnalysis = "./resources/gapp/Compound_only.gapp";
		 gateAppIeAnalysis = "./resources/gapp/CzechMeshAnalysis_IE_only.gapp";
			
		 mimirIndexUrl = "http://localhost:8080/mimir-demo/mesh_final";
	}

	
/**************************************************************************************/	
	public String getOutputDirBmcOrig() {
		return outputDirBmcOrig;
	}

	public void setOutputDirBmcOrig(String outputDirBmcOrig) {
		this.outputDirBmcOrig = outputDirBmcOrig;
	}

	public String getOutputDirBmcAnalyzedTmp_Morce() {
		return outputDirBmcAnalyzedTmp_Morce;
	}

	public void setOutputDirBmcAnalyzedTmp_Morce(
			String outputDirBmcAnalyzedTmp_Morce) {
		this.outputDirBmcAnalyzedTmp_Morce = outputDirBmcAnalyzedTmp_Morce;
	}

	public String getOutputDirBmcAnalyzed() {
		return outputDirBmcAnalyzed;
	}

	public void setOutputDirBmcAnalyzed(String outputDirBmcAnalyzed) {
		this.outputDirBmcAnalyzed = outputDirBmcAnalyzed;
	}

	public String getOutputDirBmcAnalyzedCompound() {
		return outputDirBmcAnalyzedCompound;
	}

	public void setOutputDirBmcAnalyzedCompound(String outputDirBmcAnalyzedCompound) {
		this.outputDirBmcAnalyzedCompound = outputDirBmcAnalyzedCompound;
	}

	public String getOutputDirBmcCrash() {
		return outputDirBmcCrash;
	}

	public void setOutputDirBmcCrash(String outputDirBmcCrash) {
		this.outputDirBmcCrash = outputDirBmcCrash;
	}

	public String getOutputDirBmcFitered() {
		return outputDirBmcFitered;
	}

	public void setOutputDirBmcFitered(String outputDirBmcFitered) {
		this.outputDirBmcFitered = outputDirBmcFitered;
	}

	public String getOutputDirBmcPlainTextExport() {
		return outputDirBmcPlainTextExport;
	}

	public void setOutputDirBmcPlainTextExport(String outputDirBmcPlainTextExport) {
		this.outputDirBmcPlainTextExport = outputDirBmcPlainTextExport;
	}

	public String getInputDirFileInfo() {
		return inputDirFileInfo;
	}

	public void setInputDirFileInfo(String inputDirFileInfo) {
		this.inputDirFileInfo = inputDirFileInfo;
	}

	public String getInputDirLinkExport() {
		return inputDirLinkExport;
	}

	public void setInputDirLinkExport(String inputDirLinkExport) {
		this.inputDirLinkExport = inputDirLinkExport;
	}

	public String getBmcIsoFilePath() {
		return bmcIsoFilePath;
	}

	public void setBmcIsoFilePath(String bmcIsoFilePath) {
		this.bmcIsoFilePath = bmcIsoFilePath;
	}

	public String getMeshCzLammatizationAnalysisOutput() {
		return meshCzLammatizationAnalysisOutput;
	}

	public void setMeshCzLammatizationAnalysisOutput(
			String meshCzLammatizationAnalysisOutput) {
		this.meshCzLammatizationAnalysisOutput = meshCzLammatizationAnalysisOutput;
	}

	public String getGateAppCompoundAnalysis() {
		return gateAppCompoundAnalysis;
	}

	public void setGateAppCompoundAnalysis(String gateAppCmpoundAnalysis) {
		this.gateAppCompoundAnalysis = gateAppCmpoundAnalysis;
	}

	public String getGateAppIeAnalysis() {
		return gateAppIeAnalysis;
	}

	public void setGateAppIeAnalysis(String gateAppIeAnalysis) {
		this.gateAppIeAnalysis = gateAppIeAnalysis;
	}

	public String getMimirIndexUrl() {
		return mimirIndexUrl;
	}

	public void setMimirIndexUrl(String mimirIndexUrl) {
		this.mimirIndexUrl = mimirIndexUrl;
	}

	public void setInputDirStatistics(String inputDirStatistics) {
		this.inputDirStatistics = inputDirStatistics;
	}

	public String getInputDirStatistics() {
		return inputDirStatistics;
	}

	public void setSerializedResourcesDir(String serializedResourcesDir) {
		this.serializedResourcesDir = serializedResourcesDir;
	}

	public String getSerializedResourcesDir() {
		return serializedResourcesDir;
	}

	public void setMeshXmlFilePath(String meshXmlFilePath) {
		this.meshXmlFilePath = meshXmlFilePath;
	}

	public String getMeshXmlFilePath() {
		return meshXmlFilePath;
	}

	public void setInputDirMimirIndexFeeder(String inputDirMimirIndexFeeder) {
		this.inputDirMimirIndexFeeder = inputDirMimirIndexFeeder;
	}

	public String getInputDirMimirIndexFeeder() {
		return inputDirMimirIndexFeeder;
	}

	public void setGazetteerResourcesDir(String gazetteerResourcesDir) {
		this.gazetteerResourcesDir = gazetteerResourcesDir;
	}

	public String getGazetteerResourcesDir() {
		return gazetteerResourcesDir;
	}

	public void setOutputDirBmcFilterInlude(String outputDirBmcFilterInlude) {
		this.outputDirBmcFilterInlude = outputDirBmcFilterInlude;
	}

	public String getOutputDirBmcFilterInlude() {
		return outputDirBmcFilterInlude;
	}

	public void setOutputDirBmcFilterExclude(String outputDirBmcFilterExclude) {
		this.outputDirBmcFilterExclude = outputDirBmcFilterExclude;
	}

	public String getOutputDirBmcFilterExclude() {
		return outputDirBmcFilterExclude;
	}	
}
