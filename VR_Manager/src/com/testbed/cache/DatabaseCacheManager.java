package com.testbed.cache;

import com.testbed.database.DbTestBedFactory;
import com.util.LongCache;

/**
 * Central cache management of all caches used by TestBed.
 *
 */
public class DatabaseCacheManager {
	
	public static final int EXPERIMENT_CACHE = 0;
	public static final int PHYMACHINE_CACHE = 1;
	public static final int VIRTUALROUTER_CACHE = 2;
	public static final int PORT_CACHE = 3;
	public static final int USER_CACHE = 4;
	public static final int OPERATION_CACHE = 5;
	public static final int ROUTERTABLE_CACHE = 6;
	
	public ExperimentCache experimentCache;
	public PhyMachineCache phyMachineCache;
	public VirtualRouterCache virtualRouterCache;
	public PortCache portCache;
	public UserCache userCache;
	public OperationCache operationCache;
	public RouterTableCache routerTableCache;

	private DbTestBedFactory factory;
	
	public DatabaseCacheManager(DbTestBedFactory factory) {
		this.factory = factory;
		
		// Default cache sizes
		int experimentCacheSize = 2048 * 1024;
		int phyMachineCacheSize = 512 * 1024;
		int virtualRouterCacheSize = 1024 * 1024;
		int portCacheSize = 512 * 1024;
		int userCacheSize = 512 * 1024;
		int operationCacheSize = 512 * 1024;
		int routerTableCacheSize = 512 * 1024;
		
		// Initialize all cache structures
		experimentCache = new ExperimentCache(new LongCache(experimentCacheSize),
				factory);
		phyMachineCache = new PhyMachineCache(new LongCache(phyMachineCacheSize),
				factory);
		virtualRouterCache = new VirtualRouterCache(new LongCache(virtualRouterCacheSize),
				factory);
		portCache = new PortCache(new LongCache(portCacheSize),
				factory);
		userCache = new UserCache(new LongCache(userCacheSize),
				factory);
		operationCache = new OperationCache(new LongCache(operationCacheSize),
				factory);
		routerTableCache = new RouterTableCache(new LongCache(routerTableCacheSize),
				factory);
	}
	
	public void clear(int cacheType) {
        getCache(cacheType).clear();
    }

    public long getHits(int cacheType) {
        return getCache(cacheType).getCacheHits();
    }

    public long getMisses(int cacheType) {
        return getCache(cacheType).getCacheMisses();
    }

    public int getSize(int cacheType) {
         return getCache(cacheType).getSize();
    }

    public int getMaxSize(int cacheType) {
        return getCache(cacheType).getMaxSize();
    }

    public void setMaxSize(int cacheType, int size) {
        getCache(cacheType).setMaxSize(size);
    }
    
    public int getNumElements(int cacheType) {
        return getCache(cacheType).getNumElements();
    }

    private DatabaseCache getCache(int cacheType) {
        switch (cacheType) {
            case EXPERIMENT_CACHE:
                return experimentCache;
            case PHYMACHINE_CACHE:
                return phyMachineCache;
            case VIRTUALROUTER_CACHE:
                return virtualRouterCache;
            case PORT_CACHE:
                return portCache;
            case USER_CACHE:
                return userCache;
            case OPERATION_CACHE:
                return operationCache;
            case ROUTERTABLE_CACHE:
                return routerTableCache;
            default:
                throw new IllegalArgumentException("Invalid cache type: " + cacheType);
        }
    }
}
