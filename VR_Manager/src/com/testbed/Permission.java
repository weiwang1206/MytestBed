package com.testbed;

/**
 * Defines a set of permissions for objects in the TestBed system that
 * users can be granted. TestBed permissions are used by the protection
 * proxy objects defined for each major component of the system.  
 *
 */
public class Permission {
	
	/**
	 * Permission count.
	 */
	public static final int PERM_COUNT = 2;
	/**
	 * Permission to experiment with the system.
	 */
	public static final int EXPERIMENTER = 0;
	
	/**
	 * Permission to administer the entire system.
	 */
	public static final int SYSTEM_ADMIN = 1;
	
	
	/**
	 * Holds the actual permission values.
	 */
	private boolean [] values = new boolean[PERM_COUNT];
	
	private static final Permission NO_PERMS = 
		new Permission(false, false);
	private static final Permission EXPERIMENTER_PERMS =
		new Permission(true, false);
	private static final Permission SYSTEM_ADMIN_PERMS =
		new Permission(false, true);
	
	/**
	 * Factory method to create none permission.
	 */
	public static Permission none() {
		return NO_PERMS;
	}
	
	/**
	 * Factory method to create experimenter permission.
	 */
	public static Permission experimenter() {
		return EXPERIMENTER_PERMS;
	}
	
	/**
	 * Factory method to create administrator permission.
	 */
	public static Permission administrator() {
		return SYSTEM_ADMIN_PERMS;
	}
	
	
	/**
	 * Create a new permissions object with the specified permissions.
	 */
	public Permission(boolean experimenter, boolean system_admin) {
		values[EXPERIMENTER] = experimenter;
		values[SYSTEM_ADMIN] = system_admin;
	}
	
	
	/**
     * Creates a new ForumPermission object by combining two permissions
     * objects. The higher permission of each permission type will be used.
     */
    public Permission(Permission perm1,
    		Permission perm2)
    {
        values[0] = perm1.get(0) || perm2.get(0);
        values[1] = perm1.get(1) || perm2.get(1);
    }
    
    
	/**
	 * Returns true if the permission of a particular type is allowed.
	 * @return true if the permission of a particular type is allowed.
	 */
	public boolean get(int type) {
		if (type < 0 || type > PERM_COUNT) {
			return false;
		}
		
		return values[type];
	}
}
