package org.jclarion.clarion.swing;

import java.awt.BorderLayout;
import java.awt.Component;
import java.awt.Container;
import java.util.List;

import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.border.CompoundBorder;
import javax.swing.border.EmptyBorder;

import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.runtime.CWinImpl;

public class ClarionStatusPane extends JPanel 
{
    private static final long serialVersionUID = -402058107201081579L;
    private Container 				statusBar;
    private AbstractWindowTarget 	_awt;
    private AbstractWindowTarget 	child;
    
    public ClarionStatusPane(AbstractWindowTarget awt,Component base)
    {
        setLayout(new BorderLayout(0,0));
        add(base,BorderLayout.CENTER);
        this._awt=awt;
    }
    
    public AbstractWindowTarget getTarget()
    {
        AbstractWindowTarget consider;
        synchronized(this) {
            consider=child;
        }
        if (consider!=null) {
            synchronized(consider) {
                if (consider.getStatus()!=null) {
                    if (!consider.getStatus().isEmpty()) {
                        if (consider.getStatus().get(0).getWidth()!=0) return consider;
                    }
                }
            }
        }
        return _awt;
    }
    
    public void setChild(AbstractWindowTarget target)
    {
        synchronized(this) {
            child=target;
        }
        notifyStatusChange();
    }

    public void clearChild(AbstractWindowTarget target)
    {
        synchronized(this) {
            if (child==target) child=null;
        }
        notifyStatusChange();
    }
    
    public synchronized Container getStatusBar()
    {
        return statusBar;
    }
    
    public void notifyStatusChange() 
    {
    	CWinImpl.run(_awt,AbstractWindowTarget.NOTIFY_STATUS_CHANGE);
    }

    public void doNotifyStatusChange()
    {
		AbstractWindowTarget awt = getTarget();

		int[] sizes;
		String[] values;
		int size = 0;

		synchronized (awt) {
			List<AbstractWindowTarget.StatusBar> l = awt.getStatus();
			if (l != null) {
				for (int scan = 0; scan < l.size(); scan++) {
					AbstractWindowTarget.StatusBar bar = l.get(scan);
					if (bar.getWidth() == 0) break;
					size = scan + 1;
				}
			}

			sizes = new int[size];
			values = new String[size];
			for (int scan = 0; scan < size; scan++) {
				AbstractWindowTarget.StatusBar bar = l.get(scan);
				sizes[scan] = bar.getWidth();
				values[scan] = bar.getValue();
			}
		}

		JPanel panel = null;
		if (size > 0) {

			for (int scan = 0; scan < size; scan++) {
				sizes[scan] = awt.widthDialogToPixels(sizes[scan]);
			}

			panel = new JPanel(new StatusLayout(sizes));
			for (String label : values) {
				if (label.equals(""))
					label = " ";
				JLabel test = new JLabel(label);
				test.setBorder(new CompoundBorder(new ClarionBorder(0, -1,
						null), new EmptyBorder(2, 5, 2, 5)));
				panel.add(test);
			}
		}
		if (statusBar != null) {
			remove(statusBar);
		}
		statusBar = panel;
		if (statusBar != null) {
			add(statusBar, BorderLayout.SOUTH);
		}
		validate();
    }
}
