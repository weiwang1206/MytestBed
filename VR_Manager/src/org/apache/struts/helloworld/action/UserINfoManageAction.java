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
import com.testbed.UserManager;
import com.testbed.database.DbTestBedFactory;
import com.testbed.database.TestBedGlobals;
import com.util.PageUtils;

public class UserINfoManageAction extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String type;
	private ArrayList<User> users = new ArrayList<User>();
	private ArrayList<Integer> appendList = new ArrayList<Integer>(); 
	private int contentCntInPage;
	private int pageIndex = -1;
	private int pageCnt;
	
	
	
	public ArrayList<Integer> getAppendList() {
		return appendList;
	}
	public void setAppendList(ArrayList<Integer> appendList) {
		this.appendList = appendList;
	}
	public int getContentCntInPage() {
		return contentCntInPage;
	}
	public void setContentCntInPage(int contentCntInPage) {
		this.contentCntInPage = contentCntInPage;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public ArrayList<User> getUsers() {
		return users;
	}
	public void setUsers(ArrayList<User> users) {
		this.users = users;
	}
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
	public String execute() throws Exception {
		
		HttpServletRequest request;
		HttpServletResponse response;
		Authorization authToken;
		System.out.println("pageIndex------------->" + pageIndex);
		if (type == null || pageIndex == -1) {
			return SUCCESS;
		}
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
		contentCntInPage = TestBedGlobals.PAGE_SIZE;
		while (it.hasNext()) {
			contentCntInPage--;
			users.add((User) it.next());
		}
		
		for (int i = 0; i < contentCntInPage; i++) {
			appendList.add(0);
		}
		System.out.println("contentCntInPage------------>" + contentCntInPage);
		System.out.println("pageCnt------------->" + pageCnt);
		System.out.println("pageIndex------------->" + pageIndex);
		return SUCCESS;
	}
}
