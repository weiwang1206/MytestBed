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
import com.testbed.RouterTableItem;
import com.testbed.TestBedFactory;
import com.testbed.VirtualRouter;
import com.testbed.database.DbRouterTableItem;
import com.testbed.database.DbTestBedFactory;
import com.testbed.database.TestBedGlobals;
import com.util.PageUtils;

public class VRDataForWebAction extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int vid;
	private VirtualRouter vr;
	private ArrayList<Integer> vrList = new ArrayList<Integer>();
	private int expId;
	private String expName;
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
			// TO DO 通过session 获得expID
			
			
			expId = PageUtils.getExpID(request, response);
			//for debug
			//expId = 1;
			setExpName(factory.getExp(expId).getExpName());
			//change code to id
			int id = factory.getExp(expId).getCode2ID().get(vid);
			vr=factory.getVR(id);
			
			//for debug
			//RouterTableItem rti1=factory.createRouterItem("C", "10.21.2.10", "10.21.2.9", "eth0");
			//RouterTableItem rti2=factory.createRouterItem("O", "10.21.2.8", "192.168.1.1", "eth0");

			//vr.addRouterTableItem(rti1);
			//vr.addRouterTableItem(rti2);
			
			//router list (just high router)
			vrList.clear();
			setVrList(factory.getExp(expId).getHighCodeID());
			
			//for debug
			/*vrList.clear();
			vrList.add(0);
			vrList.add(1);
			vrList.add(2);
			vrList.add(3);*/
			
			return SUCCESS;
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return null;
	}


	public int getVid() {
		return vid;
	}


	public void setVid(int vid) {
		this.vid = vid;
	}


	public void setVr(VirtualRouter vr) {
		this.vr = vr;
	}


	public VirtualRouter getVr() {
		return vr;
	}


	public void setVrList(ArrayList<Integer> vrList) {
		this.vrList = vrList;
	}


	public ArrayList<Integer> getVrList() {
		return vrList;
	}


	public void setExpName(String expName) {
		this.expName = expName;
	}


	public String getExpName() {
		return expName;
	}

	
	
}
