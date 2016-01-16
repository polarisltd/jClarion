package org.jclarion.clarion.appgen.symbol;

import org.jclarion.clarion.appgen.symbol.user.AppLoaderScope;
import org.jclarion.clarion.appgen.symbol.user.UserSymbolScope;

import junit.framework.TestCase;

/**
 *  Verify behaviours of a scoped symbol. Particularly fixing/dependency behaviour 
 *  
 * @author barney
 *
 */
public class UserSymbolScopeTest extends TestCase 
{
	public void testNull()
	{
		UserSymbolScope scope = new UserSymbolScope("TEST");		
		assertNull(scope.get("test"));
	}

	public void testSimpleDeclare()
	{
		UserSymbolScope scope = new UserSymbolScope("TEST");
		
		scope.declare("test",false);
		assertNotNull(scope.get("test"));
		assertNull(scope.get("test").getValue());
		scope.get("Test").scalar().setValue(new StringSymbolValue("some value"));

		scope.declare("%file",false);
		assertNotNull(scope.get("%file"));
		scope.get("%file").scalar().setValue(new IntSymbolValue(10));
		
		assertEquals("10",scope.get("%file").getValue().getString());
		assertEquals("some value",scope.get("Test").getValue().getString());
	}
	
	public void testNestedDeclare()
	{
		UserSymbolScope parent = new UserSymbolScope("TEST");
		UserSymbolScope scope = new UserSymbolScope("TEST");
		scope.setParent(parent);
		
		scope.declare("test",false);
		assertNotNull(scope.get("test"));
		assertNull(scope.get("test").getValue());
		scope.get("Test").scalar().setValue(new StringSymbolValue("some value"));

		parent.declare("%file",false);
		assertNotNull(scope.get("%file"));
		scope.get("%file").scalar().setValue(new IntSymbolValue(10));
		
		assertEquals("10",scope.get("%file").getValue().getString());
		assertEquals("some value",scope.get("Test").getValue().getString());

		assertEquals("10",parent.get("%file").getValue().getString());
		assertNull(parent.get("Test"));

		scope.get("Test").scalar().setValue(new StringSymbolValue("some new value"));
		scope.get("%file").scalar().setValue(new IntSymbolValue(20));

		assertEquals("20",scope.get("%file").getValue().getString());
		assertEquals("some new value",scope.get("Test").getValue().getString());

		assertEquals("20",parent.get("%file").getValue().getString());
		assertNull(parent.get("Test"));
	}
	
	public void testSimpleDependency()
	{
		UserSymbolScope scope = new UserSymbolScope("TEST");

		scope.declare("%file",false);
		scope.declare("fieldName",false,"STRING","%file");
		scope.declare("fieldPicture",false,"STRING","%file");
		
		scope.get("%file").scalar().setValue(SymbolValue.construct("partnumber"));
		scope.get("fieldName").scalar().setValue(SymbolValue.construct("The Part Number"));
		scope.get("fieldPicture").scalar().setValue(SymbolValue.construct("@s40"));
		
		scope.get("%file").scalar().setValue(SymbolValue.construct("qty"));
		scope.get("fieldName").scalar().setValue(SymbolValue.construct("The Part Qty"));
		scope.get("fieldPicture").scalar().setValue(SymbolValue.construct("@n10.2"));
	
		scope.get("%file").scalar().setValue(SymbolValue.construct("partnumber"));
		assertEquals("The Part Number",scope.get("fieldname").getValue().getString());
		assertEquals("@s40",scope.get("fieldpicture").getValue().getString());

		scope.get("%file").scalar().setValue(SymbolValue.construct("qty"));
		assertEquals("The Part Qty",scope.get("fieldname").getValue().getString());
		assertEquals("@n10.2",scope.get("fieldpicture").getValue().getString());
	}
	
	public void testCloneInvariant_B()
	{
		UserSymbolScope scope = new UserSymbolScope("TEST");

		scope.declare("%file",false);
		scope.declare("fieldName",false,"STRING","%file");
		scope.declare("fieldPicture",false,"STRING","%file");

		scope.get("%file").scalar().setValue(SymbolValue.construct("HERE"));
		scope.get("fieldName").scalar().setValue(SymbolValue.construct("THERE"));

		UserSymbolScope scope_2 = new UserSymbolScope(scope,null);
		scope_2.get("%file").scalar().setValue(SymbolValue.construct("HERE"));
		scope_2.get("fieldName").scalar().setValue(SymbolValue.construct("THERE"));

		scope_2.dispose();		
		try {
			assertNull(scope_2.get("fieldName"));
			fail();
		} catch (NullPointerException ex) { 			
		}
	}
	
	public void testCloneSimpleDependency()
	{
		//create 
		UserSymbolScope scope = new UserSymbolScope("TEST");

		scope.declare("%file",false);
		scope.declare("fieldName",false,"STRING","%file");
		scope.declare("fieldPicture",false,"STRING","%file");

		scope.get("%file").scalar().setValue(SymbolValue.construct("partnumber"));
		
		scope.get("%file").scalar().setValue(SymbolValue.construct("partnumber"));
		scope.get("fieldName").scalar().setValue(SymbolValue.construct("The Part Number"));
		scope.get("fieldPicture").scalar().setValue(SymbolValue.construct("@s40"));
		
		scope.get("%file").scalar().setValue(SymbolValue.construct("qty"));
		scope.get("fieldName").scalar().setValue(SymbolValue.construct("The Part Qty"));
		scope.get("fieldPicture").scalar().setValue(SymbolValue.construct("@n10.2"));
	
		scope.get("%file").scalar().setValue(SymbolValue.construct("partnumber"));
		assertEquals("The Part Number",scope.get("fieldname").getValue().getString());
		assertEquals("@s40",scope.get("fieldpicture").getValue().getString());

		scope.get("%file").scalar().setValue(SymbolValue.construct("qty"));
		assertEquals("The Part Qty",scope.get("fieldname").getValue().getString());
		assertEquals("@n10.2",scope.get("fieldpicture").getValue().getString());
		
		//create new scope
		
		UserSymbolScope scope_2 = new UserSymbolScope(scope,null);
		
		// test new scope
		
		scope_2.get("%file").scalar().setValue(SymbolValue.construct("partnumber"));
		assertEquals("The Part Number",scope_2.get("fieldname").getValue().getString());
		assertEquals("@s40",scope_2.get("fieldpicture").getValue().getString());

		scope_2.get("%file").scalar().setValue(SymbolValue.construct("qty"));
		assertEquals("The Part Qty",scope_2.get("fieldname").getValue().getString());
		assertEquals("@n10.2",scope_2.get("fieldpicture").getValue().getString());
		
		// modify new scope
		scope_2.get("%file").scalar().setValue(SymbolValue.construct("partnumber #2"));
		scope_2.get("%file").scalar().setValue(SymbolValue.construct("partnumber"));
		scope_2.get("fieldName").scalar().setValue(SymbolValue.construct("The Adjusted Part Number"));

		// test new scope
		
		scope_2.get("%file").scalar().setValue(SymbolValue.construct("partnumber"));
		assertEquals("The Adjusted Part Number",scope_2.get("fieldname").getValue().getString());
		assertEquals("@s40",scope_2.get("fieldpicture").getValue().getString());

		scope_2.get("%file").scalar().setValue(SymbolValue.construct("qty"));
		assertEquals("The Part Qty",scope_2.get("fieldname").getValue().getString());
		assertEquals("@n10.2",scope_2.get("fieldpicture").getValue().getString());
		
		// dispose new scope
		scope_2.dispose();
		
		// tweak old scope
		scope.get("%file").scalar().setValue(SymbolValue.construct("partnumber"));
		scope.get("fieldName").scalar().setValue(SymbolValue.construct("The Modified Part Number"));
				
		//create new scope
		
		scope_2 = new UserSymbolScope(scope,null);
		
		// test new scope
		
		scope_2.get("%file").scalar().setValue(SymbolValue.construct("partnumber"));
		assertEquals("The Modified Part Number",scope_2.get("fieldname").getValue().getString());
		assertEquals("@s40",scope_2.get("fieldpicture").getValue().getString());

		scope_2.get("%file").scalar().setValue(SymbolValue.construct("qty"));
		assertEquals("The Part Qty",scope_2.get("fieldname").getValue().getString());
		assertEquals("@n10.2",scope_2.get("fieldpicture").getValue().getString());
		
		// modify new scope
		scope_2.get("%file").scalar().setValue(SymbolValue.construct("partnumber #2"));
		scope_2.get("%file").scalar().setValue(SymbolValue.construct("partnumber"));
		scope_2.get("fieldName").scalar().setValue(SymbolValue.construct("The Adjusted Part Number"));

		// test new scope
		
		scope_2.get("%file").scalar().setValue(SymbolValue.construct("partnumber"));
		assertEquals("The Adjusted Part Number",scope_2.get("fieldname").getValue().getString());
		assertEquals("@s40",scope_2.get("fieldpicture").getValue().getString());

		scope_2.get("%file").scalar().setValue(SymbolValue.construct("qty"));
		assertEquals("The Part Qty",scope_2.get("fieldname").getValue().getString());
		assertEquals("@n10.2",scope_2.get("fieldpicture").getValue().getString());
				
	}
	
	public void testCloneSimpleDependencyWithPlaceholders()
	{
		//create 
		UserSymbolScope scope = new UserSymbolScope("TEST");
		scope.setParent(new AppLoaderScope());

		scope.declare("fieldName",false,"STRING","%file");
		scope.declare("fieldPicture",false,"STRING","%file");

		set(scope,"%file","partnumber");
		scope.get("fieldName").scalar().setValue(SymbolValue.construct("The Part Number"));
		scope.get("fieldPicture").scalar().setValue(SymbolValue.construct("@s40"));
		
		set(scope,"%file","qty");
		scope.get("fieldName").scalar().setValue(SymbolValue.construct("The Part Qty"));
		scope.get("fieldPicture").scalar().setValue(SymbolValue.construct("@n10.2"));
	
		set(scope,"%file","partnumber");
		assertEquals("The Part Number",scope.get("fieldname").getValue().getString());
		assertEquals("@s40",scope.get("fieldpicture").getValue().getString());

		set(scope,"%file","qty");
		assertEquals("The Part Qty",scope.get("fieldname").getValue().getString());
		assertEquals("@n10.2",scope.get("fieldpicture").getValue().getString());
		
		//create new scope
		
		UserSymbolScope realParent=new UserSymbolScope("TEST");
		realParent.declare("%file",true);
		
		UserSymbolScope scope_2 = new UserSymbolScope(scope,realParent);
		
		// test old scope
		
		set(scope,"%file","partnumber");
		assertEquals("The Part Number",scope.get("fieldname").getValue().getString());
		assertEquals("@s40",scope.get("fieldpicture").getValue().getString());

		set(scope,"%file","qty");
		assertEquals("The Part Qty",scope.get("fieldname").getValue().getString());
		assertEquals("@n10.2",scope.get("fieldpicture").getValue().getString());

		// test new scope
		
		set(realParent,"%file","partnumber");
		assertEquals("The Part Number",scope_2.get("fieldname").getValue().getString());
		assertEquals("@s40",scope_2.get("fieldpicture").getValue().getString());

		set(realParent,"%file","qty");
		assertEquals("The Part Qty",scope_2.get("fieldname").getValue().getString());
		assertEquals("@n10.2",scope_2.get("fieldpicture").getValue().getString());
		
		// modify new scope
		set(realParent,"%file","partnumber #2");
		set(scope_2,"%file","partnumber");
		scope_2.get("fieldName").scalar().setValue(SymbolValue.construct("The Adjusted Part Number"));

		// test new scope
		
		set(realParent,"%file","partnumber");
		assertEquals("The Adjusted Part Number",scope_2.get("fieldname").getValue().getString());
		assertEquals("@s40",scope_2.get("fieldpicture").getValue().getString());

		set(realParent,"%file","qty");
		assertEquals("The Part Qty",scope_2.get("fieldname").getValue().getString());
		assertEquals("@n10.2",scope_2.get("fieldpicture").getValue().getString());
		
		// dispose new scope
		scope_2.dispose();
		
		// tweak old scope
		set(scope,"%file","partnumber");
		scope.get("fieldName").scalar().setValue(SymbolValue.construct("The Modified Part Number"));
				
		//create new scope
		
		scope_2 = new UserSymbolScope(scope,realParent);
		
		// test old scope
		
		set(scope,"%file","partnumber");
		assertEquals("The Modified Part Number",scope.get("fieldname").getValue().getString());
		assertEquals("@s40",scope.get("fieldpicture").getValue().getString());

		set(scope,"%file","qty");
		assertEquals("The Part Qty",scope.get("fieldname").getValue().getString());
		assertEquals("@n10.2",scope.get("fieldpicture").getValue().getString());

		// test new scope
		
		set(realParent,"%file","partnumber");
		assertEquals("The Modified Part Number",scope_2.get("fieldname").getValue().getString());
		assertEquals("@s40",scope_2.get("fieldpicture").getValue().getString());

		set(realParent,"%file","qty");
		assertEquals("The Part Qty",scope_2.get("fieldname").getValue().getString());
		assertEquals("@n10.2",scope_2.get("fieldpicture").getValue().getString());
		
		// modify new scope
		set(scope_2,"%file","partnumber #2");
		set(scope_2,"%file","partnumber");
		scope_2.get("fieldName").scalar().setValue(SymbolValue.construct("The Adjusted Part Number"));

		// test old scope
		
		set(scope,"%file","partnumber");
		assertEquals("The Modified Part Number",scope.get("fieldname").getValue().getString());
		assertEquals("@s40",scope.get("fieldpicture").getValue().getString());

		set(scope,"%file","qty");
		assertEquals("The Part Qty",scope.get("fieldname").getValue().getString());
		assertEquals("@n10.2",scope.get("fieldpicture").getValue().getString());

		// test new scope
		
		set(scope_2,"%file","partnumber");
		assertEquals("The Adjusted Part Number",scope_2.get("fieldname").getValue().getString());
		assertEquals("@s40",scope_2.get("fieldpicture").getValue().getString());

		set(scope_2,"%file","qty");
		assertEquals("The Part Qty",scope_2.get("fieldname").getValue().getString());
		assertEquals("@n10.2",scope_2.get("fieldpicture").getValue().getString());
				
	}
	
	private void set(UserSymbolScope scope, String field, String val) 
	{
		SymbolValue sv = SymbolValue.construct(val);
		ListSymbolValue lsv = scope.get(field).list().values();
		if (!lsv.fix(sv)) {
			lsv.add(sv);
			lsv.fix(sv);
		}
	}

	public void testNestedDependency()
	{
		UserSymbolScope scope = new UserSymbolScope("TEST");

		scope.declare("file",false);
		scope.declare("%file",false,"STRING","file");
		scope.declare("fileName",false,"STRING","file");
		scope.declare("fieldName",false,"STRING","file","%file");
		scope.declare("fieldPicture",false,"STRING","file","%file");
		
		scope.get("file").scalar().setValue(SymbolValue.construct("invhead"));
		scope.get("%file").scalar().setValue(SymbolValue.construct("partnumber"));
		
		scope.get("fileName").scalar().setValue(SymbolValue.construct("Spares Invoices"));
		scope.get("fieldName").scalar().setValue(SymbolValue.construct("The Part Number"));
		scope.get("fieldPicture").scalar().setValue(SymbolValue.construct("@s40"));
		
		scope.get("%file").scalar().setValue(SymbolValue.construct("qty"));
		scope.get("fieldName").scalar().setValue(SymbolValue.construct("The Part Qty"));
		scope.get("fieldPicture").scalar().setValue(SymbolValue.construct("@n10.2"));

		scope.get("file").scalar().setValue(SymbolValue.construct("jobhead"));
		scope.get("%file").scalar().setValue(SymbolValue.construct("partnumber"));
		
		scope.get("fileName").scalar().setValue(SymbolValue.construct("Service Jobs"));
		scope.get("fieldName").scalar().setValue(SymbolValue.construct("Job Part Number"));
		scope.get("fieldPicture").scalar().setValue(SymbolValue.construct("@s20"));
		
		scope.get("%file").scalar().setValue(SymbolValue.construct("qty"));
		scope.get("fieldName").scalar().setValue(SymbolValue.construct("Job Item Qty"));
		scope.get("fieldPicture").scalar().setValue(SymbolValue.construct("@n$5.2"));

		scope.get("%file").scalar().setValue(SymbolValue.construct("linetype"));
		scope.get("fieldName").scalar().setValue(SymbolValue.construct("Job LineType Qty"));
		scope.get("fieldPicture").scalar().setValue(SymbolValue.construct("@s1"));
		
		scope.get("file").scalar().setValue(SymbolValue.construct("invhead"));
		scope.get("%file").scalar().setValue(SymbolValue.construct("partnumber"));
		
		assertEquals("Spares Invoices",scope.get("filename").getValue().getString());		
		assertEquals("The Part Number",scope.get("fieldname").getValue().getString());
		assertEquals("@s40",scope.get("fieldpicture").getValue().getString());

		scope.get("%file").scalar().setValue(SymbolValue.construct("qty"));

		assertEquals("The Part Qty",scope.get("fieldname").getValue().getString());
		assertEquals("@n10.2",scope.get("fieldpicture").getValue().getString());

		scope.get("%file").scalar().setValue(SymbolValue.construct("linetype"));
		
		assertNull(scope.get("fieldname").getValue());
		assertNull(scope.get("fieldpicture").getValue());
		
		scope.get("file").scalar().setValue(SymbolValue.construct("jobhead"));
		scope.get("%file").scalar().setValue(SymbolValue.construct("partnumber"));
		
		assertEquals("Service Jobs",scope.get("filename").getValue().getString());		
		assertEquals("Job Part Number",scope.get("fieldname").getValue().getString());
		assertEquals("@s20",scope.get("fieldpicture").getValue().getString());

		scope.get("%file").scalar().setValue(SymbolValue.construct("qty"));

		assertEquals("Job Item Qty",scope.get("fieldname").getValue().getString());
		assertEquals("@n$5.2",scope.get("fieldpicture").getValue().getString());

		scope.get("%file").scalar().setValue(SymbolValue.construct("linetype"));

		assertEquals("Job LineType Qty",scope.get("fieldname").getValue().getString());
		assertEquals("@s1",scope.get("fieldpicture").getValue().getString());
		
	}
	
}
