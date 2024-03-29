package org.apache.struts.helloworld.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.testbed.Authorization;
import com.testbed.AuthorizationFactory;
import com.testbed.TestBedFactory;
import com.testbed.User;
import com.testbed.UserManager;
import com.testbed.database.DbTestBedFactory;
import com.testbed.database.TestBedGlobals;
import com.util.PageUtils;

public class BasicInfoAction extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private User user;
	private String userName="您尚未登录";
	
	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String execute() throws Exception {
		
		HttpServletRequest request = ServletActionContext.getRequest ();
		HttpServletResponse response = ServletActionContext.getResponse();
		
		//得到用户的权限
		Authorization authToken = PageUtils.getUserAuthorization(request, response);
		
		if (authToken == null) {
			// 通过工厂AuthorizationFactory的静态方法getAnonymousAuthorization()
			// 获得客人所具备的权限
			authToken = AuthorizationFactory.getAnonymousAuthorization();
		} else {
			userName = PageUtils.getUserName(request);
		}
		
		TestBedFactory factory=DbTestBedFactory.getInstance(authToken);
		user = factory.getUserManager().getUser(authToken.getUserID());
		System.out.println(user.getName());
		System.out.println(user.getCity());
		
		if (user.getUserLevel() != 
			TestBedGlobals.USER_LEVEL_VALUE.ADMINISTRATOR.ordinal()) {
			return "successForExperimenter";
		}
		
		return SUCCESS;
	}
}
