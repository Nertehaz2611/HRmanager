package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.bean.department;
import model.bean.staff;

public class departmentDAO{
	String table = "phongban";
	String idField = "IDPB";
	String nameField = "Tenpb";
	String desField = "Mota";
	public ArrayList<department> view() throws SQLException {
        ArrayList<department> List = new ArrayList<>();
        database data = new database();
        
        try (ResultSet resultSet = data.selectAll(this.table)) {
            while (resultSet.next()) {
                department st = new department();
                st.setID(resultSet.getString(1));
                st.setName(resultSet.getString(2));
                st.setDescription(resultSet.getString(3));
                List.add(st);
            }
        } catch (SQLException e) {
            throw new SQLException("Lỗi khi lấy danh sách sinh viên: " + e.getMessage(), e);
        }
        
        return List;
    }
	
	public void delete(String id) throws SQLException {
        database data = new database();
        data.drop(this.table, this.idField, id);
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
	
	public ArrayList<department> getByField(String field, Object value) throws SQLException{
		ArrayList<department> List = new ArrayList<>();
        database data = new database();
        try (ResultSet resultSet = data.selectByField(this.table, field, value)) {
            while (resultSet.next()) {
                department dp = new department();
                dp.setID(resultSet.getString(1));
                dp.setName(resultSet.getString(2));
                dp.setDescription(resultSet.getString(3));
                List.add(dp);
            }
        } catch (SQLException e) {
            throw new SQLException("Lỗi khi lấy danh sách sinh viên: " + e.getMessage(), e);
        }
        
        return List;
	}
	
	public void updateDepartment(String oldID, String newID, String newName, String newDes) throws SQLException {
		database data = new database();
		data.updateDepartment(oldID, newID, newName, newDes);
	}
}