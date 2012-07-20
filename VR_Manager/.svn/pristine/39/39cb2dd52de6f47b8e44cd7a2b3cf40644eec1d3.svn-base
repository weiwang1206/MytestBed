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
import com.testbed.TestBedFactory;
import com.testbed.User;
import com.testbed.database.DbTestBedFactory;
import com.util.PageUtils;

public class ExperimentorExpsAction extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ArrayList<Experiment> exps = new ArrayList<Experiment>();
	public ArrayList<Experiment> getExps() {
		return exps;
	}
	public void setExps(ArrayList<Experiment> exps) {
		this.exps = exps;
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
