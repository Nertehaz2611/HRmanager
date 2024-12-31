package model.bean;

public class staff{
	private String ID;
	private String name;
	private String departmentID;
	private String address;
	private String lastTimeKeeping;
	private boolean timeKeepingStatus;
	
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
		ID = iD;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDepartmentID() {
		return departmentID;
	}
	public void setDepartmentID(String departmentID) {
		this.departmentID = departmentID;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getLastTimeKeeping() {
		return lastTimeKeeping;
	}
	public void setLastTimeKeeping(String lastTimeKeeping) {
		this.lastTimeKeeping = lastTimeKeeping;
	}
	public boolean isTimeKeepingStatus() {
		return timeKeepingStatus;
	}
	public void setTimeKeepingStatus(boolean timeKeepingStatus) {
		this.timeKeepingStatus = timeKeepingStatus;
	}
	
	
}