package org.apache.struts.helloworld.action;

import java.io.BufferedReader;
import java.io.StringReader;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.testbed.Authorization;
import com.testbed.AuthorizationFactory;
import com.testbed.Experiment;
import com.testbed.PhyMachine;
import com.testbed.TestBedFactory;
import com.testbed.VirtualRouter;
import com.testbed.VrCodeAndPmCode;
import com.testbed.database.DbTestBedFactory;
import com.testbed.database.TestBedGlobals;
import com.util.Communication;
import com.util.PageUtils;

public class JSONOfferExperiment extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String json; 
	private int expID;
	
	public int getExpID() {
		return expID;
	}

	public void setExpID(int expID) {
		this.expID = expID;
	}

	public String getJson() {
		return json;
	}

	public void setJson(String json) {
		this.json = json;
	}

	public String execute() throws Exception {
		//send the data to create a new VR,N = new a VR
		
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
		
		System.out.println(json);
		
		JSONArray jsonArray = null ; 
		JSONObject jsonObject;
		VrCodeAndPmCode value;
		try{  
	        //将json字符串转化为JsonArray对象  
			jsonArray = JSONArray.fromObject(json); 
			System.out.println(jsonArray);
			for (int i = 0; i < jsonArray.size(); i++) {
				String data="N\n";
				jsonObject = jsonArray.getJSONObject(i);
				value = (VrCodeAndPmCode) JSONObject.toBean(jsonObject, VrCodeAndPmCode.class);
				System.out.println("<-----------------------vrCode and pmCode----------------->");
				System.out.println(value.getCode());
				System.out.println(value.getPmID());
				PhyMachine pm = factory.getPM(value.getPmID());
				Experiment exp = factory.getExp(expID);
				exp.setExpState(TestBedGlobals.EXP_STATE_VALUE.EXPERIMENTING.ordinal());
				exp.saveToDb();
				
				
				VirtualRouter vr = factory.getVR(exp.getCode2ID().get(value.getCode()));
				
				vr.setPhyID(pm.getId());
				
				pm.addVR(vr);
				
				
				
				
				// 调用创建路由器的脚本
				
				Communication com = new Communication();
				data = data + vr.getId()+"\n";
				com.sendTo(pm.getIp(), data);
				Thread.sleep(50000);
				System.out.println("JSONOfferExperiment--------> data = " + data);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}

}


