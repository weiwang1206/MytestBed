package com.testbed;

import java.util.ArrayList;
import java.util.Iterator;

import com.testbed.database.DbPort;

public interface VirtualRouter {
	
	/**
	 * Returns the ID of the VirtualRouter, the ID is unique in the whole VR system.
	 * @return the ID of the VirtualRouter.
	 */
	public int getId();
	
	/**
	 * Returns the parent PhysicalMachine of the VirtualRouter.
	 * @return the parent PhysicalMachine of the VirtualRouter.
	 */
	public PhyMachine getPM();
	
	public int getPhyID();
	/**
	 * Returns the parent Experiment of the VirtualRouter.
	 * @return the parent Experiment of the VirtualRouter.
	 */
	public Experiment getExperiment();
	
	
	/**
	 * Returns a port from the VirtualRouter based on its id.
	 * @param portID the ID of the port to get from the virtual router
	 * @return port
	 */
	public Port getPort(int portID);
	
	
	/**
	 * Returns the number of the ports in the virtual router.
	 * @return 
	 */
	public int getPortCount();
	
	
	/**
	 * Adds a new port to the port.
	 * @param port add this port into this virtual router.
	 */
	public void addPort(Port port, int which);
	
	
	/**
	 * Deletes a port in the virtual router. Deleting a port also deletes all of its
	 * data.
	 * @param port
	 */
	public void deletePort(int which);
	
	/**
	 * Returns an iterator for all the ports of the virtual router.
	 * @return an iterator for all the ports of the virtual router.
	 */
	public ArrayList<Port> ports();
	
	
	/**
	 * Returns a routerTableItemID from the VirtualRouter based on its id.
	 * @param routerTableItemID  the ID of the RouterTableItem to get from the virtual router
	 * @return RouterTableItem
	 */
	public ArrayList<RouterTableItem> getRouterTable();
	
	
	/**
	 * Returns the number of the RouterTableItems in the virtual router.
	 * @return 
	 */
	public int getRouterTableCount();
	
	
	/**
	 * Adds a new routerTableItem to the virtual router.
	 * @param routerTableItem add this routerTableItem into this virtual router.
	 */
	public void addRouterTableItem(RouterTableItem routerTableItem);
	
	
	/**
	 * Deletes a routerTableItem in the virtual router.
	 * @param routerTableItem
	 */
	public void deleteRouterTable();
	
	/**
	 * Returns an iterator for all the routerTableItems of the virtual router.
	 * @return an iterator for all the routerTableItem of the virtual router.
	 */
	
	
	
	/**
	 * Returns the protocol of the router.
	 * @return protocol.
	 */
	public String getRouteProtocol();

	
	/**
	 * Returns the current state of the virtual router.
	 * @return true: existing | false: released. 
	 */
	public boolean getRunState();
	
	
	/**
	 * Returns the type of the virtual router.
	 * @return true: High Priority | false: Low Priority.
	 */
	public boolean getType();
	
	
	/**
	 * save real data(routerTable) into database.
	 */
	public void saveRealData();
	
	/**
	 * Returns the Code of the virtual router.
	 * @return for example: 0 or 1 or 2 or 3
	 */
	public int getVrCode();

	/**
	 * Sets the code of the VirtualRouter
	 * @param vrCode
	 */
	public void setVrCode(int vrCode);
	
	
	public void setId(int id);
	
	public void setExpID(int expID);
	
	
	public void setPhyID(int phyID);
	
	public void setRouteProtocol(String routeProtocol);
	
	public void setRunState(boolean runState);
	
	public void setType(boolean type);
}