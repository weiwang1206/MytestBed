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
import com.testbed.UserManager;
import com.testbed.database.DbTestBedFactory;
import com.testbed.database.TestBedGlobals;
import com.util.PageUtils;

public class ExperimentManageAction extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String type;
	private int contentCntInPage;
	private ArrayList<Experiment> exps = new ArrayList<Experiment>();
	private ArrayList<Integer> appendList = new ArrayList<Integer>(); 
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
	
	public ArrayList<Experiment> getExps() {
		return exps;
	}
	public void setExps(ArrayList<Experiment> exps) {
		this.exps = exps;
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
		
		System.out.println(type);
		
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
		/** 
		 * 设置Filter，取得第 pageIndex页的内容
		 */
		ResultFilter filter = ResultFilter.createDefaultExpFilter();
		filter.setStartIndex(pageIndex * TestBedGlobals.PAGE_SIZE);
		filter.setNumResults(TestBedGlobals.PAGE_SIZE);
		
		
		if (type.equals("applying")) {
			filter.addProperty(TestBedGlobals.EXP_STATE,
					TestBedGlobals.EXP_STATE_VALUE.APPLYING);
		} else if (type.equals("experimenting")) {
			filter.addProperty(TestBedGlobals.EXP_STATE,
					TestBedGlobals.EXP_STATE_VALUE.EXPERIMENTING);
		} else if (type.equals("finished")) {
			filter.addProperty(TestBedGlobals.EXP_STATE,
					TestBedGlobals.EXP_STATE_VALUE.FINISHED);
		} else if (type.equals("released")) {
			filter.addProperty(TestBedGlobals.EXP_STATE,
					TestBedGlobals.EXP_STATE_VALUE.RELEASEED);
		} else if (type.equals("rejected")) {
			filter.addProperty(TestBedGlobals.EXP_STATE,
					TestBedGlobals.EXP_STATE_VALUE.REJECTED);
		} 
		
		
		Iterator it = factory.exps(filter);
		pageCnt = factory.getExpCnt(filter) / TestBedGlobals.PAGE_SIZE;
		contentCntInPage = TestBedGlobals.PAGE_SIZE;
		while (it.hasNext()) {
			contentCntInPage--;
			exps.add((Experiment) it.next());
		}
		
		for (int i = 0; i < contentCntInPage; i++) {
			appendList.add(0);
		}
		
		return SUCCESS;
	}

}
