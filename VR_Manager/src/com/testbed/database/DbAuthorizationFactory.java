package com.testbed.database;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import com.testbed.Authorization;
import com.testbed.AuthorizationFactory;
import com.testbed.UnauthorizedException;

public class DbAuthorizationFactory extends AuthorizationFactory{

	
	private static AuthorizationFactory factory = null;
	
	private static final String GET_USER_ID =
        "SELECT ID FROM USERINFO WHERE USERNAME=? AND PASSWORD=?";
    
    private static SessionFactory sessionFactory;
    
    /** 初始化Hibernate，创建SessionFactory实例 */
	  static{
	    try{
	      // 根据默认位置的Hibernate配置文件的配置信息，创建一个Configuration实例
	      Configuration config = new Configuration().configure();
	      //加载DbExperiment类的对象-关系映射文件


	      // 创建SessionFactory实例 */
	      sessionFactory = config.buildSessionFactory();
	    }catch(RuntimeException e){e.printStackTrace();throw e;}
	  }
	  
	  
	
	/**
	 * The same token can be used for all anonymous users.
	 */
	public static final Authorization anonymousAuth = new DbAuthorization(-1);

	@Override
	protected Authorization createAuthorization(String username, String password)
			throws UnauthorizedException {
		// TODO Auto-generated method stub
		int userID = -1;
		if (username == null || password == null) {
			throw new UnauthorizedException();
		}
		
		Session session = sessionFactory.openSession(); //创建一个会话
		Transaction tx = null;
        try {
        	tx = session.beginTransaction(); //开始一个事务
			Query query= session.createSQLQuery(GET_USER_ID)
			.setParameter(0, username)
			.setParameter(1, password);
			userID = (Integer) query.list().get(0); 
			System.out.println("userID-------------->" + userID);
	        tx.commit(); //提交事务
        }
        catch( Exception sqle ) {
            sqle.printStackTrace();
            if (tx != null) {
				tx.rollback();
			}
            System.out.println("this user doesn't exist!!!!!!!!");
            throw new UnauthorizedException();
        }
        finally {
        	session.close();
        }
		
		return new DbAuthorization(userID);
	}

	@Override
	protected Authorization createAnonymousAuthorization() {
		// TODO Auto-generated method stub
		return anonymousAuth;
	}
	
	

}
