package com.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;


public class Communication
{
	
	private Socket socket;
	PrintWriter out;
	BufferedReader in;
	
	public Boolean sendTo(String IP, String data)
	{
		
		
			try
			{
			
			socket = new Socket(IP, 8083);
			in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
			out = new PrintWriter(socket.getOutputStream(),true);
			
			out.println(data);
			
			String result=in.readLine();
			System.out.println(result);

			in.close();
			out.close();
			socket.close();
			return true;
			}
			catch (IOException e)
			{
				System.out.println(e.toString());
				return false;
			}
		
	}
	
}