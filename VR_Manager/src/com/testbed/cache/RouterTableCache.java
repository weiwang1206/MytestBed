package com.testbed.cache;

import javassist.NotFoundException;

import com.testbed.database.DbRouterTableItem;
import com.testbed.database.DbTestBedFactory;
import com.util.LongCache;

public class RouterTableCache extends DatabaseCache{

	public RouterTableCache(LongCache cache, DbTestBedFactory factory) {
		super(cache, factory);
		// TODO Auto-generated constructor stub
	} 

	public DbRouterTableItem get(long routerTableItemID)  throws NotFoundException{
		DbRouterTableItem rt = (DbRouterTableItem)cache.get(routerTableItemID);
		if (rt == null) {
			rt = new DbRouterTableItem((int)routerTableItemID, factory);
			cache.add(routerTableItemID, rt);
		}
		return rt;
	}
}
