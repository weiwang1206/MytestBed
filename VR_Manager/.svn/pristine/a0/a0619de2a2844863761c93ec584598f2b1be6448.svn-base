package com.resultFilter;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;

import com.testbed.database.TestBedGlobals;


/**
 * Filters and sorts lists of experiments, physicalMachines, users, routers, 
 * ports. This allows for a very
 * rich set of possible queries that can be run on TestBed data. Some examples
 * are: "Show all physicalMahcines in the test bed sort by their ip address" or 
 * "Show all experiment applications, sorted by their apply date".<p>
 *
 * The class also supports pagination of results with the setStartIndex(int)
 * and setNumResults(int) methods. If the start index is not set, it will
 * begin at index 0 (the start of results). If the number of results is not set,
 * it will be unbounded and return as many results as available.<p>
 *
 */
public class ResultFilter {

	/**
     * Descending sort, i.e. 3, 2, 1...
     */
    public static final int DESCENDING = 0;

    /**
     * Ascending sort, i.e. 3, 4, 5...
     */
    public static final int ASCENDING = 1;

    /**
     * An integer value that represents NULL. The actual value is
     * Integer.MAX_VALUE - 123 (an arbitrary number that has a very low
     * probability of actually being selected by a user as a valid value).
     */
    public static final int NULL_INT = Integer.MAX_VALUE - 123;

    /**
     * Creates a default PhyMachine ResultFilter: no filtering with results 
     * sorted on the Experiment code.
     */
    public static ResultFilter createDefaultPmFilter() {
        ResultFilter resultFilter = new ResultFilter("phymachine");
        return resultFilter;
    }

    /**
     * Creates a default Experiment ResultFilter: no filtering with results 
     * sorted on the Experiment creation date.
     */
    public static ResultFilter createDefaultExpFilter() {
        ResultFilter resultFilter = new ResultFilter("experiment");
        resultFilter.setSortField(TestBedGlobals.CREATION_DATE);
        resultFilter.setSortOrder(ASCENDING);
        return resultFilter;
    }
    
    /**
     * Creates a default VirtualRouter ResultFilter: no filtering.
     */
    public static ResultFilter createDefaultVrFilter() {
        ResultFilter resultFilter = new ResultFilter("virtualrouter");
        return resultFilter;
    }
    
    /**
     * Creates a default Port ResultFilter: no filtering.
     */
    public static ResultFilter createDefaultPortFilter() {
        ResultFilter resultFilter = new ResultFilter("port");
        resultFilter.setSortField(TestBedGlobals.CODE);
        resultFilter.setSortOrder(ASCENDING);
        return resultFilter;
    }
    
    
    /**
     * Creates a default Port ResultFilter: no filtering.
     */
    public static ResultFilter createDefaultRouterItemFilter() {
        ResultFilter resultFilter = new ResultFilter("routertable");
        return resultFilter;
    }
    /**
     * Creates a default User ResultFilter: no filtering.
     */
    public static ResultFilter createDefaultUserFilter() {
        ResultFilter resultFilter = new ResultFilter("userinfo");
        return resultFilter;
    }
    
    
    /**
     * Creates a default HistoryData ResultFilter: no filtering with results 
     * sorted on the operation date.
     */
    public static ResultFilter createDefaultOptHistoryDataFilter() {
        ResultFilter resultFilter = new ResultFilter("operationhistory");
        resultFilter.setSortField(TestBedGlobals.CREATION_DATE);
        resultFilter.setSortOrder(ASCENDING);
        return resultFilter;
    }
    
    public ResultFilter(String database) {
    	this.database = database;
    	if (database.equals("experiment")) {
    		IDColumn = "expID";
    	} else if (database.equals("phymachine")) {
    		IDColumn = "expID";
    	} else if (database.equals("userinfo")) {
    		IDColumn = "userID";
    	} else if (database.equals("virtualrouter")) {
    		IDColumn = "vrID";
    	} else if (database.equals("routertable")) {
    		IDColumn = "ID";
    	} else if (database.equals("port")) {
    		IDColumn = "ID";
    	} else if (database.equals("experimentmodel")) {
    		IDColumn = "expModelID";
    	} else if (database.equals("operationhistory")) {
    		IDColumn = "optID";
    	} else if (database.equals("phyhistorydata")) {
    		IDColumn = "phyID";
    	} else if (database.equals("phyrealdata")) {
    		IDColumn = "phyID";
    	} else if (database.equals("porthistorydata")) {
    		IDColumn = "ID";
    	} else if (database.equals("portrealdata")) {
    		IDColumn = "ID";
    	} else if (database.equals("routerhistorytable")) {
    		IDColumn = "ID";
    	} 
    }
    
    private String database;
    private String IDColumn;
    private int sortField = -1;
    private int sortOrder = -1;
    /**
     * The starting index for results. Default is 0.
     */
    private int startIndex = -1;

    /**
     * Number of results to return. Default is NULL_INT which means an unlimited
     * number of results.
     */
    private int numResults = NULL_INT;
    
    private long userID = NULL_INT;
    private Date creationDateRangeMin = null;
    private Date creationDateRangeMax = null;
    private List<Integer> propertyNames = new ArrayList<Integer>();
    private List<Enum> propertyValues = new ArrayList<Enum>();

    /**
     * Returns the userID that results will be filtered on. The method will
     * return NULL_INT if no user to filter on has been specified. The method
     * will return -1 if filtering is to take place on all "anonymous" users.
     *
     * @return the userID that results will be filtered on.
     */
    public long getUserID() {
        return userID;
    }

    /**
     * Sets the userID that results will be filtered on. If you'd like to filter
     * on "anonymous" users, pass in an id of -1. By default, no filtering on
     * userID's will take place. If you'd like to change so that no filtering
     * is performed, pass in ResultFilter.NULL_INT.
     *
     * @param userID the user ID to filter on.
     */
    public void setUserID(long userID) {
        this.userID = userID;
    }

    /**
     * Adds a property to the list of properties that will be filtered on.
     * For a message or thread to pass the property filter:<ul>
     *      <li> The message or thread must have a property with the same name
     *              as the filter.
     *      <li> The property value in the thread or message must exactly match
     *              the property value of the filter.
     * </ul>
     *
     * For example, say that we have a message with extended properties "color"
     * and "size" with the values "green" and "big". If we create a result
     * filter and specify that we should filter on "color=green" and
     * "size=small", the hypothetical message will be filtered out since the
     * size property values don't match.
     *
     * @param name the name of the property to filter on.
     * @param value the value of the property that results must match.
     */
    public void addProperty(int name, Enum value) {
        propertyNames.add(name);
        propertyValues.add(value);
    }

    /**
     * Returns the number of properties that results will be filtered on.
     *
     * @return the number of properties that results will be filtered on.
     */
    public int getPropertyCount() {
        return propertyNames.size();
    }

    /**
     * Returns the name of the property at the specified index in the list of
     * properties to be filtered on. If the index is invalid, null will be
     * returned.
     *
     * @return the name of the property at the specified index in the property
     *      filter list.
     */
    public int getPropertyName(int index) {
        if (index >= 0 && index < propertyNames.size()) {
            return (int)propertyNames.get(index);
        }
        else {
            return -1;
        }
    }

    /**
     * Returns the value of the property at the specified index in the list of
     * properties to be filtered on. If the index is invalid, null will be
     * returned.
     *
     * @return the value of the property at the specified index in the property
     *      filter list.
     */
    public Enum getPropertyValue(int index) {
        if (index >= 0 && index < propertyValues.size()) {
            return (Enum)propertyValues.get(index);
        }
        else {
            return null;
        }
    }

    /**
     * Returns the creation date that represents the lower boundary for messages
     * or threads to be filtered on. If this value has not been set, the method
     * will return null.
     *
     * @return a Date representing the lower bound for creation dates to filter
     *      on.
     */
    public Date getCreationDateRangeMin() {
        return creationDateRangeMin;
    }

    /**
     * Sets the date that represents the lower boundary for messages or threads to
     * be selected by the result filter. If this value is not set the results filter will
     * be unbounded for the earliest creation date selected.
     *
     * @param creationDateRangeMin Date representing the filter lowest value of
     *      the creation date to be selected.
     */
    public void setCreationDateRangeMin(Date creationDateRangeMin) {
        this.creationDateRangeMin = creationDateRangeMin;
    }

    /**
     * Returns a date that represents the upper boundary for messages or threads to
     * be selected by the result filter. If this value is not set it will return null
     * and the results filter will be unbounded for the latest creation date selected.
     *
     * @return a Date representing the filter highest value of the creation date to be
     * selected.
     */
    public Date getCreationDateRangeMax() {
        return creationDateRangeMax;
    }

    /**
     * Sets a date that represents the upper boundary for messages or threads to
     * be selected by the result filter. If this value is not set the results filter will
     * be unbounded for the latest creation date selected.
     *
     * @param creationDateRangeMax Date representing the filter lowest value of
     * the creation date range.
     */
    public void setCreationDateRangeMax(Date creationDateRangeMax) {
        this.creationDateRangeMax = creationDateRangeMax;
    }

    /*
     * Returns the currently selected sort field. Default is
     * JiveGlobals.CREATION_DATE.
     *
     * @return current sort field.
     */
    public int getSortField() {
        return sortField;
    }

    /**
     * Sets the sort field to use. Default is JiveGlobals.MODIFIED_DATE .
     * If the sortField is set to JiveGlobals.EXTENDED_PROPERTY, the name of
     * the property must be set by a subsequent call to
     * setSortPropertyName(String).
     *
     * @param sortField the field that will be used for sorting.
     */
    public void setSortField(int sortField) {
        this.sortField = sortField;
    }



    /**
     * Returns the sort order, which will be ResultFilter.ASCENDING for
     * ascending sorting, or ResultFilter.DESCENDING for descending sorting.
     * Descending sorting is: 3, 2, 1, etc. Ascending sorting is 1, 2, 3, etc.
     *
     * @retun the sort order.
     */
    public int getSortOrder() {
        return this.sortOrder;
    }

    /**
     * Sets the sort type. Valid arguments are ResultFilter.ASCENDING for
     * ascending sorting or ResultFilter.DESCENDING for descending sorting.
     * Descending sorting is: 3, 2, 1, etc. Ascending sorting is 1, 2, 3, etc.
     *
     * @param sortOrder the order that results will be sorted in.
     */
    public void setSortOrder(int sortOrder) {
        if (! (sortOrder == ResultFilter.ASCENDING ||
               sortOrder == ResultFilter.DESCENDING)
            )
        {
            throw new IllegalArgumentException();
        }
        this.sortOrder = sortOrder;
    }

    /**
     * Returns the max number of results that should be returned.
     * The default value for is NULL_INT, which means there will be no limit
     * on the number of results. This method can be used in combination with
     * setStartIndex(int) to perform pagination of results.
     *
     * @return the max number of results to return.
     * @see #setStartIndex(int)
     */
    public int getNumResults() {
        return numResults;
    }

    /**
     * Sets the limit on the number of results to be returned.
     *
     * @param numResults the number of results to return.
     */
    public void setNumResults(int numResults) {
        this.numResults = numResults;
    }

    /**
     * Returns the index of the first result to return.
     *
     * @return the index of the first result which should be returned.
     */
    public int getStartIndex() {
        return startIndex;
    }

    /**
     * Sets the index of the first result to return. For example, if the start
     * index is set to 20, the Iterator returned will start at the 20th result
     * in the query. This method can be used in combination with
     * setNumResults(int) to perform pagination of results.
     *
     * @param startIndex the index of the first result to return.
     */
    public void setStartIndex(int startIndex) {
        this.startIndex = startIndex;
    }

	public String getDatabase() {
		return database;
	}

	public String getIDColumn() {
		return IDColumn;
	}

	
   
	
}