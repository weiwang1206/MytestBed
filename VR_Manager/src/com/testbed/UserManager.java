package com.testbed;

import java.util.Iterator;

import com.resultFilter.ResultFilter;

public interface UserManager {
	
	/**
	 * Factory method for creating a new User with all required values:
	 * password, email address and a unique name.
	 * 
	 * @param userName
	 * @param password
	 * @param email
	 * @return a user	null if failed
	 */
	public User createUser(String userName, String password, String email);
	
	
	/**
	 * Factory method for creating a new user with all required AND optional
	 * values.
	 * 
	 * @param userName
	 * @param password
	 * @param email
	 * @param provice
	 * @param city
	 * @return a user	null if failed
	 */
	public User createUser(String userName, String password, String email,
			String telephone, String provice, String city);
	
	/**
	 * Returns a user specified by a userID.
	 * @param userID
	 * @return a user specified by a userID 
	 */
	public User getUser(int userID);
	
	
	/**
	 * Get userID by userName.
	 * @param userName
	 * @return userID
	 * 			-1: means this userName doesn't exist.
	 */
	public int getUserIDByName(String userName);
	
	
	/**
	 * Delete a user. To maintain the data consistency, deleting a user will
	 * cause all experiments and operationHistories to be deleted.
	 * @param user  the user to delete.
	 */
	public void deleteUser(User user);
	
	
	/**
	 * Returns the number of users in the system that 
	 * matches the criteria specified by the ResultFilter.
	 * 
	 * @param filter a ResultFilter object to perform filtering and
     *      sorting with.
	 * @return the total numbers of users that 
	 * matches the criteria specified by the ResultFilter.
	 */
	public int getUserCount(ResultFilter filter);
	
	
	/**
	 * Returns an iterators for all users in the system that 
	 * matches the criteria specified by the ResultFilter.
	 * 
	 * @param filter a ResultFilter object to perform filtering and
     *      sorting with.
	 * @return an iterator for all users that 
	 * matches the criteria specified by the ResultFilter.
	 */
	public Iterator users(ResultFilter filter);
	

	
	
	
	
	
	
	

}
