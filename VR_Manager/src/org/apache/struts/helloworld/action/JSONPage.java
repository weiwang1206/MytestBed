package org.apache.struts.helloworld.action;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.PropertyFilter;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.resultFilter.ResultFilter;
import com.testbed.Authorization;
import com.testbed.AuthorizationFactory;
import com.testbed.Experiment;
import com.testbed.PhyMachine;
import com.testbed.TestBedFactory;
import com.testbed.User;
import com.testbed.UserManager;
import com.testbed.VirtualRouter;
import com.testbed.database.DbTestBedFactory;
import com.testbed.database.TestBedGlobals;
import com.util.PageUtils;

public class JSONPage  extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String pageKind;
	private int pageIndex = -1;
	private int pageCnt;
	private String type;
	
	
	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}


	public String getPageKind() {
		return pageKind;
	}


	public void setPageKind(String pageKind) {
		this.pageKind = pageKind;
	}


	public int getPageIndex() {
		return pageIndex;
	}


	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}


	public int getPageCnt() {
		return pageCnt;
	}


	public void setPageCnt(int pageCnt) {
		this.pageCnt = pageCnt;
	}



	public String execute() throws Exception {
		
		HttpServletRequest request;
		HttpServletResponse response;
		Authorization authToken;
		
		if (pageIndex == -1) {
			return SUCCESS;
		}
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

		System.out.println("pageKind------------->" + pageKind);
		System.out.println("type------------->" + type);
		/**
		 * 此json action处理各种分页功能的json：
		 * <ul>
		 * <li id="a">All the physical machines in the testbed;</li>
		 * <li id="b">all the experiments in the testbed;</li>
		 * <li id="c">all the virtual routers in a physical machine;</li>
		 * <li id="d">all the virtual routers in an experiment;</li>
		 * <li id="e">all the ports in a virtual router;</li>
		 * <li id="f">all the users in the testbed.</li>
		 * <li id="g">all the virtual routers in testbed;</li>
		 * </ul>
		 * 我们通过pageKind类区分每一种情况。
		 * 		pageKind					情况
		 * 		pms							a
		 * 		exps						b
		 * 		vrsInPm						c
		 * 		vrsInExp					d
		 * 		ports						e
		 * 		users						f
		 * 		vrs							g
		 */
		try {
			// 设置字符集
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			
			JSONObject json = new JSONObject();
			
			Map map = new HashMap(); 
			List list = new ArrayList();
			if (pageKind.equals("pms")) {
				/** 
				 * 设置Filter，取得第 pageIndex页的内容
				 */
				ResultFilter filter = ResultFilter.createDefaultPmFilter();
				filter.setStartIndex(pageIndex * TestBedGlobals.PAGE_SIZE);
				filter.setNumResults(TestBedGlobals.PAGE_SIZE);
	
				Iterator it = factory.pms(filter);
				pageCnt = factory.getPmCnt(filter) / TestBedGlobals.PAGE_SIZE;
				
				while (it.hasNext())
				{
					PhyMachine pm = (PhyMachine) it.next();
					list.add(pm);
				}
			} else if (pageKind.equals("exps")) {
				
				/** 
				 * 设置Filter，取得第 pageIndex页的内容
				 */
				ResultFilter filter = ResultFilter.createDefaultExpFilter();
				filter.setStartIndex(pageIndex * TestBedGlobals.PAGE_SIZE);
				filter.setNumResults(TestBedGlobals.PAGE_SIZE);
				
				if (type.equals("APPLYING")) {
					/** 
					 * 设置Filter，取得未批准的实验
					 */
					filter.addProperty(TestBedGlobals.EXP_STATE, 
							TestBedGlobals.EXP_STATE_VALUE.APPLYING);
				} else if (type.equals("FINISHED")) {
					/** 
					 * 设置Filter，取得结束的实验
					 */
					filter.addProperty(TestBedGlobals.EXP_STATE, 
							TestBedGlobals.EXP_STATE_VALUE.FINISHED);
				} else if (type.equals("EXPERIMENTING")) {
					/** 
					 * 设置Filter，取得结束的实验
					 */
					filter.addProperty(TestBedGlobals.EXP_STATE, 
							TestBedGlobals.EXP_STATE_VALUE.EXPERIMENTING);
				} else if (type.equals("REJECTED")) {
					/** 
					 * 设置Filter，取得结束的实验
					 */
					filter.addProperty(TestBedGlobals.EXP_STATE, 
							TestBedGlobals.EXP_STATE_VALUE.REJECTED);
				} else if (type.equals("RELEASEED")) {
					/** 
					 * 设置Filter，取得结束的实验
					 */
					filter.addProperty(TestBedGlobals.EXP_STATE, 
							TestBedGlobals.EXP_STATE_VALUE.RELEASEED);
				}
				
				Iterator it = factory.exps(filter);
				pageCnt = factory.getExpCnt(filter) / TestBedGlobals.PAGE_SIZE;
				while (it.hasNext()) {
					list.add((Experiment) it.next());
				}
				for (int i = 0; i < list.size(); i++) {
					System.out.println("expName--->" + ((Experiment)list.get(i)).getExpName());
				}
				
			} else if (pageKind.equals("vrsInPm")) {
				
			} else if (pageKind.equals("vrsInExp")) {
				
			} else if (pageKind.equals("ports")) {
				
			} else if (pageKind.equals("users")) {
				/** 
				 * 设置Filter，取得第 pageIndex页的内容
				 */
				ResultFilter filter = ResultFilter.createDefaultUserFilter();
				filter.setStartIndex(pageIndex * TestBedGlobals.PAGE_SIZE);
				filter.setNumResults(TestBedGlobals.PAGE_SIZE);
				
				if (type.equals("unregistered")) {
					/** 
					 * 设置Filter，取得未批准的用户
					 */
					filter.addProperty(TestBedGlobals.USER_LEVEL, 
							TestBedGlobals.USER_LEVEL_VALUE.REGISTERING);
				} else if (type.equals("registered")) {
					/** 
					 * 设置Filter，取得批准的用户
					 */
					filter.addProperty(TestBedGlobals.USER_LEVEL, 
							TestBedGlobals.USER_LEVEL_VALUE.REGISTED);
				}
				
				UserManager userManager = factory.getUserManager();
				Iterator it = userManager.users(filter);
				pageCnt = userManager.getUserCount(filter) / TestBedGlobals.PAGE_SIZE;
				while (it.hasNext()) {
					list.add((User) it.next());
				}
				
				for (int i = 0; i < list.size(); i++) {
					System.out.println(((User)list.get(i)).getName());
				}
				
			} else if (pageKind.equals("vrs")) {
				/** 
				 * 设置Filter，取得第 pageIndex页的内容
				 */
				ResultFilter filter = ResultFilter.createDefaultVrFilter();
				filter.setStartIndex(pageIndex * TestBedGlobals.PAGE_SIZE);
				filter.setNumResults(TestBedGlobals.PAGE_SIZE);
	
				Iterator it = factory.vrs(filter);
				pageCnt = factory.getVrCnt(filter) / TestBedGlobals.PAGE_SIZE;
				List pmCodeList = new ArrayList<String>();
				List portCntList = new ArrayList<Integer>();
				List experimenterList = new ArrayList<String>();
				List experimentNameList = new ArrayList<String>();
				
				while (it.hasNext())
				{
					VirtualRouter vr = (VirtualRouter) it.next();
					pmCodeList.add(vr.getPM().getCode());
					portCntList.add(vr.getPortCount());
					Experiment expTmp = vr.getExperiment();
					experimenterList.add(expTmp.getUser().getName());
					experimentNameList.add(expTmp.getExpName());
					list.add(vr);
				}
				
				map.put("pmCodeList", pmCodeList);
				map.put("portCntList", portCntList);
				map.put("experimenterList", experimenterList);
				map.put("experimentNameList", experimentNameList);
			}
			
			
			map.put("pageCnt", pageCnt);
			System.out.println("before put list into map");
			map.put("list",list);
			System.out.println("before put list into json");
			JsonConfig config = new JsonConfig();
	        config.setJsonPropertyFilter(new PropertyFilter() {
	            public boolean apply(Object source, String name, Object value) {
	                if ( name.equals("factory") ||
	                	 name.equals("topoXML") ||
	                	 name.equals("configXML")) {
	                    return true;
	                } else {
	                    return false;
	                }
	            }
	        });
	        
			json = JSONObject.fromObject(map, config);
			System.out.println("after put list into json");
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
		
		System.out.println("pageCnt------------->" + pageCnt);
		System.out.println("pageIndex------------->" + pageIndex);
		return null;
	}


}
