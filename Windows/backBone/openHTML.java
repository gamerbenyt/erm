import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Scanner;


public class openHTML {
	//Input java openHTML html1 jar1 html2 jar2
	public static void main( String[]args )
	{
		if( args.length == 5 )
		{
			String startPointOne = "";
			String startPointTwo = "";
			openHTML file = new openHTML();
			if( args[4].compareTo( "bothpath" ) == 0 ){
				startPointOne = args[0];
				startPointTwo = args[2];
				
				
				startPointOne = startPointOne.replace( ".class", "" );
				startPointOne = startPointOne.replace( "\\", "." );
				startPointOne = startPointOne.replace( "/", "." );
				
				startPointTwo = startPointTwo.replace( ".class", "" );
				startPointTwo = startPointTwo.replace( "\\", "." );
				startPointTwo = startPointTwo.replace( "/", "." );
				
				file.wrightCombine( startPointOne, startPointTwo );
				
			}
			else if( args[4].compareTo( "bothHTML" ) == 0 )
			{
				String fileOne[] = { args[0], args[1] };
				String fileTwo[] = { args[2], args[3] };
				startPointOne = file.findFile( fileOne, file );
				startPointOne = startPointOne.replace( ".class", "" );
				startPointOne = startPointOne.replace( "\\", "." );
				
				startPointTwo = file.findFile( fileTwo, file );
				startPointTwo = startPointTwo.replace( ".class", "" );
				startPointTwo = startPointTwo.replace( "\\", "." );
				file.wrightCombine( startPointOne, startPointTwo );
			}
			else if( args[4].compareTo( "PathOneHTMLTwo" ) == 0 )
			{
				startPointOne = args[0];
				startPointOne = startPointOne.replace( ".class", "" );
				startPointOne = startPointOne.replace( "\\", "." );
				
				String fileTwo[] = { args[2], args[3] };
				startPointTwo = file.findFile(fileTwo, file);
				startPointTwo = startPointTwo.replace(".class", "");
				startPointTwo = startPointTwo.replace("\\", ".");
				file.wrightCombine(startPointOne, startPointTwo);
			}
			else if( args[4].compareTo( "HtmlOnePathTwo" ) == 0 )
			{
				
				
				String fileOne[] = { args[0], args[1] };
				startPointOne = file.findFile( fileOne, file );
				startPointOne = startPointOne.replace( ".class", "" );
				startPointOne = startPointOne.replace( "\\", "." );
				
				startPointTwo = args[2];
				startPointTwo = startPointTwo.replace( ".class", "" );
				startPointTwo = startPointTwo.replace( "\\", "." );
				file.wrightCombine( startPointOne, startPointTwo );
			}
			
		}
	}
	public void wrightCombine( String fileOne, String fileTwo )
	{
		File outputFile = new File("Combine.java"); 
		FileWriter fw = null;
		try {
			fw = new FileWriter(outputFile.getAbsoluteFile());
			BufferedWriter bw = new BufferedWriter(fw); 
			bw.write("import java.applet.Applet;");
			bw.newLine();
			bw.write("import java.applet.AppletStub;");
			bw.newLine();
			bw.write("import java.awt.GridLayout;");
			bw.newLine();
			bw.write("@SuppressWarnings(\"serial\")");
			bw.newLine();
			bw.write("public class Combine extends Applet");
			bw.newLine();
			bw.write("implements Runnable, AppletStub {");
			bw.newLine();
			bw.write("Thread threadABC;");
			bw.newLine();
			bw.write("public void init(){}");
			bw.newLine();
			bw.write("public void run() {");
			bw.newLine();
			bw.write("String app1 = \"");
			bw.write(fileOne);
			bw.write("\";");
			bw.newLine();
			bw.write("String app2 = \"");
			bw.write(fileTwo);
			bw.write("\";");
			bw.newLine();
			bw.write("try {");
			bw.newLine();
			bw.write("GridLayout experimentLayout = new GridLayout(1,1);");  
			bw.newLine();
			bw.write("setLayout( experimentLayout );");
			bw.newLine();
			bw.write("@SuppressWarnings(\"rawtypes\")");
			bw.newLine();
			bw.write("Class applet1 = Class.forName(app1);");
			bw.newLine();
			bw.write("Applet appletToLoad1 = (Applet)applet1.newInstance();");
			bw.newLine();
			bw.write("appletToLoad1.setStub(this);");
			//bw.newLine();
			//bw.write("setLayout( experimentLayout );");
			bw.newLine();
			bw.write("add(appletToLoad1);");
			bw.newLine();
			bw.write("appletToLoad1.init();");
			bw.newLine();
			bw.write("appletToLoad1.start();");
			bw.newLine();
			bw.write("@SuppressWarnings(\"rawtypes\")");
			bw.newLine();			
			bw.write("Class applet2 = Class.forName(app2);");
			bw.newLine();
			bw.write("Applet appletToLoad = (Applet)applet2.newInstance();");
			bw.newLine();
			bw.write("appletToLoad.setStub(this);");
			//bw.newLine();
			//bw.write("setLayout( new GridLayout(20,20));");
			bw.newLine();
			bw.write("//add(appletToLoad);");
			bw.newLine();
			bw.write("appletToLoad.init();");
			bw.newLine();
			bw.write("appletToLoad.start();");
			bw.newLine();
			bw.write("}catch (Exception e) {");
			bw.newLine();
			bw.write("System.out.println(e);");
			bw.newLine();
			bw.write("}");
			bw.newLine();
			bw.write("validate();");
			bw.newLine();
			bw.write("}");
			bw.newLine();
			bw.write("public void start(){");
			bw.newLine();
			bw.write("threadABC = new Thread(this);");
			bw.newLine();
			bw.write("threadABC.start();");
			bw.newLine();
			bw.write("}");
			bw.newLine();
			bw.write("@SuppressWarnings(\"deprecation\")");
			bw.newLine();			
			bw.write("public void stop() {");
			bw.newLine();
			bw.write("threadABC.stop();");
			bw.newLine();
			bw.write("threadABC = null;");
			bw.newLine();
			bw.write("}");
			bw.newLine();
			bw.write("public void appletResize( int width, int height ){");
			bw.newLine();
			bw.write("resize( width, height );");
			bw.newLine();
			bw.write("}");
			bw.newLine();
			bw.write("}");
			bw.newLine();
			
			
			
			
			bw.close();
			fw.close();
		} catch (IOException e) {
			e.printStackTrace();
		} 
	}
	public String findFile(String args[], openHTML file){
		Scanner scan = null;
		
		String data = null;//holds the line being worked on during input
		String fileLocation = "";//location of the starting point in the jar file
		String nameOfJar = "";//name of jar being worked on
		String foundNameOfJar = "";
		
		boolean isItInApplet = false;//checks to see if this is the right <applet tag
		boolean recordJarName = false;
		boolean recordStartPoint = false;
		boolean keepRunning = true;
		
		
		if(args.length == 2){
			nameOfJar = removeDir(args[1]);
			try {
				scan = new Scanner(new File(args[0]));
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			}
			if(scan == null){
				System.out.println("not there");
			}
			
			//reads in the html file line by line to avoid memory overflow
			while(scan.hasNextLine() && keepRunning){
				data = scan.nextLine();
				
				//loops through the string looking for a specific set of words
				for(int counter = 0; counter < data.length() && keepRunning; counter++){
					if(data.charAt(counter) == '<' && file.isItThere(data.substring(counter), "<applet ")){
						counter+=7;
						isItInApplet = true;
					}else if(data.charAt(counter) == '>'){
						if (nameOfJar.compareTo(foundNameOfJar) == 0){
							scan.close();
							return fileLocation;
							
						}
						isItInApplet = false;
					}
					
					//verifies it is in a applet and then checks for code=
					if(isItInApplet && data.charAt(counter) == 'c' && file.isItThere(data.substring(counter),"code=")){
						recordStartPoint = true;
						counter+=6;
					}
					
					//verifies it is in a applet and then checks for archive=
					if(isItInApplet && data.charAt(counter) == 'a' && file.isItThere(data.substring(counter),"archive=")){
						recordJarName = true;
						counter+=9;
					}
					
					if(recordJarName && data.charAt(counter) == '"'){
						recordJarName = false;
					}else if(recordStartPoint && data.charAt(counter) == '"'){
						recordStartPoint = false;
					}else if(recordJarName){
						foundNameOfJar+=data.charAt(counter);
					}else if(recordStartPoint){
						fileLocation+=data.charAt(counter);
					}
					
				}
			}
			
		}	
		scan.close();
		return "";
	}
	
	public String removeDir( String fileLocation )
	{
		String file = "";
		String temp = "";
		fileLocation = fileLocation.replace( "/", "\\" );
		char tempChar = fileLocation.charAt(fileLocation.length() - 1);
		int fileLocationCounter = 0;
		//Set the reversed file name to temp
		for( fileLocationCounter = 0; tempChar != '\\' && fileLocationCounter < fileLocation.length() - 1; fileLocationCounter++)
		{
			temp += fileLocation.charAt(fileLocation.length() - fileLocationCounter - 1);
			tempChar = fileLocation.charAt(fileLocation.length() - fileLocationCounter - 2);
		}
		//reverses the string
		
		for( fileLocationCounter = 0; fileLocationCounter < temp.length(); fileLocationCounter++)
		{
			file += temp.charAt(temp.length() - fileLocationCounter - 1);
		}
		return file;
	}
	
	//takes substring and sees if main string starts with that
	public boolean isItThere( String mainString, String subString )
	{
		if( mainString.length() < subString.length() )
		{
			return false;
		}
		for( int counter = 0; counter < subString.length(); counter++ )
		{
			if( mainString.charAt( counter ) != subString.charAt( counter ) )
			{
				return false;
			}
		}
		return true;
		
	}
}
