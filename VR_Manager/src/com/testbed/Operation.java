package com.testbed;

import java.util.Date;

public interface Operation {
	
	
	/**
	 * Returns the id of the operation.
	 * @return id of the operation.
	 */
	public int getId();
	
	
	/**
	 * Returns the Date of the operation.
	 * @return date
	 */
	public Date getDate();
	
	
	/**
	 * Returns the description of the operation. 
	 * @return the description of the operation.
	 */
	public String getOpeRecord();
	
	/**
	 * Returns the owner of the operation.
	 * @return the owner of the operation.
	 */
	public User getUser();
}
