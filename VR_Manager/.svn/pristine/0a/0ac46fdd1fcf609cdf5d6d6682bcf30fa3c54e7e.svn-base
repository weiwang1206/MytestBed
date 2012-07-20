package org.apache.struts.helloworld.action;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ActionSupport;
import com.testbed.Authorization;
import com.testbed.AuthorizationFactory;
import com.testbed.TestBedFactory;
import com.testbed.TestBedTopologyXML;
import com.testbed.database.DbTestBedFactory;
import com.util.PageUtils;


public class LoadXMLTestAction extends ActionSupport {
	
	private static final long serialVersionUID = 1L;
	private String XML;
	private String method;
	public String execute() throws Exception {
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
		
		if (method.equals("store"))
		{
			BufferedReader br = new BufferedReader(new InputStreamReader((ServletInputStream)request.getInputStream()));  
	        String line = null;  
	        StringBuilder sb = new StringBuilder();  
	        while((line = br.readLine())!=null){  
	            sb.append(line);  
	        }  
	        XML = sb.toString();
	        TestBedTopologyXML topologyXML = factory.getTopologyXML();
	        topologyXML.setXml(XML);
	        topologyXML.saveToDb();
	        
			System.out.println(XML);		
		} else if (method.equals("loadTopologyXML")) {
			PrintWriter out = response.getWriter();
			
			JSONObject json = new JSONObject();
			System.out.println("in loadTopologyXML");
			Map<String,String> map = new HashMap<String,String>();
			
			XML=factory.getTopologyXML().getXml();
			map.put("XML", XML);
			System.out.println(XML);
			json = JSONObject.fromObject( map ); 
			
			// 直接输入响应的内容
			out.println(json);
			//System.out.println(json);
			/** 格式化输出时间 **/
			out.flush();
			out.close();
		}
		else
		{
			PrintWriter out = response.getWriter();
			
			JSONObject json = new JSONObject();
			
			Map<String,String> map = new HashMap<String,String>();
			
			int expID = PageUtils.getExpID(request, response);
			XML=factory.getExp(expID).getTopoXML();
			System.out.println(factory.getExp(expID).getExpName());
			map.put("XML", XML);
			System.out.println(XML);
			json = JSONObject.fromObject( map ); 
			
			// 直接输入响应的内容
			out.println(json);
			//System.out.println(json);
			/** 格式化输出时间 **/
			out.flush();
			out.close();
		}
		return null;
	}
	public void setXML(String xML) {
		XML = xML;
	}
	public String getXML() {
		return XML;
	}
	public String getMethod() {
		return method;
	}
	public void setMethod(String method) {
		this.method = method;
	}
	

}