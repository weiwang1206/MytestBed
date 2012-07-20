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
import com.testbed.Experiment;
import com.testbed.Port;
import com.testbed.TestBedFactory;
import com.testbed.VirtualRouter;
import com.testbed.database.DbTestBedFactory;
import com.util.PageUtils;


public class OpenExperimentAction extends ActionSupport {
	
	private static final long serialVersionUID = 1L;
	private String XML;
	private String method;
	private String vrCode;
	private String expId;
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
		

			PrintWriter out = response.getWriter();
			
			JSONObject json = new JSONObject();
			
			Map<String,String> map = new HashMap<String,String>();
			
			int expID;
			
			if (method.equals("offer"))
			{
				expID=Integer.parseInt(expId);
				System.out.println("In openexperiment method is offer and id is "+expID);
			}
			else
			{
				expID = PageUtils.getExpID(request, response);
				
			}
			
			
			
			//int expID=1;
			Experiment exp = factory.getExp(expID);
			
			if (method.equals("xml") || method.equals("offer"))
			{
				XML=exp.getTopoXML();
				System.out.println(factory.getExp(expID).getExpName());
				map.put("XML", XML);
				System.out.println(XML);
				json = JSONObject.fromObject( map ); 
				PageUtils.saveExpID(request, response, expID);
			}
			else
			{
				int id = exp.getCode2ID().get(Integer.parseInt(vrCode));
				VirtualRouter vr=factory.getVR(id);
				if (vr.getPhyID()==19)
				{
					map.put("exists", "no");
				}
				else
				{
					map.put("vid", vrCode);
					map.put("exists", "yes");
					for (int i = 0; i < 4; i++)
					{
						Port port = vr.getPort(i);
						String ip="",ospf="";
						if (port != null)
						{
							ip = port.getIp();
							ospf = port.getOspf();
						}
						map.put("portIP"+i, ip);
						map.put("portOSPF"+i, ospf);
						
					}
					 
				}
				json = JSONObject.fromObject( map );
				
			}
			
			// 直接输入响应的内容
			out.println(json);
			//System.out.println(json);
			/** 格式化输出时间 **/
			out.flush();
			out.close();
			
			
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
	public void setVrCode(String vrCode) {
		this.vrCode = vrCode;
	}
	public String getVrCode() {
		return vrCode;
	}
	public void setExpId(String expId) {
		this.expId = expId;
	}
	public String getExpId() {
		return expId;
	}
	

}