package com.testbed.database;


import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javassist.NotFoundException;


import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import com.resultFilter.ResultFilter;
import com.testbed.Experiment;
import com.testbed.User;
import com.testbed.VirtualRouter;
import com.testbed.database.TestBedGlobals.EXP_STATE_VALUE;
import com.util.CacheSizes;
import com.util.Cacheable;
import com.util.IntList;

public class DbExperiment implements Experiment, Cacheable{

	private DbTestBedFactory factory;
	
	private int id;
	private int userID;
	private String expName;
	private String description;
	private int vrNumHigh;
	private int vrNumLow;
	private String topoXML;
	private String configXML;
	// 0 = APPLYING, 1 = EXPERIMENTING, 2 = REJECTED, 3 = FINISHED, 4 = RELEASEED 
	private int expState;
	private boolean isStart;
	private java.util.Date expApplyTime;
	private java.util.Date expDeadLine;
	private java.util.Date expStartTime;
	
	
	private ArrayList<Integer> HighCodeID = new ArrayList<Integer>();
	private ArrayList<Integer> LowCodeID = new ArrayList<Integer>();
	
	//map  code to ID
	private Map<Integer, Integer> code2ID = new HashMap<Integer, Integer>();
	
	private ArrayList<Integer> HVRsID = new ArrayList<Integer>();
	private ArrayList<Integer> LVRsID = new ArrayList<Integer>();
	
	
	/**
	 * Creates a new Experiment with the owner and specified name and \
	 * description and topological graph.
	 * Then call private method <code>insertIntoDb</code> to insert 
	 * this experiment into database. 
	 * @param user	owner
	 * @param expName
	 * @param description	
	 * @param topo
	 */
	public DbExperiment(User user, String expName, String description, String topo,
			int vrH, int vrL, ArrayList<Integer> HCID,ArrayList<Integer> LCID,String config, DbTestBedFactory factory) {
		this.setFactory(factory);
		
		//this.setId(SequenceManager.nextID(TestBedGlobals.EXPERIMENT));
		this.setUserID(user.getId());
		this.setExpName(expName);
		this.setDescription(description);
		this.setVrNumHigh(vrH);
		this.setVrNumLow(vrL);
		this.setHighCodeID(HCID);
		this.setLowCodeID(LCID);
		this.setTopoXML(topo);
		this.setConfigXML(config);
		this.setExpState(0);
		long now = System.currentTimeMillis();
		this.setExpApplyTime(new java.util.Date(now));
		this.setStart(false);
		
		
		
		
		insertIntoDb();
		
		int vrN = this.getVrNumHigh();
		for (int i = 0; i < vrN ; i++)
		{
			//暂时存放在pm1
			VirtualRouter vr = factory.createVR(19, (Experiment)this, HighCodeID.get(i), true);
			this.addVR(vr);
		}
		
		vrN = this.getVrNumLow();
		for (int i = 0; i < vrN ; i++)
		{
			//暂时存放在pm1
			VirtualRouter vr = factory.createVR(19, (Experiment)this, LowCodeID.get(i), false);
			this.addVR(vr);
		}
		
		
		//test();
	}
	

	public DbExperiment() {};

	public void test()
	{
		SessionFactory sessionFactory=new Configuration().configure().buildSessionFactory();

		Session session=sessionFactory.openSession();
		Transaction transaction = session.beginTransaction();
		String sql = "insert into portRealData(VRID,PORTID,TIME,EXPID,FLOW) values(?,?,?,?,?)";
		
			Query query= session.createSQLQuery(sql)
			.setParameter(0, 1)
			.setParameter(1, 0)
			.setParameter(2, new java.util.Date(System.currentTimeMillis()))
			.setParameter(3, 10)
			.setParameter(4, 1.5);
			query.executeUpdate();
		
		transaction.commit();
		session.close();
	}
	
	/**
	 * Loads the specified DbTestBedFactory by its id.
	 * @param id
	 * @param factory
	 */
	public DbExperiment(int id, DbTestBedFactory factory) throws NotFoundException{
		this.setFactory(factory);
		this.setId(id);
		loadFromDb();
		
	}

	

	

	public String getDescription() {
		// TODO Auto-generated method stub
		return this.description;
	}

	public void setDescription(String descriptions) {
		// TODO Auto-generated method stub
		this.description = descriptions;
	}

	public void addVR(VirtualRouter vr) {
		//把ID加进数组
		// TODO Auto-generated method stub
		if (vr.getType())
		{
			this.HVRsID.add(vr.getId());
			
		}
		else
		{
			this.LVRsID.add(vr.getId());
			
		}
		code2ID.put(vr.getVrCode(), vr.getId());
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
		}
		else
		{
			this.LVRsID.remove(vr.getId());
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

	public void start() {
		// TODO Auto-generated method stub
		//发送控制信息，开始实验
		
		loadtoCache();
		this.setStart(true);
	}

	public void stop() {
		// TODO Auto-generated method stub
		//发送控制信息，结束实验
		
		this.setStart(false);
		deleteFromCache();
	}

	
	private void deleteFromCache() {
		// TODO Auto-generated method stub
		
	}

	private void loadtoCache() {
		// TODO Auto-generated method stub
		
	}
	
	private void insertIntoDb() {
		// TODO Auto-generated method stub
		
		System.out.println(userID);
		System.out.println(expName);
		System.out.println(description);
		System.out.println(vrNumLow);
		System.out.println(vrNumHigh);
		System.out.println(topoXML);
		System.out.println("state:"+expState);
		System.out.println("applytime："+expApplyTime);
		System.out.println("isstart"+isStart);
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
	    factory.getCacheManager().experimentCache.cache.add(this.id, this);
	}
	
	private void loadFromDb() throws NotFoundException{
		// TODO Auto-generated method stub
		
		Session session = factory.getSessionFactory().openSession();
	    Transaction tx = null;
	    DbExperiment exp;
	    try {
	      tx = session.beginTransaction();

	      exp=(DbExperiment)session.get(DbExperiment.class,this.id);
	      System.out.println("this.id");
	      tx.commit();

	    }catch (RuntimeException e) {
	      if (tx != null) {
	        tx.rollback();
	      }
	      throw e;
	    } finally {
	      session.close();
	    }
	    if (exp!=null)
	    {
	    	this.setUserID(exp.getUserID());
	 		this.setExpName(exp.getExpName());
	 		this.setDescription(exp.getDescription());
	 		this.setVrNumHigh(exp.getVrNumHigh());
	 		this.setVrNumLow(exp.getVrNumLow());
	 		
	 		this.setTopoXML(exp.getTopoXML());
	 		this.setConfigXML(exp.getConfigXML());
	 		this.setExpState(exp.getExpState());
	 		
	 		this.setExpApplyTime(exp.getExpApplyTime());
	 		this.setStart(exp.isStart());
	 		this.setExpDeadLine(exp.getExpDeadLine());
	 		this.setExpStartTime(exp.getExpStartTime());
	 		
	 		/** 
			 * 设置Filter，取得高优先级的路由器ID List.
			 */
			ResultFilter filter = ResultFilter.createDefaultVrFilter();
			filter.addProperty(TestBedGlobals.VR_TYPE, 
					TestBedGlobals.VR_TYPE_VALUE.VR_HIGN);
			Object [] IDList = getIDBlock(filter);
			int code;
			for (int i = 0; i < IDList.length; i++) {
				HVRsID.add((Integer) IDList[i]);
				code = factory.getVR((Integer)IDList[i]).getVrCode();
				this.HighCodeID.add(code);
				this.code2ID.put(code,(Integer)IDList[i]);
			}
			System.out.println("HVRsID---------->"+HVRsID);
			System.out.println("HVRsCode---------->"+HighCodeID);
			filter = ResultFilter.createDefaultVrFilter();
			filter.addProperty(TestBedGlobals.VR_TYPE, 
					TestBedGlobals.VR_TYPE_VALUE.VR_LOW);
			IDList = getIDBlock(filter);
			for (int i = 0; i < IDList.length; i++) {
				LVRsID.add((Integer) IDList[i]);
				code = factory.getVR((Integer)IDList[i]).getVrCode();
				this.LowCodeID.add(code);
				this.code2ID.put(code,(Integer)IDList[i]);
			}
			System.out.println("LVRsID------>"+LVRsID);
	    }  else {
	    	throw new NotFoundException("PhyMachine not found");
	    }
	}
	
	/**
	 * Saves Experiment data to the database.
	 */
	public void saveToDb()	{
		Session session = factory.getSessionFactory().openSession();
	    Transaction tx = null;
	    DbExperiment exp;
	    try {
	    	tx = session.beginTransaction();

	    	exp=(DbExperiment)session.get(DbExperiment.class,this.id);
	      
	    	exp.setUserID(userID);
	    	exp.setExpName(expName);
	    	exp.setDescription(description);
	    	exp.setVrNumHigh(vrNumHigh);
	    	exp.setVrNumLow(vrNumLow);
	 		
	    	exp.setTopoXML(topoXML);
	    	exp.setConfigXML(configXML);
	    	exp.setExpState(expState);
	 		
	    	exp.setExpApplyTime(expApplyTime);
	    	exp.setStart(isStart);
	    	exp.setExpDeadLine(expDeadLine);
	    	exp.setExpStartTime(expStartTime);
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
	

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public int getUserID() {
		return userID;
	}

	public void setExpName(String expName) {
		this.expName = expName;
	}

	public String getExpName() {
		return expName;
	}

	public void setVrNumHigh(int vrNumHigh) {
		this.vrNumHigh = vrNumHigh;
	}

	public int getVrNumHigh() {
		return vrNumHigh;
	}

	public void setVrNumLow(int vrNumLow) {
		this.vrNumLow = vrNumLow;
	}

	public int getVrNumLow() {
		return vrNumLow;
	}

	public void setTopoXML(String topoXML) {
		this.topoXML = topoXML;
	}

	public String getTopoXML() {
		return topoXML;
	}

	public void setExpState(int expState) {
		this.expState = expState;
	}

	public int getExpState() {
		return expState;
	}

	public void setExpApplyTime(java.util.Date expApplyTime) {
		this.expApplyTime = expApplyTime;
	}

	public ArrayList<Integer> getHVRsID() {
		return HVRsID;
	}

	public void setHVRsID(ArrayList<Integer> hVRsID) {
		HVRsID = hVRsID;
	}
	
	public ArrayList<Integer> getLVRsID() {
		return LVRsID;
	}

	public java.util.Date getExpApplyTime() {
		return expApplyTime;
	}

	public void setStart(boolean isStart) {
		this.isStart = isStart;
	}

	public boolean isStart() {
		return isStart;
	}

	public void setExpDeadLine(java.util.Date expDeadLine) {
		this.expDeadLine = expDeadLine;
	}

	public java.util.Date getExpDeadLine() {
		return expDeadLine;
	}

	public void setExpStartTime(java.util.Date expStartTime) {
		this.expStartTime = expStartTime;
	}

	public java.util.Date getExpStartTime() {
		return expStartTime;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getId() {
		return id;
	}

	public void setConfigXML(String configXML) {
		this.configXML = configXML;
	}

	public String getConfigXML() {
		return configXML;
	}

	public void setFactory(DbTestBedFactory factory) {
		this.factory = factory;
	}

	public DbTestBedFactory getFactory() {
		return factory;
	}

	
	public int getSize() {
		// TODO Auto-generated method stub
		int size = 0;
		
		size += CacheSizes.sizeOfObject();					// overhead of object
		size += CacheSizes.sizeOfInt();						// id
		size += CacheSizes.sizeOfInt();						// userID
		size += CacheSizes.sizeOfString(expName);			// expName
		size += CacheSizes.sizeOfString(description);		// description
		size += CacheSizes.sizeOfInt();						// vrNumHigh
		size += CacheSizes.sizeOfInt();						// vrNumLow
		size += CacheSizes.sizeOfString(topoXML);			// topoXML
		size += CacheSizes.sizeOfString(configXML);			// configXML
		size += CacheSizes.sizeOfInt();						// expState
		size += CacheSizes.sizeOfDate();					// expApplyTime
		size += CacheSizes.sizeOfBoolean();					// isStarted
		size += CacheSizes.sizeOfDate();					// expDeadLine
		size += CacheSizes.sizeOfDate();					// expStartTime
		size += CacheSizes.sizeOfObject();					// factory
		
		size += CacheSizes.sizeOfInteger() * HVRsID.size();			// HVRsID
		size += CacheSizes.sizeOfInteger() * LVRsID.size();			// LVRsID
		
		return size;
	}


	public void setHighCodeID(ArrayList<Integer> highCodeID) {
		HighCodeID = highCodeID;
	}

	public ArrayList<Integer> getHighCodeID() {
		return HighCodeID;
	}

	public void setLowCodeID(ArrayList<Integer> lowCodeID) {
		LowCodeID = lowCodeID;
	}

	public ArrayList<Integer> getLowCodeID() {
		return LowCodeID;
	}

	public void setCode2ID(Map<Integer, Integer> code2ID) {
		this.code2ID = code2ID;
	}

	public Map<Integer, Integer> getCode2ID() {
		return code2ID;
	}


	public User getUser() {
		// TODO Auto-generated method stub
		
		return factory.getUserManager().getUser(userID);
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
				e.printStackTrace();
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
                	hql.append(", code");
                	break;
                case TestBedGlobals.CREATION_DATE :
                	hql.append(", time");
                	break;
            }
        }
        
        // FROM -- values
        hql.append(" FROM ").append(resultFilter.getDatabase());
        
        // WHERE BLOCK
        hql.append(" WHERE expID=").append(this.id);
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
	            	hql.append(" Code");
	            	break;
	            case TestBedGlobals.CREATION_DATE :
	            	hql.append(" time");
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
