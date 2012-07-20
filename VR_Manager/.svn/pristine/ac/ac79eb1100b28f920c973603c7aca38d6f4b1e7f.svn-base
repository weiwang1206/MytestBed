package org.apache.struts.helloworld.action;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.testbed.Authorization;
import com.testbed.TestBedFactory;
import com.testbed.UnauthorizedException;
import com.testbed.User;
import com.testbed.database.DbTestBedFactory;
import com.testbed.database.TestBedGlobals;
import com.util.PageUtils;
import net.sf.json.JSONObject;

public class JSONLogin  extends ActionSupport {
	
	
	private static final long serialVersionUID = 1L;
	private String userName;
	private String password;
	private String autoLogin;
	
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
	
	
	public String getAutoLogin() {
		return autoLogin;
	}
	public void setAutoLogin(String autoLogin) {
		this.autoLogin = autoLogin;
	}
	
	
	public String execute() throws Exception {
		int userID = -1;
		boolean IsVerified = false;
		
		try 
		{
			HttpServletRequest request = ServletActionContext.getRequest ();
			HttpServletResponse response = ServletActionContext.getResponse();
			Authorization authToken = null;
			if (autoLogin.equals("on"))//得到用户的权限
				authToken = PageUtils.Login(request, response, userName, password, true);
			else
				authToken = PageUtils.Login(request, response, userName, password, false);

			TestBedFactory factory=DbTestBedFactory.getInstance(authToken);
			User user = factory.getUserManager().getUser(authToken.getUserID());
			
			if (user.getUserLevel() == 
				TestBedGlobals.USER_LEVEL_VALUE.REGISTERING.ordinal())
			{
				userID = authToken.getUserID();
			}
			else if (user.getUserLevel() == 
				TestBedGlobals.USER_LEVEL_VALUE.REGISTED.ordinal() ||
				user.getUserLevel() == 
				TestBedGlobals.USER_LEVEL_VALUE.ADMINISTRATOR.ordinal()) {
				IsVerified = true;
				userID = authToken.getUserID();
			}
		} catch (UnauthorizedException e) {
			
		} finally {
			
			try {
				HttpServletResponse response = ServletActionContext.getResponse();
				
				// 设置字符集
				response.setCharacterEncoding("UTF-8");
				PrintWriter out = response.getWriter();
				
				JSONObject json = new JSONObject();
				
				Map map = new HashMap(); 
				
				map.put("userID", userID);
				map.put("IsVerified", IsVerified);
			
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
}

