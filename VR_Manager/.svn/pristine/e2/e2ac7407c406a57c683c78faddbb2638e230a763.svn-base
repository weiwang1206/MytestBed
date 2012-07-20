package org.apache.struts.helloworld.action;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.resultFilter.ResultFilter;
import com.testbed.Authorization;
import com.testbed.AuthorizationFactory;
import com.testbed.Experiment;
import com.testbed.PhyMachine;
import com.testbed.TestBedFactory;
import com.testbed.VirtualRouter;
import com.testbed.database.DbTestBedFactory;
import com.testbed.database.TestBedGlobals;
import com.util.PageUtils;

public class VirtualRouterListAction extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int pageIndex = -1;
	private int pageCnt;
	List pmCodeList = new ArrayList<String>();
	List portCntList = new ArrayList<Integer>();
	List experimenterList = new ArrayList<String>();
	List experimentNameList = new ArrayList<String>();
	private ArrayList<VirtualRouter> vrList = new ArrayList<VirtualRouter>();
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
	public ArrayList<VirtualRouter> getVrList() {
		return vrList;
	}
	public void setVrList(ArrayList<VirtualRouter> vrList) {
		this.vrList = vrList;
	}
	

	public List getPmCodeList() {
		return pmCodeList;
	}
	public void setPmCodeList(List pmCodeList) {
		this.pmCodeList = pmCodeList;
	}
	public List getPortCntList() {
		return portCntList;
	}
	public void setPortCntList(List portCntList) {
		this.portCntList = portCntList;
	}
	public List getExperimenterList() {
		return experimenterList;
	}
	public void setExperimenterList(List experimenterList) {
		this.experimenterList = experimenterList;
	}
	public List getExperimentNameList() {
		return experimentNameList;
	}
	public void setExperimentNameList(List experimentNameList) {
		this.experimentNameList = experimentNameList;
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
		ResultFilter filter = ResultFilter.createDefaultVrFilter();
		filter.setStartIndex(pageIndex * TestBedGlobals.PAGE_SIZE);
		filter.setNumResults(TestBedGlobals.PAGE_SIZE);

		Iterator it = factory.vrs(filter);
		
		
		pageCnt = factory.getVrCnt(filter) / TestBedGlobals.PAGE_SIZE;
		while (it.hasNext()) {
			VirtualRouter vr = (VirtualRouter) it.next();
			vrList.add(vr);
			
			pmCodeList.add(vr.getPM().getCode());
			portCntList.add(vr.getPortCount());
			Experiment expTmp = vr.getExperiment();
			experimenterList.add(expTmp.getUser().getName());
			experimentNameList.add(expTmp.getExpName());
		}
		
		System.out.println(portCntList.toString());
		System.out.println("pageCnt------------->" + pageCnt);
		System.out.println("pageIndex------------->" + pageIndex);
		
		return SUCCESS;
	}
}
