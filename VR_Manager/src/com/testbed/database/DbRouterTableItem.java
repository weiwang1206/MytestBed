package com.testbed.database;

import org.hibernate.Session;
import org.hibernate.Transaction;

import javassist.NotFoundException;

import com.testbed.Port;
import com.testbed.RouterTableItem;
import com.testbed.VirtualRouter;
import com.util.CacheSizes;
import com.util.Cacheable;

public class DbRouterTableItem implements RouterTableItem, Cacheable{

	private DbTestBedFactory factory;
	private int id;
	private int vrID;
	private String code;
	private String desIP;
	private String nextHop;
	private String exPort;
	
	
	/**
	 * Creates a new DbPort.
	 * Then it must be add to a VirtualRouter.
	 * @param code
	 * @param desIP
	 * @param nextHop
	 * @param _interface
	 * @param factory
	 */
	public DbRouterTableItem(String code, String desIP, String nextHop, String exPort,
			DbTestBedFactory factory) {
		this.factory = factory;
		//this.id = SequenceManager.nextID(TestBedGlobals.ROUTERTABLE);
		this.code = code;
		this.desIP = desIP;
		this.nextHop = nextHop;
		this.exPort = exPort;
	}
	
	/**
	 * Loads a DbPort from the database based on its id.
	 * @param id
	 * @param factory
	 */
	public DbRouterTableItem(int id, DbTestBedFactory factory) throws NotFoundException{
		this.id = id;
		this.factory = factory;
		loadFromDb();
	}
	
	public DbRouterTableItem() {};
	

	
	public VirtualRouter getVR() {
		// TODO Auto-generated method stub
		return null;
	}
	
	/**
	 * Loads VR from the database.
	 */
	private void loadFromDb() throws NotFoundException{
		Session session = factory.getSessionFactory().openSession();
	    Transaction tx = null;
	    RouterTableItem rtItem;
	    try {
	      tx = session.beginTransaction();

	      rtItem = (RouterTableItem)session.get(DbRouterTableItem.class,this.id);
	      tx.commit();

	    }catch (RuntimeException e) {
	      if (tx != null) {
	    	  e.printStackTrace();
	    	  tx.rollback();
	      }
	      throw e;
	    } finally {
	      session.close();
	    }
	    if (rtItem!=null)
	    {
	    	this.code = rtItem.getCode();
	    	this.desIP = rtItem.getDesIP();
	 		this.exPort = rtItem.getExPort();
	 		this.nextHop = rtItem.getNextHop();
	 		this.vrID = rtItem.getVrID();
	    } else {
	    	throw new NotFoundException("RouterTableItem not found");
	    }
	}
	
	/**
	 * Inserts a new VR record into the database.
	 * @param vr VirtualRouter which this routerTable belongs to.
	 */
	public void insertIntoDb()	{
		System.out.println("before insertIntoDb---------");
		Session session = factory.getSessionFactory().openSession();
	    Transaction tx = null;
	    try {
	      tx = session.beginTransaction();
	      session.save(this);
	      tx.commit();

	    }catch (RuntimeException e) {
	      if (tx != null) {
	        tx.rollback();
	      }
	      throw e;
	    } finally {
	      session.close();
	    }
	    System.out.println(this.id);
	    factory.getCacheManager().routerTableCache.cache.add(this.id, this);
	    System.out.println("after insertIntoDb---------");
	}
	
	/**
	 * Saves VR data to the database.
	 */
	private void saveToDb()	{
		Session session = factory.getSessionFactory().openSession();
	    Transaction tx = null;
	    RouterTableItem rtItem;
	    try {
	    	tx = session.beginTransaction();

	    	rtItem=(RouterTableItem)session.get(DbRouterTableItem.class,this.id);
	     
	    	rtItem.setVrID(vrID);
	    	rtItem.setCode(code);
	    	rtItem.setDesIP(desIP);
	    	rtItem.setNextHop(nextHop);
			tx.commit();

	    }catch (RuntimeException e) {
	    	if (tx != null) {
	    		e.printStackTrace();
	    		tx.rollback();
	    	}
	    	throw e;
	    } finally {
	    	session.close();
	    }
	}

	/**
	 * Deletes the RouterTable records in the database.
	 */
	private void deleteRouterTable() {
		
	}

	
	public int getSize() {
		// TODO Auto-generated method stub
//		private DbTestBedFactory factory;
//		private int id;
//		private int vrID;
//		private String code;
//		private String desIP;
//		private String nextHop;
//		private String _interface;
		int size = 0;
		
		size += CacheSizes.sizeOfObject();				// overhead of object
		size += CacheSizes.sizeOfString(exPort);	// _interface
		size += CacheSizes.sizeOfString(code);			// code
		size += CacheSizes.sizeOfString(desIP);			// desIP
		size += CacheSizes.sizeOfObject();				// factory
		size += CacheSizes.sizeOfInt();					// id
		size += CacheSizes.sizeOfString(nextHop);		// nextHop
		size += CacheSizes.sizeOfInt();					// vrID
		
		return size;
	}
	public DbTestBedFactory getFactory() {
		return factory;
	}

	public void setFactory(DbTestBedFactory factory) {
		this.factory = factory;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getVrID() {
		return vrID;
	}

	public void setVrID(int vrID) {
		this.vrID = vrID;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getDesIP() {
		return desIP;
	}

	public void setDesIP(String desIP) {
		this.desIP = desIP;
	}

	public String getNextHop() {
		return nextHop;
	}

	public void setNextHop(String nextHop) {
		this.nextHop = nextHop;
	}

	public String getExPort() {
		return exPort;
	}

	public void setExPort(String exPort) {
		this.exPort = exPort;
	}

	
	
}
