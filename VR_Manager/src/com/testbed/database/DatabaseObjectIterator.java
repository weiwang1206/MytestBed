package com.testbed.database;

import com.testbed.PhyMachine;
import com.testbed.UserManager;
import com.testbed.User;
import com.testbed.Experiment;
import com.testbed.TestBedFactory;
import com.testbed.Operation;
import com.testbed.VirtualRouter;

import java.util.Iterator;


/**
 * An class that defines the logic to iterate through an array of long unique
 * ID's of TestBed objects.
 * 
 * One feature of the class is the ability to recover from underlying
 * modifications to the database in some cases. Consider the following sequence
 * of events:
 * <ul>
 * 		<li> Time 0: An Iterator for Experiments of the user is obtained.
 * 		<li> Time 1: 3 of the 8 experiments of the user are deleted.
 * 		<li> Time 2: Iteration of experiments begins.
 * </ul>
 * 
 * In the above example, the underlying experiments of the user were changed
 * after the initial iterator was obtained. The logic in this class will
 * attempt to automatically compensate for these changes by skipping over items
 * that cannot be loaded. In the above example, that would translate to the
 * iterator returning 5 messages instead of 8.
 */
public class DatabaseObjectIterator implements Iterator{

	private Object [] elementIDs;
	private int currentIndex = -1;
	private Object nextElement = null;
	
	private DatabaseObjectFactory objectFactory;
	/**
	 * Creates a new DatabaseObjectIterator. The type must be one of the
	 * following: 
	 * <ul>
	 * 		<li> TestBedGlobals.USER
	 * 		<li> TestBedGlobals.EXPERIMENT
	 * 		<li> TestBedGlobals.OPERATION
	 * </ul>
	 * 
	 * Additionally, each type of iterator requires an extra object of a 
	 * certain type to perform iteration. In respective order for each
	 * <code>type</code>, <code>extraObject</code> should be a TestBedFactory,
	 * User, User. If <code>extraObject</code> do not match, iteration 
	 * construction will fail.
	 * 
	 * The implementation of this method takes the type and extraObject
	 * and creates anonymous inner classes to handle loading of each
	 * TestBed object.
	 * 
	 */
	public DatabaseObjectIterator(int type, Object [] elementIDs, 
			final Object extraObject) {
		this.elementIDs = elementIDs;
		
		/**
		 *  Loads the appropriate factory depending on the type of object
		 *  that we are iterating through.
		 */
		switch (type) {
			//USER
			case TestBedGlobals.USER:
				// Creates an objectFactory to load User
				this.objectFactory = new DatabaseObjectFactory() {
					UserManager userManager = (UserManager)extraObject;

					public Object loadObject(int id) {
						// TODO Auto-generated method stub
						User user = userManager.getUser(id); 
						return user;
					}
				};
				break;
				
			// EXPERIMENT
			case TestBedGlobals.EXPERIMENT:
				/**
				 * Creates an objectFactory to load experiments. There are
				 * two possibilities -- the first is that extraObject is
				 * a User that we can directly load experiments from. The
				 * second is that extraObject is a TestBedFactory. The 
				 * latter case can occur when we need to iterate through
				 * a set of experiments that come from multiple different
				 * that come from multiple different users.
				 */
				// Creates an objectFactory to load Experiment
				if (extraObject instanceof User) {
					this.objectFactory = new DatabaseObjectFactory() {
						User user = (User)extraObject;

						public Object loadObject(int id) {
							// TODO Auto-generated method stub
							Experiment experiment = user.getExp(id); 
							return experiment;
						}
					};
				} else {
					this.objectFactory = new DatabaseObjectFactory() {
						TestBedFactory factory = (TestBedFactory)extraObject;
						public Object loadObject(int id) {
							// TODO Auto-generated method stub
							Experiment experiment = factory.getExp(id);
							return experiment;
						}
						
					};
				}
				break;
			// OPERATION
			case TestBedGlobals.OPERATION:
				// Creates an objectFactory to load Experiment
				this.objectFactory = new DatabaseObjectFactory() {
					User user = (User)extraObject;
					public Object loadObject(int id) {
						// TODO Auto-generated method stub
						Operation oper = user.getOper(id);
						return oper;
					}
				};
				break;
			// PhyMachine
			case TestBedGlobals.PHYMACHINE:
				// Creates an objectFactory to load Experiment
				this.objectFactory = new DatabaseObjectFactory() {
					TestBedFactory factory = (TestBedFactory)extraObject;
					public Object loadObject(int id) {
						// TODO Auto-generated method stub
						
						PhyMachine experiment = factory.getPM(id);
						return experiment;
					}
				};
				break;
			// PhyMachine
			case TestBedGlobals.VIRTUALROUTER:
				/**
				 * Creates an objectFactory to load experiments. There are
				 * three possibilities -- the first is that extraObject is
				 * a Experiment that we can load VirtualRouter from. The
				 * second is that extraObject is a TestBedFactory. The 
				 * latter case can occur when we need to iterate through
				 * a set of experiments that come from multiple different
				 * that come from multiple different users. The third is 
				 * that extraObject is a PhyMachine.
				 */
				if (extraObject instanceof Experiment) {
					this.objectFactory = new DatabaseObjectFactory() {
						Experiment experiment = (Experiment)extraObject;

						public Object loadObject(int id) {
							// TODO Auto-generated method stub
							VirtualRouter vr = experiment.getVR(id); 
							return vr;
						}
					};
				} else if (extraObject instanceof TestBedFactory){
					this.objectFactory = new DatabaseObjectFactory() {
						TestBedFactory factory = (TestBedFactory)extraObject;
						
						public Object loadObject(int id) {
							// TODO Auto-generated method stub
							VirtualRouter vr = factory.getVR(id);
							return vr;
						}
						
					};
				} else {
					this.objectFactory = new DatabaseObjectFactory() {
						PhyMachine phyMachine = (PhyMachine)extraObject;

						public Object loadObject(int id) {
							// TODO Auto-generated method stub
							VirtualRouter vr = phyMachine.getVR(id); 
							return vr;
						}
					};
				}
				break;
			default:
				throw new IllegalArgumentException("Illegal type specified");
		}
	}
	
	/**
	 * Returns true if there are more elements in the iteration.
	 * @return true if there are more elements in the iteration.
	 */
	public boolean hasNext() {
		// TODO Auto-generated method stub
		/**
		 *  If we are at the end of the list, there can't be any more
		 *  to iterate through.
		 */
		if (currentIndex + 1 >= elementIDs.length && nextElement == null) {
			return false;
		}
		
		/**
		 * Otherwise, see if nextElement is null. If so, try to load the next
		 * element to make sure it exists.
		 */
		if (nextElement == null) {
			nextElement = getNextElement();
			if (nextElement == null) {
				return false;
			}
		}
		return true;
	}

	public Object next() throws java.util.NoSuchElementException{
		// TODO Auto-generated method stub
		Object element = null;
		if (nextElement != null) {
			element = nextElement;
			nextElement = null;
		} else {
			element = getNextElement();
			if (element == null) {
				throw new java.util.NoSuchElementException();
			}
		}
		return element;
	}

	public void remove() throws UnsupportedOperationException{
		// TODO Auto-generated method stub
		throw new UnsupportedOperationException();
	}
	
	/**
	 * Returns the next available element, or null if there are no more
	 * elements to return.
	 * @return the next available element.
	 */
	private Object getNextElement() {
		while (currentIndex + 1 < elementIDs.length) {
			currentIndex++;
			Object element = objectFactory.loadObject(Integer.parseInt((String.valueOf(elementIDs[currentIndex]))));
			if (element != null) {
				return element;
			}
		}
		
		return null;
	}
}


/**
 * An interface for loading TestBed object.
 *
 */
interface DatabaseObjectFactory {
	
	/**
	 * Returns the object associated with <code>id</code> or null if 
	 * the object could not be loaded.
	 * 
	 * @param id the id of the object to load.
	 * @return the object specified by <code>id</code> or null if 
	 * 			it could not be loaded.
	 */
	public Object loadObject(int id);
}