package org.apache.struts.helloworld.action;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.resultFilter.ResultFilter;
import com.testbed.Authorization;
import com.testbed.AuthorizationFactory;
import com.testbed.PhyMachine;
import com.testbed.TestBedFactory;
import com.testbed.database.DbTestBedFactory;
import com.testbed.database.TestBedGlobals;
import com.util.PageUtils;

public class JSONGetPmInfo extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int id;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
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


			// 设置字符集
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			
			JSONObject json = new JSONObject();
			System.out.println("in JSONGetPmInfo -------------id = " + id);
			PhyMachine pm = factory.getPM(id);
			Map map = new HashMap(); 
			if (pm == null) {
				map.put("isExist", 0);
			} else {
				/** 
				 * 设置Filter，取得第 pageIndex页的内容
				 */
				ResultFilter filter ;
				filter = ResultFilter.createDefaultVrFilter();
				
				map.put("isExist", 1);
				map.put("code", pm.getCode() );
				map.put("ip", pm.getIp() );
				map.put("cpu", pm.getCPU() );
				map.put("memory", pm.getMemory() );
				filter.addProperty(TestBedGlobals.VR_TYPE, TestBedGlobals.VR_TYPE_VALUE.VR_HIGN);
				map.put("HVRCount", pm.getVRCount(filter) );
				filter = ResultFilter.createDefaultVrFilter();
				filter.addProperty(TestBedGlobals.VR_TYPE, TestBedGlobals.VR_TYPE_VALUE.VR_LOW);
				map.put("LVRCount", pm.getVRCount(filter) );
				map.put("description", pm.getDescription());
				System.out.println("code------------>" + pm.getCode());
				System.out.println("ip------------>" + pm.getIp());
				System.out.println("LVRCount------------>" + pm.getVRCount(filter));
//				map.put("code", "pmss" );
//				map.put("ip", "255.255.255.255" );
//				map.put("HVRCount", 2 );
//				map.put("LVRCount", 3 );
			}
			
			
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

}
