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
package org.jclarion.clarion.mojo.compile;

import org.apache.maven.artifact.DependencyResolutionRequiredException;
import org.apache.maven.plugin.AbstractMojo;
import org.apache.maven.plugin.MojoExecutionException;
import org.apache.maven.plugin.MojoFailureException;
import org.apache.maven.project.MavenProject;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLClassLoader;
import java.util.ArrayList;
import java.util.List;

import org.apache.maven.plugin.logging.Log;

import org.jclarion.clarion.compile.ClarionCompiler;

/**
 * Goal that picks up clarion source code in a project and compiles it
 *
 * @goal clarion
 * 
 * @phase process-sources
 * @requiresDependencyResolution compile
 * @requiresProject true
 * 
 * @author Andrew Barnham
 */
public class ClarionMojo extends AbstractMojo {
    
    /* --------------------------------------------------------------------
     * The following are Maven specific parameters, rather than specificlly
     * options that clarion can use
     * 
     */
    
    /**
     * @parameter expression="${project}"
     * @required
     * @readonly
     */
    protected MavenProject project;

    /**
     * Specifies the directory containing grammar files. 
     *
     * @parameter default-value="${basedir}/src/main/clarion"
     * @required
     */
    private File sourceDirectory;
    
    /**
     * Location for generated Java files. 
     *
     * @parameter default-value="${project.build.directory}/generated-sources/clarion"
     * @required
     */
    private File outputDirectory;
    
    /**
     * Name of the main program
     * 
     * @parameter default-value="main.clw"
     * @required
     */
    private String mainSourceFile;
    
    public File getSourceDirectory() {
        return sourceDirectory;
    }

    public File getOutputDirectory() {
        return outputDirectory;
    }
    
    public String getMainSourceFile()
    {
        return mainSourceFile;
    }

    void addSourceRoot(File outputDir) {
        project.addCompileSourceRoot(outputDir.getPath());
    }
    
    void setContextLoader()
    {
        try {
            List<URL> urls = new ArrayList<URL>();
            
            for (Object path : project.getCompileClasspathElements() ) {
                File f = new File(path.toString());
                urls.add(f.toURI().toURL());
            }
            
            Thread t = Thread.currentThread();
            
            t.setContextClassLoader(new URLClassLoader(
                    (URL[])urls.toArray(new URL[urls.size()]),
                    t.getContextClassLoader()));
            
        } catch (DependencyResolutionRequiredException e) {
            e.printStackTrace();
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }
    }
    
    /**
     * An instance of the compiler
     */
    protected ClarionCompiler tool;

    /**
     * The main entry point for this Mojo, it is responsible for converting
     * clarion source into java.
     * 
     */
    public void execute()
            throws MojoExecutionException, MojoFailureException {

        Log log = getLog();
        
        if (log.isDebugEnabled()) {
            log.debug("Clarion: Source: " + sourceDirectory);
            log.debug("Clarion: Output: " + outputDirectory);
            log.debug("Clarion: Main: " + mainSourceFile);
        }

        if (System.getProperty("clarion.gen.skip", "false").equals("true")) {
            log.info("Skipping Clarion Re-Generation");
        } else {
            File outputDir = getOutputDirectory();

            if (!outputDir.exists()) {
                outputDir.mkdirs();
            }

            tool = new ClarionCompiler();

            if (!sourceDirectory.exists()) {
                if (log.isInfoEnabled()) {
                    log.info("No clarion source in "
                            + sourceDirectory.getAbsolutePath());
                }
                return;
            } else {
                if (log.isInfoEnabled()) {
                    log.info("Clarion: Processing source directory "
                            + sourceDirectory.getAbsolutePath());
                }
            }

            ClassLoader cl = Thread.currentThread().getContextClassLoader();

            try {
                setContextLoader();
                tool.compile(sourceDirectory.toString(), mainSourceFile,
                        outputDirectory);
            } catch (IOException e) {
                getLog().error(e);
                throw new MojoExecutionException(e.getMessage());
            } finally {
                Thread.currentThread().setContextClassLoader(cl);
            }
        }
        
        // All looks good, so we need to tel Maven about the sources that
        if (project != null) {
            addSourceRoot(this.getOutputDirectory());
        }
    }
}
