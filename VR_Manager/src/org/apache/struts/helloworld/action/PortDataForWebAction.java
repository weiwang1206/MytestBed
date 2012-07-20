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
import com.testbed.database.DbTestBedFactory;
import com.testbed.database.TestBedGlobals;
import com.util.PageUtils;

public class PortDataForWebAction extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
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
			
			
			//***************************//
			// TO DO 通过session 获得expID
			
			
			expId = PageUtils.getExpID(request, response);
			
			//for debug
			//expId = 1;
			
			//code id
			setVrList(factory.getExp(expId).getHighCodeID());
			
			setExpName(factory.getExp(expId).getExpName());
			//for debug
			//vrList.clear();
			//vrList.add(0);
			//vrList.add(1);
			//vrList.add(2);
			//vrList.add(3);
			
			return SUCCESS;
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return null;
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
