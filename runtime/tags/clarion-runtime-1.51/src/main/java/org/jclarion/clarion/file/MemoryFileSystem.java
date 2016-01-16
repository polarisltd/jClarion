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
package org.jclarion.clarion.file;

import java.util.HashMap;
import java.util.Map;

public class MemoryFileSystem 
{
    private static byte[] EMPTY = new byte[0];
    private static Map<String, MemoryFileSystem> storedFiles = new HashMap<String, MemoryFileSystem>();
    private static int storedFileCount = 1;

    byte[] content = EMPTY;
    int size;
    String storeName;

    public static int totalSize()
    {
        int totalsize=0;
        for (MemoryFileSystem mfs : storedFiles.values() ) {
            totalsize+=mfs.size;
        }
        return totalsize;
    }
    
    public static MemoryFileSystem get(String name)
    {
        return storedFiles.get(name.toLowerCase().trim());
    }
    
    public void adjustSize(int newSize) {
        if (content.length >= newSize)
            return;

        int propSize = content.length;
        if (propSize == 0)
            propSize = 256;
        while (propSize < newSize)
            propSize = propSize << 1;

        byte newPayload[] = new byte[propSize];
        System.arraycopy(content, 0, newPayload, 0, size);
        content = newPayload;
    }

    public String store() {
        if (storeName == null) {
            storeName = "memory:/temp/" + (++storedFileCount);
            storedFiles.put(storeName,this);
        }
        return storeName;
    }

    public void store(String name) {
        free();
        storeName = name;
        storedFiles.put(storeName.toLowerCase().trim(),this);
    }

    public void free() {
        if (storeName != null) {
            storedFiles.remove(storeName);
            storeName = null;
        }
    }

}
