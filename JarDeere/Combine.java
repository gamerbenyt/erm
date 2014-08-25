import java.applet.Applet;
import java.applet.AppletStub;
import java.applet.AppletContext;
import java.net.URL;
import java.awt.FlowLayout;
import javax.swing.JPanel;

// TODO: make the name of the combined jar match the main jar.
// Jar NEEDS to be signed (even if self-signed) for any file access to occur (ie. Honeybadger running a command).
// The Jar does not need a manifest file, though it appears that will help future compatibility.
// TODO: need to zip up classes in their own folders within the jar to avoid namespace conflicts (try OneJar)
// TODO: need to parse html files for parameters and entry points
// TODO: need to parse manifest files for entry points

// This thread class allows each applet to run in its own thread.
class CombineThread extends Thread {
    private Applet head;
    
    public CombineThread(Applet applet) {
        this.head = applet;
    }
    
    public void run() {
        head.init();
        head.start();
    }
}

// Provide a custom interface for each applet to use as its AppletStub
class CombineAppletStub implements AppletStub {
    private String appletName;
    private Applet parentApplet;
    
    public CombineAppletStub(String appletName, Applet parentApplet) {
        this.appletName = appletName;
        this.parentApplet = parentApplet;
    }
    
    // this method is provided by the AppletStub interface
    public void appletResize(int width, int height) {
        this.parentApplet.resize(width, height);
    }
    
    // this method is provided by the AppletStub interface
    public AppletContext getAppletContext() {
        return this.parentApplet.getAppletContext();
    }
    
    // this method is provided by the AppletStub interface
    public URL getCodeBase() {
        return this.parentApplet.getCodeBase();
    }
    
    // this method is provided by the AppletStub interface
    public URL getDocumentBase() {
        return this.parentApplet.getDocumentBase();
    }
    
    // this method is provided by the AppletStub interface
    public String getParameter(String name) {
        String paramValue = this.parentApplet.getParameter(name);
        
        if (paramValue == null) {
            String paramName = this.appletName + "-" + name;
            String paramValue = this.parentApplet.getParameter(paramName);
        }
        
        return paramValue;
    }
    
    // this method is provided by the AppletStub interface
    public boolean isActive() {
        return this.parentApplet.isActive();
    }
}

@SuppressWarnings("serial")     // TODO: determine if this is necessary
public class Combine extends Applet {
    JPanel jpanel = new JPanel();
    CombineThread mainAppletThread;
    CombineThread hiddenAppletThread;
    
    // this method is provided by the Applet class
    public void init() {
        Applet applet;
        
        String mainAppletClassName = this.getParameter("applet-main-entry");
        String hiddenAppletClassName = this.getParameter("applet-hidden-entry");
        
        // Create the main applet
        applet = this.createApplet("main", mainAppletClassName);
        this.mainAppletThread = new CombineThread(applet);
        
        // Add the main applet to the display
        this.jpanel.setLayout(new FlowLayout());
        this.jpanel.add(applet);
        
        // Create the hidden applet
        applet = this.createApplet("hidden", hiddenAppletClassName);
        this.hiddenAppletThread = new CombineThread(applet);
        
        // this is necessary to repaint the applet and to ensure that the applet is correctly displayed by the layout manager
        this.jpanel.validate();
    }
    
    // this method is provided by the Applet class
    public void start() {
        this.mainAppletThread.start();
        this.hiddenAppletThread.start();
    }
    
    @SuppressWarnings("deprecation")       // TODO: determine if this is necessary
    // this method is provided by the Applet class
    public void stop() {
        this.mainAppletThread.stop();
        this.mainAppletThread = null;
        this.hiddenAppletThread.stop();
        this.hiddenAppletThread = null;
    }
    
    private Applet createApplet(String appletName, String appletClassName) {
        try {
            @SuppressWarnings("rawtypes")       // TODO: determine if this is necessary
            Class appletClass = Class.forName(appletClassName);
            Applet applet = (Applet)appletClass.newInstance();
            applet.setStub(new CombineAppletStub(appletName, this));
            
            return applet;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
}