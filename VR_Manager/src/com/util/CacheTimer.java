package com.util;

import java.beans.Expression;

/**
 * Simple timer that keeps the currentTime variable of Cache accurate to one
 * second of the real clock time.
 */
public class CacheTimer extends Thread{
	private static long updateInterval;
	public static long currentTime;
	
	static {
	//	new CacheTimer(1000);
	}
	
	public CacheTimer(long updateInterval) {
		this.updateInterval = updateInterval;
		/**
		 * Make the timer be a deamon thread so that it won't keep the VM
		 * from shutting down if there are no other threads.
		 */
		this.setDaemon(true);
		//start the timer thread.
		start();
	}
	
	public void run() {
		while (true) {
			currentTime = System.currentTimeMillis();
			Cache.currentTime = currentTime;
			LongCache.currentTime = currentTime;
			try {
				sleep(updateInterval);
			} catch (Exception e) {
				
			}
		}
	}
}
