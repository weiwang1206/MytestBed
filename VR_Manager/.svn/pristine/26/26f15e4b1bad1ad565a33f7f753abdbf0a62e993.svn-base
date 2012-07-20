package org.apache.struts.helloworld.action;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

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

public class JSONRegister  extends ActionSupport {
	
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
		
		boolean result = false;
		TestBedFactory factory=DbTestBedFactory.getInstance(AuthorizationFactory.getAnonymousAuthorization());
		UserManager userManager = factory.getUserManager();
		User user = userManager.createUser(userName, password, email);
		if( user == null )
			result = false;
		else {
			System.out.println("userName---------------->" + userName);
			System.out.println("password---------------->" + password);
			user.saveToDb();
			result = true;
		}
			
		try {
			HttpServletResponse response = ServletActionContext.getResponse();
			
			// 设置字符集
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			
			JSONObject json = new JSONObject();
			
			Map map = new HashMap(); 
			
			map.put("result", result);
		
			json = JSONObject.fromObject( map );
			// 直接输入响应的内容
			out.println(json);
			//System.out.println(json);
			/** 格式化输出时间 **/
			out.flush();
			out.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			return null;
		}
		
		
	}
}
