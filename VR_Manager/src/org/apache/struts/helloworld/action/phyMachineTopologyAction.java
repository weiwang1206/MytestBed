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
import com.testbed.PhyMachine;
import com.testbed.TestBedFactory;
import com.testbed.database.DbTestBedFactory;
import com.util.PageUtils;

public class phyMachineTopologyAction extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ArrayList<PhyMachine> pms = new ArrayList<PhyMachine>();
	
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
		
		request = ServletActionContext.getRequest ();
		response = ServletActionContext.getResponse();
		
		//�õ��û���Ȩ��
		authToken = PageUtils.getUserAuthorization(request, response);
		
		if (authToken == null) {
			// ͨ������AuthorizationFactory�ľ�̬����getAnonymousAuthorization()
			// ��ÿ������߱���Ȩ��
			authToken = AuthorizationFactory.getAnonymousAuthorization();
		}
		
		TestBedFactory factory=DbTestBedFactory.getInstance(authToken);
		/** 
		 * ����Filter��ȡ�õ� pageIndexҳ������
		 */
		ResultFilter filter = ResultFilter.createDefaultPmFilter();
		Iterator it = factory.pms(filter);
		while (it.hasNext()) {
			pms.add((PhyMachine) it.next());
		}
		return SUCCESS;
	}

}
