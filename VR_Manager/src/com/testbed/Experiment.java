package com.testbed;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;

import com.resultFilter.ResultFilter;
import com.testbed.database.TestBedGlobals.EXP_STATE_VALUE;
import com.testbed.database.DbPort;
import com.testbed.database.DbVirtualRouter;

public interface Experiment {
	
	/**
	 * Returns the ID of the Experiment.
	 * @return the ID of the Experiment.
	 */
	public int getId();
	
	/**
	 * Sets experiment's name.
	 * @param expName
	 */
	public void setExpName(String expName);

	/**
	 * Returns experiment's name.
	 * @return experiment's name.
	 */
	public String getExpName();
	
	
	/**
	 * Returns the description of the experiment.
	 * @return
	 */
	public String getDescription();
	
	/**
	 * Sets the description of the experiment.
	 */
	public void setDescription(String description);
	
	/**
	 * Adds a new VirtualRouter to the Experiment.
	 * @param vr
	 */
	public void addVR(VirtualRouter vr);
	
	/**
	 * Returns the VirtualRouter specified by id.
	 * @param vrID
	 * @return the VirtualRouter corresponding to vrID.
	 */
	public VirtualRouter getVR(int vrID);
	
	
	/**
	 * Deletes a VirtualRouter in the experiment. Deleting a VirtualRouter also 
	 * deletes all of its data.
	 * 
	 * Then it will be deleted by the PhyMachine.
	 * @param vr
	 */
	public void deleteVR(VirtualRouter vr);	
	
	
	/**
	 * Returns the total number of the VirtualRouter(specified by the router type) 
	 * in the experiment that matches the criteria specified by the ResultFilter.
	 * 
	 * @param filter a ResultFilter object to perform filtering and
     *      sorting with.
	 * @return the total number of the VirtualRouter that matches the
     *      ResultFilter.
	 */
	public int getVRCount(ResultFilter filter);
	
	

	
	/**
	 * Returns the iterator for all the VirtualRouters(specified by the router type) 
	 * in the Experiment that matches the criteria specified by the ResultFilter.
	 * 
	 * @param filter a ResultFilter object to perform filtering and
     *      sorting with.
	 * @return the iterator for all the VirtualRouters in the Experiment that matches the
     *      ResultFilter.
	 */
	public ArrayList<VirtualRouter> vrs(ResultFilter filter);

	
	/**
	 * Returns the topological file of the configuration or application.
	 * @return
	 */
	public String getTopoXML();

	/**
	 * Returns the current state of the experiment.
	 * Enums the state: applying, reject, offer, release. 
	 * @return the state of the experiment.
	 */
	public int getExpState();
	
	/**
	 * Sets experiment's state.
	 * @param state
	 */
	public void setExpState(int state);
	
	
	/**
	 * Check if the experiment is started.
	 * @return
	 */
	public boolean isStart();
	
	/**
	 * Starts the experiment, so the VirtualRouters start to work.
	 */
	public void start();
	
	/**
	 * Stops the experiment, so the VirtualRouters stop working.
	 */
	public void stop();
	
	/**
	 * Returns the experiment's apply time.
	 * @return apply time
	 */
	public Date getExpApplyTime();
	
	
	/**
	 * Returns the Dead Line of the experiment.
	 * @return the Dead Line of the experiment.
	 */
	public Date getExpDeadLine();
	
	
	public ArrayList<Integer> getHVRsID();

	
	public Map<Integer, Integer> getCode2ID();
	
	public ArrayList<Integer> getHighCodeID();

	
	public ArrayList<Integer> getLVRsID();

	/**
	 * Returns the owner of the experiment.
	 */
	public User getUser();
	
	public void saveToDb();

}
