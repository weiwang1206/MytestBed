package com.util;

/**
 * Doubly linked node in a LinkedList. Most LinkedList implementations keep
 * the equivalent of this class private. We make it public so that references
 * to each node in the list can be maintained externally.
 * 
 * Exposing this class lets us make remove operations very fast. Remove is built
 * into this class and only requires to reference reassignments. If remove was
 * built into the main LinkedList class, a linear scan would have to be performed
 * to find the correct node to delete.
 * 
 * The linked list implementation was specifically written for the Cache system.
 * @author Administrator
 *
 */
public class LinkedListNode {
	public LinkedListNode previous;
	public LinkedListNode next;
	public Object object;
	
	/**
	 * This class is further customized for the cache system. It maintains a
	 * time stamp of a cacheable object was first added to cache. Time stamps are
	 * stored as long values and represent the number of milleseconds passed
	 * since January 1, 1970 00:00:00.000 GMT.
	 * 
	 * The creation time stamp is used in the case that the cache has a maximum 
	 * lifetime set. In taht case, when
	 * [current time] - [creation time] > [max lifetime], the object will be
	 * delete from cache.
	 */
	public long timestamp;
	
	/**
	 * Constructs a new linked list node.
	 * @param object the object that the node represents.
	 * @param next a reference to the next LinkedListNode in the list.
	 * @param previous a reference to the previous LinkedListNode in the list.
	 */
	public LinkedListNode(Object object, LinkedListNode next, 
			LinkedListNode previous) {
		this.object = object;
		this.next = next;
		this.previous = previous;
	}
	
	/**
	 * Removes this node from the linked list that it is a part of.
	 */
	public void remove() {
		previous.next = next;
		next.previous = previous;
	}
	
	/**
	 * Returns a String representation of the linked list node by calling the toString
	 * method of the node's object.
	 */
	public String toString() {
		return object.toString();
	}
}
