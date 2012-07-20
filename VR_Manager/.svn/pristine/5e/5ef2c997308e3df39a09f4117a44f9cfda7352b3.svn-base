package com.testbed.cache;

import com.testbed.database.DbTestBedFactory;
import com.util.LongCache;

/**
 * A base class that defines the basic functionality needed to wrap the general
 * purpose cache classes to caches for TestBed database objects.
 */
public class DatabaseCache {
	
	public LongCache cache;
	public DbTestBedFactory factory;
	
	
	/**
	 * Creates a new database cache object.
	 * @param cache a cache object to wrap.
	 * @param factory a DbTestBedFactory to be used to perform TestBed operations.
	 */
	public DatabaseCache(LongCache cache, DbTestBedFactory factory) {
		this.cache = cache;
		this.factory = factory;
	}
	
	/**
	 * Calls LongCache.remove(long).
	 * 
	 * @see LongCache#getCacheHits()
	 */
	public void remove(long key) {
		cache.remove(key);
	}
	
	/**
     * Calls method for LongCache.getCacheHits().
     *
     * @see LongCache#getCacheHits()
     */
    public long getCacheHits() {
        return cache.getCacheHits();
    }

    /**
     * Calls for LongCache.getCacheMisses().
     *
     * @see LongCache#getCacheMisses()
     */
    public long getCacheMisses() {
        return cache.getCacheMisses();
    }

    public int getSize() {
        return cache.getSize();
    }

    public void setMaxSize(int maxSize) {
        cache.setMaxSize(maxSize);
    }

    public int getMaxSize() {
        return cache.getMaxSize();
    }

    public int getNumElements() {
        return cache.getNumElements();
    }

    public void clear() {
        cache.clear();
    }

    /*
    public boolean isEnabled() {
        return factory.cacheManager.isCacheEnabled();
    }
	
	*/
}
