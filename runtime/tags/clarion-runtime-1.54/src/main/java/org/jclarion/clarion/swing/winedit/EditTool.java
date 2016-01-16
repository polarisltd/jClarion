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
package org.jclarion.clarion.swing.winedit;

import java.awt.BorderLayout;
import java.awt.Container;
import java.awt.Frame;
import java.awt.Rectangle;
import java.awt.event.KeyEvent;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;
import java.util.Collection;
import java.util.LinkedList;

import javax.swing.JDialog;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JSplitPane;
import javax.swing.JTable;
import javax.swing.JTree;
import javax.swing.event.TreeSelectionEvent;
import javax.swing.event.TreeSelectionListener;
import javax.swing.tree.TreeNode;
import javax.swing.tree.TreePath;

import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.control.AbstractControl;

public class EditTool {
    
    private AbstractWindowTarget target;
    
    public EditTool(AbstractWindowTarget target)
    {
        this.target=target;
        
        init();
        run();
    }
    
    private JDialog dialog;
    private Frame frame;
    private PropertyTableModel mode;
    private JTree tree;
    
    public void init()
    {
        mode=new PropertyTableModel();
        
        frame=new Frame();
        dialog = new JDialog(frame,"Window Edit tool");
        dialog.setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
        dialog.addWindowListener(new WindowListener() {

            @Override
            public void windowActivated(WindowEvent e) {
            }

            @Override
            public void windowClosed(WindowEvent e) {
            }

            @Override
            public void windowClosing(WindowEvent e) {
                close();
            }

            @Override
            public void windowDeactivated(WindowEvent e) {
            }

            @Override
            public void windowDeiconified(WindowEvent e) {
            }

            @Override
            public void windowIconified(WindowEvent e) {
            }

            @Override
            public void windowOpened(WindowEvent e) {
            } } );
        
        Container content = dialog.getContentPane();
        JSplitPane pane = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT);
        content.add(pane);

        tree =new JTree(new WindowTreeNode(target));
        tree.addTreeSelectionListener(new TreeSelectionListener() {
            @Override
            public void valueChanged(TreeSelectionEvent e) {

                tree.scrollPathToVisible(e.getPath());
                
                if (e.getPath()==null) {
                    mode.set(null);
                } else {
                    mode.set(((AbstractWinTreeNode)e.getPath().getLastPathComponent()).get());
                }
            } } );

        LinkedList<TreeNode> path = new LinkedList<TreeNode>();
        path.add(new WindowTreeNode(target));
        
        scan(target.getControls(),path);
        
        JPanel right = new JPanel();
        right.setLayout(new BorderLayout());
        JTable table = new JTable(mode);
        right.add(new JScrollPane(table),BorderLayout.CENTER);

        Rectangle r = dialog.getGraphicsConfiguration().getBounds();
        dialog.setSize(r.width/2,r.height/2);
        dialog.setLocation(r.width/8+r.x,r.height/8+r.y);
        dialog.validate();
        
        pane.add(new JScrollPane(tree));
        pane.add(right);
        pane.setDividerLocation(r.width/4);

        target.registerEvent(Event.CLOSEWINDOW,new Runnable(){ public void run() { close(); } },-1);
        
    }
    
    private void close()
    {
        mode.set(null);
        dialog.dispose();
        frame.dispose();
        target.deregisterEvent(Event.CLOSEWINDOW,null,-1);
    }

    private void scan(Collection<? extends AbstractControl> controls,
            LinkedList<TreeNode> path) 
    {
        for (AbstractControl ac : controls) {

            path.add(new ControlTreeNode(path.getLast(),ac));
            
            if (ac.getComponent()!=null) {
                
                TreeNode tna[] = new TreeNode[path.size()];
                path.toArray(tna);
                final TreePath tp  = new TreePath(tna);
                
                ac.getComponent().addMouseListener(new MouseListener() {

                    @Override
                    public void mouseClicked(MouseEvent e) {
                    }

                    
                    @Override
                    public void mouseEntered(MouseEvent e) {
                
                        if (e.getModifiersEx()!=KeyEvent.CTRL_DOWN_MASK) return;
                        
                        if (!dialog.isVisible()) {
                            e.getComponent().removeMouseListener(this);
                            return;
                        }
                        e.consume();
                        tree.setSelectionPath(tp);
                    }

                    @Override
                    public void mouseExited(MouseEvent e) {
                    }

                    @Override
                    public void mousePressed(MouseEvent e) {
                    }

                    @Override
                    public void mouseReleased(MouseEvent e) {
                    } });
            }

            scan(ac.getChildren(),path);
            
            path.removeLast();
        }
        
    }

    public void run()
    {
        Thread t = new Thread() {
            public void run() {
                dialog.setVisible(true);
            }
        };
        t.start();
    }
}
