package model.bean;

import java.security.Timestamp;
import java.time.LocalDateTime;

public class timeKeeping{
	private int ID;
	private String staffID;
	private String time;
	private staff staff;
	
	public int getID() {
		return ID;
	}
	public void setID(int iD) {
		ID = iD;
	}
	public String getStaffID() {
		return staffID;
	}
	public void setStaffID(String staffID) {
		this.staffID = staffID;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String timestamp) {
		this.time = timestamp;
	}
	public staff getStaff() {
		return staff;
	}
	public void setStaff(staff staff) {
		this.staff = staff;
	}
	
}