package model.bo;

import java.sql.SQLException;
import java.util.ArrayList;

import model.bean.department;
import model.bean.staff;
import model.dao.database;
import model.dao.departmentDAO;

public class departmentBO{
	departmentDAO dpdao = new departmentDAO();
	public ArrayList<department> view() throws SQLException{
			return dpdao.view();
	}
	
	public void delete(String id) throws SQLException{
		dpdao.delete(id);
	}
	
	public ArrayList<String> getListOfField(String field) throws SQLException{
		String actualField = "";
		switch(field) {
			case "ID":{
				actualField = "IDPB";
				break;
			}
			
			case "name":{
				actualField = "Tenpb";
				break;
			}
			
			case "description":{
				actualField = "Mota";
				break;
			}
		}
		return dpdao.getListOfField(actualField);
	}
	
	public ArrayList<department> getByField(String field, Object value) throws SQLException{
		return dpdao.getByField(field, value);
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
	
	public void updateDepartment(String oldID, String newID, String newName, String newDes) throws SQLException {
		dpdao.updateDepartment(oldID, newID, newName, newDes);
	}
	
}