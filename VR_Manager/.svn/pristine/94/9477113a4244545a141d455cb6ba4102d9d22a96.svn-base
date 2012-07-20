package org.apache.struts.helloworld.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.testbed.Authorization;
import com.testbed.AuthorizationFactory;
import com.testbed.TestBedFactory;
import com.testbed.UnauthorizedException;
import com.testbed.User;
import com.testbed.UserManager;
import com.testbed.database.DbTestBedFactory;
import com.util.PageUtils;

public class RegisterAction  extends ActionSupport {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String userName;
	private String password;
	private String email;
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}

	
	public String execute() throws Exception {
		try 
		{
		
			HttpServletRequest request = ServletActionContext.getRequest ();
	
			
			TestBedFactory factory=DbTestBedFactory.getInstance(AuthorizationFactory.getAnonymousAuthorization());
			UserManager userManager = factory.getUserManager();
			User user = userManager.createUser(userName, password, email);
	
			System.out.println("userName---------------->" + userName);
			System.out.println("password---------------->" + password);
			user.saveToDb();
			PageUtils.Register(request, userName, password);
			
			// 判断是administrator还是experimenter，跳转到不同的界面
			return SUCCESS;
		} catch (UnauthorizedException e) {
			return ERROR;
		}
	}
}
