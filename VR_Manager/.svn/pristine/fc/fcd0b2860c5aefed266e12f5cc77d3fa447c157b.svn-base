package org.apache.struts.helloworld.action;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import com.opensymphony.xwork2.ActionSupport;
import com.testbed.Authorization;
import com.testbed.AuthorizationFactory;
import com.testbed.TestBedFactory;
import com.testbed.database.DbTestBedFactory;
import com.testbed.database.SequenceManager;
import com.testbed.database.TestBedGlobals;

import net.sf.json.JSONObject;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

public class JSONCheckUserName  extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String userName;

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String execute() throws Exception {
		try {
			HttpServletResponse response = ServletActionContext.getResponse();
			Authorization authToken = AuthorizationFactory.getAnonymousAuthorization();

			TestBedFactory factory=DbTestBedFactory.getInstance(authToken);
			int userID = factory.getUserManager().getUserIDByName(userName);
			// 设置字符集
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			
			JSONObject json = new JSONObject();
			
			Map map = new HashMap(); 
			
			map.put("userID", userID);
		
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
		}
		
		return null;
	}
}
