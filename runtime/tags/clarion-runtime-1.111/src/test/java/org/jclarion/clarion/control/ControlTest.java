package org.jclarion.clarion.control;

import org.jclarion.clarion.constants.Prop;

import junit.framework.TestCase;

public class ControlTest extends TestCase 
{
	public void testDragDrop()
	{
		AbstractControl ac = new StringControl();
		assertEquals("",ac.getProperty(Prop.DRAGID,1).toString());
		assertEquals("",ac.getProperty(Prop.DRAGID,2).toString());
		assertEquals("",ac.getProperty(Prop.DRAGID,3).toString());
		assertEquals("",ac.getProperty(Prop.DROPID,1).toString());
		assertEquals("",ac.getProperty(Prop.DROPID,2).toString());
		assertEquals("",ac.getProperty(Prop.DROPID,3).toString());
		
		ac.setProperty(Prop.DRAGID,2,"#1");
		ac.setProperty(Prop.DROPID,2,"#2");

		assertEquals("",ac.getProperty(Prop.DRAGID,1).toString());
		assertEquals("#1",ac.getProperty(Prop.DRAGID,2).toString());
		assertEquals("",ac.getProperty(Prop.DRAGID,3).toString());
		assertEquals("",ac.getProperty(Prop.DROPID,1).toString());
		assertEquals("#2",ac.getProperty(Prop.DROPID,2).toString());
		assertEquals("",ac.getProperty(Prop.DROPID,3).toString());
	}

	public void testDragDropPreset()
	{
		AbstractControl ac = new StringControl();
		ac.setDragID("#P1");
		ac.setDropID("#P2");
		assertEquals("#P1",ac.getProperty(Prop.DRAGID,1).toString());
		assertEquals("",ac.getProperty(Prop.DRAGID,2).toString());
		assertEquals("",ac.getProperty(Prop.DRAGID,3).toString());
		assertEquals("#P2",ac.getProperty(Prop.DROPID,1).toString());
		assertEquals("",ac.getProperty(Prop.DROPID,2).toString());
		assertEquals("",ac.getProperty(Prop.DROPID,3).toString());
		
		ac.setProperty(Prop.DRAGID,2,"#1");
		ac.setProperty(Prop.DROPID,2,"#2");

		assertEquals("#P1",ac.getProperty(Prop.DRAGID,1).toString());
		assertEquals("#1",ac.getProperty(Prop.DRAGID,2).toString());
		assertEquals("",ac.getProperty(Prop.DRAGID,3).toString());
		assertEquals("#P2",ac.getProperty(Prop.DROPID,1).toString());
		assertEquals("#2",ac.getProperty(Prop.DROPID,2).toString());
		assertEquals("",ac.getProperty(Prop.DROPID,3).toString());
	}
}
