package czsem.online.helpers;

import gate.util.GateException;

import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;

import org.apache.commons.io.IOUtils;

public class Main {

	public static void main(String[] args) throws GateException, IOException {
		CzsemBootStrap.bootStrap();
		
//		PageCreator pc = new PageCreator("http://localhost:8888/charset");
//		PageCreator pc = new PageCreator("http://lezec.cz");
//		PageCreator pc = new PageCreator("http://dedekj.appspot.com");
		
		//InputStream in = new URL("http://lezec.cz").openStream();
		
		//IOUtils.copy(in, System.out);
		
/*		
		System.err.println(pc.getParams());

		System.err.println(pc.getDocContentString());
		
*/
		System.err.println("end");

	}

}
