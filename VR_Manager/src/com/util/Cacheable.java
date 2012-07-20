package com.util;

/**
 * Interface that defines the necessary behavior for objects added to a Cache.
 * Objects only need to know how big they are (in bytes). That size
 * should be considered to be a best estimate of how much memory the object occupies
 * and may be based on empirical trials or dynamic calculations.
 * 
 * While the accuracy of the size calculation is important, care should be taken to 
 * minimize the computation time so that cache operations are speedy.
 */
public interface Cacheable {

	/**
	 * Returns the approximate size of the object in bytes.
	 * @return the size of the object in bytes.
	 */
	public int getSize();
}
