/**
 * Copyright 2010, by Andrew Barnham
 *
 * The contents of this file are subject to
 * GNU Lesser General Public License (LGPL), v.3
 * http://www.gnu.org/licenses/lgpl.txt
 * 
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied.
 */
package org.jclarion.clarion.compile.javac;

import java.io.File;
import java.io.FileFilter;
import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

import javax.tools.FileObject;
import javax.tools.ForwardingJavaFileManager;
import javax.tools.JavaFileManager;
import javax.tools.JavaFileObject;
import javax.tools.StandardLocation;
import javax.tools.JavaFileObject.Kind;

import org.jclarion.clarion.compile.java.ClassRepository;
import org.jclarion.clarion.compile.java.JavaClass;

public class ClarionFileManager extends ForwardingJavaFileManager<JavaFileManager>
{
    private Map<String,ClarionJavaFileObject> source=new HashMap<String,ClarionJavaFileObject>();

    private Map<String,ClarionJavaFileObject> target=new HashMap<String,ClarionJavaFileObject>();

    public ClarionFileManager(JavaFileManager fileManager,String pkg,String name,String content) {
        super(fileManager);
        source.put(pkg+"."+name,new ClarionJavaFileObject(
            this,Kind.SOURCE,pkg,pkg+"."+name,content));
    }    
    
    public ClarionFileManager(JavaFileManager fileManager) {
        super(fileManager);
        
        for (JavaClass jc : ClassRepository.getAll() ) {
            source.put(jc.getPackage()+"."+jc.getName(),
                new ClarionJavaFileObject(
                    this,
                    Kind.SOURCE,jc.getPackage(),
                    jc.getPackage()+"."+jc.getName(),
                    jc.toJavaSource()));
        }
    }

    
    
    @Override
    public JavaFileObject getJavaFileForInput(Location location,
            String className, Kind kind) throws IOException 
    {
        JavaFileObject result = super.getJavaFileForInput(location, className, kind);;  
        //System.out.println("* getJavaFileForInput("+location+","+className+","+kind+") = "+result);
        return result;
    }

    @Override
    public boolean hasLocation(Location location) {
        if (location==StandardLocation.SOURCE_PATH) return true;
        
        boolean result = super.hasLocation(location);
        //System.out.println("* hasLocation("+location+") = "+result);
        return result;
    }

    public ClarionJavaFileObject getSource(String name)
    {
        return source.get(name);
    }

    public ClarionJavaFileObject getTarget(String name)
    {
        return target.get(name);
    }


    @Override
    public JavaFileObject getJavaFileForOutput(Location location,
            String className, Kind kind, FileObject sibling) throws IOException {

        ClarionJavaFileObject cjfo = new ClarionJavaFileObject(this,Kind.CLASS,null,className,null);
        target.put(className,cjfo);

        //System.out.println("* getJavaFileForOutput("+location+","+className+","+kind+","+sibling+") = "+cjfo);
        
        return cjfo;
    }

    public Iterable<? extends JavaFileObject> getAllSourceFiles() {
        return source.values();
    }



    @Override
    public boolean isSameFile(FileObject a, FileObject b) {
        
        if (a instanceof ClarionJavaFileObject) {
            return a==b;
        }
        
        return super.isSameFile(a, b);
    }

    @Override
    public void close() throws IOException {
        // TODO Auto-generated method stub
        super.close();
    }

    @Override
    public void flush() throws IOException {
        // TODO Auto-generated method stub
        super.flush();
    }

    @Override
    public ClassLoader getClassLoader(Location location) {
        // TODO Auto-generated method stub
        return super.getClassLoader(location);
    }

    @Override
    public FileObject getFileForInput(Location location, String packageName,
            String relativeName) throws IOException {
        
        FileObject result = super.getFileForInput(location, packageName, relativeName);
        //System.out.println("* getFileForInput("+location+","+packageName+","+relativeName+") = "+result);
        return result;
    }

    @Override
    public FileObject getFileForOutput(Location location, String packageName,
            String relativeName, FileObject sibling) throws IOException {

        FileObject result =  super.getFileForOutput(location, packageName, relativeName, sibling);
        
        //System.out.println("* getFileForOutput("+location+","+packageName+","+relativeName+","+sibling+") = "+result);
        return result;
    }

    @Override
    public boolean handleOption(String current, Iterator<String> remaining) {
        
        boolean result = super.handleOption(current, remaining);
        //System.out.println("* handleOption("+current+","+remaining+") = "+result);
        return result;
    }

    @Override
    public String inferBinaryName(Location location, JavaFileObject file) {
        String result;
        if (file instanceof MavenHack) {
            result=file.getName().replace('/','.').replaceAll(".class$","");
        } else {
            result = super.inferBinaryName(location, file);
        }
        //System.out.println("* inferBinaryName("+location+","+file+") = "+result);
        return result;
    }

    @Override
    public int isSupportedOption(String option) {

        int result = super.isSupportedOption(option);
        //System.out.println("* isSupportedOption("+option+") = "+result);
        return result;
    }

    @Override
    public Iterable<JavaFileObject> list(Location location, String packageName,
            Set<Kind> kinds, boolean recurse) throws IOException {
        
        Iterable<JavaFileObject> result =  super.list(location, packageName, kinds, recurse);
        
        if (!result.iterator().hasNext() && location==StandardLocation.CLASS_PATH) {

            
            String pkg = packageName.replace('.','/');
            
            List<JavaFileObject> l = new ArrayList<JavaFileObject>();
            Enumeration<URL> e = getClass().getClassLoader().getResources(pkg);
            
            while (e.hasMoreElements()) {
                URL u = e.nextElement();
                if (u.getProtocol().equals("file")) {
                    File base = new File(u.getPath());
                    int baseLength = base.toString().length();
                    File kids[]=base.listFiles(new FileFilter() {
                        @Override
                        public boolean accept(File pathname) {
                            return pathname.getName().endsWith(".class");
                        } 
                    } );
                
                    for (final File f : kids ) {
                        
                        final String name = packageName+f.toString().substring(baseLength);
                        l.add(new MavenHackFileJava(f,name));
                    }
                }
                
                if (u.getProtocol().equals("jar")) {
                    String path = u.getPath();
                    int spos = path.indexOf('!');

                    File jar = new File(path.substring(0,spos).substring(5));
                    
                    String zippath = path.substring(spos+1);
                    if (!zippath.endsWith("/")) zippath=zippath+"/";
                    if (zippath.startsWith("/")) zippath=zippath.substring(1);
                    
                    ZipFile zf = new ZipFile(jar);
                    Enumeration<? extends ZipEntry> bits = zf.entries();

                    while (bits.hasMoreElements()) {
                        ZipEntry ze = bits.nextElement();
                        String s = ze.getName();
                        if (!s.endsWith(".class")) continue;
                        if (!s.startsWith(zippath)) continue;
                        if (s.indexOf('/',zippath.length())>=0) continue;
                        try {
                            l.add(new MavenHackJarJava(u.toURI(),jar,ze,s));
                        } catch (URISyntaxException e1) {
                            e1.printStackTrace();
                        }
                    }
                }
                                    
            }
            
            result=l;
        }
        
        //System.out.println("* list("+location+","+packageName+","+kinds+","+recurse+") = "+result);
        
        return result;
    }
}
