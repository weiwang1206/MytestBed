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
import com.testbed.Operation;
import com.testbed.TestBedFactory;
import com.testbed.User;
import com.testbed.database.DbTestBedFactory;
import com.testbed.database.TestBedGlobals;
import com.util.PageUtils;

public class UserInfoAction extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private User user;
	private ArrayList<Experiment> exps = new ArrayList<Experiment>();
	private int userId;
	
	public User getUser() {
		return user;
	}


	public void setUser(User user) {
		this.user = user;
	}

	
	public ArrayList<Experiment> getExps() {
		return exps;
	}


	public void setExps(ArrayList<Experiment> exps) {
		this.exps = exps;
	}


	public int getUserId() {
		return userId;
	}


	public void setUserId(int userId) {
		this.userId = userId;
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
		
		user = factory.getUserManager().getUser(userId);
		/** 
		 * 设置Filter
		 */
		ResultFilter filter = ResultFilter.createDefaultExpFilter();
		
		Iterator it = user.exps(filter);
		while (it.hasNext()) {
			exps.add((Experiment) it.next());
		}
		for (int i = 0; i < exps.size(); i++) {
			System.out.println(exps.get(i).getExpName());
		}
		System.out.println(user.getName());
		
		return SUCCESS;
	}
}
