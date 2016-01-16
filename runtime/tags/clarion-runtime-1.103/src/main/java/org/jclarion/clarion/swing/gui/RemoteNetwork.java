package org.jclarion.clarion.swing.gui;

import java.awt.Color;
import java.awt.Font;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.jclarion.clarion.ClarionBool;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.constants.Paper;
import org.jclarion.clarion.print.Bitmap;
import org.jclarion.clarion.print.Box;
import org.jclarion.clarion.print.Line;
import org.jclarion.clarion.print.Page;
import org.jclarion.clarion.print.PrintElement;
import org.jclarion.clarion.print.PrintObject;
import org.jclarion.clarion.print.Text;
import org.jclarion.clarion.print.TextArea;
import org.jclarion.clarion.util.SharedOutputStream;

public class RemoteNetwork {

	public static final int COMMAND_RESPONSE = 65535;
	private static final int NOTIFY_SEMAPHORE = 65534;

	private static final int NULL = 0;
	private static final int INTEGER = 1;
	private static final int INT_1 = 1;
	private static final int INT_2 = 2;
	private static final int INT_4 = 3;
	private static final int STRING = 4;

	private static final int CLARION_NUMBER = 5;
	private static final int CLARION_NUMBER_1 = 5;
	private static final int CLARION_NUMBER_2 = 6;
	private static final int CLARION_NUMBER_4 = 7;

	private static final int CLARION_STRING = 8;
	private static final int CLARION_PADDED_STRING = 9;

	private static final int CLARION_DECIMAL = 10;

	private static final int NEW_WIDGET = 11;
	private static final int UPDATING_WIDGET = 12;
	private static final int WIDGET = 13;

	private static final int NEW_ANON_SEMAPHORE = 14;
	private static final int NEW_SEMAPHORE = 15;
	private static final int SEMAPHORE = 16;

	private static final int BOOLEAN   = 17;
	private static final int BOOL_TRUE = 17;
	private static final int BOOL_FALSE = 18;

	private static final int CLARION_UNBOUNDED_DECIMAL = 19;

	private static final int CBOOLEAN = 20;
	private static final int CBOOL_TRUE = 20;
	private static final int CBOOL_FALSE = 21;

	private static final int CLARION_UNBOUNDED_STRING = 22;

	private static final int ARRAY = 23;
	private static final int MAP = 24;

	private static final int INPUTSTREAM = 25;
	
	private static final int BYTEARRAY = 26;

	private static final int PAGE=27;
	private static final int COLOR = 28;
	private static final int FONT = 29;
	private static final int NEW_FONT = 30;
	
	private static final int FLOAT   = 31;
	private static final int DOUBLE = 32;
	
	private static final int LONG = 33;

	private static final int METADATA = -1;
	private static final int COLLECTION = -2;

	
	private int responseID = 0;

	private int _id = 0;

	private Map<Integer, RemoteWidget> widgets = new HashMap<Integer, RemoteWidget>();
	private Map<Integer, RemoteSemaphore> semaphores = new HashMap<Integer, RemoteSemaphore>();
	private Map<Integer, RemoteResponse> responses = new HashMap<Integer, RemoteResponse>();
	private Map<Font,Integer> font_to_int = new HashMap<Font,Integer>();
	private Map<Integer, Font> int_to_font = new HashMap<Integer, Font>();

	public RemoteNetwork() {
	}

	public RemoteNetwork(int startID) {
		_id = startID;
	}
	
	public int getNextID()
	{
		synchronized(this) {
			_id++;
			return _id;
		}
	}

	public int readNumber(InputStream is) throws IOException
	{
		int b0 = is.read();
		if (b0==-1) throw new IOException("EOF");
		
		boolean neg=false;
		
		if ( (b0&128)==128) {
			neg=true;
			b0=b0-128;
		}
		
		int count=0;

		while ( true ) {
			if (b0>=64) {
				b0=b0-64;
				break;
			}
			if (b0>=32) {
				b0=b0-32;
				count=1;
				break;
			}
			if (b0>=16) {
				b0=b0-16;
				count=2;
				break;
			}
			if (b0>=8) {
				b0=b0-8;
				count=3;
				break;
			}
			if (b0==4) {
				b0=0;
				count=4;
				break;
			}
			if (b0==3) {
				return Integer.MIN_VALUE;
			}
			throw new IOException("Undefined :"+b0);
		}
				
		while (count>0) {
			int nb = is.read();
			if (nb==-1) throw new IOException("EOF");
			b0=(b0<<8)+nb;
			count--;
		}
		if (neg) {
			return -b0;
		} else {
			return b0;
		}
	}
	
	public void writeNumber(OutputStream os,int value) throws IOException
	{
		if (value==Integer.MIN_VALUE) {
			os.write(128+3);
			return;
		}
		
		boolean neg=false;
		if (value<0) {
			neg=true;
			value=-value;
		}
		
		int b0=neg ? 128 : 0 ;
		
		if (value<(1<<5)) {
			os.write(b0+64+value);
			return;
		}
		
		if (value<(1<<12)) {
			os.write(b0+32+(value>>8));
			os.write(value&0xff);
			return;
		}
		
		if (value<(1<<19)) {
			os.write(b0+16+(value>>16));
			os.write((value>>8)&0xff);
			os.write((value)&0xff);
			return;
		}
		
		if (value<(1<<26)) {
			os.write(b0+8+(value>>24));
			os.write((value>>16)&0xff);
			os.write((value>>8)&0xff);
			os.write((value)&0xff);
			return;
		}
		
		os.write(b0+4);
		os.write((value>>24)&0xff);
		os.write((value>>16)&0xff);
		os.write((value>>8)&0xff);
		os.write((value)&0xff);
	}
	
	public void writeNumber(OutputStream os, int value, int bytes)
			throws IOException {
		bytes = bytes << 3; // times 8
		while (bytes > 0) {
			bytes = bytes - 8;
			os.write((value >> bytes) & 0xff);
		}
	}

	public int readNumber(InputStream is, int bytes) throws IOException {
		int result = 0;
		while (bytes > 0) {
			int r = is.read();
			if (r == -1)
				throw new IOException("EOF");
			result = (result << 8) + (r & 0xff);
			bytes--;
		}
		return result;
	}

	public void writeString(OutputStream os, String s) throws IOException {
		// byte 1 codifies:
		// encoding. 8bit or 16bit.
		// length. if <127
		// if length value=127 then length is in next 4 bytes.

		boolean bit16 = false;
		for (int l = 0; l < s.length(); l++) {
			if (s.charAt(l) > 255) {
				bit16 = true;
				break;
			}
		}

		int len = s.length();
		if (len >= 127)
			len = 127;
		if (bit16)
			len = len + 128;
		os.write(len);
		if (s.length() >= 127) {
			writeNumber(os, s.length(), 4);
		}
		if (bit16) {
			for (int l = 0; l < s.length(); l++) {
				int c = s.charAt(l);
				os.write((c >> 8) & 0xff);
				os.write(c & 0xff);
			}
		} else {
			for (int l = 0; l < s.length(); l++) {
				int c = s.charAt(l);
				os.write(c & 0xff);
			}
		}
	}

	public String readString(InputStream is) throws IOException {
		int len = is.read();
		if (len == -1)
			throw new IOException("EOF");
		boolean bit16 = false;
		if (len > 127) {
			bit16 = true;
			len = len - 128;
		}
		if (len == 127) {
			len = readNumber(is, 4);
		}
		char result[] = new char[len];
		if (bit16) {
			for (int scan = 0; scan < len; scan++) {
				int hb = is.read();
				if (hb == -1)
					throw new IOException("EOF");
				int lb = is.read();
				if (lb == -1)
					throw new IOException("EOF");
				result[scan] = (char) ((hb << 8) + lb);
			}
		} else {
			for (int scan = 0; scan < len; scan++) {
				int lb = is.read();
				if (lb == -1)
					throw new IOException("EOF");
				result[scan] = (char) (lb);
			}
		}

		return new String(result);
	}

	private Map<Class<?>,Integer> classCache=new HashMap<Class<?>,Integer>();
	
	public void writeParameter(OutputStream os, Object parameter)
			throws IOException {
		if (parameter == null) {
			os.write(NULL);
			return;
		}

		Integer type = classCache.get(parameter.getClass());
		if (type==null) {
			while ( true ) {
				if (parameter instanceof byte[]) {
					type=BYTEARRAY;
					break;
				}
				if (parameter.getClass().isArray()) {
					type=ARRAY;
					break;
				}
				if (parameter instanceof Map<?,?>) {
					type=MAP;
					break;
				}
				if (parameter instanceof Collection<?>) {
					type=COLLECTION;
					break;
				}
				if (parameter instanceof Boolean) {
					type=BOOLEAN;
					break;
				}
				if (parameter instanceof Integer) {
					type=INTEGER;
					break;
				}
				if (parameter instanceof String) {
					type=STRING;
					break;
				}
				if (parameter instanceof ClarionBool) {
					type=CBOOLEAN;
					break;
				}
				if (parameter instanceof ClarionNumber) {
					type=CLARION_NUMBER;
					break;
				}
				if (parameter instanceof ClarionString) {
					type=CLARION_STRING;
					break;
				}
				if (parameter instanceof ClarionDecimal) {
					type=CLARION_DECIMAL;
					break;
				}
				if (parameter instanceof RemoteWidget) {
					type=WIDGET;
					break;
				}
				if (parameter instanceof RemoteSemaphore) {
					type=SEMAPHORE;
					break;
				}
				if (parameter instanceof NetworkMetaData) {
					type=METADATA;
					break;
				}
				if (parameter instanceof InputStream) {
					type=INPUTSTREAM;
					break;
				}
				if (parameter instanceof Font) {
					type=FONT;
					break;
				}
				if (parameter instanceof Color) {
					type=COLOR;
					break;
				}
				if (parameter instanceof Page) {
					type=PAGE;
					break;
				}
				if (parameter instanceof Float) {
					type=FLOAT;
					break;
				}
				if (parameter instanceof Double) {
					type=DOUBLE;
					break;
				}
				if (parameter instanceof Long) {
					type=LONG;
					break;
				}
				throw new IOException("Do not know how to serialize:" + parameter+" "+parameter.getClass());
			}
			classCache.put(parameter.getClass(),type);
		}
		
		switch(type.intValue()) {
			case FONT: {
				Font f = (Font)parameter;
				Integer i=null;
				boolean nf=false;
				synchronized(font_to_int) {
					i=font_to_int.get(f);
					if (i==null) {
						nf=true;
						i=font_to_int.size()+1;
						font_to_int.put(f,i);
					}
				}
				if (nf) {
					os.write(NEW_FONT);
					writeNumber(os,i);
					writeString(os,f.getName());
					writeNumber(os,f.getStyle());
					writeNumber(os,f.getSize());
				} else {
					os.write(FONT);
					writeNumber(os,i);
				}
				return;
			}
			case COLOR: {
				Color c = (Color)parameter;
				os.write(COLOR);
				os.write(c.getAlpha());
				os.write(c.getRed());
				os.write(c.getGreen());
				os.write(c.getBlue());
				return;
			}
			case ARRAY: { 
				os.write(ARRAY);
				int len = Array.getLength(parameter); 
				writeNumber(os,len);
				for (int scan=0;scan<len;scan++) {
					writeParameter(os,Array.get(parameter,scan));
				}
				return;
			}
			case MAP: {
				os.write(MAP);
				Map<?,?> c  = (Map<?,?>)parameter;
				int len = c.size();
				writeNumber(os,len);
				for (Map.Entry<?,?> me : c.entrySet() ) {
					writeParameter(os,me.getKey());
					writeParameter(os,me.getValue());
				}
				return;
			}
			case COLLECTION: {
				os.write(ARRAY);
				Collection<?> c  = (Collection<?>)parameter;
				int len = c.size();
				writeNumber(os,len);
				for (Object o : c ) {
					writeParameter(os,o);
				}
				return;
			}
			case BOOLEAN: {
				Boolean b = (Boolean) parameter;
				os.write(b ? BOOL_TRUE : BOOL_FALSE);
				return;
			}
			case INTEGER: { 
				int val = (Integer) parameter;
				if (val >= 0 && val <= 255) {
					os.write(INT_1);
					writeNumber(os, val, 1);
					return;
				}
				if (val >= 0 && val <= 65535) {
					os.write(INT_2);
					writeNumber(os, val, 2);
					return;
				}
				os.write(INT_4);
				writeNumber(os, val, 4);
				return;
			}
			case STRING: { 
				os.write(STRING);
				writeString(os, parameter.toString());
				return;
			}
			case CBOOLEAN: {
				ClarionBool cb = (ClarionBool)parameter;
				os.write(cb.boolValue() ? CBOOL_TRUE : CBOOL_FALSE );
				return;
			}
			case CLARION_NUMBER: {
				int val = ((ClarionNumber) parameter).intValue();
				if (val >= 0 && val <= 255) {
					os.write(CLARION_NUMBER_1);
					writeNumber(os, val, 1);
					return;
				}	
				if (val >= 0 && val <= 65535) {
					os.write(CLARION_NUMBER_2);
					writeNumber(os, val, 2);
					return;
				}
				os.write(CLARION_NUMBER_4);
				writeNumber(os, val, 4);
				return;
			}
			case CLARION_STRING: {
				ClarionString cs = (ClarionString)parameter;
				String s = parameter.toString();
				if (cs.getSize()==-1) {
					os.write(CLARION_UNBOUNDED_STRING);
					writeString(os, s);
					return;
				}			
				int padlength = s.length();
				while (padlength > 0 && s.charAt(padlength - 1) == ' ') {
					padlength--;
				}
				if (padlength < cs.getSize() - 4) {
					os.write(CLARION_PADDED_STRING);
					writeNumber(os, cs.getSize(), 4);
					writeString(os, s.substring(0, padlength));
					return;
				}
				os.write(CLARION_STRING);
				writeString(os, s);
				return;
			}
			case CLARION_DECIMAL: {
				ClarionDecimal cd = (ClarionDecimal) parameter;
				int size = cd.getSize();
				int precision = cd.getPrecision();
				if (size==-1 && precision==-1) {
					os.write(CLARION_UNBOUNDED_DECIMAL);
				} else {
					if (size > 31 || size < 0)
						throw new IOException("Cannot serialize decimal : "+size+" "+precision);
					if (precision > 7 || precision < 0)
						throw new IOException("Cannot serialize decimal");
					os.write(CLARION_DECIMAL);
					os.write(size * 8 + precision);
				}
				writeString(os, cd.toString().trim());
				return;
			}

			case WIDGET: {
				RemoteWidget w = (RemoteWidget) parameter;
				if (w.getID() == 0) {
					os.write(NEW_WIDGET);
					writeNumber(os, w.getWidgetType(), 4);
					w.setID(getNextID());
					synchronized (widgets) {
						widgets.put(w.getID(), w);
					}
					writeNumber(os, w.getID(), 4);
					if (w.getParentWidget() != null) {
						if (w.getParentWidget().getID() == 0) {
							System.out.println(w);
							System.out.println(w.getParentWidget());
							throw new IOException("Cannot serialize Widget parent not serialized");
						}
						writeNumber(os, w.getParentWidget().getID(), 4);
					} else {
						writeNumber(os, 0, 4);
					}
					Map<Integer, Object> md = w.getChangedMetaData();
					if (md == null) {
						writeNumber(os, 0, 2);
					} else {
						writeNumber(os, md.size(), 2);
						for (Map.Entry<Integer, Object> e : md.entrySet()) {
							writeNumber(os, e.getKey(), 4);
							writeParameter(os, e.getValue());
						}
					}
					List<RemoteWidget> kids = new ArrayList<RemoteWidget>();
					Iterable<? extends RemoteWidget> i = w.getChildWidgets();
					if (i != null) {
						for (RemoteWidget child : i) {
							if (child.getID() == 0) {
								kids.add(child);
							}
						}
					}
					writeNumber(os, kids.size(), 2);
					for (RemoteWidget child : kids) {
						writeParameter(os, child);
					}
				} else {
					Map<Integer, Object> md = w.getChangedMetaData();
					if (md == null || md.size() == 0) {
						os.write(WIDGET);
						writeNumber(os, w.getID(), 4);
					} else {
						os.write(UPDATING_WIDGET);
						writeNumber(os, w.getID(), 4);
						writeNumber(os, md.size(), 2);
						for (Map.Entry<Integer, Object> e : md.entrySet()) {
							writeNumber(os, e.getKey(), 4);
							writeParameter(os, e.getValue());
						}
					}
				}
				return;
			}

			case SEMAPHORE: {
				RemoteSemaphore sem = (RemoteSemaphore) parameter;
				if (sem.getID() == 0) {
					if (sem.isNetworkSemaphore()) {
						os.write(NEW_SEMAPHORE);
						os.write(sem.getType());
						sem.setID(getNextID());
						synchronized (semaphores) {
							semaphores.put(sem.getID(), sem);
						}
						writeNumber(os, sem.getID(), 4);
					} else {
						os.write(NEW_ANON_SEMAPHORE);
						os.write(sem.getType());
					}
					Object[] md = sem.getMetaData();
					if (md != null) {
						os.write(md.length);
						for (Object o : md) {
							writeParameter(os, o);
						}
					} else {
						os.write(0);
					}
				} else {
					os.write(SEMAPHORE);
					writeNumber(os, sem.getID(), 4);
				}
				return;
			}
			case INPUTSTREAM: {
				os.write(INPUTSTREAM);
				SharedOutputStream sos = new SharedOutputStream(8192);
				InputStream is = (InputStream)parameter;
				sos.readAll(is);
				writeNumber(os,sos.getSize());
				os.write(sos.getBytes(),0,sos.getSize());
				return;
			}
			case BYTEARRAY: {
				os.write(BYTEARRAY);
				byte[] b = (byte[])parameter;
				writeNumber(os,b.length);
				os.write(b);
				return;
			}
			case FLOAT: {
				os.write(FLOAT);
				writeNumber(os,Float.floatToIntBits((Float)parameter),4);
				return;
			}
			case DOUBLE: {
				os.write(DOUBLE);
				long d = Double.doubleToRawLongBits((Double)parameter);
				writeNumber(os,(int)(d>>32),4);
				writeNumber(os,(int)(d&0xffffffff),4);
				return;
			}
			case LONG: {
				os.write(LONG);
				long d = (Long)parameter;
				writeNumber(os,(int)(d>>32),4);
				writeNumber(os,(int)(d&0xffffffff),4);
				return;
			}
			case PAGE: {
				os.write(PAGE);
				Page p = (Page)parameter;
				writeNumber(os,p.getX());
				writeNumber(os,p.getY());
				writeNumber(os,p.getWidth());
				writeNumber(os,p.getHeight());
				writeParameter(os,p.getXScale());
				writeParameter(os,p.getYScale());
				os.write(p.getLandscape());
				writeNumber(os,p.getPaper());
				if (p.getPaper()==Paper.USER) {
					writeNumber(os,p.getPaperWidth());
					writeNumber(os,p.getPaperHeight());
				}
				for (PrintObject po : p.getPrintObjects()) {
					os.write(1);
					writeNumber(os,po.getX());
					writeNumber(os,po.getY());
					writeNumber(os,po.getWidth());
					writeNumber(os,po.getHeight());
					writeNumber(os,po.getPositionedX());
					writeNumber(os,po.getPositionedY());
					for (PrintElement pe : po.getElements() ) {
						int petype=0;
						if (pe.getClass()==Text.class) {
							petype=1;
						}
						if (pe.getClass()==TextArea.class) {
							petype=2;
						}
						if (pe.getClass()==Line.class) {
							petype=3;
						}
						if (pe.getClass()==Bitmap.class) {
							petype=4;
						}
						if (pe.getClass()==Box.class) {
							petype=5;
						}
						if (petype==0) throw new IOException("Cannot serialize:"+pe.getClass());
						petype=petype<<4;
						
						Object mda[] = pe.getMetaData();
						petype+=mda.length;
						os.write(petype);
						for (Object md : mda ) {
							writeParameter(os,md);
						}
					}
				}
				os.write(2);
				return;
			}
			case METADATA: {
				writeParameter(os,((NetworkMetaData)parameter).getMetaData());
				return;
			}
		}
		throw new IOException("Do not know how to serialize:" + parameter+" "+parameter.getClass());
	}

	public Object readParameter(InputStream is, GUIModel remote)
			throws IOException {
		int type = is.read();
		if (type == -1)
			throw new IOException("EOF");

		switch (type) {
		case NULL:
			return null;
		case BOOL_TRUE:
			return true;
		case BOOL_FALSE:
			return false;
		case CBOOL_TRUE:
			return new ClarionBool(true);
		case CBOOL_FALSE:
			return new ClarionBool(false);
		case INT_1:
			return readNumber(is, 1);
		case INT_2:
			return readNumber(is, 2);
		case INT_4:
			return readNumber(is, 4);
		case STRING:
			return readString(is);
		case CLARION_NUMBER_1:
			return new ClarionNumber(readNumber(is, 1));
		case CLARION_NUMBER_2:
			return new ClarionNumber(readNumber(is, 2));
		case CLARION_NUMBER_4:
			return new ClarionNumber(readNumber(is, 4));
		case CLARION_STRING:
			return new ClarionString(readString(is));
		case CLARION_UNBOUNDED_STRING: {
			ClarionString cs = new ClarionString();
			cs.setValue(readString(is));
			return cs;
		}
		case CLARION_PADDED_STRING: {
			ClarionString cs = new ClarionString(readNumber(is, 4));
			cs.setValue(readString(is));
			return cs;
		}
		case CLARION_DECIMAL: {
			int details = is.read();
			if (details == -1)
				throw new IOException("EOF");
			ClarionDecimal cd = new ClarionDecimal(details >> 3, details & 7);
			cd.setValue(readString(is));
			return cd;
		}
		case CLARION_UNBOUNDED_DECIMAL: {
			ClarionDecimal cd = new ClarionDecimal();
			cd.setValue(readString(is));
			return cd;
		}
		case MAP: {
			int len  = readNumber(is);
			Map<Object,Object> m  = new HashMap<Object,Object>();
			for (int scan=0;scan<len;scan++) {
				m.put(readParameter(is,remote),readParameter(is,remote));
			}
			return m;
		}
		case ARRAY: {
			int len  =readNumber(is);
			Object array[]=new Object[len];
			for (int scan=0;scan<len;scan++) {
				array[scan]=readParameter(is,remote);
			}
			return array;
		}
		case NEW_WIDGET: {
			int w_type = readNumber(is, 4);
			RemoteWidget w = RemoteTypes.getInstance()
					.manufactureWidget(w_type);
			if (w==null) throw new RuntimeException("Cannot manufacture Widget");
			int id = readNumber(is, 4);
			w.setID(id);
			synchronized (widgets) {
				widgets.put(id, w);
			}
			int parentID = readNumber(is, 4);
			int md_count = readNumber(is, 2);
			if (md_count > 0) {
				Map<Integer, Object> meta_data = new HashMap<Integer, Object>();
				while (md_count > 0) {
					meta_data.put(readNumber(is, 4), readParameter(is, remote));
					md_count--;
				}
				w.setMetaData(meta_data);
			}
			w.getChangedMetaData(); // ignore results so far
			
			if (parentID > 0) {
				synchronized (widgets) {
					widgets.get(parentID).addWidget(w);
				}
			}
			int kid_count = readNumber(is, 2);
			while (kid_count > 0) {
				readParameter(is, remote);
				kid_count--;
			}
			return w;
		}
		case UPDATING_WIDGET: {
			RemoteWidget w = widgets.get(readNumber(is, 4));
			int md_count = readNumber(is, 2);
			if (md_count > 0) {
				Map<Integer, Object> meta_data = new HashMap<Integer, Object>();
				while (md_count > 0) {
					meta_data.put(readNumber(is, 4), readParameter(is, remote));
					md_count--;
				}
				if (w!=null) {
					w.setMetaData(meta_data);
				}
			}
			return w;
		}
		case WIDGET: {
			RemoteWidget w = widgets.get(readNumber(is, 4)); 
			return w;
		}
		case NEW_ANON_SEMAPHORE: {
			int s_type = is.read();
			RemoteSemaphore rs = RemoteTypes.getInstance()
					.manufactureSemaphore(s_type);
			int len = is.read();
			if (len == -1)
				throw new IOException("EOF");
			if (len > 0) {
				Object o[] = new Object[len];
				for (int scan = 0; scan < len; scan++) {
					o[scan] = readParameter(is, remote);
				}
				rs.setMetaData(o);
			}
			return rs;
		}
		case NEW_SEMAPHORE: {
			int s_type = is.read();
			RemoteSemaphore rs = RemoteTypes.getInstance()
					.manufactureSemaphore(s_type);
			int id = readNumber(is, 4);
			rs.setID(id, remote);
			synchronized (semaphores) {
				semaphores.put(id, rs);
			}
			int len = is.read();
			if (len == -1)
				throw new IOException("EOF");
			if (len > 0) {
				Object o[] = new Object[len];
				for (int scan = 0; scan < len; scan++) {
					o[scan] = readParameter(is, remote);
				}
				rs.setMetaData(o);
			}
			return rs;
		}
		case SEMAPHORE:
			synchronized (semaphores) {
				return semaphores.get(readNumber(is, 4));
			}
		case INPUTSTREAM: {
			int len = readNumber(is);
			SharedOutputStream sos = new SharedOutputStream(len);
			if (sos.readSome(is,len)!=len) throw new IOException("EOF");
			return sos.getInputStream();
		}
		case BYTEARRAY: {
			int len = readNumber(is);
			SharedOutputStream sos = new SharedOutputStream(len);
			if (sos.readSome(is,len)!=len) throw new IOException("EOF");
			byte[] r;
			if (sos.getBytes().length==len) {
				r=sos.getBytes();
			} else {
				r=sos.toByteArray();
			}
			return r;
		}
		case FONT: {
			int id = readNumber(is);
			synchronized(int_to_font) {
				return int_to_font.get(id);
			}
		}
		case COLOR : {
			int a = is.read(); if (a==-1) throw new IOException("EOF");
			int r = is.read(); if (r==-1) throw new IOException("EOF");
			int g = is.read(); if (g==-1) throw new IOException("EOF");
			int b = is.read(); if (b==-1) throw new IOException("EOF");
			return new Color(r,g,b,a);
		}
		case NEW_FONT: {
			int id = readNumber(is);
			Font f = new Font(readString(is),readNumber(is),readNumber(is));
			synchronized(int_to_font) {
				int_to_font.put(id,f);
			}
			return f;
		}
		case DOUBLE: {
			int i1=readNumber(is,4);
			int i2=readNumber(is,4);
			long l = ((i1&0xffffffffl)<<32)+(i2&0xffffffffl);
			return Double.longBitsToDouble(l);
		}
		case LONG: {
			int i1=readNumber(is,4);
			int i2=readNumber(is,4);
			long l = ((i1&0xffffffffl)<<32)+(i2&0xffffffffl);
			return l;
		}
		case FLOAT: {
			return Float.intBitsToFloat(readNumber(is,4));
		}
		case PAGE: {
			int x = readNumber(is);
			int y = readNumber(is);
			int width = readNumber(is);
			int height = readNumber(is);
			double xs = (Double)readParameter(is,remote);
			double ys = (Double)readParameter(is,remote);
			int landscape = is.read();
			int page = readNumber(is);
			int pw=0;
			int ph=0;
			if (page==Paper.USER) {
				pw=readNumber(is);
				ph=readNumber(is);
			}
			
			Page p = new Page(x,y,width,height,xs,ys,landscape,page,pw,ph);
			PrintObject po = null;
			
			while ( true ) {
				int cmd = is.read();
				if (cmd==1) {
					po=new PrintObject(
							readNumber(is),readNumber(is),readNumber(is),readNumber(is),
							readNumber(is),readNumber(is)
							);
					p.add(null,po);
					continue;
				}
				if (cmd==2) {
					break;
				}
				
				int args = cmd & 0xf;
				cmd=cmd>>4;
				if (cmd<1 || cmd>5) throw new IOException("Invalid cmd");
				Object params[] = new Object[args];
				for (int scan=0;scan<args;scan++) {
					params[scan]=readParameter(is,remote);
				}
				PrintElement pe=null;
				switch(cmd) {
					case 1:
						pe=new Text(params);
						break;
					case 2:
						pe=new TextArea(params);
						break;
					case 3:
						pe=new Line(params);
						break;
					case 4:
						pe=new Bitmap(params);
						break;
					case 5:
						pe=new Box(params);
						break;
				}
				po.add(pe);
				continue;
			}
			return p;
		}
		}
		throw new IOException("Unknown Parameter Type:" + type);
	}
	
	private void checkSend(List<RemoteWidget> send,RemoteWidget w)
	{
		if (w==null) return;
		if (w.getID()>0) return;
		checkSend(send,w.getParentWidget());
		send.add(w);
	}
	
	public RemoteResponse writeCommand(OutputStream os, int command,
			boolean createResponse, ResponseRunnable runOnResponse,
			RemoteWidget source, Object... params) throws IOException 
	{
		boolean required=false;
		if (source!=null && source.getParentWidget()!=null && source.getParentWidget().getID()==0) {
			required=true;
		} else {
			for (Object o : params) {
				if (o instanceof RemoteWidget) {
					RemoteWidget t = (RemoteWidget)o;
					if (t!=null && t.getParentWidget()!=null && t.getParentWidget().getID()==0) {
						required=true;
					}
				}
			}			
		}
		
		if (required) {
			System.out.println("Required");
			List<RemoteWidget> send = new ArrayList<RemoteWidget>();
			if (source!=null) {
				checkSend(send,source.getParentWidget());
			}
			for (Object o : params) {
				if (o==null) continue;
				if (o instanceof RemoteWidget) {
					checkSend(send,((RemoteWidget)o).getParentWidget());
				}
			}
			if (send.size()>0) {
				writeNumber(os, 0, 2);
				writeNumber(os, 0, 2);
				writeParameter(os, null);
				os.write(send.size());
				for (RemoteWidget w : send ) {
					writeParameter(os,w);					
				}
			}
		}
		
		
		RemoteResponse rr = null;
		int responseID = 0;
		if (createResponse) {
			rr = new RemoteResponse(command,source);
			rr.run = runOnResponse;
			synchronized (responses) {
				this.responseID++;
				if (this.responseID > 32767)
					this.responseID = 1;
				responseID = this.responseID;
				if (runOnResponse!=null) responseID+=32768;
				responses.put(responseID, rr);
			}
		}

			writeNumber(os, command, 2);
			writeNumber(os, responseID, 2);
			writeParameter(os, source);
			os.write(params.length);
			for (Object p : params) {
				writeParameter(os, p);
			}
			os.flush();

		return rr;
	}

	public void writeResponse(OutputStream os, RemoteCommand c, Object response)
			throws IOException {
		if (c.response == 0)
			return;

			writeNumber(os, COMMAND_RESPONSE, 2);
			writeNumber(os, c.response, 2);
			writeParameter(os, c.source);
			os.write(1);
			writeParameter(os, response);
			os.flush();
	}

	public void notifySemaphore(OutputStream os, RemoteSemaphore s,
			Object response) throws IOException {
		if (s.getID() == 0)
			return;

			writeNumber(os, NOTIFY_SEMAPHORE, 2);
			writeNumber(os, 0, 2);
			writeParameter(os, null);
			os.write(2);
			writeParameter(os, s.getID());
			writeParameter(os, response);
			os.flush();

	}

	public void processResponse(RemoteCommand rc)
	{
		if (rc.command == COMMAND_RESPONSE) {
			RemoteResponse rr;
			synchronized (responses) {
				rr = responses.remove(rc.response);
			}
			if (rr != null) {
				rr.setResponse(rc.params[0]);
			}
		}
	}

	public RemoteCommand readCommand(InputStream is, GUIModel remote)
		throws IOException {
		return readCommand(is,remote,true);
	}
	
	public RemoteCommand readCommand(InputStream is, GUIModel remote,boolean handleResponse)
			throws IOException {
		while (true) {
			RemoteCommand rc = new RemoteCommand();

			int hi = is.read();
			if (hi == -1)
				return null;

			int lo = is.read();
			if (lo == -1)
				throw new IOException("EOF");

			rc.command = (hi << 8) + lo;
			rc.response = readNumber(is, 2);
			rc.source = (RemoteWidget) readParameter(is, remote);
			rc.params = new Object[is.read()];
			for (int scan = 0; scan < rc.params.length; scan++) {
				rc.params[scan] = readParameter(is, remote);
			}
			
			if (rc.command == COMMAND_RESPONSE && handleResponse) {
				processResponse(rc);
				continue;
			}

			if (rc.command == NOTIFY_SEMAPHORE) {
				int semid = (Integer) rc.params[0];
				Object result = rc.params[1];
				RemoteSemaphore rs;
				synchronized (semaphores) {
					rs = semaphores.remove(semid);
				}
				if (rs != null) {
					rs.notify(result);
				} else {
					System.out
							.println("Could not notify semaphore ID:" + semid);
				}
				continue;
			}

			return rc;
		}
	}

	public RemoteWidget getWidget(int id) {
		synchronized (widgets) {
			return widgets.get(id);
		}
	}
	
	public void shutdown()
	{
		for (RemoteSemaphore rs : semaphores.values() ) {
			rs.notify(null);
		}
		
		for (RemoteResponse rs : responses.values() ) {
			rs.setResponse(null);
		}
	}
	
	public void dispose(RemoteWidget w)
	{
		synchronized(widgets) {
			doRemove(w);
		}
		doDispose(w);
	}
	
	public void dispose(RemoteSemaphore rs)
	{
		synchronized(this.semaphores) {
			semaphores.remove(rs.getID());
		}
	}
	
	private void doRemove(RemoteWidget w)
	{
		if (w==null) return;
		this.widgets.remove(w.getID());
		Iterable<? extends RemoteWidget> kids=w.getChildWidgets();
		if (kids==null) return;
		for (RemoteWidget k : kids ) {
			doRemove(k);
		}		
	}
	
	private void doDispose(RemoteWidget w)
	{
		if (w==null) return;
		w.disposeWidget();
		Iterable<? extends RemoteWidget> kids=w.getChildWidgets();
		if (kids==null) return;
		for (RemoteWidget k : kids ) {
			doDispose(k);
		}
	}
	
	public boolean testMemoryUsage(String src)
	{
		boolean err=false;
		if (!widgets.isEmpty()) {
			for (RemoteWidget t : widgets.values() ) {
				if (isStaticWidget(t.getWidgetType())) continue;
				System.out.println(src+" "+widgets);
				err=true;
				break;
			}
		}
		if (!semaphores.isEmpty()) {
			err=true;
			System.out.println(src+" "+semaphores);
		}
		if (!responses.isEmpty()) {
			err=true;
			System.out.println(src+" "+responses);
		}
		return err;
	}
	
	public boolean isStaticWidget(int type)
	{
		switch (type) {
			case RemoteTypes.CWIN: 
			case RemoteTypes.PRINTER: 
			case RemoteTypes.FILE: 
			case RemoteTypes.NOTIFIER:
				return true;
		}
		return false;
	}
	
	public void cleanup() 
	{
		Iterator<RemoteWidget> i = widgets.values().iterator();
		while (i.hasNext()) {
			RemoteWidget w = i.next();
			if (isStaticWidget(w.getWidgetType())) {
				w.disposeWidget();
				i.remove();
			}
		}
	}
}
