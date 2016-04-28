/*
 * SVGIcon.java
 *
 * Created on April 21, 2005, 10:45 AM
 */

package com.kitfox.svg.app.beans;

import javax.swing.*;
import java.awt.*;
import java.awt.geom.*;
import java.net.*;
import java.beans.*;

import com.kitfox.svg.*;

/**
 *
 * @author kitfox
 */
public class SVGIcon implements Icon
{
    public static final long serialVersionUID = 1;
    
    private PropertyChangeSupport changes = new PropertyChangeSupport(this);
    
    SVGUniverse svgUniverse = SVGCache.getSVGUniverse();
    public static final int INTERP_NEAREST_NEIGHBOR = 0;
    public static final int INTERP_BILINEAR = 1;
    public static final int INTERP_BICUBIC = 2;
    
    private boolean antiAlias;
    private int interpolation = INTERP_NEAREST_NEIGHBOR;
    private boolean clipToViewbox;
    
//    private String svgPath;
    URI svgURI;
    
    private boolean scaleToFit;
    AffineTransform scaleXform = new AffineTransform();
    
//    Dimension preferredSize = new Dimension(100, 100);
    Dimension preferredSize;
    
    /** Creates a new instance of SVGIcon */
    public SVGIcon()
    {
    }
    
    public void addPropertyChangeListener(PropertyChangeListener p)
    {
        changes.addPropertyChangeListener(p);
    }
    
    public void removePropertyChangeListener(PropertyChangeListener p)
    {
        changes.removePropertyChangeListener(p);
    }
    
    /**
     * @return height of this icon
     */
    public int getIconHeight()
    {
        if (scaleToFit && preferredSize != null)
        {
            return preferredSize.height;
        }
        
        SVGDiagram diagram = svgUniverse.getDiagram(svgURI);
        if (diagram == null) return 0;
        return (int)diagram.getHeight();
    }
    
    /**
     * @return width of this icon
     */
    public int getIconWidth()
    {
        if (scaleToFit && preferredSize != null)
        {
            return preferredSize.width;
        }
        
        SVGDiagram diagram = svgUniverse.getDiagram(svgURI);
        if (diagram == null) return 0;
        return (int)diagram.getWidth();
    }
    
    /**
     * Draws the icon to the specified component.
     * @param comp - Component to draw icon to.  This is ignored by SVGIcon, and can be set to null; only gg is used for drawing the icon
     * @param gg - Graphics context to render SVG content to
     * @param x - X coordinate to draw icon
     * @param y - Y coordinate to draw icon
     */
    public void paintIcon(Component comp, Graphics gg, int x, int y)
    {
        Graphics2D g = (Graphics2D)gg;
        
        Object oldAliasHint = g.getRenderingHint(RenderingHints.KEY_ANTIALIASING);
        g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, antiAlias ? RenderingHints.VALUE_ANTIALIAS_ON : RenderingHints.VALUE_ANTIALIAS_OFF);
        
        Object oldInterpolationHint = g.getRenderingHint(RenderingHints.KEY_INTERPOLATION);
        switch (interpolation)
        {
            case INTERP_NEAREST_NEIGHBOR:
                g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_NEAREST_NEIGHBOR);
                break;
            case INTERP_BILINEAR:
                g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
                break;
            case INTERP_BICUBIC:
                g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BICUBIC);
                break;
        }
        
        
        SVGDiagram diagram = svgUniverse.getDiagram(svgURI);
        if (diagram == null) return;
        
        g.translate(x, y);
        diagram.setIgnoringClipHeuristic(!clipToViewbox);
        if (clipToViewbox)
        {
            g.setClip(new Rectangle2D.Float(0, 0, diagram.getWidth(), diagram.getHeight()));
        }
        
        
        
        if (!scaleToFit)
        {
            try
            {
                diagram.render(g);
                g.translate(-x, -y);
                g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, oldAliasHint);
            }
            catch (Exception e)
            {
                throw new RuntimeException(e);
            }
            return;
        }
        
        final int width = getIconWidth();
        final int height = getIconHeight();
//        int width = getWidth();
//        int height = getHeight();
        
        if (width == 0 || height == 0)
        {
            return;
        }
        
//        if (width == 0 || height == 0)
//        {
//           //Chances are we're rendering offscreen
//            Dimension dim = getSize();
//            width = dim.width;
//            height = dim.height;
//            return;
//        }
        
//        g.setClip(0, 0, width, height);
        
        
        final Rectangle2D.Double rect = new Rectangle2D.Double();
        diagram.getViewRect(rect);
        
        scaleXform.setToScale(width / rect.width, height / rect.height);
        
        AffineTransform oldXform = g.getTransform();
        g.transform(scaleXform);
        
        try
        {
            diagram.render(g);
        }
        catch (SVGException e)
        {
            throw new RuntimeException(e);
        }
        
        g.setTransform(oldXform);
        
        
        g.translate(-x, -y);
        
        g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, oldAliasHint);
        if (oldInterpolationHint != null) g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, oldInterpolationHint);
    }
    
    /**
     * @return the universe this icon draws it's SVGDiagrams from
     */
    public SVGUniverse getSvgUniverse()
    {
        return svgUniverse;
    }
    
    public void setSvgUniverse(SVGUniverse svgUniverse)
    {
        SVGUniverse old = this.svgUniverse;
        this.svgUniverse = svgUniverse;
        changes.firePropertyChange("svgUniverse", old, svgUniverse);
    }
    
    /**
     * @return the uni of the document being displayed by this icon
     */
    public URI getSvgURI()
    {
        return svgURI;
    }
    
    /**
     * Loads an SVG document from a URI.
     * @param svgURI - URI to load document from
     */
    public void setSvgURI(URI svgURI)
    {
        URI old = this.svgURI;
        this.svgURI = svgURI;
        
        SVGDiagram diagram = svgUniverse.getDiagram(svgURI);
        if (diagram != null)
        {
            Dimension size = getPreferredSize();
            if (size == null)
            {
                size = new Dimension((int)diagram.getRoot().getDeviceWidth(), (int)diagram.getRoot().getDeviceHeight());
            }
            diagram.setDeviceViewport(new Rectangle(0, 0, size.width, size.height));
        }
        
        changes.firePropertyChange("svgURI", old, svgURI);
    }
    
    /**
     * Loads an SVG document from the classpath.  This function is equivilant to
     * setSvgURI(new URI(getClass().getResource(resourcePath).toString());
     * @param resourcePath - resource to load
     */
    public void setSvgResourcePath(String resourcePath)
    {
        URI old = this.svgURI;
        
        try
        {
            svgURI = new URI(getClass().getResource(resourcePath).toString());
            changes.firePropertyChange("svgURI", old, svgURI);
            
            SVGDiagram diagram = svgUniverse.getDiagram(svgURI);
            if (diagram != null)
            {
                diagram.setDeviceViewport(new Rectangle(0, 0, preferredSize.width, preferredSize.height));
            }
            
        }
        catch (Exception e)
        {
            svgURI = old;
        }
    }
    
    /**
     * If this SVG document has a viewbox, if scaleToFit is set, will scale the viewbox to match the
     * preferred size of this icon
     */
    public boolean isScaleToFit()
    {
        return scaleToFit;
    }
    
    public void setScaleToFit(boolean scaleToFit)
    {
        boolean old = this.scaleToFit;
        this.scaleToFit = scaleToFit;
        changes.firePropertyChange("scaleToFit", old, scaleToFit);
    }
    
    public Dimension getPreferredSize()
    {
        if (preferredSize == null)
        {
            SVGDiagram diagram = svgUniverse.getDiagram(svgURI);
            if (diagram != null)
            {
                //preferredSize = new Dimension((int)diagram.getWidth(), (int)diagram.getHeight());
                setPreferredSize(new Dimension((int)diagram.getWidth(), (int)diagram.getHeight()));
            }
        }
        
        return new Dimension(preferredSize);
    }
    
    public void setPreferredSize(Dimension preferredSize)
    {
        Dimension old = this.preferredSize;
        this.preferredSize = preferredSize;
        
        SVGDiagram diagram = svgUniverse.getDiagram(svgURI);
        if (diagram != null)
        {
            diagram.setDeviceViewport(new Rectangle(0, 0, preferredSize.width, preferredSize.height));
        }
        
        changes.firePropertyChange("preferredSize", old, preferredSize);
    }
    
    
    /**
     * @return true if antiAliasing is turned on.
     * @deprecated
     */
    public boolean getUseAntiAlias()
    {
        return getAntiAlias();
    }
    
    /**
     * @param antiAlias true to use antiAliasing.
     * @deprecated
     */
    public void setUseAntiAlias(boolean antiAlias)
    {
        setAntiAlias(antiAlias);
    }
    
    /**
     * @return true if antiAliasing is turned on.
     */
    public boolean getAntiAlias()
    {
        return antiAlias;
    }
    
    /**
     * @param antiAlias true to use antiAliasing.
     */
    public void setAntiAlias(boolean antiAlias)
    {
        boolean old = this.antiAlias;
        this.antiAlias = antiAlias;
        changes.firePropertyChange("antiAlias", old, antiAlias);
    }
    
    /**
     * @return interpolation used in rescaling images
     */
    public int getInterpolation()
    {
        return interpolation;
    }
    
    /**
     * @param interpolation Interpolation value used in rescaling images.
     * Should be one of
     *    INTERP_NEAREST_NEIGHBOR - Fastest, one pixel resampling, poor quality
     *    INTERP_BILINEAR - four pixel resampling
     *    INTERP_BICUBIC - Slowest, nine pixel resampling, best quality
     */
    public void setInterpolation(int interpolation)
    {
        int old = this.interpolation;
        this.interpolation = interpolation;
        changes.firePropertyChange("interpolation", old, interpolation);
    }
    
    /**
     * clipToViewbox will set a clip box equivilant to the SVG's viewbox before
     * rendering.
     */
    public boolean isClipToViewbox()
    {
        return clipToViewbox;
    }
    
    public void setClipToViewbox(boolean clipToViewbox)
    {
        this.clipToViewbox = clipToViewbox;
    }
    
}
