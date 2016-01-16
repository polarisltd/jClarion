package org.jclarion.clarion.swing;

import java.awt.Image;
import java.awt.image.ImageObserver;

public class WaitingImageObserver implements ImageObserver
{
    private boolean done;

    @Override
    public boolean imageUpdate(Image img, int infoflags, int x, int y,
            int width, int height) {
        if ((infoflags & (ImageObserver.ALLBITS | ImageObserver.FRAMEBITS | ImageObserver.ERROR)) != 0) {
            synchronized (this) {
                done = true;
                notifyAll();
            }
            return false;
        }
        return true;
    }

    public boolean waitTillDone() {
        long limit = System.currentTimeMillis() + 5000;

        synchronized (this) {
            while (!done) {
                try {
                    long until = limit - System.currentTimeMillis();
                    if (until <= 0)
                        return false;
                    wait(until);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
        return true;
    }

}
