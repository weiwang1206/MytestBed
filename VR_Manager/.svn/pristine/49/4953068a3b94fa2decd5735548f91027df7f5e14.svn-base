package org.apache.struts.helloworld.action;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.testbed.Authorization;
import com.testbed.AuthorizationFactory;
import com.testbed.Port;
import com.testbed.TestBedFactory;
import com.testbed.database.DbTestBedFactory;
import com.util.Communication;
import com.util.PageUtils;


public class ConfigureRouterAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String IDArray;
	private String configArray;
	private String portArray;
	private String expID;
	private String userID;
	private String[] routerID;
	private String[] routerConfig;
	private String[] portID;
	private int vrHighNum,vrLowNum;
	Socket socket;
	PrintWriter out;
	BufferedReader in;
	TestBedFactory factory;
	
	public String execute() throws Exception {
		
		try {
			HttpServletRequest request;
			HttpServletResponse response;
			Authorization authToken;
			
			request = ServletActionContext.getRequest ();
			response = ServletActionContext.getResponse();
			
			//得到用户的权限
			int expID = PageUtils.getExpID(request, response);
			authToken = PageUtils.getUserAuthorization(request, response);
			
			if (authToken == null) {
				// 通过工厂AuthorizationFactory的静态方法getAnonymousAuthorization()
				// 获得客人所具备的权限
				authToken = AuthorizationFactory.getAnonymousAuthorization();
			}
			
			factory=DbTestBedFactory.getInstance(authToken);
			
			System.out.println(IDArray);
			System.out.println(configArray);
			
			setRouterID(IDArray.split(","));
			setRouterConfig(configArray.split(","));
			setPortID(portArray.split(","));
			
			String data = null;
			Communication com = new Communication();
			
			System.out.println(vrHighNum);
			
			int index = 0;
			String []ID =new String[vrHighNum];
			ID[index] = routerID[0];
			int [] IDLength = new int[vrHighNum];
			IDLength[index] = 1;
			for (int i = 1;i<routerID.length;i++)
			{
				if (!ID[index].equals(routerID[i]) )
				{
					index++;
					ID[index] = routerID[i];
					IDLength[index]=0;
				}
				IDLength[index]++;
			}
			
			int tmp = 0,vid;
			for (int j = 0; j <= index; j++)
			{
				vid = factory.getExp(expID).getCode2ID().get(Integer.parseInt(ID[j]));
				data = create(vid,tmp,IDLength[j]);	
				System.out.println(data);
				com.sendTo(factory.getVR(vid).getPM().getIp(), data);
				System.out.println("正在配置一台路由器......请稍后");
				Thread.sleep(5000);
				System.out.println("完成配置");
				tmp = tmp + IDLength[j];
			}

		
			//1：发送给实际路由器，进行配置 2：更新对应的实验的数据库，包括exp、router、port
			//?实验ID怎么获取，客户端没有记录ID
			//配置时怎么对应哪个路由器
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		return null;
	}
	//生成配置字符串给机器，并且添加port在后台
	public String create(int id,int index,int length)
	{
		String data,ethNum,ip,ospf;
		//C means config the router
		data = "C\n"+id + "\n";
		//String data="<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>";
		for (int i = 0;i<length/2;i++)
		{
			ethNum = "eth"+portID[index];
			data=data+ethNum+"\n";
			
			//System.out.println(data);
			//System.out.println(routerConfig[index]);
			ip = routerConfig[index++];
			data=data+ip+"\n";
			ospf = routerConfig[index++];
			if (i == (length/2 -1))
			{
				data=data+ospf;
			}
			else
			{
				data=data+ospf+"\n";
			}
			
			Port port;
			port = factory.getVR(id).getPort(Integer.parseInt(portID[index-2]));
			if (port == null)
			{
				port = factory.createProt(factory.getVR(id),Integer.parseInt(portID[index-2]), ip, ospf);
				factory.getVR(id).addPort(port, Integer.parseInt(portID[index-2]));
			}
			else
			{
				port.setIp(ip);
				port.setOspf(ospf);
				port.saveToDb();
		
			}
		}
		return data;
		
	}
	
	public void setIDArray(String iDArray) {
		IDArray = iDArray;
	}

	public String getIDArray() {
		return IDArray;
	}

	public void setConfigArray(String configArray) {
		this.configArray = configArray;
	}

	public String getConfigArray() {
		return configArray;
	}
	public void setRouterID(String[] routerID) {
		this.routerID = routerID;
	}
	public String[] getRouterID() {
		return routerID;
	}
	public void setRouterConfig(String[] routerConfig) {
		this.routerConfig = routerConfig;
	}
	public String[] getRouterConfig() {
		return routerConfig;
	}
	public void setExpID(String expID) {
		this.expID = expID;
	}
	public String getExpID() {
		return expID;
	}

	public void setVrHighNum(int vrHighNum) {
		this.vrHighNum = vrHighNum;
	}

	public int getVrHighNum() {
		return vrHighNum;
	}

	public void setVrLowNum(int vrLowNum) {
		this.vrLowNum = vrLowNum;
	}

	public int getVrLowNum() {
		return vrLowNum;
	}

	public void setPortArray(String portArray) {
		this.portArray = portArray;
	}

	public String getPortArray() {
		return portArray;
	}

	public void setPortID(String[] portID) {
		this.portID = portID;
	}

	public String[] getPortID() {
		return portID;
	}
	
	
}




	
	



