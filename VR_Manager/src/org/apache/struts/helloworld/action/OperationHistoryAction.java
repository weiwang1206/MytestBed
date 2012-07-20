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
import com.testbed.Operation;
import com.testbed.TestBedFactory;
import com.testbed.User;
import com.testbed.database.DbTestBedFactory;
import com.testbed.database.TestBedGlobals;
import com.util.PageUtils;

public class OperationHistoryAction extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	ArrayList<Operation> opers = new ArrayList<Operation>();

	public ArrayList getOpers() {
		return opers;
	}

	public void setOpers(ArrayList opers) {
		this.opers = opers;
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
		User user = factory.getUserManager().getUser(authToken.getUserID());
		
		/** 
		 * 设置Filter
		 */
		ResultFilter filter = ResultFilter.createDefaultOptHistoryDataFilter();
		
		Iterator it = user.opers(filter);
		while (it.hasNext()) {
			opers.add((Operation) it.next());
		}
		
		System.out.println(opers.size());
		
		for (int i = 0; i < opers.size(); i++) {
			System.out.println("opers.get(i).getOpeRecord()------------>" + opers.get(i).getOpeRecord());
		}
		
		if (user.getUserLevel() != 
			TestBedGlobals.USER_LEVEL_VALUE.ADMINISTRATOR.ordinal()) {
			return "successForExperimenter";
		}
		
		return SUCCESS;
	}
}
