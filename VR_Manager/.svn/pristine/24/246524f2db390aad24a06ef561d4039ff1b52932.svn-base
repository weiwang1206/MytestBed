package com.testbed.database;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import com.resultFilter.ResultFilter;

/**
 * A special table in the database doles out blocks of unique ID's to each
 * virtual machine that interacts with TestBed. This has the following consequence.
 * <ul>
 * 	<li>There is no need to go to the database with the same database every time we 
 * 		want a new unique id.
 * </ul>
 */
public class SequenceManager {

	private static final String LOAD_ID =
        "SELECT id FROM TestBedID WHERE idType=?";
    private static final String UPDATE_ID =
        "UPDATE TestBedID SET id=? WHERE idType=? AND id=?";
    
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
	 * The number of ID's to checkout at a time. 15 should provide a good blancd between
	 * speed and efficiency.
	 * Feel free to change this number if you believe you believe your TestBed setup
	 * warrants it.
	 */
	private static final int INCREMENT = 15;
	private static final int ATTEMPTTIME = 5;
	
	//Statically startup a sequence manager for each of the sequence counters. 
	private static SequenceManager[] managers;
	static {
		managers = new SequenceManager[TestBedGlobals.TABLECOUNT - 7];
		for (int i = 0; i < managers.length; i++) {
			managers[i] = new SequenceManager(i);
		}
	}
	
	/**
	 * Returns the next ID of the specified type.
	 * @param type the type of unique ID.
	 * @return the next ID of the specified type.
	 */
	public static int nextID(int type) {
		return managers[type].nextUniqueID();
	}
	
		
	
	private int type;
	private int currentID;
	private int maxID;
	
	/**
	 * Creates a new SequenceManager.
	 * @param type
	 */
	public SequenceManager(int type) {
		this.type = type;
		currentID = 1;
		maxID = 1;
	}
	
	/**
	 * Returns the next available unique ID. Essentially this provides for
	 * the functionality of auto-increment database field.
	 * @return nextUniqueID
	 */
	public synchronized int nextUniqueID() {
		if (! (currentID < maxID)) {
			getNextBlock(ATTEMPTTIME);
		}
		int id = currentID;
		currentID++;
		
		return id;
	}
	
	/**
	 * Performs a lookup to get the next available ID block. The algorithm is as
	 * follows: <ol>
	 * <li> Select currentID from appropriate db row.
	 * <li> Increment id returned from db.
	 * <li> Update db row with new id where id = old_id
	 * <li> If update fails another process checked out the block firsst; go back 
	 * 		to step 1, Otherwise, done. 
	 * </ol>
	 * @param count attempt time
	 */
	
	
	
	
	private void getNextBlock(int count) {
		if (count == 0) {
            System.out.println("Failed at last attempt to obtain an ID, aborting...");
            return;
        }
        boolean success = false;
        Session session = sessionFactory.openSession(); //创建一个会话
		Transaction tx = null;
        try {
        	tx = session.beginTransaction(); //开始一个事务
			Query query= session.createSQLQuery(LOAD_ID)
			.setParameter(0, type);
			int currentID = (Integer) query.list().get(0); 
			
			int newID = currentID + INCREMENT;
			query= session.createSQLQuery(UPDATE_ID)
			.setParameter(0, newID)
			.setParameter(1, type)
			.setParameter(2, currentID);
			success = (query.executeUpdate() == 1);
			if (success) {
				this.currentID = currentID;
                this.maxID = newID;
			}
	        tx.commit(); //提交事务
        }
        catch( Exception sqle ) {
            sqle.printStackTrace();
            if (tx != null) {
				tx.rollback();
			}
        }
        finally {
        	session.close();
        }
        if (!success) {
            try {
                Thread.currentThread().sleep(75);
            } catch (InterruptedException ie) { }
            getNextBlock(count-1);
        }
	}
	
}
