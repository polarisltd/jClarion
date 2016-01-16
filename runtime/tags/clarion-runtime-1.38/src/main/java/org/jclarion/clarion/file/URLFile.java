package org.jclarion.clarion.file;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;

public class URLFile extends RingBufferedInputStreamClarionFile
{
    private URL url;
    
    public URLFile(URL url)
    {
        this.url=url;
    }

    @Override
    protected InputStream createStream() throws IOException 
    {
        return url.openStream();
    }

    @Override
    public String getName() {
        String path = url.getPath();
        
        int pos=path.length();
        while (pos>0 && path.charAt(pos-1)=='/') {
            pos--;
        }
        if (pos>0) {
            int slash = path.lastIndexOf('/',pos-1);
            if (slash>=0) {
                path=path.substring(slash+1,pos);
            } else {
                path=path.substring(0,pos);
            }
        }
        return path;
    }



    private long lenCache=-1;
    @Override
    public long length() throws IOException {
        if (lenCache==-1) {
            try {
                lenCache = url.openConnection().getContentLength();
            } catch (IOException ex) { }
            if (lenCache<0) lenCache=super.length();
        }
        return lenCache;
    }

}
