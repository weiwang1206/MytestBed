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
import com.testbed.database.DbTestBedFactory;
import com.testbed.database.TestBedGlobals;
import com.util.PageUtils;

public class ApplicationsListAction extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ArrayList<Experiment> exps = new ArrayList<Experiment>();
	private int pageIndex = -1;
	private int pageCnt;
	private String userName="����δ��¼";
	
	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
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
		
		request = ServletActionContext.getRequest ();
		response = ServletActionContext.getResponse();
		
		//�õ��û���Ȩ��
		authToken = PageUtils.getUserAuthorization(request, response);
		
		if (authToken == null) {
			// ͨ������AuthorizationFactory�ľ�̬����getAnonymousAuthorization()
			// ��ÿ������߱���Ȩ��
			authToken = AuthorizationFactory.getAnonymousAuthorization();
		} else {
			userName = PageUtils.getUserName(request);
		}
		
		TestBedFactory factory = DbTestBedFactory.getInstance(authToken);
		/** 
		 * ����Filter��ȡ�õ� pageIndexҳ������
		 */
		ResultFilter filter = ResultFilter.createDefaultExpFilter();
		filter.setStartIndex(pageIndex * TestBedGlobals.PAGE_SIZE);
		filter.setNumResults(TestBedGlobals.PAGE_SIZE);
		
		
		filter.addProperty(TestBedGlobals.EXP_STATE,
				TestBedGlobals.EXP_STATE_VALUE.APPLYING);
		
		Iterator it = factory.exps(filter);
		
		pageCnt = factory.getExpCnt(filter) / TestBedGlobals.PAGE_SIZE;
		System.out.println("ApplicationsListAction pageCnt------------------------------------->" + pageCnt);
		while (it.hasNext()) {
			exps.add((Experiment) it.next());
		}
		
		return SUCCESS;
	}


}
