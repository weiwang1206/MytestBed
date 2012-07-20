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
import com.testbed.Operation;
import com.testbed.Port;
import com.testbed.RouterTableItem;
import com.testbed.User;
import com.util.CacheSizes;
import com.util.Cacheable;

public class DbUser implements User, Cacheable{

	private int id;
	private String name;
	private String password;
	private String telephone;
	private String email;
	private String province;
	private String city;
	private int userLevel;
	private ArrayList<Integer> expsID = new ArrayList<Integer>();
	private ArrayList<Integer> opersID = new ArrayList<Integer>();
	
	private DbTestBedFactory factory;
	
	/**
	 * Creates a new DbUser with all required fields.
	 * @param userName
	 * @param password
	 * @param email
	 * @param factory
	 */
	public DbUser(String userName, String password, String email, 
			DbTestBedFactory factory) {
		this.name = userName;
		this.password = password;
		this.email = email;
		this.factory = factory;
		insertIntoDb();
	}
	
	/**
	 * Creates a new DbUser with all required AND optional fields.
	 * @param userName
	 * @param password
	 * @param email
	 * @param telephone
	 * @param province
	 * @param city
	 * @param factory
	 */
	public DbUser(String userName, String password, String email, 
			String telephone, String province, String city,
			DbTestBedFactory factory) {
		this.id = SequenceManager.nextID(TestBedGlobals.USER);
		this.name = userName;
		this.password = password;
		this.email = email;
		this.telephone = telephone;
		this.province = province;
		this.city = city;
		this.factory = factory;
		insertIntoDb();
	}
	
	/**
	 * Loads a DbUser object specified by userID.
	 * @param userID
	 * @param factory
	 */
	public DbUser(int userID, DbTestBedFactory factory) throws NotFoundException{
		this.id = userID;
		this.factory = factory;
		// test
		
		loadFromDb();
	}
	public DbUser(){
		this.id = 0;
	}
	
	public int getId() {
		// TODO Auto-generated method stub
		return id;
	}

	
	public String getName() {
		// TODO Auto-generated method stub
		return name;
	}

	public void setName(String name) {
		// TODO Auto-generated method stub
		this.name = name;
		// I think the corresponding cache value have already been updated.
	}

	
	public String getPassword() {
		// TODO Auto-generated method stub
		return password;
	}

	
	public void setPassword(String password) {
		// TODO Auto-generated method stub
		this.password = password;
		// I think the corresponding cache value have already been updated.
	}

	
	public String getTelephone() {
		// TODO Auto-generated method stub
		return telephone;
	}

	
	public void setTelephone(String phoneNum) {
		// TODO Auto-generated method stub
		this.telephone = phoneNum;
		// I think the corresponding cache value have already been updated.
	}

	
	public String getEmail() {
		// TODO Auto-generated method stub
		return email;
	}

	
	public void setEmail(String email) {
		// TODO Auto-generated method stub
		this.email = email;
		// I think the corresponding cache value have already been updated.
	}

	
	public String getProvince() {
		// TODO Auto-generated method stub
		return province;
	}

	
	public void setProvince(String province) {
		// TODO Auto-generated method stub
		this.province = province;
		// I think the corresponding cache value have already been updated.
	}

	
	public String getCity() {
		// TODO Auto-generated method stub
		return city;
	}

	
	public void setCity(String city) {
		// TODO Auto-generated method stub
		this.city = city;
		// I think the corresponding cache value have already been updated.
	}

	
	public int getUserLevel() {
		// TODO Auto-generated method stub
		return userLevel;
	}

	
	public void setUserLevel(int userLevel) {
		// TODO Auto-generated method stub
		this.userLevel = userLevel;
		// I think the corresponding cache value have already been updated.
	}
	
	/**
	 * Loads user from the database.
	 */
	private void loadFromDb() throws NotFoundException{
		Session session = factory.getSessionFactory().openSession();
	    Transaction tx = null;
	    User user;
	    try {
	      tx = session.beginTransaction();

	      user=(User)session.get(DbUser.class,this.id);
	      tx.commit();

	    }catch (RuntimeException e) {
	    	System.out.println("DbUser loadFromDb catch");
	      if (tx != null) {
	    	  e.printStackTrace();
	        tx.rollback();
	      }
	      throw e;
	    } finally {
	      session.close();
	    }
	    if (user!=null)
	    {
	    	this.setCity(user.getCity());
	    	this.setEmail(user.getEmail());
	    	this.setName(user.getName());
	 		this.setPassword(user.getPassword());
	 		this.setProvince(user.getProvince());
	 		this.setTelephone(user.getTelephone());
	 		this.setUserLevel(user.getUserLevel());
	 		
	 		
	 		/** 
			 * 设置Filter，取得高优先级的路由器ID List.
			 */
			ResultFilter filter = ResultFilter.createDefaultExpFilter();
			expsID = (ArrayList<Integer>) getIDBlock(filter);
			
			filter = ResultFilter.createDefaultOptHistoryDataFilter();
			filter.setSortField(TestBedGlobals.CREATION_DATE);
			opersID = (ArrayList<Integer>) getIDBlock(filter);
	    } else {
	    	throw new NotFoundException("User not found");
	    }
	}
	
	/**
	 * Inserts a new user record into the database.
	 */
	private void insertIntoDb()	{
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
	}
	
	/**
	 * Saves user data to the database.
	 */
	public void saveToDb()	{
		Session session = factory.getSessionFactory().openSession();
	    Transaction tx = null;
	    User user;
	    try {
	    	tx = session.beginTransaction();

	    	user=(User)session.get(DbUser.class,this.id);
	      
	    	user.setCity(this.getCity());
	    	user.setEmail(this.getEmail());
	    	user.setName(this.getName());
	    	user.setPassword(this.getPassword());
	    	user.setProvince(this.getProvince());
	    	user.setTelephone(this.getTelephone());
	    	user.setUserLevel(this.getUserLevel());
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
		
		size += CacheSizes.sizeOfObject();				// overhead of object
		size += CacheSizes.sizeOfString(city);			// city
		size += CacheSizes.sizeOfString(email);			// email
		size += CacheSizes.sizeOfInt();					// id
		size += CacheSizes.sizeOfString(password);		// password
		size += CacheSizes.sizeOfString(province);		// province
		size += CacheSizes.sizeOfString(telephone);		// telephone
		size += CacheSizes.sizeOfInt();					// userLevel
		size += CacheSizes.sizeOfString(name);		// userName
		// expsID
		size += CacheSizes.sizeOfInteger() * expsID.size();		
		// opersID
		size += CacheSizes.sizeOfInteger() * opersID.size();		
		
		return size;
	}


	/**
	 * Adds expID into expsID.
	 */
	public void addExp(Experiment exp) {
		// TODO Auto-generated method stub
		expsID.add(exp.getId());
	}


	public Experiment getExp(int expID) {
		// TODO Auto-generated method stub
		return factory.getExp(expID);
	}


	/**
	 * 
	 */
	public void ReleaseExp(Experiment exp) {
		// TODO Auto-generated method stub
		
	}


	public int getExpCount(ResultFilter filter) {
		// TODO Auto-generated method stub
		return expsID.size();
	}


	public Iterator<Experiment> exps(ResultFilter filter) {
		// TODO Auto-generated method stub
		List<Integer> IDBlock = getIDBlock(filter);
        return new DatabaseObjectIterator(TestBedGlobals.EXPERIMENT, 
        		IDBlock.toArray(), this);
	}


	/**
	 * Adds operID into opersID.
	 */
	public void addOper(Operation oper) {
		// TODO Auto-generated method stub
		opersID.add(oper.getId());
	}


	public Operation getOper(int operID) {
		// TODO Auto-generated method stub
		return factory.getOperatoin(operID);
	}


	public void deleteOper(Operation oper) {
		// TODO Auto-generated method stub
		int index;
		if ((index = opersID.indexOf(oper.getId())) == -1) {
			System.out.println("This user doesn't own this operation");
			return;
		}
		
		Session session = factory.getSessionFactory().openSession();
	    Transaction tx = null;
	    try {
	      tx = session.beginTransaction();
	      session.delete(oper);
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
	    
		
		opersID.remove(index);
		
		// delete oper from database
		
		factory.getCacheManager().operationCache.remove(oper.getId());
	}


	public int getOperCount(ResultFilter filter) {
		// TODO Auto-generated method stub
		return opersID.size();
	}


	public Iterator<Operation> opers(ResultFilter filter) {
		// TODO Auto-generated method stub
		List<Integer> IDBlock = getIDBlock(filter);
        return new DatabaseObjectIterator(TestBedGlobals.OPERATION, 
        		IDBlock.toArray(), this);
	}

	public int getExpIDByName(String expName) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	
	private List<Integer> getIDBlock(ResultFilter filter) {
		Session session = factory.getSessionFactory().openSession(); //创建一个会话
		Transaction tx = null;
		List<Integer> results = new ArrayList<Integer>();
		List<Object> tmpList = new ArrayList<Object>();
		
		try {
			tx = session.beginTransaction(); //开始一个事务
			String hql = getIDListHQL(filter, false);
			Query query=session.createSQLQuery(hql);
			System.out.println("user.exps()  sql------->" + hql);
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
				tx.rollback();
			}
	    } finally {
	        session.close();
	        for (Iterator iter = tmpList.iterator(); iter.hasNext();){  
	        	Object obj = iter.next();
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
                	if (resultFilter.getDatabase().equals("operationhistory"))
                		hql.append(", date");
                	else
                		hql.append(", expApplyTime");
                	break;
            }
        }
        
        // FROM -- values
        hql.append(" FROM ").append(resultFilter.getDatabase());
        
        // WHERE BLOCK
        hql.append(" WHERE userID=").append(this.id);
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
	            	if (resultFilter.getDatabase().equals("operationhistory"))
                		hql.append("date");
                	else
                		hql.append("expApplyTime");
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

	public void setId(int id) {
		this.id = id;
	}
	
	

	
}
