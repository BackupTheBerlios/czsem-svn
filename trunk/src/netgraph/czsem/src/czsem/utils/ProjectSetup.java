package czsem.utils;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class ProjectSetup {
	public File working_directory;
	public String dir_for_projects = "C:\\workspace\\czsem\\src\\netgraph\\czsem\\ILP_serial_projects\\";
	public String current_project_dir = null;
	public String project_name = "serialized_exp";
//	private Serializer ser_bkg;		
	
	public void init_project() throws FileNotFoundException, UnsupportedEncodingException
	{
        Calendar rightNow = Calendar.getInstance();
        SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd_HHmmss");
        String time_stamp = df.format(rightNow.getTime());
        
        StringBuilder file_strb = new StringBuilder();
        file_strb.append(dir_for_projects);
        file_strb.append(time_stamp);
        file_strb.append('\\');
//        file_strb.append("pokkk");
        
        current_project_dir = file_strb.toString();
        
        working_directory = new File(current_project_dir);
        working_directory.mkdir();    
	}
}
