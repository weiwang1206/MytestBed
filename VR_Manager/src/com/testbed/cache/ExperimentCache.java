package com.testbed.cache;

import javassist.NotFoundException;

import com.testbed.database.DbExperiment;
import com.testbed.database.DbTestBedFactory;
import com.util.LongCache;

/**
 * Cache for DbExperiment objects.
 */
public class ExperimentCache extends DatabaseCache {

	public ExperimentCache(LongCache cache, DbTestBedFactory factory) {
		super(cache, factory);
	}
	
	public DbExperiment get(long expID) throws NotFoundException{
		DbExperiment exp = (DbExperiment)cache.get(expID);
		if (exp == null) {
			exp = new DbExperiment((int)expID, factory);
			cache.add(expID, exp);
		}
		return exp;
	}
}
