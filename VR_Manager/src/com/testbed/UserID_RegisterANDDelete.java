package com.testbed;

public class UserID_RegisterANDDelete {
	private int userID;
	private boolean register;
	private boolean deleteUser;
	public int getUserID() {
		return userID;
	}
	public void setUserID(int userID) {
		this.userID = userID;
	}
	public boolean isRegister() {
		return register;
	}
	public void setRegister(boolean register) {
		this.register = register;
	}
	public boolean isDeleteUser() {
		return deleteUser;
	}
	public void setDeleteUser(boolean deleteUser) {
		this.deleteUser = deleteUser;
	}
}
