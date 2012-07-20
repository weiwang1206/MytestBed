package com.testbed;

import java.util.ArrayList;
import java.util.Iterator;

import com.resultFilter.ResultFilter;
import com.testbed.database.DbVirtualRouter;

public interface User {
	
	/**
	 * All sets will be saved into cache and database.
	 */
	
	/**
	 * Returns the user's id. All ids must be unique in the system.
	 * @return the user's id.
	 */
	public int getId();
	
	/**
	 * Returns the user's name. The name is unique in the system.
	 * @return the user's name.
	 */
	public String getName();
	
	/**
	 * Set the user's new name, the user's name needs to be unique in the system.
	 * @param name 	new name for the user
	 * @return 
	 */
	public void setName(String name);
	
	/**
	 * Returns the user's password.
	 * @return the user's password.
	 */
	public String getPassword();
	
	/**
	 * Set the user's new password.
	 * @param password  user's new password
	 */
	public void setPassword(String password);
	
	
	/**
	 * Returns the user's telephone.
	 * @return the user's telephone.
	 */
	public String getTelephone();
	
	/**
	 * Set the user's new phoneNum.
	 * @param phoneNum  the user's new phoneNum
	 */
	public void setTelephone(String phoneNum);
	
	
	/**
	 * Returns the user's email.
	 * @return the user's email.
	 */
	public String getEmail();
	
	/**
	 * Set the user's new email.
	 * @param phoneNum  the user's new email
	 */
	public void setEmail(String email);
	
	
	/**
	 * Returns the user's province.
	 * @return the user's province.
	 */
	public String getProvince();
	
	/**
	 * Set the user's new province.
	 * @param phoneNum  the user's new province
	 */
	public void setProvince(String province);
	
	
	/**
	 * Returns the user's city.
	 * @return the user's city.
	 */
	public String getCity();
	
	/**
	 * Set the user's new city.
	 * @param phoneNum  the user's new city
	 */
	public void setCity(String city);
	
	/**
	 * Returns the user's level.
	 * @return the user's level
	 */
	public int getUserLevel();
	
	
	/**
	 * Change the user's level.
	 * @param userLevel  user's level
	 */
	public void setUserLevel(int userLevel);
	
	/**
	 * Adds a new Experiment to the User.
	 * @param exp
	 */
	public void addExp(Experiment exp);
	
	/**
	 * Returns the Experiment specified by id.
	 * @param expID
	 * @return the Experiment corresponding to expID.
	 */
	public Experiment getExp(int expID);
	
	
	/**
	 * Returns the Experiment ID specified by expName.
	 * @param expName
	 * @return the Experiment ID corresponding to expName.
	 * 			-1: means this experiment name doesn't exist.
	 */
	public int getExpIDByName(String expName);
	
	
	/**
	 * Release a Experiment of the user.
	 * 
	 * @param exp
	 */
	public void ReleaseExp(Experiment exp);	
	
	
	/**
	 * Returns the total number of the Experiment of the User that 
	 * matches the criteria specified by the ResultFilter.
	 * 
	 * @param filter a ResultFilter object to perform filtering and
     *      sorting with.
	 * @return the total number of the Experiment that 
	 * matches the criteria specified by the ResultFilter.
	 */
	public int getExpCount(ResultFilter filter);
	
	
	/**
	 * Returns the iterator for all the Experiment of the User that 
	 * matches the criteria specified by the ResultFilter.
	 * 
	 * @param filter a ResultFilter object to perform filtering and
     *      sorting with.
	 * @return the iterator for all the Experiment of the User that 
	 * matches the criteria specified by the ResultFilter.
	 */
	public Iterator<Experiment> exps(ResultFilter filter);
	
	/**
	 * Adds a new Operation to the User.
	 * @param oper
	 */
	public void addOper(Operation oper);
	
	/**
	 * Returns the Operation specified by id.
	 * @param operID
	 * @return the Operation corresponding to operID.
	 */
	public Operation getOper(int operID);
	
	
	/**
	 * Deletes a Operation of the user.
	 * 
	 * @param oper
	 */
	public void deleteOper(Operation oper);	
	
	
	/**
	 * Returns the total number of the Operation of the User  that 
	 * matches the criteria specified by the ResultFilter.
	 * 
	 * @param filter a ResultFilter object to perform filtering and
     *      sorting with.
	 * @return the total number of the Operation  that 
	 * matches the criteria specified by the ResultFilter.
	 */
	public int getOperCount(ResultFilter filter);
	
	
	/**
	 * Returns the iterator for all the Operation of the User that 
	 * matches the criteria specified by the ResultFilter.
	 * 
	 * @param filter a ResultFilter object to perform filtering and
     *      sorting with.
	 * @return the iterator for all the Operation of the User that 
	 * matches the criteria specified by the ResultFilter.
	 */
	public Iterator<Operation> opers(ResultFilter filter);
	
	public void saveToDb();
	
}
