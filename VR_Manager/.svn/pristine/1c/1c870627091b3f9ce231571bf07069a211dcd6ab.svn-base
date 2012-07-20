package org.apache.struts.helloworld.action;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.testbed.Authorization;
import com.testbed.AuthorizationFactory;
import com.testbed.Experiment;
import com.testbed.TestBedFactory;
import com.testbed.User;
import com.testbed.database.DbTestBedFactory;
import com.util.Cacheable;
import com.util.PageUtils;

public class ApplyExperimentAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	static private String XML;
	private String expName;
	private String expDescription;
	private String highNum;
	private String lowNum;
	private String highCodeID;
	private String lowCodeID;
	private ArrayList<Integer> highCodeIDArray = new ArrayList<Integer>();
	private ArrayList<Integer> lowCodeIDArray = new ArrayList<Integer>();
	private String userName="您尚未登录";
	
	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	

	public String execute() throws Exception {
		
		try {
		
			
				HttpServletRequest request = ServletActionContext.getRequest ();
				BufferedReader br = new BufferedReader(new InputStreamReader((ServletInputStream)request.getInputStream()));  
		        String line = null;  
		        StringBuilder sb = new StringBuilder();  
		        while((line = br.readLine())!=null){  
		            sb.append(line);  
		        }  
		        XML = sb.toString();
				
				System.out.println(XML);
				System.out.println(expName);
				System.out.println(expDescription);
				System.out.println(highNum);
				System.out.println(lowNum);
				System.out.println(highCodeID);
				System.out.println(lowCodeID);
				
				String [] highCodeTmp = highCodeID.split(",");
				String [] lowCodeTmp = lowCodeID.split(",");
				
				if (!highCodeTmp[0].equals(""))
				{
				for ( int i = 0; i< highCodeTmp.length;i++)
				{
					highCodeIDArray.add(Integer.parseInt(highCodeTmp[i]));
				}
				}
				
				if (!lowCodeTmp[0].equals(""))
				{
					for ( int i = 0; i< lowCodeTmp.length;i++)
					{
						lowCodeIDArray.add(Integer.parseInt(lowCodeTmp[i]));
					}
				}
				
				
				HttpServletResponse response = ServletActionContext.getResponse();
				
				//得到用户的权限
				Authorization authToken = PageUtils.getUserAuthorization(request, response);
				
				if (authToken == null) {
					// 通过工厂AuthorizationFactory的静态方法getAnonymousAuthorization()
					// 获得客人所具备的权限
					authToken = AuthorizationFactory.getAnonymousAuthorization();
				} else {
					userName = PageUtils.getUserName(request);
				}
				
				TestBedFactory factory=DbTestBedFactory.getInstance(authToken);
				User user = factory.getUserManager().getUser(authToken.getUserID());
				
				Experiment exp = factory.createExperiment(user, expName, expDescription, XML, Integer.parseInt(highNum), Integer.parseInt(lowNum), highCodeIDArray,lowCodeIDArray,"");
				user.addExp(exp);
				factory.getCacheManager().experimentCache.cache.add(exp.getId(), (Cacheable) exp);
				// 需要返回factory的ID，这里暂时用0来替代
				PageUtils.saveExpID(request, response, exp.getId());
				
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
			
			//System.out.println("in execute");
		return null;
	}

	public void setXML(String xML) {
		XML = xML;
	}

	public String getXML() {
		return XML;
	}
	public void setExpName(String expName) {
		this.expName = expName;
	}

	public String getExpName() {
		return expName;
	}

	public void setExpDescription(String expDescription) {
		this.expDescription = expDescription;
	}

	public String getExpDescription() {
		return expDescription;
	}

	public void setHighNum(String highNum) {
		this.highNum = highNum;
	}

	public String getHighNum() {
		return highNum;
	}

	public void setLowNum(String lowNum) {
		this.lowNum = lowNum;
	}

	public String getLowNum() {
		return lowNum;
	}

	public String getHighCodeID() {
		return highCodeID;
	}

	public void setHighCodeID(String highCodeID) {
		this.highCodeID = highCodeID;
	}

	public String getLowCodeID() {
		return lowCodeID;
	}

	public void setLowCodeID(String lowCodeID) {
		this.lowCodeID = lowCodeID;
	}

	public ArrayList<Integer> getHighCodeIDArray() {
		return highCodeIDArray;
	}

	public void setHighCodeIDArray(ArrayList<Integer> highCodeIDArray) {
		this.highCodeIDArray = highCodeIDArray;
	}

	public ArrayList<Integer> getLowCodeIDArray() {
		return lowCodeIDArray;
	}

	public void setLowCodeIDArray(ArrayList<Integer> lowCodeIDArray) {
		this.lowCodeIDArray = lowCodeIDArray;
	}

}
