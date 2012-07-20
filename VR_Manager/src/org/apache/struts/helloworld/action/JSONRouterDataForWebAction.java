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

public class JSONRouterDataForWebAction extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	private String vid;
	
	public String execute() throws Exception {
		
		try {
			HttpServletRequest request = ServletActionContext.getRequest ();
			HttpServletResponse response = ServletActionContext.getResponse();
			
			//�õ��û���Ȩ��
			Authorization authToken = PageUtils.getUserAuthorization(request, response);
			
			if (authToken == null) {
				// ͨ������AuthorizationFactory�ľ�̬����getAnonymousAuthorization()
				// ��ÿ������߱���Ȩ��
				authToken = AuthorizationFactory.getAnonymousAuthorization();
			}
			
			TestBedFactory factory=DbTestBedFactory.getInstance(authToken);

			
			int expID=PageUtils.getExpID(request, response);
			
			//debug
			//int expID=1;
			Experiment exp = factory.getExp(expID);
			
			int id = exp.getCode2ID().get(vid);
			
			
			VirtualRouter vr =  factory.getVR(id);
			
			ArrayList routerTable = vr.getRouterTable();
			
			
			Map<String, ArrayList> map = new HashMap<String, ArrayList>();
			
		
			map.put("routerTable", routerTable);
			
			// �����ַ���
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			
			JSONObject json = new JSONObject();
			
			json = JSONObject.fromObject( map ); 
			
			// ֱ��������Ӧ������
			out.println(json);
			//System.out.println(json);
			/** ��ʽ�����ʱ�� **/
			out.flush();
			out.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return null;
	}
	
	public String getVid() {
		return vid;
	}
	public void setVid(String vid) {
		this.vid = vid;
	}
	
	

}
