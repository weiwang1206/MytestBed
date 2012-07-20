package com.testbed.database;

import java.util.Date;

import javassist.NotFoundException;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.testbed.Operation;
import com.testbed.Port;
import com.testbed.User;
import com.util.CacheSizes;
import com.util.Cacheable;

public class DbOperation implements Operation, Cacheable{

	private int id;
	private int userID;
	private Date date;
	private int expID;
	private String opeRecord;
	private DbTestBedFactory factory;
	
	
	public DbOperation() {};
	/**
	 * Creates a new Operation with the owner and Experiment and \
	 * date and operation record.
	 * Then call private method <code>insertIntoDb</code> to insert 
	 * this Operation into database. 
	 * @param user
	 * @param exp
	 * @param date
	 * @param opeRecord
	 * @param factory
	 */
	public DbOperation(User user, int expID, Date date, String opeRecord,
			DbTestBedFactory factory) {
		this.factory = factory;
		this.id = SequenceManager.nextID(TestBedGlobals.OPERATION);
		this.userID = user.getId();
		this.expID = expID;
		this.date = date;
		this.opeRecord = opeRecord;
		insertIntoDb();
	}
	
	/**
	 * Loads the specified Operation by its id.
	 * @param id
	 * @param factory
	 */
	public DbOperation(int id, DbTestBedFactory factory) throws NotFoundException{
		this.factory = factory;
		this.id = id;
		loadFromDb();
	}



	public Date getDate() {
		// TODO Auto-generated method stub
		return date;
	}


	public String getOpeRecord() {
		// TODO Auto-generated method stub
		return opeRecord;
	}


	public User getUser() {
		// TODO Auto-generated method stub
		return factory.getUserManager().getUser(userID);
	}
	
	
	private void insertIntoDb() {
		// TODO Auto-generated method stub
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
	    factory.getCacheManager().phyMachineCache.cache.add(this.id, this);
	    System.out.println("after insertIntoDb---------");
	}
	
	private void loadFromDb() throws NotFoundException{
		// TODO Auto-generated method stub
		Session session = factory.getSessionFactory().openSession();
	    Transaction tx = null;
	    Operation op;
	    try {
	      tx = session.beginTransaction();

	      op = (Operation)session.get(DbOperation.class,this.id);
	      tx.commit();

	    }catch (RuntimeException e) {
	      if (tx != null) {
	        tx.rollback();
	      }
	      throw e;
	    } finally {
	      session.close();
	    }
	    if (op != null)
	    {
	    	this.date = op.getDate();
	 		this.opeRecord = op.getOpeRecord();
	    } else {
	    	throw new NotFoundException("PhyMachine not found");
	    }
	}

	public int getSize() {
		// TODO Auto-generated method stub

		int size = 0;
		
		size += CacheSizes.sizeOfObject();					// overhead of object
		size += CacheSizes.sizeOfInt();						// id
		size += CacheSizes.sizeOfInt();						// userID
		size += CacheSizes.sizeOfDate();					// date
		size += CacheSizes.sizeOfInt();						// expID
		size += CacheSizes.sizeOfString(opeRecord);			// opeRecord
		size += CacheSizes.sizeOfObject();					// factory
		
		return size;
	}

	public int getId() {
		// TODO Auto-generated method stub
		return id;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public int getExpID() {
		return expID;
	}

	public void setExpID(int expID) {
		this.expID = expID;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public void setOpeRecord(String opeRecord) {
		this.opeRecord = opeRecord;
	}
	
	
}
