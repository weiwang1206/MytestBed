package org.apache.struts.helloworld.action;

import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.resultFilter.ResultFilter;
import com.testbed.Authorization;
import com.testbed.AuthorizationFactory;
import com.testbed.Experiment;
import com.testbed.PhyMachine;
import com.testbed.TestBedFactory;
import com.testbed.database.DbTestBedFactory;
import com.testbed.database.TestBedGlobals;
import com.util.PageUtils;

public class OfferExperimentAction extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int id;
	private Experiment exp;
	private ArrayList<PhyMachine> pms = new ArrayList<PhyMachine>();
	private ArrayList<Integer> pmIDs ;
	private String expName;
	
	public ArrayList<Integer> getPmIDs() {
		return pmIDs;
	}

	public void setPmIDs(ArrayList<Integer> pmIDs) {
		this.pmIDs = pmIDs;
	}

	public Experiment getExp() {
		return exp;
	}

	public void setExp(Experiment exp) {
		this.exp = exp;
	}
	
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String execute() throws Exception {
		
		HttpServletRequest request;
		HttpServletResponse response;
		Authorization authToken;
		
		request = ServletActionContext.getRequest ();
		response = ServletActionContext.getResponse();
		
		//得到用户的权限
		authToken = PageUtils.getUserAuthorization(request, response);
		
		if (authToken == null) {
			// 通过工厂AuthorizationFactory的静态方法getAnonymousAuthorization()
			// 获得客人所具备的权限
			authToken = AuthorizationFactory.getAnonymousAuthorization();
		}
		
		TestBedFactory factory=DbTestBedFactory.getInstance(authToken);
		ResultFilter filter = ResultFilter.createDefaultPmFilter();
		System.out.println("in OfferExperimentAction  expID ------> "+ id);
		exp = factory.getExp(id);
		setExpName(exp.getExpName());
		
		pmIDs = factory.pmIDs(filter);
		
		Iterator it = factory.pms(filter);
		
		while (it.hasNext()) {
			pms.add((PhyMachine)it.next());
		}
		
		System.out.println(pmIDs.toString());
		return SUCCESS;
	}

	public void setExpName(String expName) {
		this.expName = expName;
	}

	public String getExpName() {
		return expName;
	}

	public ArrayList<PhyMachine> getPms() {
		return pms;
	}

	public void setPms(ArrayList<PhyMachine> pms) {
		this.pms = pms;
	}

}
