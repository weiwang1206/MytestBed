package com.testbed;

import java.lang.reflect.Proxy;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;

import org.hibernate.SessionFactory;

import com.resultFilter.ResultFilter;
import com.testbed.cache.DatabaseCacheManager;
import com.testbed.database.DbExperiment;
import com.testbed.database.DbPhyMachine;

/*
 * 管理TestBed，提供TestBed的接口。是整个TestBed系统的入口。
 * 通常与TestBed交互的步骤为：
 * 1.通过AuthorizationFactory.getInstance().getAuthorization(username, password)获取用户认证authorizaiton。
 * 2.以authorizaiton为参数，获取TestBedFactory对象。
 * 3.利用TestBed factory来与TestBed交互。
 * 
 * 
 * 
 * When an object is created, it will be insert into database immediately.
 * Then it will be added to it's owner. 
 */

public interface TestBedFactory {
	
	/**
	 * Returns the topology xml of the testBed.
	 * @return
	 */
	public TestBedTopologyXML getTopologyXML();
	
	
	/**
	 * Creates a new forum. This method always be used instead of trying to instantiate
	 * a experiment directly. 
	 * Saves the experiment to Database.
	 * @param name  experiment's name must be unique in a scope of a user.
	 * @param description description of a experiment.
	 * @return Experiment
	 */
	public Experiment createExperiment(User user, String expName,
			String description, String topo,
			int vrH, int vrL, 
			ArrayList<Integer> HCID,ArrayList<Integer> LCID,
			String config);
	
	
	/**
	 * Creates a new Physical Machine.
	 * Saves the physical Machine to Database.
	 * @param ip IP of the Physical Machine.
	 * @param description description of the Physical Machine
	 * @param code code of the Physical Machine
	 * @return Physical Machine
	 */
	public PhyMachine createPM(int id, String ip, String description, String code);
	
	
	/**
	 * Creates a new Virtual Router.
	 * Then the VR must be added to Physical Machine and Experiment.
	 * @param pm
	 * @param exp
	 * @param type true: High Priority | false: Low Priority.
	 * @param vrCode
	 * @return Virtual Router
	 */
	public VirtualRouter createVR(PhyMachine pm, Experiment exp, int vrCode, boolean type);
	
	public VirtualRouter createVR(int pmid, Experiment exp, int vrCode,
			boolean type);
	/**
	 * Creates a new Port.
	 * Then it must be added to a virtual router.
	 * 
	 * @param vr
	 * @param code
	 * @param ip
	 * @param ospf
	 * @return Port
	 */
	public Port createProt(VirtualRouter vr, int code, String ip, String ospf);
	
	
	/**
	 * Creates a new routerItem.
	 * Then the routerItem must be added to port.
	 * @param code
	 * @param desIP
	 * @param nextHop
	 * @param portInterface
	 * @return routerItem
	 */
	public RouterTableItem createRouterItem(String code, String desIP, String nextHop,
			String portInterface);
	
	/**
	 * Creates a new operation.
	 * @param user
	 * @param date
	 * @param opeRecord
	 * @param expID
	 * @return
	 */
	public Operation createOperation(User user, Date date, String opeRecord, int expID);
	
	
	/**
	 * Returns the Experiment with the specified expID. 
	 * @param expID
	 * @return the Experiment with the specified expID.
	 */
	public Experiment getExp(int expID);
	
	
	
	/**
	 * Deletes an experiment and all of its content. 
	 * @param exp the experiment to delete.
	 */
	public void deleteExp(Experiment exp); 
	
	
	/**
     * Returns a Iterator for all the experiments in the TestBed that matches 
     * the criteria specified by the ResultFilter.
     *
     * @param filter a ResultFilter object to perform filtering and
     *      sorting with.
     * @return an Iterator for the experiments in the TestBed that matches the
     *      ResultFilter.
     */
	public Iterator exps(ResultFilter filter);
	
	
	/**
     * Returns the count of all the experiments in the TestBed that matches 
     * the criteria specified by the ResultFilter.
     *
     * @param filter a ResultFilter object to perform filtering and
     *      sorting with.
     * @return the count of all the experiments in the TestBed that matches the
     *      ResultFilter.
     */
	public int getExpCnt(ResultFilter filter);
	
	
	
	/**
	 * Returns the PhyMachine with the specified pmID.
	 * @param pmID
	 * @return the PhyMachine with the specified pmID
	 */
	public PhyMachine getPM(int pmID);
	
	/**
	 * Returns the VirtualRouter with the specified vid.
	 * @param vid
	 * @return
	 */
	public VirtualRouter getVR(int vid);
	
	/**
     * Returns the count of all the VirtualRouter in the TestBed that matches 
     * the criteria specified by the ResultFilter.
     *
     * @param filter a ResultFilter object to perform filtering and
     *      sorting with.
     * @return the count of all the VirtualRouter in the TestBed that matches the
     *      ResultFilter.
     */
	public int getVrCnt(ResultFilter filter);
	
	
	/**
     * Returns a Iterator for all the VirtualRouter in the TestBed that matches 
     * the criteria specified by the ResultFilter.
     *
     * @param filter a ResultFilter object to perform filtering and
     *      sorting with.
     * @return an Iterator for the VirtualRouter in the TestBed that matches the
     *      ResultFilter.
     */
	public Iterator vrs(ResultFilter filter);
	
	/**
	 * Deletes a physical machine and all of its content.
	 * @param pm the PhyMachine to delete.
	 */
	public void deletePM(PhyMachine pm);
	
	
	/**
     * Returns a Iterator for all the physicalMachine in the TestBed that 
     * matches the criteria specified by the ResultFilter.
     *
     * @param filter a ResultFilter object to perform filtering and
     *      sorting with.
     * @return an Iterator for the physicalMachine in the TestBed that matches 
     * the ResultFilter.
     */
	public Iterator pms(ResultFilter filter);
	
	
	/**
     * Returns a list for all the physicalMachine ID in the TestBed that 
     * matches the criteria specified by the ResultFilter.
     *
     * @param filter a ResultFilter object to perform filtering and
     *      sorting with.
     * @return an Iterator for the physicalMachine ID in the TestBed that matches 
     * the ResultFilter.
     */
	public ArrayList<Integer> pmIDs(ResultFilter filter);

	
	/**
     * Returns the count of all the PhyMachine in the TestBed that matches 
     * the criteria specified by the ResultFilter.
     *
     * @param filter a ResultFilter object to perform filtering and
     *      sorting with.
     * @return the count of all the PhyMachine in the TestBed that matches the
     *      ResultFilter.
     */
	public int getPmCnt(ResultFilter filter);
	
	
	/**
	 * Returns a UserManager that can be used to manage uses.
	 * @return
	 */
	public UserManager getUserManager();
	
	
	/**
	 * Returns a CacheManager that can be used to manage cache.
	 * @return
	 */
	public DatabaseCacheManager getCacheManager();
	
	/**
	 * Returns a permission specified by an authorization.
	 * @return
	 */
	public Permission getPermission(Authorization authorization);
	
	/**
	 * Returns a SessionFactory which can create session in hibernate.
	 * @return
	 */
	public SessionFactory getSessionFactory();
	
}