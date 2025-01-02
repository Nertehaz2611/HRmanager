package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.bean.staff;

public class staffDAO{
	String table = "nhanvien";
	String idField = "IDNV";
	String nameField = "Hoten";
	String departmentIDfield = "IDPB";
	String addressField = "Diachi";
	String foreignKey = "staffID";
	String foreignTable = "chamcong";
	public ArrayList<staff> view() throws SQLException {
        ArrayList<staff> List = new ArrayList<>();
        database data = new database();
        
        try (ResultSet resultSet = data.selectAll(this.table)) {
            while (resultSet.next()) {
                staff st = new staff();
                st.setID(resultSet.getString(1));
                st.setName(resultSet.getString(2));
                st.setDepartmentID(resultSet.getString(3));
                st.setAddress(resultSet.getString(4));
                st.setLastTimeKeeping(resultSet.getString(5));
                st.setTimeKeepingStatus(resultSet.getBoolean(6));
                List.add(st);
            }
        } catch (SQLException e) {
            throw new SQLException("Lỗi khi lấy danh sách sinh viên: " + e.getMessage(), e);
        }
        
        return List;
    }
	
	public ArrayList<staff> getByField(String field, Object value) throws SQLException{
		ArrayList<staff> List = new ArrayList<>();
        database data = new database();
        
        try (ResultSet resultSet = data.selectByField(this.table, field, value)) {
            while (resultSet.next()) {
                staff st = new staff();
                st.setID(resultSet.getString(1));
                st.setName(resultSet.getString(2));
                st.setDepartmentID(resultSet.getString(3));
                st.setAddress(resultSet.getString(4));
                st.setLastTimeKeeping(resultSet.getString(5));
                st.setTimeKeepingStatus(resultSet.getBoolean(6));
                List.add(st);
            }
        } catch (SQLException e) {
            throw new SQLException("Lỗi khi lấy danh sách sinh viên: " + e.getMessage(), e);
        }
        
        return List;
	}
	
	public staff getEach(Object value) throws SQLException{
		staff st = new staff();
        database data = new database();
        
        try (ResultSet resultSet = data.selectByField(this.table, this.idField, value)) {
            while (resultSet.next()) {
                st.setID(resultSet.getString(1));
                st.setName(resultSet.getString(2));
                st.setDepartmentID(resultSet.getString(3));
                st.setAddress(resultSet.getString(4));
            }
        } catch (SQLException e) {
            throw new SQLException("Lỗi khi lấy danh sách sinh viên: " + e.getMessage(), e);
        }
        
        return st;
	}
	
	public void delete(String id) throws SQLException {
        database data = new database();
        data.drop(this.table, this.idField, id);
    }
	
	public void deleteMany(String id[]) throws SQLException {
		database data = new database();
        data.dropMany(this.table, this.idField, id, this.foreignKey, this.foreignTable);
	}
	
	public ArrayList<String> getListOfField(String field) throws SQLException {
		ArrayList<String> List = new ArrayList<>();
		database data = new database();
		try (ResultSet resultSet = data.getListOfField(this.table, field)) {
			while (resultSet.next()) {
	             List.add(resultSet.getString(field));
	         }
        } catch (SQLException e) {
            throw new SQLException("Lỗi khi lấy danh sách sinh viên: " + e.getMessage(), e);
        }
        return List;
	}
	
	public String getID(String ID) throws SQLException{
		String result = null;
		database data = new database();
		try (ResultSet resultSet = data.getID(this.table, this.idField, ID)) {
			while (resultSet.next()) {
	             result = resultSet.getString(1);
	         }
        } catch (SQLException e) {
            throw new SQLException("Lỗi khi lấy danh sách sinh viên: " + e.getMessage(), e);
        }
        return result;
	}
	
	public void addStaff(String ID, String name, String departmentID, String address) throws SQLException {
		database data = new database();
		data.insert(this.table, ID, name, departmentID, address);
	}
	
	public void editStaff(String oldID, String newID, String newName, String newDepartmentID, String newAddress) throws SQLException {
		database data = new database();
		data.editStaff(oldID, newID, newName, newDepartmentID, newAddress);
	}
}