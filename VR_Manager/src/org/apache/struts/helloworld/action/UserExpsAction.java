package org.apache.struts.helloworld.action;

import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import com.testbed.Experiment;
import com.opensymphony.xwork2.ActionSupport;
import com.resultFilter.ResultFilter;
import com.testbed.Authorization;
import com.testbed.AuthorizationFactory;
import com.testbed.Experiment;
import com.testbed.TestBedFactory;
import com.testbed.database.DbTestBedFactory;
import com.testbed.database.TestBedGlobals;
import com.util.PageUtils;

public class UserExpsAction extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ArrayList<Experiment> exps = new ArrayList<Experiment>();
	private String expName;
	SessionFactory sessionFactory;

	public ArrayList<Experiment> getExps() {
		return exps;
	}

	public void setExps(ArrayList<Experiment> exps) {
		this.exps = exps;
	}

	
	public String execute() throws Exception {
		
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
		
		TestBedFactory factory = DbTestBedFactory.getInstance(authToken);
	
		//int expId = PageUtils.getExpID(request, response);
		//setExpName(factory.getExp(expId).getExpName());
		
		Session session=factory.getSessionFactory().openSession();
				
		
		String hql = "from DbExperiment experiment where experiment.userID=?";
		Query query= session.createQuery(hql).setParameter(0, authToken.getUserID());
		exps = (ArrayList<Experiment>)query.list();
		session.close();
		
		
		
		
		
		
		
		
		
		
		
		
		
		return SUCCESS;
	}

	public void setExpName(String expName) {
		this.expName = expName;
	}

	public String getExpName() {
		return expName;
	}


}