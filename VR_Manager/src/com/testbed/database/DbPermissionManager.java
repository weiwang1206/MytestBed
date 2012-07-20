package com.testbed.database;

import java.util.Iterator;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.resultFilter.ResultFilter;
import com.testbed.Permission;
import com.testbed.PerssionManager;
import com.testbed.User;
import com.util.IntList;

public class DbPermissionManager implements PerssionManager{
	
	private DbTestBedFactory factory;
	
	public DbPermissionManager(DbTestBedFactory factory){
		this.factory = factory;
	}

	public void addUserPermission(User user, int permissionType) {
		// TODO Auto-generated method stub
		if (!userHasPermission(user, permissionType)) {
			addUserPermission(user.getId(), permissionType);
		}
	}

	public void removeUserPermission(User user, int permissionType) {
		// TODO Auto-generated method stub
		removeUserPermission(user.getId(), permissionType);
	}

	public boolean userHasPermission(User user, int permissionType) {
		// TODO Auto-generated method stub
		return userHasPermission(user.getId(), permissionType);
	}

	public Iterator usersWithPermission(ResultFilter filter) {
		// TODO Auto-generated method stub
		Object [] IDBlock = getIDBlock(filter);
		
		return new DatabaseObjectIterator(TestBedGlobals.USER, 
				IDBlock, factory.getUserManager());

	}

	public int usersWithPermissionCount(int permissionType) {
		// TODO Auto-generated method stub
		return -1;
	}
	
	public Permission getUserPermissions(int userID) {
		boolean isAnonymous = (userID == -1);
        
        if (isAnonymous) {
        	return Permission.none();
        } else {
        	/**
        	 *  load from database.
        	 *  Now we suppose if <code>userID == 0</code> then 
        	 *  it is the administrator; otherwise it is the experimenter.
        	 */
        	
        	if (userID == 0) {
        		return Permission.administrator();
        	} else {
        		return Permission.experimenter();
        	}
        }

	}
	
	private void addUserPermission(int userID, int permissionType) {
		
	}
	
	private void removeUserPermission(int userID, int permissionType) {
		
	}
	
	private boolean userHasPermission(int userID, int permissionType) {
		return false;
	}

	
	
	private Object [] getIDBlock(ResultFilter filter) {
		Session session = factory.getSessionFactory().openSession(); //创建一个会话
		Transaction tx = null;
		List<Integer> results = null;
		
		try {
			tx = session.beginTransaction(); //开始一个事务
			String hql = getIDListHQL(filter, false);
			Query query=session.createQuery(hql);
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
