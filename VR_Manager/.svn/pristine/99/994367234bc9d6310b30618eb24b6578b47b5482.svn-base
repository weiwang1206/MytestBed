package org.apache.struts.helloworld.action;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Date;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.testbed.Authorization;
import com.testbed.AuthorizationFactory;
import com.testbed.PhyMachine;
import com.testbed.TestBedFactory;
import com.testbed.database.DbTestBedFactory;
import com.util.PageUtils;

public class UpdatePMRealData extends ActionSupport {

	private static final long serialVersionUID = 1L;

	
	Socket socket;
	PrintWriter out;
	BufferedReader in;
	
	
	
	private String phyId;
	
	
	private String cpuUsage;
	private String memUsage;
	
	
	

	public String execute() throws Exception {
		
		//messageStore = new MessageStore() ;
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

		PhyMachine pm = factory.getPM(Integer.parseInt(phyId));
		
		String []mem = memUsage.split(" ");
		float memU = Float.parseFloat(mem[1])/Float.parseFloat(mem[0]);
		System.out.println(cpuUsage);
		System.out.println(memU);
		pm.update(Float.parseFloat(cpuUsage)*(float)0.1, memU, new Date(System.currentTimeMillis()));
		/*if (type.equals("machine"))
		{
			
		}
		else if (type.equals("router"))
	
			
		}
		else if (type.equals("port"))
		{
			
		}*/
		
		//clientTest("10.21.2.10");
		
		
		return SUCCESS;
	}
	
	
	
	

	public String getPhyId() {
		return phyId;
	}

	public void setPhyId(String phyId) {
		this.phyId = phyId;
	}

	
	public String getCpuUsage() {
		return cpuUsage;
	}

	public void setCpuUsage(String cpuUsage) {
		this.cpuUsage = cpuUsage;
	}

	public String getMemUsage() {
		return memUsage;
	}

	public void setMemUsage(String memUsage) {
		this.memUsage = memUsage;
	}


	
	
}