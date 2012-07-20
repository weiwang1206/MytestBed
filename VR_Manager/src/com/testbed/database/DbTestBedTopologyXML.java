package com.testbed.database;

import java.util.ArrayList;

import javassist.NotFoundException;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.resultFilter.ResultFilter;
import com.testbed.TestBedTopologyXML;
import com.testbed.User;

public class DbTestBedTopologyXML implements TestBedTopologyXML{

	private String xml;
	private int id = 1;
	private DbTestBedFactory factory;
	
	public DbTestBedTopologyXML() {};
	public DbTestBedTopologyXML(DbTestBedFactory factory) throws NotFoundException{
		this.factory = factory;
		loadFromDb();
	}
	
	private void loadFromDb() throws NotFoundException{
		// TODO Auto-generated method stub
		//xml = "<mxGraphModel><root><mxCell id=\"0\"/><mxCell id=\"1\" parent=\"0\"/></root></mxGraphModel>";
		//xml = "<mxGraphModel><root><mxCell id=\"0\"/><mxCell id=\"1\" parent=\"0\"/><mxCell id=\"10000\" value=\"&lt;h1 style=&quot;margin:0px&quot;&gt;Physical&lt;br&gt;Machine&lt;/h1&gt;&lt;br&gt;&lt;img src=&quot;topology/images/icons48/Router.png&quot; width=&quot;48&quot; height=&quot;48&quot;&gt;&lt;br&gt;&lt;a href=&quot;#none&quot; name=10000 onclick=&quot;testMessageBox(event,this)&quot;&gt;Configure&lt;/a&gt;\" vertex=\"1\" connectable=\"0\" parent=\"1\"><mxGeometry x=\"220\" y=\"60\" width=\"120\" height=\"120\" as=\"geometry\"><mxRectangle width=\"120\" height=\"40\" as=\"alternateBounds\"/></mxGeometry></mxCell><mxCell id=\"3\" value=\"Trigger\" style=\"port;image=topology/images/green-dot.gif;align=right;imageAlign=right;spacingRight=18\" vertex=\"1\" parent=\"10000\"><mxGeometry x=\"0.5\" y=\"0.5\" width=\"16\" height=\"16\" relative=\"1\" as=\"geometry\"><mxPoint x=\"-6\" y=\"-8\" as=\"offset\"/></mxGeometry></mxCell></root></mxGraphModel>";
		Session session = factory.getSessionFactory().openSession();
	    Transaction tx = null;
	    TestBedTopologyXML topoXML;
	    try {
	    	System.out.println("before tx");
	      tx = session.beginTransaction();
	      System.out.println("after tx");
	      topoXML=(TestBedTopologyXML)session.get(DbTestBedTopologyXML.class,this.id);
	      
	      tx.commit();

	    }catch (RuntimeException e) {
	    	System.out.println("catch");
	      if (tx != null) {
	    	  e.printStackTrace();
	        tx.rollback();
	      }
	      throw e;
	    } finally {
	      session.close();
	    }
	    if (topoXML!=null)
	    {
	    	System.out.println("load topoXML");
	    	this.setXml(topoXML.getXml());
	    } else {
	    	throw new NotFoundException("PhyMachine not found");
	    }
	}

	public void saveToDb() {
		// TODO Auto-generated method stub
		Session session = factory.getSessionFactory().openSession();
	    Transaction tx = null;
	    TestBedTopologyXML topoXML;
	    try {
	    	tx = session.beginTransaction();

	    	topoXML=(TestBedTopologyXML)session.get(DbTestBedTopologyXML.class,this.id);
	      
	    	topoXML.setXml(this.getXml());
			tx.commit();

	    }catch (RuntimeException e) {
	    	if (tx != null) {
	    		tx.rollback();
	    	}
	    	throw e;
	    } finally {
	    	session.close();
	    }
	}


	public String getXml() {
		return xml;
	}

	public void setXml(String xml) {
		this.xml = xml;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
}
