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
import com.testbed.RouterTableItem;
import com.testbed.TestBedFactory;
import com.testbed.VirtualRouter;
import com.testbed.database.DbTestBedFactory;
import com.util.PageUtils;

public class UpdateVRRealData extends ActionSupport {

	private static final long serialVersionUID = 1L;

	
	Socket socket;
	PrintWriter out;
	BufferedReader in;
	//High router or Low router
	private String state;
	private String type;
	private String vid;
	
	private String routeTable;
	private String flow1;
	private String flow2;
	private String flow3;
	private String flow4;
	
	

	public String execute() throws Exception {
		
		//messageStore = new MessageStore() ;
		/*HttpServletRequest request = ServletActionContext.getRequest ();
		BufferedReader br = new BufferedReader(new InputStreamReader((ServletInputStream)request.getInputStream()));  
        String line = null;  
        StringBuilder sb = new StringBuilder();  
        while((line = br.readLine())!=null){  
            sb.append(line);  
        }  
        System.out.println(vid);
		System.out.println(flow1);
		System.out.println(flow2);
		System.out.println(flow3);
		System.out.println(flow4);
		System.out.println(routeTable);
		*/
	
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
		VirtualRouter vr= factory.getVR(Integer.parseInt(vid));
		
		//清空原来的路由表
		vr.deleteRouterTable();
		
		String []ri = routeTable.split(";");
		//添加新的路由表
		for (int i = 0; i< ri.length; i++)
		{
			String [] rti = ri[i].split(" ");
			RouterTableItem routerTableItem=factory.createRouterItem(rti[0], rti[1], rti[2], rti[3]);
			vr.addRouterTableItem(routerTableItem);
		}
		
		
		//更新流量
		long now = System.currentTimeMillis();
		Date time = new Date(now);
		if (vr.getPort(0)!=null)
			vr.getPort(0).updateFlow(Float.parseFloat(flow1), time);
		if (vr.getPort(1)!=null)
			vr.getPort(1).updateFlow(Float.parseFloat(flow2), time);
		if (vr.getPort(2)!=null)
			vr.getPort(2).updateFlow(Float.parseFloat(flow3), time);
		if (vr.getPort(3)!=null)
			vr.getPort(3).updateFlow(Float.parseFloat(flow4), time);
		
		
		

		
		
		return SUCCESS;
	}
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}



	public String getRouteTable() {
		return routeTable;
	}

	public void setRouteTable(String routeTable) {
		this.routeTable = routeTable;
	}

	public void setFlow1(String flow1) {
		this.flow1 = flow1;
	}

	public String getFlow1() {
		return flow1;
	}

	public void setFlow2(String flow2) {
		this.flow2 = flow2;
	}

	public String getFlow2() {
		return flow2;
	}

	public void setFlow3(String flow3) {
		this.flow3 = flow3;
	}

	public String getFlow3() {
		return flow3;
	}

	public void setFlow4(String flow4) {
		this.flow4 = flow4;
	}

	public String getFlow4() {
		return flow4;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getState() {
		return state;
	}

	public void setVid(String vid) {
		this.vid = vid;
	}

	public String getVid() {
		return vid;
	}
	
	
}