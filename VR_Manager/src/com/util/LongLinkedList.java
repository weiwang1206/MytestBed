package com.util;

import java.util.*;

/**
 * Simple LinkedList implementation. The main feature is that list nodes
 * are public, which allows very fast delete operations (when one has a
 * reference to the node that is to be deleted).<p>
 *
 * The linked list implementation was specifically written for the CoolServlets
 * cache system. While it can be used as a general purpose linked list, for
 * most applications, it is more suitable to use the linked list that is part
 * of the Java Collections package.
 */
public class LongLinkedList {

    /**
     * The root of the list keeps a reference to both the first and last
     * elements of the list.
     */
    private LongLinkedListNode head = new LongLinkedListNode(-1L, null, null);

    /**
     * Creates a new linked list.
     */
    public LongLinkedList() {
        head.next = head.previous = head;
    }

    /**
     * Returns the first linked list node in the list.
     *
     * @return the first element of the list.
     */
    public LongLinkedListNode getFirst() {
        LongLinkedListNode node = head.next;
        if (node == head) {
            return null;
        }
        return node;
    }

    /**
     * Returns the last linked list node in the list.
     *
     * @return the last element of the list.
     */
    public LongLinkedListNode getLast() {
        LongLinkedListNode node = head.previous;
        if (node == head) {
            return null;
        }
        return node;
    }

    /**
     * Adds a node to the beginning of the list.
     *
     * @param node the node to add to the beginning of the list.
     */
    public LongLinkedListNode addFirst(LongLinkedListNode node) {
        node.next = head.next;
        node.previous = head;
        node.previous.next = node;
        node.next.previous = node;
        return node;
    }

    /**
     * Adds an object to the beginning of the list by automatically creating a
     * a new node and adding it to the beginning of the list.
     *
     * @param object the object to add to the beginning of the list.
     * @return the node created to wrap the object.
     */
    public LongLinkedListNode addFirst(long key) {
        LongLinkedListNode node = new LongLinkedListNode(key, head.next, head);
        node.previous.next = node;
        node.next.previous = node;
        return node;
    }

    /**
     * Adds an object to the end of the list by automatically creating a
     * a new node and adding it to the end of the list.
     *
     * @param object the object to add to the end of the list.
     * @return the node created to wrap the object.
     */
    public LongLinkedListNode addLast(long key) {
        LongLinkedListNode node = new LongLinkedListNode(key, head, head.previous);
        node.previous.next = node;
        node.next.previous = node;
        return node;
    }

    /**
     * Erases all elements in the list and re-initializes it.
     */
    public void clear() {
        //Remove all references in the list.
        LongLinkedListNode node = getLast();
        while (node != null) {
            node.remove();
            node = getLast();
        }

        //Re-initialize.
        head.next = head.previous = head;
    }

    /**
     * Returns a String representation of the linked list with a comma
     * delimited list of all the elements in the list.
     *
     * @return a String representation of the LinkedList.
     */
    public String toString() {
        LongLinkedListNode node = head.next;
        StringBuffer buf = new StringBuffer();
        while (node != head) {
            buf.append(node.toString()).append(", ");
            node = node.next;
        }
        return buf.toString();
    }
}
