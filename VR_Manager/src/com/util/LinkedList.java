package com.util;

/**
 * Simple LinkedList implementation. The main feature is that list nodes are public,
 * which allows very fast delete operations (when one has a reference to the node
 * that is to be delete).
 * 
 * The linked list implementation was specifically written for the Cache system.
 */
public class LinkedList {
	
	/**
	 * The root of the list keeps a reference to both the first and last
	 * elements of the list.
	 */
	private LinkedListNode head = new LinkedListNode("head", null, null);
	
	/**
	 * Creates a new linked list.
	 */
	public LinkedList() {
		head.next = head.previous = head;
	}
	
	
	/**
	 * Returns the first linked list node in the list.
	 * @return the first node in the list.
	 */
	public LinkedListNode getFirst() {
		LinkedListNode node = head.next;
		if (node == head) {
			return null;
		}
		return node;
	}
	
	
	/**
	 * Returns the last linked list node in the list.
	 * @return the last node in the list.
	 */
	public LinkedListNode getLast() {
		LinkedListNode node = head.previous;
		if (node == null) {
			return null;
		}
		return node;
	}
	
	
	/**
	 * Adds a node to the beginning of the list.
	 * @param node add this node
	 * @return
	 */
	public LinkedListNode addFirst(LinkedListNode node) {
		node.next = head.next;
		node.previous = head;
		node.previous.next = node;
		node.next.previous = node;
		return node;
	}
	
	/**
	 * Adds an object to the beginning of the list by automatically creating a 
	 * new node and adding it to the beginning of the list.
	 * 
	 * @param object the object to add to the beginning of the list.
	 * @return the node created to wrap the object.
	 */
	public LinkedListNode addFirst(Object object) {
		LinkedListNode node = new LinkedListNode(object, head.next, head);
		node.previous.next = node;
		node.next.previous = node;
		return node;
	}
	
	/**
	 * Adds an object to the end of the list by automatically creating a 
	 * new node and adding it to the end of the list.
	 * @param object the object to add to the end of the list.
	 * @return the node created to wrap the object
	 */
	public LinkedListNode addLast(Object object) {
		LinkedListNode node = new LinkedListNode(object, head, head.previous);
		node.previous.next = node;
		node.next.previous = node;
		return node;
	}
	
	/**
	 * Erases all elements in the list and re-initializes it.
	 */
	public void clear() {
		//Remove all reference in the list.
		LinkedListNode node = getLast();
		while (node != null) {
			node.remove();
			node = getLast();
		}
		
		//re-initialize.
		head.next = head.previous = head;
	}
	
	
	/**
	 * Returns a String representation of the LinkedList.
	 * @return String representation of the LinkedList.
	 */
	public String toString() {
		LinkedListNode node = head.next;
		StringBuffer buf = new StringBuffer();
		while (node != null) {
			buf.append(node.toString()).append(", ");
			node = node.next;
		}
		
		return buf.toString();
	}
}
