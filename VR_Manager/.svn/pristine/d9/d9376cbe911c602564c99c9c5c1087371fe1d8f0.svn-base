package com.testbed.cache;

import javassist.NotFoundException;

import com.testbed.database.DbTestBedFactory;
import com.testbed.database.DbUser;
import com.util.LongCache;

public class UserCache extends DatabaseCache{

	public UserCache(LongCache cache, DbTestBedFactory factory) {
		super(cache, factory);
		// TODO Auto-generated constructor stub
	}
	
	public DbUser get(long userID) throws NotFoundException {
		DbUser user = (DbUser)cache.get(userID);
		if (user == null) {
			user = new DbUser((int)userID, factory);
			cache.add(userID, user);
		}
		return user;
	}
}
