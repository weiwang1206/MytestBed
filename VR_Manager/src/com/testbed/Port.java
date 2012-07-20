package com.testbed;

import java.util.ArrayList;
import java.util.Date;

import com.resultFilter.ResultFilter;


public interface Port {
	
	/**
	 * Returns the ID of the Port. The ID is unique in the whole port system.
	 * @return
	 */
	public int getId();
	
	
	/**
	 * Returns the VirtualRouter the port belongs to.
	 * @return VirtualRouter
	 */
	public VirtualRouter getVR();
	
	public int getVrID();
	
	/**
	 * Returns the IP of the port.
	 * @return the IP of the port.
	 */
	public String getIp();
	
	/**
	 * Sets the IP of the port.
	 * @param ip
	 */
	public void setIp(String ip);
	
	/**
	 * Returns the OSPF detail information.
	 * @return the OSPF detail information.
	 */
	public String getOspf();
	
	/**
	 * Set the OSPF information.
	 */
	public void setOspf(String ospf);
	
	/**
	 * Returns the real flow data.
	 * @return real flow data
	 */
	public float getFlow();
	
	/**
	 * Updates the arrayLIst for the net flow. 
	 * Pushes the flow in front of the list, and pops the oldest node. 
	 */
	public void updateFlow(float flow, Date time);
	
	
	/**
	 * Save RealData (including flow by now) into file or database or others.
	 */
	public void saveRealData();
	
	/**
	 * Returns the code of the port
	 * @return the code of the port (for example: 0, 1, 2 or 3)
	 */
	public int getPortCode();

	/**
	 * Sets the code of the port.
	 * @param portCode for example: 0, 1, 2 or 3
	 */
	public void setPortCode(int portCode);
	
	
	/**
	 * Returns the iterator for all the flow of the port 
	 * that matches the criteria specified by the ResultFilter.
	 * 
	 * @param filter a ResultFilter object to perform filtering and
     *      sorting with.
	 * @return the iterator for all the flow of the port 
	 * that matches the criteria specified by the ResultFilter.
	 */
	public ArrayList<Float> getFLowList(ResultFilter filter);
	
	/**
	 * Returns the count of all the flow of the port 
	 * that matches the criteria specified by the ResultFilter.
	 * 
	 * @param filter a ResultFilter object to perform filtering and
     *      sorting with.
	 * @return the count of all the flow of the port 
	 * that matches the criteria specified by the ResultFilter.
	 */
	public int getFLowListCnt(ResultFilter filter);
	
	public void saveToDb();
}
