package com.util;


/**
 * A simplified List for int values. Only the bare number of methods needed
 * by Jive have been implemented so far, so additional implementation work
 * would be welcome.<p>
 *
 * The implementation uses an array for maximum speed. If the number of elements
 * grows larger than capacity, the capacity will automatically grow.
 */
public class IntList {

    int [] elements;
    int capacity;
    int size;

    /**
     * Creates a new list of int values with a default capacity of 50.
     */
    public IntList() {
        this(50);
    }

    /**
     * Creates a new list of int values with a specified initial capacity.
     *
     * @param initialCapacity a capacity to initialize the list with.
     */
    public IntList(int initialCapacity) {
        size = 0;
        capacity = initialCapacity;
        elements = new int[capacity];
    }

    /**
     * Adds a new int value to the end of the list.
     */
    public void add(int value) {
        elements[size] = value;
        size++;
        if (size == capacity) {
            capacity = capacity * 2;
            int[] newElements = new int[capacity];
            for (int i=0; i<size; i++) {
                newElements[i] = elements[i];
            }
            elements = newElements;
        }
    }

    /**
     * Returns the int value at the specified index. If the index is not
     * valid, an IndexOutOfBoundException will be thrown.
     *
     * @param index the index of the value to return.
     * @return the value at the specified index.
     */
    public int get(int index) {
        if (index < 0 || index >= size) {
            throw new IndexOutOfBoundsException("Index " + index + " not valid.");
        }
        return elements[index];
    }

    /**
     * Returns the number of elements in the list.
     *
     * @return the number of elements in the list.
     */
    public int size() {
        return size;
    }

    /**
     * Returns a new array containing the list elements.
     *
     * @return an array of the list elements.
     */
    public int[] toArray() {
        int size = this.size;
        int[] newElements = new int[size];
        for (int i=0; i<size; i++) {
            newElements[i] = elements[i];
        }
        return newElements;
    }

    public String toString() {
        StringBuffer buf = new StringBuffer();
        for (int i=0; i<this.size; i++) {
            buf.append(elements[i]).append(" ");
        }
        return buf.toString();
    }
    
    public int getSize() {
    	int size = 0;
    	
    	size += CacheSizes.sizeOfObject();		   	// overhead of object
    	size += CacheSizes.sizeOfInt() * capacity; 	// elements
    	size += CacheSizes.sizeOfInt();				// capacity
    	size += CacheSizes.sizeOfInt();				// size
    	
    	return size;
    }
}

