package com.testbed;

import java.util.Iterator;

import com.resultFilter.ResultFilter;

/**
 * Interface for managing Permissions for users. 
 *
 * This class is only intended for administrative purpose, and
 * should not be used to check the permissions for individual
 * users. For example, to check a particular user has permissions
 * to create ports in a VirtualRouter, the proper code snippet
 * is as follows:
 * 
 * VirtualRouter vr = factory.getVR(vrID);
 * boolean canCreatePort = vr.hasPermission(Permission.CREATEPORT);
 */
public interface PerssionManager {

	/**
	 * Grants a user a particular permission. Only administrators
	 * can assign permissions.
	 * 
	 * @param user the User to grant a permission to.
	 * @param permissionType the type of permission to grant the user.
	 */
	public void addUserPermission(User user, int permissionType);
	
	
	/**
	 * Revokes a particular permission from a user. Only administrators
	 * can assign permissions.
	 * 
	 * @param user the User to revoke a permission from.
	 * @param permissionType the type of permission to revoke.
	 */
	public void removeUserPermission(User user, int permissionType);
	
	
	/**
	 * Returns true if the specified user has a particular permission.
	 * 
	 * @param user the User to check permissions for.
	 * @param permissionType the permission to check.
	 * @return true if the specified user has a particular permission.
	 */
	public boolean userHasPermission(User user, int permissionType);
	
	/**
	 * Returns all the UserID's of users with a particular permission. 
	 * This method is not the normal method for determining if a user
	 * has a certain permission on an object in the system; instead it
	 * is only useful for permission management. For example to check
	 * if a user has the permission to create port in a router, simply
	 * call virtualRouter.hasPermission(Permission.CREATE_PORT).
	 * 
	 * @param filter a ResultFilter object to perform filtering and
     *      sorting with.
	 * @return an Iterator of all the users that 
	 * matches the criteria specified by the ResultFilter.
	 */
	public Iterator usersWithPermission(ResultFilter filter);
	
	
	/**
	 * Returns a count of the users that have a particular permission.
	 * 
	 * @param permissionType the type of permission to list.
	 * @return a count of the users that have a particular permission.
	 */
	public int usersWithPermissionCount(int permissionType);
	
	/**
	 * Returns a permission with a specified userID.
	 * @param userID
	 * @return
	 */
	public Permission getUserPermissions(int userID);
}
