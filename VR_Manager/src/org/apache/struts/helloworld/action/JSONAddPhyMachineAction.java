package org.apache.struts.helloworld.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.testbed.Authorization;
import com.testbed.AuthorizationFactory;
import com.testbed.PhyMachine;
import com.testbed.TestBedFactory;
import com.testbed.UnauthorizedException;
import com.testbed.database.DbTestBedFactory;
import com.util.PageUtils;

public class JSONAddPhyMachineAction extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String code;
	private String ip;
	private String description;
	private float cpu;
	private float memory;
	private int pmID;
	
	
	
	public float getCpu() {
		return cpu;
	}
	public void setCpu(float cpu) {
		this.cpu = cpu;
	}
	public float getMemory() {
		return memory;
	}
	public void setMemory(float memory) {
		this.memory = memory;
	}
	public int getPmID() {
		return pmID;
	}
	public void setPmID(int pmID) {
		this.pmID = pmID;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
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
		
		PhyMachine pm = factory.getPM(pmID);
		if (pm == null) {
			System.out.println("create pm");
			pm = factory.createPM(pmID, ip, description, code);
			pm.setCPU(cpu);
			pm.setMemory(memory);
			pm.saveToDb();
		} else {
			System.out.println("update pm");
			pm.setDescription(description);
			pm.setIp(ip);
			pm.setCPU(cpu);
			pm.setMemory(memory);
			pm.setCode(code);
			pm.saveToDb();
		}
		//创建了PM需不需要add到factory上
		
		return null;
	}

}
