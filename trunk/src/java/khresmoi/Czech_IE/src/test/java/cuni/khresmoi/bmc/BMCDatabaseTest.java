package cuni.khresmoi.bmc;

import java.net.MalformedURLException;
import java.net.URL;

import junit.framework.TestCase;

public class BMCDatabaseTest extends TestCase {

  public void testBmcIdFromUrl() throws MalformedURLException {
	  assertEquals(
			  "bmc10017301",
			  BMCDatabase.bmcIdFromUrl(
					  new URL("file:/C:/Program%20Files/czsem_suite_1.1.0/./bmc/compound/bmc10017301.xml")));
	  
	  assertEquals(
			  "bmc10017301",
			  BMCDatabase.bmcIdFromUrl(
					  new URL("file:/root/czsem_suite_1.1.0/./bmc/compound/bmc10017301.xml")));
    
  }
}
