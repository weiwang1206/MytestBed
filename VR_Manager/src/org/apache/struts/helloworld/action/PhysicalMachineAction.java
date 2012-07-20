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
import com.testbed.UserManager;
import com.testbed.VirtualRouter;
import com.testbed.database.DbTestBedFactory;
import com.testbed.database.TestBedGlobals;
import com.util.PageUtils;

public class PhysicalMachineAction extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private PhyMachine pm;
	private ArrayList<VirtualRouter> vrs = new ArrayList<VirtualRouter>();
	
	
	public ArrayList<VirtualRouter> getVrs() {
		return vrs;
	}
	public void setVrs(ArrayList<VirtualRouter> vrs) {
		this.vrs = vrs;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public PhyMachine getPm() {
		return pm;
	}
	public void setPm(PhyMachine pm) {
		this.pm = pm;
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

		pm = factory.getPM(id);
		System.out.println("pm.code-------->" + pm.getCode());
		ResultFilter filter = ResultFilter.createDefaultVrFilter();
		vrs = pm.vrs(filter);
		System.out.println("vrs.size()-------->" + vrs.size());
//		while (it.hasNext()) {
//			vrs.add((VirtualRouter) it.next());
//		}
		return SUCCESS;
	}
}
