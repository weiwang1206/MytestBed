package org.apache.struts.helloworld.action;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.resultFilter.ResultFilter;
import com.testbed.Authorization;
import com.testbed.AuthorizationFactory;
import com.testbed.TestBedFactory;
import com.testbed.User;
import com.testbed.UserID_RegisterANDDelete;
import com.testbed.UserManager;
import com.testbed.database.DbTestBedFactory;
import com.testbed.database.TestBedGlobals;
import com.util.PageUtils;

public class JSONUserInfoManageOperation extends ActionSupport{

	private String json; 
	private int pageIndex = -1;
	private int pageCnt;
	private String type;
	

	public int getPageIndex() {
		return pageIndex;
	}
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}
	public int getPageCnt() {
		return pageCnt;
	}
	public void setPageCnt(int pageCnt) {
		this.pageCnt = pageCnt;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getJson() {
		return json;
	}
	public void setJson(String json) {
		this.json = json;
	}
	
	public String execute() throws Exception {
		//send the data to create a new VR,N = new a VR
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
		UserManager userManager = factory.getUserManager();
		
		JSONArray jsonArray = null ; 
		JSONObject jsonObject;
		UserID_RegisterANDDelete value;
		try{  
	        //将json字符串转化为JsonArray对象  
			jsonArray = JSONArray.fromObject(json); 
			System.out.println(jsonArray);
			for (int i = 0; i < jsonArray.size(); i++) {
				jsonObject = jsonArray.getJSONObject(i);
				value = (UserID_RegisterANDDelete) JSONObject.toBean(jsonObject, UserID_RegisterANDDelete.class);
				System.out.println("<-----------------------UserID_RegisterANDDelete----------------->");
				System.out.println(value.getUserID());
				System.out.println(value.isDeleteUser());
				System.out.println(value.isRegister());
				User user = userManager.getUser(value.getUserID());
				if (value.isRegister()) {
					user.setUserLevel(TestBedGlobals.USER_LEVEL_VALUE.REGISTED.ordinal());
					user.saveToDb();
				}
				if (value.isDeleteUser()) {
					userManager.deleteUser(user);
				}
				
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		try {
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			
			JSONObject json = new JSONObject();
			
			Map map = new HashMap(); 
			List list = new ArrayList();
			
			/** 
			 * 设置Filter，取得第 pageIndex页的内容
			 */
			ResultFilter filter = ResultFilter.createDefaultUserFilter();
			filter.setStartIndex(pageIndex * TestBedGlobals.PAGE_SIZE);
			filter.setNumResults(TestBedGlobals.PAGE_SIZE);
			
			if (type.equals("unregistered")) {
				/** 
				 * 设置Filter，取得未批准的用户
				 */
				filter.addProperty(TestBedGlobals.USER_LEVEL, 
						TestBedGlobals.USER_LEVEL_VALUE.REGISTERING);
			} else if (type.equals("registered")) {
				/** 
				 * 设置Filter，取得批准的用户
				 */
				filter.addProperty(TestBedGlobals.USER_LEVEL, 
						TestBedGlobals.USER_LEVEL_VALUE.REGISTED);
			}
			
			
			Iterator it = userManager.users(filter);
			pageCnt = userManager.getUserCount(filter) / TestBedGlobals.PAGE_SIZE;
			while (it.hasNext()) {
				list.add((User) it.next());
			}
			
			for (int i = 0; i < list.size(); i++) {
				System.out.println(((User)list.get(i)).getName());
			}
			
			map.put("pageCnt", pageCnt);
			System.out.println("before put list into map");
			map.put("list",list);
			System.out.println("before put list into json");
			json = JSONObject.fromObject( map ); 
			System.out.println("after put list into json");
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
		
		System.out.println("pageCnt------------->" + pageCnt);
		System.out.println("pageIndex------------->" + pageIndex);
		return null;
	}
}
