package org.apache.struts.helloworld.action;

import java.io.PrintWriter;
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
import com.testbed.PhyMachine;
import com.testbed.TestBedFactory;
import com.testbed.database.DbTestBedFactory;
import com.testbed.database.TestBedGlobals;
import com.util.PageUtils;

public class JSONPhyMachineInfo extends ActionSupport{

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
			
			//�õ��û���Ȩ��
			Authorization authToken = PageUtils.getUserAuthorization(request, response);
			
			if (authToken == null) {
				// ͨ������AuthorizationFactory�ľ�̬����getAnonymousAuthorization()
				// ��ÿ������߱���Ȩ��
				authToken = AuthorizationFactory.getAnonymousAuthorization();
			}
			
			TestBedFactory factory=DbTestBedFactory.getInstance(authToken);


			// �����ַ���
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			
			JSONObject json = new JSONObject();
			
			PhyMachine pm = factory.getPM(id);
			
			Map map = new HashMap(); 
			map.put("CPUUseage", pm.getCpuUsage()*100 );
			map.put("MemUseage", pm.getMemUsage()*100 );
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
	
}
