package org.apache.struts.helloworld.action;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.resultFilter.ResultFilter;
import com.testbed.Authorization;
import com.testbed.AuthorizationFactory;
import com.testbed.Experiment;
import com.testbed.Port;
import com.testbed.RouterTableItem;
import com.testbed.TestBedFactory;
import com.testbed.VirtualRouter;
import com.testbed.database.DbTestBedFactory;
import com.testbed.database.TestBedGlobals;
import com.util.PageUtils;

public class JSONPortDataForWebAction extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String [] VRId;//将一系列的vid和portID一起传过来
	private String [] portId;//0,1,2,3
	private String vid;
	private String port;
	private String cases;
	public String execute() throws Exception {
		
		try {
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

			System.out.println(vid);
			System.out.println(port);
			
			Map<String, Float> map = new HashMap<String, Float>();
			
			if (cases.equals("exp"))
			{
				int expID=PageUtils.getExpID(request, response);
				
				//debug
				//int expID=1;
				Experiment exp = factory.getExp(expID);
				
				
				VRId =vid.split(",");
				portId = port.split(",");
				
				
				
				float flow;
				for (int i = 0; i < VRId.length; i++)
				{
					if (!VRId[i].equals(""))
					{
						//将code 转化为 ID 再获取VR
						int id = exp.getCode2ID().get(Integer.parseInt(VRId[i]));
						Port port = factory.getVR(id).getPort(Integer.parseInt(portId[i]));
						if (port != null)
						{
							flow = port.getFlow();
						}
						else
						{
							flow = (float)1.0;
						}
						map.put("VR"+(i+1), flow );
					}
					else
					{
						map.put("VR"+(i+1), (float)0);
					}
						
				}
			}
			else if (cases.equals("admin"))
			{
				VRId =vid.split(",");
				portId = port.split(",");
				
				
				
				float flow;
				for (int i = 0; i < VRId.length; i++)
				{
					if (!VRId[i].equals(""))
					{
						//将code 转化为 ID 再获取VR
					
						Port port = factory.getVR(Integer.parseInt(VRId[i])).getPort(Integer.parseInt(portId[i]));
						if (port != null)
						{
							flow = port.getFlow();
						}
						else
						{
							flow = (float)0.0;
						}
						map.put("VR"+(i+1), flow );
					}
					else
					{
						map.put("VR"+(i+1), (float)0);
					}
						
				}
			}
			
			
			
			System.out.println(map);
			// 设置字符集
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			
			JSONObject json = new JSONObject();
			
			//VirtualRouter vr = factory.getVR(vid);
			//Port port = vr.getPort(portId);
			//Map<String, Float> map = new HashMap<String, Float>(); 
			//map.put("flow", (port.getFlow()) );
			
			json = JSONObject.fromObject( map ); 
			
			// 直接输入响应的内容
			out.println(json);
			//System.out.println(json);
			/** 格式化输出时间 **/
			out.flush();
			out.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return null;
	}
	public String[] getVRId() {
		return VRId;
	}
	public void setVRId(String[] vRId) {
		VRId = vRId;
	}
	public String[] getPortId() {
		return portId;
	}
	public void setPortId(String[] portId) {
		this.portId = portId;
	}
	public String getVid() {
		return vid;
	}
	public void setVid(String vid) {
		this.vid = vid;
	}
	public String getPort() {
		return port;
	}
	public void setPort(String port) {
		this.port = port;
	}
	public void setCases(String cases) {
		this.cases = cases;
	}
	public String getCases() {
		return cases;
	}

	

}
