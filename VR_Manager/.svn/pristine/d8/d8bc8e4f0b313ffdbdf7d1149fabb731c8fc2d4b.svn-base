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
import com.testbed.User;
import com.testbed.UserManager;
import com.testbed.cache.UserCache;
import com.util.IntList;

public class DbUserManager implements UserManager{
	private DbTestBedFactory factory;
	private UserCache userCache;

	/**
	 * Creates a new UserManager.
	 * @param factory
	 */
	public DbUserManager(DbTestBedFactory factory) {
		this.factory = factory;
		userCache = factory.getCacheManager().userCache;
	}
	
	public User createUser(String userName, String password, String email) {
		// TODO Auto-generated method stub
		int userID = getUserIDByName(userName);
		if (userID != -1) {
			return null;
		}
			
		return new DbUser(userName, password, email, factory);
	}

	
	public User createUser(String userName, String password, String email,
			String telephone, String provice, String city) {
		// TODO Auto-generated method stub
		int userID = getUserIDByName(userName);
		if (userID != -1) {
			return null;
		}
		
		return new DbUser(userName, password, email, 
				telephone, password, city, factory);
	}

	
	public User getUser(int userID) {
		// TODO Auto-generated method stub
		User user;
		try {
			return (User)userCache.get(userID);
		} catch (NotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}

	}

	public int getUserIDByName(String userName) {
		// TODO Auto-generated method stub
		// get from database
		
		Session session = factory.getSessionFactory().openSession(); //创建一个会话
		Transaction tx = null;
		List<Integer> results = new ArrayList<Integer>();
		
		try {
			tx = session.beginTransaction(); //开始一个事务
			String hql = "SELECT ID FROM userinfo WHERE userName = '" + userName + "'";
			System.out.println(hql);
			Query query=session.createSQLQuery(hql);
			
	        results = query.list(); 
	        tx.commit(); //提交事务
	        
		} catch (RuntimeException e) {
			System.out.println("catch");
			if (tx != null) {
				e.printStackTrace();
				tx.rollback();
			}
	    } finally {
	        session.close();
	        if (results.size() == 0)
	        	return -1;
	        else
	        	return results.get(0);
	    }
	}

	
	public void deleteUser(User user) {
	    Session session = factory.getSessionFactory().openSession();
	    Transaction tx = null;
	    try {
	      tx = session.beginTransaction();
	      // 首先删除user的所有的operationHistory
	      ResultFilter filter = ResultFilter.createDefaultOptHistoryDataFilter();
	      Iterator it = user.opers(filter);
	      while (it.hasNext()) {
	    	  Operation oper = (Operation)it.next();
	    	  user.deleteOper(oper);
	      }
	      // 其次删除user的所有的实验
//	      filter = ResultFilter.createDefaultExpFilter();
//	      it = user.exps(filter);
//	      
//	      while (it.hasNext()) {
//	    	  Experiment exp = (Experiment)it.next();
//	    	  // 删除exp
//	      }
	      
	      session.delete(user);
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

	
	public int getUserCount(ResultFilter filter) {
		// TODO Auto-generated method stub
		return getIDCnt(filter);
	}

	
	public Iterator users(ResultFilter filter) {
		// TODO Auto-generated method stub
		Object [] IDBlock = getIDBlock(filter);
		
		return new DatabaseObjectIterator(TestBedGlobals.USER, 
				IDBlock, this);
	}
	
	private Object [] getIDBlock(ResultFilter filter) {
		Session session = factory.getSessionFactory().openSession(); //创建一个会话
		Transaction tx = null;
		List<Integer> results = new ArrayList<Integer>();
		
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
	        results = query.list(); 
	        tx.commit(); //提交事务
	        
		} catch (RuntimeException e) {
			System.out.println("catch");
			if (tx != null) {
				e.printStackTrace();
				tx.rollback();
			}
	    } finally {
	        session.close();
	        System.out.println(results);
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
        hql.append(" WHERE 1=1");
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
	            	hql.append("Code");
	            	break;
	            case TestBedGlobals.CREATION_DATE :
	            	hql.append("time");
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
	
	private int getIDCnt(ResultFilter filter) {
		Session session = factory.getSessionFactory().openSession(); //创建一个会话
		Transaction tx = null;
		int cnt = -1;
		try {
			
			tx = session.beginTransaction(); //开始一个事务
			System.out.println("tx");
			String hql = getIDListHQL(filter, true);
			System.out.println(hql);
			Query query=session.createSQLQuery(hql);
			System.out.println("query");
			String tmp = query.uniqueResult().toString();
			cnt = Integer.parseInt(tmp);
			System.out.println("user cnt----------------------------->" + cnt);
	        tx.commit(); //提交事务
	        
		} catch (RuntimeException e) {
			System.out.println("catch");
			if (tx != null) {
				e.printStackTrace();
				tx.rollback();
			}
	    } finally {
	        session.close();
	        
	        return cnt;
	    }
	}
}
