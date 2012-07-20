package com.testbed.cache;

import javassist.NotFoundException;

import com.testbed.database.DbTestBedFactory;
import com.testbed.database.DbVirtualRouter;
import com.util.LongCache;

public class VirtualRouterCache extends DatabaseCache{

	public VirtualRouterCache(LongCache cache, DbTestBedFactory factory) {
		super(cache, factory);
		// TODO Auto-generated constructor stub
	}
	
	public DbVirtualRouter get(long vrID)  throws NotFoundException{
		DbVirtualRouter vr = (DbVirtualRouter)cache.get(vrID);
		if (vr == null) {
			vr = new DbVirtualRouter((int)vrID, factory);
			cache.add(vrID, vr);
		}
		return vr;
	}

}
