package cuni.khresmoi;

import gate.util.GateException;

import java.io.IOException;
import java.net.URISyntaxException;

import czsem.utils.AbstractConfig;

public class KhresmoiConfig extends AbstractConfig {
	private static KhresmoiConfig config = null;
	private static final String config_filename = "khresmoi_config.xml";
			
	private String outputDirBmcOrig = "C:\\Users\\dedek\\Desktop\\bmc\\bmc\\";
	private String outputDirBmcFilterInlude = "C:\\Users\\dedek\\Desktop\\bmc\\filter_include\\";
	private String outputDirBmcFilterExclude = "C:\\Users\\dedek\\Desktop\\bmc\\filter_exclude\\";
	private String outputDirBmcAnalyzedTmp_Morce = "C:\\Users\\dedek\\Desktop\\bmc\\morce_analyzed\\";
	private String outputDirBmcAnalyzed = "C:\\Users\\dedek\\Desktop\\bmc\\analyzed\\";
	private String outputDirBmcAnalyzedCompound = "C:\\Users\\dedek\\Desktop\\bmc\\compound\\";
	private String outputDirBmcCrash = "C:\\Users\\dedek\\Desktop\\bmc\\flex_crash\\";
	private String outputDirBmcFitered = "C:\\Users\\dedek\\Desktop\\bmc\\filter_include\\";
	private String outputDirBmcPlainTextExport = "C:\\Users\\dedek\\Desktop\\bmc\\plain_text_export\\";
	
	private String inputDirFileInfo = "C:\\Users\\dedek\\Desktop\\bmc\\samples\\analysed\\";
	private String inputDirLinkExport = "C:\\Users\\dedek\\Desktop\\bmc\\analyzed";
	private String inputDirStatistics = "C:\\Users\\dedek\\Desktop\\bmc\\compound\\";
	private String inputDirMimirIndexFeeder = "C:\\Users\\dedek\\Desktop\\bmc\\analyzed\\";
	
	private String serializedResourcesDir = "./resources/serialized/";
	private String gazetteerResourcesDir = "./resources/gazetteer/";

	
	private String bmcIsoFilePath = "C:\\data\\Khresmoi\\BMC\\bmc-2011-01.iso";
	private String meshXmlFilePath = "C:\\data\\Khresmoi\\czmesh\\mesh2011.xml";
	private String meshCzLammatizationAnalysisOutput = "./resources/gazetteer/meshcz_analysed_gate.xml";
	
	private String gateAppCmpoundAnalysis = "./resources/gapp/Compound_only.gapp";
	private String gateAppIeAnalysis = "./resources/gapp/CzechMeshAnalysis_IE_only.gapp";
		
	private String mimirIndexUrl = "http://localhost:8080/mimir-demo/mesh_final";

	
	
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
		c.saveToFile(config_filename);
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

	public String getGateAppCmpoundAnalysis() {
		return gateAppCmpoundAnalysis;
	}

	public void setGateAppCmpoundAnalysis(String gateAppCmpoundAnalysis) {
		this.gateAppCmpoundAnalysis = gateAppCmpoundAnalysis;
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
