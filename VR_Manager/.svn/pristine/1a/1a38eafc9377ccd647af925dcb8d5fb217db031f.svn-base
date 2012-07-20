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
import com.testbed.TestBedFactory;
import com.testbed.PhyMachine;
import com.testbed.database.DbTestBedFactory;
import com.testbed.database.TestBedGlobals;
import com.util.PageUtils;

public class PhysicalMachineListAction extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int pageIndex = -1;
	private int pageCnt;
	private ArrayList<PhyMachine> pms = new ArrayList<PhyMachine>();
	
	
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


	public ArrayList<PhyMachine> getPms() {
		return pms;
	}


	public void setPms(ArrayList<PhyMachine> pms) {
		this.pms = pms;
	}


	public String execute() throws Exception {
		
		HttpServletRequest request;
		HttpServletResponse response;
		Authorization authToken;
		
		
		if (pageIndex == -1) {
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

		/** 
		 * 设置Filter，取得第 pageIndex页的内容
		 */
		ResultFilter filter = ResultFilter.createDefaultPmFilter();
		filter.setStartIndex(pageIndex * TestBedGlobals.PAGE_SIZE);
		filter.setNumResults(TestBedGlobals.PAGE_SIZE);

		Iterator it = factory.pms(filter);
		pageCnt = factory.getPmCnt(filter) / TestBedGlobals.PAGE_SIZE;
		while (it.hasNext()) {
			pms.add((PhyMachine) it.next());
		}
		
		System.out.println("pageCnt------------->" + pageCnt);
		System.out.println("pageIndex------------->" + pageIndex);
		return SUCCESS;
	}

}
