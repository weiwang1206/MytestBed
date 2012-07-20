package com.testbed.cache;

import javassist.NotFoundException;

import com.testbed.database.DbPhyMachine;
import com.testbed.database.DbTestBedFactory;
import com.util.LongCache;

public class PhyMachineCache extends DatabaseCache{

	public PhyMachineCache(LongCache cache, DbTestBedFactory factory) {
		super(cache, factory);
		// TODO Auto-generated constructor stub
	}
	
	public DbPhyMachine get(long pmID) throws NotFoundException{
		DbPhyMachine pm = (DbPhyMachine)cache.get(pmID);
		if (pm == null) {
			pm = new DbPhyMachine((int)pmID, factory);
			cache.add(pmID, pm);
		}
		return pm;
	}
}
