package org.apache.struts.helloworld.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.testbed.Authorization;
import com.testbed.AuthorizationFactory;
import com.testbed.TestBedFactory;
import com.testbed.User;
import com.testbed.database.DbTestBedFactory;
import com.testbed.database.TestBedGlobals;
import com.util.PageUtils;

public class SaveUserInfoActoin extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	private String name;
	private String email;
	private String telephone;
	private String province;
	private String city;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	
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
		User user = factory.getUserManager().getUser(authToken.getUserID());
		System.out.println(name);
		if (!user.getName().equals(name)) {
			user.setName(name);
		}
		if (!user.getEmail().equals(email)) {
			user.setEmail(email);
		}
		if (!user.getProvince().equals(province)) {
			user.setProvince(province);
		}
		if (!user.getCity().equals(city)) {
			user.setCity(city);
		}
		if (!user.getTelephone().equals(telephone)) {
			user.setTelephone(telephone);
		}
		
		user.saveToDb();
		
		if (user.getUserLevel() != 
			TestBedGlobals.USER_LEVEL_VALUE.ADMINISTRATOR.ordinal()) {
			return "successForExperimenter";
		}
		return SUCCESS;
	}

}
