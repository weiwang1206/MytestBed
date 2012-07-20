package com.testbed;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;

import com.resultFilter.ResultFilter;
import com.testbed.database.DbVirtualRouter;

public interface PhyMachine {
	
	/**
	 * Returns the unique id of the physical machine.
	 * @return physical machine ID
	 */
	public int getId();
	
	/**
	 * Returns the code of the the physical machine.
	 * @return the code of the the physical machine.
	 */
	public String getCode();
	
	/**
	 * Sets the code of the the physical machine.
	 */
	public void setCode(String code);
	
	/**
	 * Returns the IP of the the physical machine.
	 * @return the IP of the the physical machine.
	 */
	public String getIp();

	/**
	 *  Sets the IP of the the physical machine.
	 */
	public void setIp(String ip);
	
	/**
	 * Returns the CPU of the the physical machine.
	 * @return the CPU of the the physical machine.
	 */
	public float getCPU();

	/**
	 *  Sets the CPU of the the physical machine.
	 */
	public void setCPU(float CPU);
	
	
	/**
	 * Returns the Memory of the the physical machine.
	 * @return the Memory of the the physical machine.
	 */
	public float getMemory();

	/**
	 *  Sets the Memory of the the physical machine.
	 */
	public void setMemory(float memory);
	
	/**
	 * Returns the description of the the physical machine.
	 * @return the description of the the physical machine.
	 */
	public String getDescription();
	
	/**
	 * Sets the description of the the physical machine.
	 */
	public void setDescription(String des);
	
	/**
	 * Adds a new VirtualRouter to the PhyMachine.
	 * 
	 * Then it will be added to a Experiment, and written 
	 * into the database.
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
	 * Deletes a VirtualRouter in the PhyMachine.
	 * @param vr
	 */
	public void deleteVR(VirtualRouter vr);	
	
	
	/**
	 * Returns the total number of the VirtualRouter(specified by the router type) 
	 * in the PhyMachine that matches the criteria specified by the ResultFilter.
	 * 
	 * @param filter a ResultFilter object to perform filtering and
     *      sorting with.
	 * @return the total number of the VirtualRouter that matches the
     *      ResultFilter.
	 */
	public int getVRCount(ResultFilter filter);
	
	/**
	 * Returns the iterator for all the VirtualRouters(specified by the router type) 
	 * in the PhyMachine that matches the criteria specified by the ResultFilter.
	 * 
	 * @param filter a ResultFilter object to perform filtering and
     *      sorting with.
	 * @return the iterator for all the VirtualRouters in the PhyMachine that matches the
     *      ResultFilter.
	 */
	public ArrayList<VirtualRouter> vrs(ResultFilter filter);
	
	/**
	 * Returns the memUsage of the PhyMachine.
	 * @return the memUsage of the PhyMachine.
	 */
	public float getMemUsage();
	
	/**
	 * Updates MemUsage and cpuusage
	 */
	public void update(float cpu, float mem, Date time);
	
	
	/**
	 * Returns the CpuUsage of the PhyMachine.
	 * @return the CpuUsage of the PhyMachine.
	 */
	public float getCpuUsage();
	
	
	
	/**
	 * Save RealData (including memUsage and cpuUsage by now)
	 * into file or database or others.
	 */
	public void saveRealData();
	
	/**
	 * Returns the iterator for all the memory usage of the PhyMachine 
	 * that matches the criteria specified by the ResultFilter.
	 * 
	 * @param filter a ResultFilter object to perform filtering and
     *      sorting with.
	 * @return the iterator for all the memory usage of the PhyMachine 
	 * that matches the criteria specified by the ResultFilter.
	 */
	public ArrayList<Float> getMemUsageList(ResultFilter filter);
	
	
	/**
	 * Returns the iterator for all the CPU usage of the PhyMachine 
	 * that matches the criteria specified by the ResultFilter.
	 * 
	 * @param filter a ResultFilter object to perform filtering and
     *      sorting with.
	 * @return the iterator for all the CPU usage of the PhyMachine 
	 * that matches the criteria specified by the ResultFilter.
	 */
	public ArrayList<Float> getCpuUsageList(ResultFilter filter);
	
	/**
	 * Returns the count of all the memory usage of the PhyMachine 
	 * that matches the criteria specified by the ResultFilter.
	 * 
	 * @param filter a ResultFilter object to perform filtering and
     *      sorting with.
	 * @return the count of all the memory usage of the PhyMachine 
	 * that matches the criteria specified by the ResultFilter.
	 */
	public int getMemUsageListCnt(ResultFilter filter);
	
	
	/**
	 * Returns the count of all the CPU usage of the PhyMachine 
	 * that matches the criteria specified by the ResultFilter.
	 * 
	 * @param filter a ResultFilter object to perform filtering and
     *      sorting with.
	 * @return the count of all the CPU usage of the PhyMachine 
	 * that matches the criteria specified by the ResultFilter.
	 */
	public int getCpuUsageListCnt(ResultFilter filter);
	
	public void saveToDb();
	
}
