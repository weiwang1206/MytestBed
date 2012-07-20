package com.testbed;
import java.lang.reflect.*;
import com.resultFilter.*;

public class TestBedFactoryProxyHandler implements InvocationHandler {
	TestBedFactory factory;
	Permission permisson;
	Authorization authorization;
	
	public TestBedFactoryProxyHandler (TestBedFactory factory, 
			Permission permisson, Authorization authorization) {
		this.factory = factory;
		this.permisson = permisson;
		this.authorization = authorization;
	}
	
	public Object invoke(Object proxy, Method method, Object[] args)
			throws Throwable {
		// TODO Auto-generated method stub
		try {
			return method.invoke(factory, args);
		} catch (InvocationTargetException e) {
			System.out.println("in TestBedFactoryProxyHandler method = " +
					method.toString());
			e.printStackTrace();
		}
		return null;
	}
	
}