package com.testbed.database;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javassist.NotFoundException;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import com.resultFilter.ResultFilter;
import com.testbed.PhyMachine;
import com.testbed.VirtualRouter;
import com.util.CacheSizes;
import com.util.Cacheable;

public class DbPhyMachine implements PhyMachine, Cacheable{

	private DbTestBedFactory factory;
	private int id;
	private String description;
	private String ip;
	private String code;
	private int HVRCount;
	private int LVRCount;
	private float memory;
	private float CPU;
	
	
	private ArrayList<Integer> HVRsID = new ArrayList<Integer>();
	private ArrayList<Integer> LVRsID = new ArrayList<Integer>();
	
	private Date [] timeBuffer = new Date[TestBedGlobals.UPDATE_BUFFER_SIZE];
	private float [] cpuUsageBuffer = new float[TestBedGlobals.UPDATE_BUFFER_SIZE];
	private float currentCpuUsage;
	private float [] memUsageBuffer = new float[TestBedGlobals.UPDATE_BUFFER_SIZE];
	private float currentMemUsage;
	private int bufferSize;
	
	SessionFactory sessionFactory=new Configuration().configure().buildSessionFactory();
	
	public DbPhyMachine() {};
	/**
	 * Creates a new PhyMachine with the code and description and ip address.
	 * Then call private method <code>insertIntoDb</code> to insert 
	 * this PhyMachine into database.
	 * @param code
	 * @param description
	 * @param ip
	 * @param factory
	 */
	public DbPhyMachine(int expID, String code, String description, String ip,
			DbTestBedFactory factory) {
		//this.id = SequenceManager.nextID(TestBedGlobals.PHYMACHINE);
		this.factory = factory;
		this.code = code;
		this.description = description;
		this.ip = ip;
		this.id = expID;
		insertIntoDb();
	}
	
	/**
	 * Loads the specified DbTestBedFactory by its id.
	 * @param id
	 */
	public DbPhyMachine(int id, DbTestBedFactory factory) throws NotFoundException{
		this.id = id;
		this.factory = factory;
		loadFromDb();
	}
	
	/**
	 * Loads PhyMachine from the database.
	 */
	private void loadFromDb() throws NotFoundException{

//		System.out.println("loadFromDb");
//		this.id = 1;
//		this.description = "hello world";
//		this.ip = "10.21.2.10";
//		this.code = "PM0";
//		this.HVRCount = 2;
//		this.LVRCount = 3;
//		this.memory = 232;
//		this.CPU = "intel";
//		currentCpuUsage = (float) 0.323;
//		currentMemUsage = (float) 0.23;

		

		
		//getIDBlock(ResultFilter filter);

		Session session = factory.getSessionFactory().openSession();
	    Transaction tx = null;
	    DbPhyMachine pm;
	    try {
	      tx = session.beginTransaction();

	      pm=(DbPhyMachine)session.get(DbPhyMachine.class,this.id);
	      tx.commit();

	    }catch (RuntimeException e) {
	      if (tx != null) {
	        tx.rollback();
	      }
	      throw e;
	    } finally {
	      session.close();
	    }
	    if (pm!=null)
	    {
	    	this.bufferSize = 0;
	    	this.setCode(pm.getCode());
	 		this.setCPU(pm.getCPU());
	 		//cpuUsageBuffer
	 		this.currentCpuUsage = 0;
	 		this.currentMemUsage = 0;
	 		this.setDescription(pm.getDescription());
	 		this.setHVRCount(pm.getHVRCount());
	 		//HVRsID
	 		this.setIp(pm.getIp());
	 		this.setLVRCount(pm.getLVRCount());
	 		//LVRSID
	 		this.setMemory(pm.getMemory());
	 		//memUsageBuffer
	 		//timeBuffer
	 		
	 		/** 
			 * 设置Filter，取得高优先级的路由器ID List.
			 */
			ResultFilter filter = ResultFilter.createDefaultVrFilter();
			filter.addProperty(TestBedGlobals.VR_TYPE, 
					TestBedGlobals.VR_TYPE_VALUE.VR_HIGN);
			Object [] IDList = getIDBlock(filter);
			for (int i = 0; i < IDList.length; i++) {
				HVRsID.add((Integer) IDList[i]);
			}
			System.out.println("LVRsID---------->"+HVRsID);
			
			filter = ResultFilter.createDefaultVrFilter();
			filter.addProperty(TestBedGlobals.VR_TYPE, 
					TestBedGlobals.VR_TYPE_VALUE.VR_LOW);
			IDList = getIDBlock(filter);
			for (int i = 0; i < IDList.length; i++) {
				LVRsID.add((Integer) IDList[i]);
			}
			System.out.println("LVRsID------>"+LVRsID);
	    } else {
	    	throw new NotFoundException("PhyMachine not found");
	    }

	}
	
	/**
	 * Inserts a new PM record into the database.
	 */
	private void insertIntoDb()	{
		System.out.println("before insertIntoDb---------");
		System.out.println(code);
		System.out.println(CPU);
		System.out.println(description);
		System.out.println(HVRCount);
		System.out.println(ip);
		System.out.println(LVRCount);
		System.out.println(memory);
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
	    factory.getCacheManager().phyMachineCache.cache.add(this.id, this);
	    System.out.println("after insertIntoDb---------");
	}
	
	/**
	 * Saves PM data to the database.
	 */
	public void saveToDb()	{
		Session session = factory.getSessionFactory().openSession();
	    Transaction tx = null;
	    DbPhyMachine pm;
	    try {
	    	tx = session.beginTransaction();

	    	pm=(DbPhyMachine)session.get(DbPhyMachine.class,this.id);
	      
	    	pm.setCode(code);
	    	pm.setCPU(CPU);
	    	
	    	pm.setDescription(description);
	    	pm.setHVRCount(HVRCount);
			//HVRsID
	    	pm.setIp(ip);
	    	pm.setLVRCount(LVRCount);
			//LVRSID
	    	pm.setMemory(memory);
	    	
	    	System.out.println("phyMachine saveToDb CPU--------->" + pm.getCPU());
	    	System.out.println("phyMachine saveToDb memory--------->" + pm.getMemory());
	    	System.out.println("phyMachine saveToDb HVRCount--------->" + pm.getHVRCount());
	    	System.out.println("phyMachine saveToDb LVRCount--------->" + pm.getLVRCount());
	    	
			tx.commit();

	    }catch (RuntimeException e) {
	    	if (tx != null) {
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
		
		size += CacheSizes.sizeOfObject();					// overhead of object
		size += CacheSizes.sizeOfObject();					// factory
		size += CacheSizes.sizeOfInt();						// id
		// timeBuffer
		size += CacheSizes.sizeOfDate() * TestBedGlobals.UPDATE_BUFFER_SIZE;	
		// cpuUsageBuffer
		size += CacheSizes.sizeOfFloat() * TestBedGlobals.UPDATE_BUFFER_SIZE;
		size += CacheSizes.sizeOfFloat();					// currentCpuUsage
		// memUsageBuffer
		size += CacheSizes.sizeOfFloat() * TestBedGlobals.UPDATE_BUFFER_SIZE;
		size += CacheSizes.sizeOfFloat();					// currentMemUsage
		size += CacheSizes.sizeOfString(description);		// description
		size += CacheSizes.sizeOfString(ip);				// ip
		size += CacheSizes.sizeOfString(code);				// code
		size += CacheSizes.sizeOfInt();						// bufferSize
		size += CacheSizes.sizeOfInteger() * HVRsID.size();			// HVRsID
		size += CacheSizes.sizeOfInteger() * LVRsID.size();			// LVRsID
		
		return size;
	}

	public int getId() {
		// TODO Auto-generated method stub
		return this.id;
	}

	public void setId(int id)
	{
		this.id = id;
	}
	
	public String getIp() {
		// TODO Auto-generated method stub
		return this.ip;
	}

	public void setIp(String ip) {
		// TODO Auto-generated method stub
		this.ip=ip;
	}
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getDescription() {
		// TODO Auto-generated method stub
		return this.description;
	}
	
	public void setDescription(String des) {
		// TODO Auto-generated method stub
		this.description=des;
	}

	public void saveRealData() {
		// TODO Auto-generated method stub
		Session session=sessionFactory.openSession();
		Transaction transaction = session.beginTransaction();
		String sql = "insert into phyRealData(TIME,CPUUSAGE,MEMUSAGE,PHYID) values(?,?,?,?)";
		for (int i = 0 ; i< this.bufferSize; i++)
		{	
			Query query= session.createSQLQuery(sql)
			.setParameter(0, this.timeBuffer[i])
			.setParameter(2, this.cpuUsageBuffer[i])
			.setParameter(3, this.memUsageBuffer[i])
			.setParameter(1, this.id);
			
			query.executeUpdate();
		}
		transaction.commit();
		session.close();
		
		this.bufferSize = 0;
	}

	public void addVR(VirtualRouter vr) {
		// TODO Auto-generated method stub
		if (vr.getType())
		{
			this.HVRsID.add(vr.getId());
			this.HVRCount++;
		}
		else
		{
			this.LVRsID.add(vr.getId());
			this.LVRCount++;
		}
		saveToDb();
	}

	public VirtualRouter getVR(int vrID) {
		// TODO Auto-generated method stub
		return this.factory.getVR(vrID);
	}

	public void deleteVR(VirtualRouter vr) {
		// TODO Auto-generated method stub
		if (vr.getType())
		{
			this.HVRsID.remove(vr.getId());
			this.HVRCount--;
		}
		else
		{
			this.LVRsID.remove(vr.getId());
			this.LVRCount--;
		}
	}

	public int getVRCount(ResultFilter filter) {
		// TODO Auto-generated method stub
		if (filter.getPropertyCount() == 0) {
			return this.HVRsID.size() + this.LVRsID.size();
		} else if (filter.getPropertyName(0) == TestBedGlobals.VR_TYPE) {
			if (filter.getPropertyValue(0).
					equals(TestBedGlobals.VR_TYPE_VALUE.VR_HIGN))
			{
				return this.HVRsID.size();
			}
			else
			{
				return this.LVRsID.size();
			}
		} else {
			return -1;
		}
		
	}

	public ArrayList<VirtualRouter> vrs(ResultFilter filter) {
		// TODO Auto-generated method stub
		int i , length=0;
		ArrayList<Integer> vrList;
		ArrayList<VirtualRouter> vrArrayList = new ArrayList<VirtualRouter>();
		
		if (filter.getPropertyCount() == 0) {
			vrList = this.HVRsID;
			vrList.addAll(this.LVRsID);
			length=this.HVRsID.size() + this.LVRsID.size();
		} else if (filter.getPropertyName(0) == TestBedGlobals.VR_TYPE) {
			if (filter.getPropertyValue(0).
					equals(TestBedGlobals.VR_TYPE_VALUE.VR_HIGN))
			{
				vrList=this.HVRsID;
				length=this.HVRsID.size();
			}
			else
			{
				vrList=this.LVRsID;
				length=this.LVRsID.size();
			}
		} else {
			return null;
		}
		
		for (i = 0; i<length; i++)
		{
			vrArrayList.add(this.factory.getVR(vrList.get(i)));
		}
		return vrArrayList;
	}

	public float getMemUsage() {
		// TODO Auto-generated method stub
		return this.currentMemUsage;
	}
	
	public float getCpuUsage() {
		// TODO Auto-generated method stub
		return this.currentCpuUsage;
	}

	public void update(float cpu, float mem, Date time) {
		// TODO Auto-generated method stub
		if (this.bufferSize>=TestBedGlobals.UPDATE_BUFFER_SIZE)
		{
			//saveRealData();
			this.bufferSize=0;
			
		}
		else
		{
			this.timeBuffer[this.bufferSize]=time;
			this.cpuUsageBuffer[this.bufferSize]=cpu;
			this.memUsageBuffer[this.bufferSize]=mem;
			this.bufferSize++;
			
		}
		
		this.currentCpuUsage=cpu;
		this.currentMemUsage=mem;
	}

	public void setHVRCount(int hVRCount) {
		HVRCount = hVRCount;
	}

	public int getHVRCount() {
		return HVRCount;
	}

	public void setLVRCount(int lVRCount) {
		LVRCount = lVRCount;
	}

	public int getLVRCount() {
		return LVRCount;
	}

	public ArrayList<Float> getMemUsageList(ResultFilter filter) {
		// TODO Auto-generated method stub
		return null;
	}

	public ArrayList<Float> getCpuUsageList(ResultFilter filter) {
		// TODO Auto-generated method stub
		return null;
	}

	public int getMemUsageListCnt(ResultFilter filter) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int getCpuUsageListCnt(ResultFilter filter) {
		// TODO Auto-generated method stub
		return 0;
	}

	public float getCPU() {
		return CPU;
	}
	public void setCPU(float cPU) {
		CPU = cPU;
	}
	public float getMemory() {
		// TODO Auto-generated method stub
		return memory;
	}

	public void setMemory(float memory) {
		// TODO Auto-generated method stub
		this.memory = memory;
	}
	
	private Object [] getIDBlock(ResultFilter filter) {
		Session session = factory.getSessionFactory().openSession(); //创建一个会话
		Transaction tx = null;
		List<Integer> results = null;
		
		try {
			tx = session.beginTransaction(); //开始一个事务
			String hql = getIDListHQL(filter, false);
			Query query=session.createSQLQuery(hql);
			int startIndex = filter.getStartIndex();
			int maxResultCnt = filter.getNumResults();
			// 设置了开始行的行号
			if (startIndex != -1) {
				query.setFirstResult(startIndex);  
			}
	        
	        // 设置了开始总行数
	        if (maxResultCnt != ResultFilter.NULL_INT) {
	        	query.setMaxResults(maxResultCnt);  
	        }
	        results = query.list(); 
	        tx.commit(); //提交事务
	        
		} catch (RuntimeException e) {
			if (tx != null) {
				tx.rollback();
			}
	    } finally {
	        session.close();
	        return results.toArray();
	    }
	}
	
	private String getIDListHQL(ResultFilter resultFilter, boolean countQuery) {
		int sortField = resultFilter.getSortField();
		int propertyCnt = resultFilter.getPropertyCount();
		// We'll accumlate the query in a StringBuffer.
        StringBuffer hql = new StringBuffer(80);
        if (!countQuery) {
        	hql.append("SELECT ID");
        }
        else {
        	hql.append("SELECT count(1)");
        }
        
        // SELECT -- need to add value that we sort on
        if (!countQuery) {
            switch(sortField) {
                case TestBedGlobals.CODE :
                	hql.append(", Code");
                	break;
                case TestBedGlobals.CREATION_DATE :
                	hql.append(", time");
                	break;
            }
        }
        
        // FROM -- values
        hql.append(" FROM ").append(resultFilter.getDatabase());
        
        // WHERE BLOCK
        hql.append(" WHERE phyID=").append(this.id);
        // Properties
        for (int i = 0; i < propertyCnt; i++) {
    		String column = TestBedGlobals.COLUMN[resultFilter.getPropertyName(i)];
    		hql.append(" and ")
    		.append(column)
    		.append(" = ")
    		.append(resultFilter.getPropertyValue(i).ordinal());
    	}
        
        // ORDER BY
        if (!countQuery && sortField != -1) {
        	hql.append(" ORDER BY ");
            switch(sortField) {
	            case TestBedGlobals.CODE :
	            	hql.append(", Code");
	            	break;
	            case TestBedGlobals.CREATION_DATE :
	            	hql.append(", time");
	            	break;
            }
            if (resultFilter.getSortOrder() == ResultFilter.DESCENDING) {
            	hql.append(" DESC");
            }
            else {
            	hql.append(" ASC");
            }
        }
        
        return hql.toString();
	}

	
}
