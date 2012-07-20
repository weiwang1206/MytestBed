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
import com.testbed.VirtualRouter;
import com.testbed.database.DbTestBedFactory;
import com.testbed.database.TestBedGlobals;
import com.util.PageUtils;

public class RouterSInfoAction extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int pageIndex;
	private String type;
	private int pageCnt;
	private int id;	// Experiment id
	private int expID;
	private String expName;
	private ArrayList<VirtualRouter> vrs = new ArrayList<VirtualRouter>();
	
	
	public int getExpID() {
		return expID;
	}

	public void setExpID(int expID) {
		this.expID = expID;
	}

	public String getExpName() {
		return expName;
	}

	public void setExpName(String expName) {
		this.expName = expName;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getPageCnt() {
		return pageCnt;
	}

	public void setPageCnt(int pageCnt) {
		this.pageCnt = pageCnt;
	}

	public ArrayList<VirtualRouter> getVrs() {
		return vrs;
	}

	public void setVrs(ArrayList<VirtualRouter> vrs) {
		this.vrs = vrs;
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
		Experiment exp = factory.getExp(id);
		
		/** 
		 * 设置Filter，取得第 pageIndex页的内容
		 */
		ResultFilter filter = ResultFilter.createDefaultVrFilter();
		filter.setStartIndex(pageIndex * TestBedGlobals.PAGE_SIZE);
		filter.setNumResults(TestBedGlobals.PAGE_SIZE);
		
		
		expID = exp.getId();
		expName = exp.getExpName();
		vrs = exp.vrs(filter);
		pageCnt = exp.getVRCount(filter) / TestBedGlobals.PAGE_SIZE;

		return SUCCESS;
	}

}
