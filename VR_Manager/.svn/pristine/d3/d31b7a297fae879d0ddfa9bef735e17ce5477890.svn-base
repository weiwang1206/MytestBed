package com.testbed;

import com.testbed.database.DbAuthorizationFactory;

/**
 * An abstract class that defines a framework for providing authorization
 * services in TestBed. The static getAuthorization(String ,String) and
 * getAnoymousAuthorization() methods should called directly from
 * applications using TestBed in order to obtain Authorization tokens.
 * 
 * 
 *
 */
public abstract class AuthorizationFactory {
	
	private static String className = 
		"com.testbed.database.DbAuthorizationFactory";
	
	private static AuthorizationFactory factory = null;
	
	private volatile static Object initLock = new Object(); 
	/**
	 * Returns the Authorization token associated with the specified
	 * userName and password. If the userName and password do not
	 * match the record of any user in the system, the method throws
	 * an UnauthorizedException.
	 * 
	 * @param name
	 * @param password
	 * @throws UnauthorizedException if the userName and password
	 * 			don't match any existing user.
	 * @return
	 */
	public static Authorization getAuthorization(String name,
			String password) throws UnauthorizedException {
		loadAuthorizationFactory();
		return factory.createAuthorization(name, password);
	}
	
	/**
	 * Returns the anonymous user Authorization.
	 * @return an anonymous user Authorization token.
	 */
	public static Authorization getAnonymousAuthorization() {
		loadAuthorizationFactory();
		return factory.createAnonymousAuthorization();
	}
	
	
	
	/**
     * Creates Authorization tokens for users. This method is implemented by
     * concrete subclasses of AuthorizationFactory.
     *
     * @param username the username to create an Authorization with.
     * @param password the password to create an Authorization with.
     * @return an Authorization token if the username and password are correct.
     * @throws UnauthorizedException if the username and password do not match
     *      any existing user.
     */
    protected abstract Authorization createAuthorization(String username,
            String password) throws UnauthorizedException;

    /**
     * Creates anonymous Authorization tokens. This method is implemented by
     * concrete subclasses AuthorizationFactory.
     *
     * @return an anonymous Authorization token.
     */
    protected abstract Authorization createAnonymousAuthorization();
    
	
	/**
	 * Loads a concrete AuthorizationFactory that can be used generate
	 * Authorization tokens for authorized users.
	 */
	private static void loadAuthorizationFactory() {
		if (factory == null) {
			synchronized (initLock) {
				if (factory == null) {
					try {
						Class c = Class.forName(className);
						factory = (AuthorizationFactory)c.newInstance();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
	}
}
