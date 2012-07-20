package org.apache.struts.helloworld.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.testbed.Authorization;
import com.testbed.AuthorizationFactory;
import com.testbed.TestBedFactory;
import com.testbed.database.DbTestBedFactory;
import com.util.PageUtils;


public class CreateExperimentAction extends ActionSupport {
	
	private static final long serialVersionUID = 1L;
	private String expName;
	private String expDescription;
	private String method;
	private String expID="";
	public String getExpName() {
		return expName;
	}

	public void setExpName(String expName) {
		this.expName = expName;
	}

	public String getExpDescription() {
		return expDescription;
	}

	public void setExpDescription(String expDescription) {
		this.expDescription = expDescription;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public String getExpID() {
		return expID;
	}

	public void setExpID(String expID) {
		this.expID = expID;
	}

	public String execute() throws Exception {
		if (method.equals("create"))
		{
			System.out.println(expName);
			System.out.println(expDescription);
			expID="create";
			return SUCCESS;			
		}
		else if (method.equals("open"))
		{
			HttpServletRequest request = ServletActionContext.getRequest ();
			HttpServletResponse response = ServletActionContext.getResponse();
			
			//得到用户的权限
			Authorization authToken = PageUtils.getUserAuthorization(request, response);
			
			if (authToken == null) {
				// 通过工厂AuthorizationFactory的静态方法getAnonymousAuthorization()
				// 获得客人所具备的权限
				authToken = AuthorizationFactory.getAnonymousAuthorization();
			}
			
			TestBedFactory factory=DbTestBedFactory.getInstance(authToken);
			
			if (!expID.equals(""))
			{
				PageUtils.saveExpID(request, response, Integer.parseInt(expID));
				expName=factory.getExp(Integer.parseInt(expID)).getExpName();
				PageUtils.saveExpName(request, response, expName);
				System.out.println(expID);
			}
			else
			{
				int expid = PageUtils.getExpID(request, response);
				if (expid != -1)
					expName=factory.getExp(expid).getExpName();
				else
					expID="create";
			}
			
			return SUCCESS;
		}
		
		return SUCCESS;
	}
	
}