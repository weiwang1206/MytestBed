package com.testbed.cache;

import javassist.NotFoundException;

import com.testbed.database.DbPort;
import com.testbed.database.DbTestBedFactory;
import com.util.LongCache;

public class PortCache extends DatabaseCache{

	public PortCache(LongCache cache, DbTestBedFactory factory) {
		super(cache, factory);
		// TODO Auto-generated constructor stub
	}

	public DbPort get(long portID) throws NotFoundException{
		DbPort port = (DbPort)cache.get(portID);
		if (port == null) {
			port = new DbPort((int)portID, factory);
			cache.add(portID, port);
		}
		return port;
	}
}
