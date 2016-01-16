package org.jclarion.clarion.file;

import java.io.IOException;
import java.io.InputStream;

public abstract class InputStreamDecorator extends InputStream
{
    protected abstract InputStream base();

    @Override
    public int available() throws IOException {
        return base().available();
    }

    @Override
    public void close() throws IOException {
        base().close();
    }

    @Override
    public void mark(int readlimit) {
        base().mark(readlimit);
    }

    @Override
    public boolean markSupported() {
        return base().markSupported();
    }

    @Override
    public int read() throws IOException {
        return 0;
    }

    @Override
    public int read(byte[] b, int off, int len) throws IOException {
        return base().read(b, off, len);
    }

    @Override
    public int read(byte[] b) throws IOException {
        return base().read(b);
    }

    @Override
    public void reset() throws IOException {
        base().reset();
    }

    @Override
    public long skip(long n) throws IOException {
        return base().skip(n);
    }

}
