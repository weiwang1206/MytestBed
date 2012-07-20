package org.apache.struts.helloworld.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.resultFilter.ResultFilter;
import com.testbed.Authorization;
import com.testbed.AuthorizationFactory;
import com.testbed.TestBedFactory;
import com.testbed.VirtualRouter;
import com.testbed.Port;
import com.testbed.database.DbTestBedFactory;
import com.util.PageUtils;

public class VirtualRouterAction extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private VirtualRouter vr;
	private int portCount;
	private ArrayList<Port> ports = new ArrayList<Port>();
	
	
	public int getPortCount() {
		return portCount;
	}
	public void setPortCount(int portCount) {
		this.portCount = portCount;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public VirtualRouter getVr() {
		return vr;
	}
	public void setVr(VirtualRouter vr) {
		this.vr = vr;
	}
	public ArrayList<Port> getPorts() {
		return ports;
	}
	public void setPorts(ArrayList<Port> ports) {
		this.ports = ports;
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

		vr = factory.getVR(id);
		
		ports = vr.ports();
		portCount = vr.getPortCount();
		
		return SUCCESS;
	}

}
