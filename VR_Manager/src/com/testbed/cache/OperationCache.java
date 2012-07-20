package com.testbed.cache;

import javassist.NotFoundException;

import com.testbed.database.DbOperation;
import com.testbed.database.DbTestBedFactory;
import com.util.LongCache;

public class OperationCache extends DatabaseCache{

	public OperationCache(LongCache cache, DbTestBedFactory factory) {
		super(cache, factory);
		// TODO Auto-generated constructor stub
	}

	public DbOperation get(long operID) throws NotFoundException{
		DbOperation oper = (DbOperation)cache.get(operID);
		if (oper == null) {
			oper = new DbOperation((int)operID, factory);
			cache.add(operID, oper);
		}
		return oper;
	}
}
