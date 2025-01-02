package model.bo;

import java.sql.SQLException;
import java.util.ArrayList;

import model.bean.staff;
import model.dao.staffDAO;

public class staffBO{
	staffDAO stdao = new staffDAO();
	public ArrayList<staff> view() throws SQLException{
			return stdao.view();
	}
	
	public ArrayList<staff> getByField(String field, Object value) throws SQLException{
		return stdao.getByField(field, value);
	}
	
	public void delete(String id) throws SQLException{
		stdao.delete(id);
	}
	
	public void deleteMany(String id[]) throws SQLException {
		stdao.deleteMany(id);
	}
	
	public ArrayList<String> getListOfField(String field) throws SQLException{
		String actualField = "";
		switch(field) {
			case "ID":{
				actualField = "IDNV";
				break;
			}
			
			case "name":{
				actualField = "Hoten";
				break;
			}
			
			case "departmentID":{
				actualField = "IDPB";
			}
			
			case "address":{
				actualField = "Diachi";
				break;
			}
		}
		return stdao.getListOfField(actualField);
	}
	
	public boolean checkExistedID(String ID) throws SQLException {
		ArrayList<String> idList = this.getListOfField("ID");
		boolean existed = false;
		for (int i = 0 ; i<idList.size(); i++) {
			if(idList.get(i).equals(ID)) {
				existed = true;
				break;
			}
		}
		return existed;
	}
	
	public void addStaff(String ID, String name, String departmentID, String address) throws SQLException {
		stdao.addStaff(ID, name, departmentID, address);
	}
	
	public void editStaff(String oldID, String newID, String newName, String newDepartmentID, String newAddress) throws SQLException{
		stdao.editStaff(oldID, newID, newName, newDepartmentID, newAddress);
	}
	
}