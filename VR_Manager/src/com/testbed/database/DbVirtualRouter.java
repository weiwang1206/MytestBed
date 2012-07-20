package com.testbed.database;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javassist.NotFoundException;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.resultFilter.ResultFilter;
import com.testbed.Experiment;
import com.testbed.PhyMachine;
import com.testbed.Port;
import com.testbed.RouterTableItem;
import com.testbed.VirtualRouter;
import com.util.CacheSizes;
import com.util.Cacheable;

public class DbVirtualRouter implements VirtualRouter, Cacheable{

	private int id;
	private int vrCode; //实验里的ID号
	private int phyID;
	private int expID;
	private String routeProtocol;
	private boolean type;
	private boolean runState = false;
	private DbTestBedFactory factory;
	
	private int[] portsID={-1,-1,-1,-1}; //eth0 对应第一个portsID 来对应好
	
	private ArrayList<RouterTableItem> routerTable = new ArrayList<RouterTableItem>();
	
	/**
	 * Creates a new DbVirtualRouter.
	 * Then it must be add to a PhyMachine.
	 * @param pm the PhyMachine which the VirtualRouter belongs to.
	 * @param routeProtocol
	 * @param type true: HighPriority | false: LowPriority
	 * @param factory
	 */
	public DbVirtualRouter(PhyMachine pm, Experiment exp, boolean type, 
			int vrCode, DbTestBedFactory factory) {
		/*PhyMachine上的VirtualRouter是否超额*/
		/*if (false) {
			return;
		}*/
		this.setFactory(factory);
		//this.setId(SequenceManager.nextID(TestBedGlobals.VIRTUALROUTER));
		this.setPhyID(pm.getId());
		this.setVrCode(vrCode);
		this.setType(type);
		this.setExpID(exp.getId());
		insertIntoDb();
	}
	
	public DbVirtualRouter(int pmid, Experiment exp, boolean type, 
			int vrCode, DbTestBedFactory factory) {
		/*PhyMachine上的VirtualRouter是否超额*/
		/*if (false) {
			return;
		}*/
		this.setFactory(factory);
		//this.setId(SequenceManager.nextID(TestBedGlobals.VIRTUALROUTER));
		this.setPhyID(pmid);
		this.setVrCode(vrCode);
		this.setType(type);
		this.setExpID(exp.getId());
		insertIntoDb();
	}
	
	public DbVirtualRouter(){}
	
	/**
	 * Loads a DbVirtualRouter from the database based on its id.
	 * @param id
	 * @param factory
	 */
	public DbVirtualRouter(int id, DbTestBedFactory factory) throws NotFoundException{
		this.setId(id);
		this.setFactory(factory);
		loadFromDb();
	}
	
	
	public PhyMachine getPM() {
		// TODO Auto-generated method stub
		return this.factory.getPM(this.phyID);
	}

	
	public Experiment getExperiment() {
		// TODO Auto-generated method stub
		return this.factory.getExp(this.expID);
	}

	
	public Port getPort(int portID) {
		// TODO Auto-generated method stub
		if (portsID[portID] == -1)
			return null;
		else
			return this.factory.getPort(portsID[portID]);
	}

	
	public int getPortCount() {
		// TODO Auto-generated method stub
		int count=0;
		for (int  i = 0; i<4; i++){
			if (portsID[i]!=-1)
			{
				count++;
			}
		}
		return count;
	}

	
	public void addPort(Port port, int which) {
		// TODO Auto-generated method stub
		this.portsID[which]=port.getId();
	}

	
	public void deletePort(int which) {
		// TODO Auto-generated method stub
		this.portsID[which]=-1;
	}

	
	public ArrayList<Port> ports() {
		// TODO Auto-generated method stub
		int i ;
		ArrayList<Port> portArrayList = new ArrayList<Port>();
		
		for (i = 0; i<4; i++)
		{
			if (portsID[i]!=-1)
			{
				portArrayList.add(this.factory.getPort(portsID[i]));
			}
			
		}
		return portArrayList;
		
	}

	
	
	public boolean getRunState() {
		// TODO Auto-generated method stub
		return this.isRunState();
	}

	
	public boolean getType() {
		// TODO Auto-generated method stub
		return this.isType();
	}

	
	public void saveRealData() {
		// TODO Auto-generated method stub
		
	}

	/**
	 * Loads RouterTable from the database.
	 */
	private void loadFromDb() throws NotFoundException{
		Session session = factory.getSessionFactory().openSession();
	    Transaction tx = null;
	    DbVirtualRouter vr;
	    try {
	      tx = session.beginTransaction();

	      vr=(DbVirtualRouter)session.get(DbVirtualRouter.class,this.id);
	      tx.commit();

	    }catch (RuntimeException e) {
	      if (tx != null) {
	        tx.rollback();
	      }
	      throw e;
	    } finally {
	      session.close();
	    }
	    if (vr!=null)
	    {
	    	this.setExpID(vr.getExpID());
	    	this.setPhyID(vr.getPhyID());
	    	//portsID
	 		this.setRouteProtocol(vr.getRouteProtocol());
	 		//routerTable
	 		this.setRunState(vr.getRunState());
	 		this.setType(vr.getType());
	 		this.vrCode=vr.getVrCode();
	 	
			ResultFilter filter = ResultFilter.createDefaultPortFilter();
			List<Integer> IDList = getIDBlock(filter);
			for (int i = 0; i < IDList.size(); i++) {
				Port port = factory.getPort(IDList.get(i).intValue());
				portsID[port.getPortCode()] = IDList.get(i).intValue();
			}
			
			filter = ResultFilter.createDefaultRouterItemFilter();
			IDList = getIDBlock(filter);
			for (int i = 0; i < IDList.size(); i++) {
				RouterTableItem rt = factory.getRouterItem(IDList.get(i));
				routerTable.add(rt);
			}
			
	    } else {
	    	throw new NotFoundException("PhyMachine not found");
	    }
	}
	
	/**
	 * Inserts a new VirtualRouter record into the database.
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
	    factory.getCacheManager().virtualRouterCache.cache.add(this.id, this);
	    System.out.println("after insertIntoDb---------");
	}

	/**
	 * Saves VirtualRouter data to the database.
	 */
	private void saveToDb()	{
		Session session = factory.getSessionFactory().openSession();
	    Transaction tx = null;
	    VirtualRouter vr;
	    try {
	    	tx = session.beginTransaction();

	    	vr=(VirtualRouter)session.get(VirtualRouter.class,this.id);
	      
	    	vr.setVrCode(vrCode);
	    	vr.setExpID(expID);
	    	vr.setPhyID(phyID);
	    	vr.setRouteProtocol(routeProtocol);
	    	vr.setRunState(runState);
	    	vr.setType(type);
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

	

	public int getRouterTableCount() {
		// TODO Auto-generated method stub
		return this.routerTable.size();
	}

	
	public void addRouterTableItem(RouterTableItem routerTableItem) {
		// TODO Auto-generated method stub
		this.routerTable.add(routerTableItem);
	}

	
	public void deleteRouterTable() {
		// TODO Auto-generated method stub
		this.routerTable.clear();
	}


	
	public int getSize() {
		// TODO Auto-generated method stub
//		private int id;
//		private int vrCode;
//		private int phyID;
//		private int expID;
//		private String routeProtocol;
//		private boolean type;
//		private boolean runState = false;
//		private DbTestBedFactory factory;
//		private IntList portsID;
//		private IntList routerTable;
		int size = 0;
		
		size += CacheSizes.sizeOfObject();						// overhead of object
		size += CacheSizes.sizeOfInt();							// id
		size += CacheSizes.sizeOfInt();							// vrCode
		size += CacheSizes.sizeOfInt();							// phyID
		size += CacheSizes.sizeOfInt();							// expID
		size += CacheSizes.sizeOfString(routeProtocol);			// routeProtocol
		size += CacheSizes.sizeOfBoolean();						// type
		size += CacheSizes.sizeOfBoolean();						// runState
		size += CacheSizes.sizeOfObject();						// factory
		// portsID
		size += CacheSizes.sizeOfInteger() * 4;			
		// routerTable
		size += CacheSizes.sizeOfInteger() * routerTable.size();
		
		return size;
	}

	public void setPhyID(int phyID) {
		this.phyID = phyID;
	}

	public int getPhyID() {
		return phyID;
	}

	public void setExpID(int expID) {
		this.expID = expID;
	}

	public int getExpID() {
		return expID;
	}

	public void setType(boolean type) {
		this.type = type;
	}

	public boolean isType() {
		return type;
	}

	public void setRunState(boolean runState) {
		this.runState = runState;
	}

	public boolean isRunState() {
		return runState;
	}

	public void setFactory(DbTestBedFactory factory) {
		this.factory = factory;
	}

	public DbTestBedFactory getFactory() {
		return factory;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getId() {
		return id;
	}
	public String getRouteProtocol() {
		return routeProtocol;
	}

	public void setRouteProtocol(String routeProtocol) {
		this.routeProtocol = routeProtocol;
	}


	public void setRouterTable(ArrayList<RouterTableItem> routerTable) {
		this.routerTable = routerTable;
	}

	public ArrayList<RouterTableItem> getRouterTable() {
		return routerTable;
	}
	
	public int getVrCode() {
		return this.vrCode;
		//return vrCode;
	}

	public void setVrCode(int vrCode) {
		this.vrCode = vrCode;
	}

	
	private List<Integer> getIDBlock(ResultFilter filter) {
		Session session = factory.getSessionFactory().openSession(); //创建一个会话
		Transaction tx = null;
		List<Integer> results = new ArrayList<Integer>();
		List<Object> tmpList = null;
		
		try {
			tx = session.beginTransaction(); //开始一个事务
			String hql = getIDListHQL(filter, false);
			System.out.println(hql);
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
	        tmpList = query.list();
	        
	        tx.commit(); //提交事务
	        
		} catch (RuntimeException e) {
			if (tx != null) {
				e.printStackTrace();
				tx.rollback();
			}
	    } finally {
	        session.close();
	        for (Iterator iter = tmpList.iterator(); iter.hasNext();){ 
	        	
	        	Object obj = iter.next();
	        	System.out.println(obj.getClass());
	        	if (obj instanceof Integer) {
	        		results.add((Integer) obj);
	        	} else {
	        		//集合中的元素是2个长度对象的数组(因为select查询了id,time两个属性)  
	        		Object[] objList = (Object[])obj;  
		            //数据组中第一个元素是id,类型是int;第二个元素是time,类型是Date(因为select中是id(int),time(Date)顺序)  
		            results.add((Integer) objList[0]); 
	        	}
	        }
	        
	        System.out.println("results--->" + results);
	        return results;
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
        hql.append(" WHERE vrID=").append(this.id);
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
