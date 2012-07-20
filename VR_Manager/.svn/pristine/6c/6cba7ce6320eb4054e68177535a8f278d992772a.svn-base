package org.apache.struts.helloworld.action;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

public class HelloWorldAction extends ActionSupport {

	private static final long serialVersionUID = 1L;

	//private MessageStore messageStore;
	//private VR_Manager vrm;
	
	Socket socket;
	PrintWriter out;
	BufferedReader in;
	private String flow;
	
	public String getFlow() {
		return flow;
	}

	public void setFlow(String flow) {
		this.flow = flow;
	}

	public String execute() throws Exception {
		
		//messageStore = new MessageStore() ;
		HttpServletRequest request = ServletActionContext.getRequest ();
		BufferedReader br = new BufferedReader(new InputStreamReader((ServletInputStream)request.getInputStream()));  
        String line = null;  
        StringBuilder sb = new StringBuilder();  
        while((line = br.readLine())!=null){  
            sb.append(line);  
        }  
        
		System.out.println(sb);
		
		clientTest("10.21.2.10");
		
		
		return SUCCESS;
	}
	
	//向各物理机器的守护进程发送控制和配置信息
	void clientTest(String IP)
	{
		try
		{
		
		socket = new Socket(IP, 8083);
		in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
		out = new PrintWriter(socket.getOutputStream(),true);
		
		out.println("Haha, I am success!\n");
		
		String result=in.readLine();
		System.out.println(result);

		in.close();
		out.close();
		socket.close();
		}
		catch (IOException e)
		{
			System.out.println(e.toString());
			
		}
	}
	
	
}