package  org.jclarion.clarion.appgen.template.cmd;

import java.io.IOException;
import java.io.Reader;
import java.util.List;

import org.jclarion.clarion.appgen.template.BufferedWriteTarget;
import org.jclarion.clarion.appgen.template.BufferedWriteTargetReader;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.WriteTarget;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;
import org.jclarion.clarion.util.SharedWriter;

public class ReplaceCmd extends Statement
{

	private CExpr oldfile;
	private CExpr newfile;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown");
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#REPLACE") && params.size()==2) {
			oldfile=params.get(0).getExpression();
			newfile=params.get(1).getExpression();
			return;
		}
		throw new ParseException("Unknown");
	}

	@Override
	public String toString() {
		return "ReplaceCmd [oldfile=" + oldfile + ", newfile=" + newfile + "]";
	}

	@Override
	public CodeResult run(ExecutionEnvironment scope) {		
		String from = scope.getTargetPath()+scope.eval(newfile).toString();
		String to = scope.getTargetPath()+scope.eval(oldfile).toString();

		SharedWriter buffer=null;
		BufferedWriteTarget source=null;
		char cb[]=new char[65536];
		
		if (from.indexOf("$")>-1) {
			source=scope.getBuffer(from);
			buffer = source.asSharedWriter();
		}
		if (buffer==null) {
			Reader r = scope.getReader(from,true);
			if (r instanceof BufferedWriteTargetReader) {
				source=((BufferedWriteTargetReader)r).getBufferedWriteTarget();
			}
			if (r==null) return CodeResult.OK;
			buffer= new SharedWriter(65536);				
			
			try {
				while (true ) {
					int len = r.read(cb);
					if (len<=0) break;
					buffer.write(cb,0,len);
				}
				r.close();
			} catch (IOException ex) {
				ex.printStackTrace();
				scope.error(ex.getMessage());
			}
			try {
				r.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		Reader r = scope.getReader(to,true);
		boolean match=false;
		if (r!=null) {
			
			char fb[] = buffer.getBuffer();
			match=true;
			try {
				int pos=0;
				
				while ( match ) {
					int len = r.read(cb);
					if (len<=0) break;
					
					for (int scan=0;scan<len;scan++) {
						if (pos>=buffer.getSize()) {
							match=false;
							break;
						}
						if (cb[scan]!=fb[pos++]) {
							match=false;
							break;							
						}
					}					
				}				
				if (pos!=buffer.getSize()) {
					match=false;
				}
			} catch (IOException ex) {
				match=false;
				ex.printStackTrace();
				scope.error(ex.getMessage());
			}
		}

		if (match) {
			try {
				r.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return CodeResult.OK;
		}
		
		WriteTarget w = scope.getWriter(to,false);
		try {
			if (source!=null) {
				source.flushInto(w); 
			} else {
				w.append(buffer);
			}
			w.close();
		} catch (IOException ex) {
			ex.printStackTrace();
			scope.error(ex.getMessage());
		}
		return CodeResult.OK;
	}

		
		
	/*
	@Override
	public CodeResult run(ExecutionEnvironment scope) {		
		File from = new File(scope.getTargetPath()+scope.eval(newfile).toString());
		File to = new File(scope.getTargetPath()+scope.eval(oldfile).toString());
		
		System.out.println(from+" "+to);
		
		if (!from.exists()) return CodeResult.OK;
		
		try {
			InputStream is = new FileInputStream(from);
			byte in_buffer[] = new byte[65536];
			byte out_buffer[] = new byte[65536];
			boolean test=true;
			
			RandomAccessFile raf = new RandomAccessFile(to,"rw");
			raf.seek(0);
			
			long pos=0;
			while (true) {
				int len =is.read(in_buffer);
				if (len<=0) break;
				
				int scan=0;
				if (test) {					
					while (test && scan<len) {
						int ro = raf.read(out_buffer,scan,len-scan);
						if (ro<=0) {
							test=false;
							break;
						}
						while (ro>0) {
							if (in_buffer[scan]!=out_buffer[scan]) {
								test=false;
								break;
							} else {
								scan++;
								ro--;
							}
						}						
					}	
					pos+=scan;					
					if (test) {
						continue;
					} else {
						raf.seek(pos);
					}
				}				
				raf.write(in_buffer,scan,len-scan);
				pos+=len-scan;
			}
			if (raf.length()>pos) {
				raf.setLength(pos);
			}
			is.close();
			raf.close();
		} catch (IOException ex) { 
			ex.printStackTrace();
			scope.error(ex.getMessage());
		}
		
		return CodeResult.OK;
	}
	*/
	
	
	
	
}
