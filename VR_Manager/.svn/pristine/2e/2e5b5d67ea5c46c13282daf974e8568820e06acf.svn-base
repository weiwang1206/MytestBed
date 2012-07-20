package com.testbed;

/**
 * Proves that a user has successfully logged in. The existence of an
 * Authorization object indicates that a person has logged in correctly
 * and has authentication to act as the user associated with the 
 * authorization. An instance of this object can be obtained from an
 * AuthorizationFactory and must be passed into to get an instance of
 * TestBedFactory.
 * 
 * In the case of using the core TestBed services through a web interface,
 * the expected behavior is to have a user login and then store the
 * Authorization object in their session. In some app servers, all objects
 * put in the session must be serializable.
 *
 */
public interface Authorization {

	/**
	 * Returns the userID associated with this Authorization.
	 * @return the userID associated with this Authorization.
	 */
	public int getUserID();
	
	
	/**
	 * Returns true if this Authorization is the Anonymous 
	 * authorization token
	 * 
	 * 
	 * @return
	 */
	public boolean isAnonymous();	
}
