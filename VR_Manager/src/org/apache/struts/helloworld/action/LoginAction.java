package org.apache.struts.helloworld.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import antlr.Utils;

import com.opensymphony.xwork2.ActionSupport;
import com.testbed.Authorization;
import com.testbed.AuthorizationFactory;
import com.testbed.TestBedFactory;
import com.testbed.UnauthorizedException;
import com.testbed.User;
import com.testbed.database.DbTestBedFactory;
import com.testbed.database.TestBedGlobals;
import com.util.PageUtils;

public class LoginAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int userID;
	
	
	
	public int getUserID() {
		return userID;
	}



	public void setUserID(int userID) {
		this.userID = userID;
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
		}
		
		if (userID != authToken.getUserID())	
			return ERROR;
		
		TestBedFactory factory=DbTestBedFactory.getInstance(authToken);
		User user = factory.getUserManager().getUser(authToken.getUserID());
		
		if (user.getUserLevel() == 
			TestBedGlobals.USER_LEVEL_VALUE.REGISTED.ordinal()) {
			return "successForExperimenter";
		} else if (user.getUserLevel() == 
			TestBedGlobals.USER_LEVEL_VALUE.ADMINISTRATOR.ordinal()){
			return SUCCESS;
		}
		return "NoAuthority";
	}
	
}
