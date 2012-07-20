package com.testbed;

import java.io.PrintStream;
import java.io.PrintWriter;

public class UnauthorizedException extends Exception{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Throwable nestedThrowable = null;
	
	public UnauthorizedException() {
		super();
	}
	
	public UnauthorizedException(String msg) {
		super(msg);
	}

	public UnauthorizedException(Throwable nestedThrowable) {
		super();
		this.nestedThrowable = nestedThrowable;
	}
	
	public UnauthorizedException(String msg, Throwable nestedThrowable) {
		super(msg);
		this.nestedThrowable = nestedThrowable;
	}
	
	public void printStackTrace() {
        super.printStackTrace();
        if (nestedThrowable != null) {
            nestedThrowable.printStackTrace();
        }
    }

    public void printStackTrace(PrintStream ps) {
        super.printStackTrace(ps);
        if (nestedThrowable != null) {
            nestedThrowable.printStackTrace(ps);
        }
    }

    public void printStackTrace(PrintWriter pw) {
        super.printStackTrace(pw);
        if (nestedThrowable != null) {
            nestedThrowable.printStackTrace(pw);
        }
    }
}
