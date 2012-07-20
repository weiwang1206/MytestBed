package com.testbed.database;

import com.testbed.Authorization;

public class DbAuthorization implements Authorization {
	
	private int userID;
	/**
	 * Constructs a new DbAuthorization with the specified userID.
	 * 
	 * @param userID the userID to create an authorization token with.
	 */
	public DbAuthorization(int userID) {
		this.userID = userID;
	}

	
	public int getUserID() {
		// TODO Auto-generated method stub
		return userID;
	}

	
	public boolean isAnonymous() {
		// TODO Auto-generated method stub
		return userID == -1;
	}
}