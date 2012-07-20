package com.testbed.database;

import java.util.ArrayList;
import java.util.Date;

import javassist.NotFoundException;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import com.resultFilter.ResultFilter;
import com.testbed.Port;
import com.testbed.VirtualRouter;
import com.util.CacheSizes;
import com.util.Cacheable;

public class DbPort implements Port, Cacheable{

	private DbTestBedFactory factory;
	private int id;
	private int portCode;
	private int vrID;


	private String ip;
	private String ospf;
	private Date [] timeBuffer = new Date[TestBedGlobals.UPDATE_BUFFER_SIZE];
	private float [] flowList = new float[TestBedGlobals.UPDATE_BUFFER_SIZE];
	private float currentFlow = 1;
	private int bufferSize = 0;
	
	SessionFactory sessionFactory=new Configuration().configure().buildSessionFactory();
	
	public float getCurrentFlow() {
		return currentFlow;
	}

	public void setCurrentFlow(float currentFlow) {
		this.currentFlow = currentFlow;
	}

	/**
	 * Creates a new DbPort.
	 * Then it must be add to a VirtualRouter.
	 * @param code for example "eth1"
	 * @param ip
	 * @param ospf
	 * @param factory
	 */
	public DbPort(VirtualRouter rt, int code, String ip, String ospf, DbTestBedFactory factory) {
		this.factory = factory;
		this.vrID = rt.getId();
		//this.id = SequenceManager.nextID(TestBedGlobals.PORT);
		this.ip = ip;
		this.ospf = ospf;
		this.portCode=code;
		insertIntoDb();
	}
	
	public DbPort(){}
	
	/**
	 * Loads a DbPort from the database based on its id.
	 * @param id
	 * @param factory
	 */
	public DbPort(int id, DbTestBedFactory factory) throws NotFoundException{
		this.id = id;
		this.factory = factory;
		loadFromDb();
	}
	
	
	
	
	public VirtualRouter getVR() {
		// TODO Auto-generated method stub
		return null;
	}


	/**
	 * Loads Port from the database.
	 */
	private void loadFromDb() throws NotFoundException{
		Session session = factory.getSessionFactory().openSession();
	    Transaction tx = null;
	    Port port;
	    try {
	      tx = session.beginTransaction();

	      port = (Port)session.get(DbPort.class,this.id);
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
	    if (port!=null)
	    {
	    	this.vrID = port.getVrID();
	    	this.setIp(port.getIp());
	 		this.setOspf(port.getOspf());
	 		this.setPortCode(port.getPortCode());
	    } else {
	    	throw new NotFoundException("port not found");
	    }
	}
	
	/**
	 * Inserts a new Port record into the database.
	 */
	private void insertIntoDb()	{
		System.out.println("before insertIntoDb---------");
		Session session = factory.getSessionFactory().openSession();
	    Transaction tx = null;
	    try {
	      tx = session.beginTransaction();
	      session.save(this);
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
	    System.out.println(this.id);
	    factory.getCacheManager().portCache.cache.add(this.id, this);
	    System.out.println("after insertIntoDb---------");
	}
	
	/**
	 * Saves Port data to the database.
	 */
	public void saveToDb()	{
		Session session = factory.getSessionFactory().openSession();
	    Transaction tx = null;
	    Port port;
	    try {
	    	tx = session.beginTransaction();

	    	port=(Port)session.get(DbPort.class,this.id);
	      
	    	port.setPortCode(portCode);
	    	port.setIp(ip);
	    	port.setOspf(ospf);
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

	
	public int getSize() {
		// TODO Auto-generated method stub
		
		int size = 0;
		
		size += CacheSizes.sizeOfObject();				// overhead of object
		size += CacheSizes.sizeOfObject();				// factory
		size += CacheSizes.sizeOfInt();					// id
		size += CacheSizes.sizeOfInt();					// portCode
		size += CacheSizes.sizeOfInt();					// vrID
		size += CacheSizes.sizeOfString(ip);			// ip
		size += CacheSizes.sizeOfString(ospf);			// ospf
		// timeBuffer
		size += CacheSizes.sizeOfDate() * TestBedGlobals.UPDATE_BUFFER_SIZE;
		// flowList
		size += CacheSizes.sizeOfFloat() * TestBedGlobals.UPDATE_BUFFER_SIZE;
		size += CacheSizes.sizeOfFloat();				// currentFlow
		
		return size;
	}

	public int getPortCode() {
		return portCode;
	}

	public void setPortCode(int portCode) {
		this.portCode = portCode;
	}

	public int getId() {
		// TODO Auto-generated method stub
		return this.id;
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
	public String getIp() {
		// TODO Auto-generated method stub
		return this.ip;
	}

	public void setIp(String ip) {
		// TODO Auto-generated method stub
		this.ip=ip;
	}

	public String getOspf() {
		// TODO Auto-generated method stub
		return this.ospf;
	}

	public void setOspf(String ospf) {
		// TODO Auto-generated method stub
		this.ospf=ospf;
	}

	public float getFlow() {
		// TODO Auto-generated method stub
		return this.currentFlow;
	}

	public void updateFlow(float flow, Date time) {
		// TODO Auto-generated method stub
		if (this.bufferSize==TestBedGlobals.UPDATE_BUFFER_SIZE)
		{
			saveRealData();
		}
		
		this.timeBuffer[this.bufferSize]=time;
		this.flowList[this.bufferSize]=flow;
		this.bufferSize++;
		
		this.setCurrentFlow(flow);
	}

	public void saveRealData() {
		// TODO Auto-generated method stub
		//Çå¿Õbuffer
		Session session=sessionFactory.openSession();
		Transaction transaction = session.beginTransaction();
		String sql = "insert into portRealData(VRID,PORTID,TIME,EXPID,FLOW) values(?,?,?,?,?)";
		for (int i = 0 ; i< this.bufferSize; i++)
		{	
			Query query= session.createSQLQuery(sql)
			.setParameter(0, this.vrID)
			.setParameter(1, this.portCode)
			.setParameter(2, timeBuffer[i])
			.setParameter(3, factory.getVR(vrID).getExperiment().getId())
			.setParameter(4, flowList[i]);
			query.executeUpdate();
		}
		transaction.commit();
		session.close();
		
		this.bufferSize = 0;
		
	}

	public ArrayList<Float> getFLowList(ResultFilter filter) {
		// TODO Auto-generated method stub
		return null;
	}

	public int getFLowListCnt(ResultFilter filter) {
		// TODO Auto-generated method stub
		return 0;
	}

}
