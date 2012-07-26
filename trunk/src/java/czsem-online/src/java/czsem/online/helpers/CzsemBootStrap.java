package czsem.online.helpers;

import gate.Gate;
import gate.util.GateException;

public class CzsemBootStrap {
	public static void bootStrap() throws GateException
	{
		Gate.runInSandbox(true);
		Gate.init();
	}

}
