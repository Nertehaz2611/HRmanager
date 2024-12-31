package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class database {
    public Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("Không tìm thấy driver MySQL!", e);
        }
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/pbl4", "root", "");
    }

    public void closeConnection(Connection conn, PreparedStatement stmt, ResultSet rs) {
    	try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            System.out.println("Lỗi khi đóng tài nguyên: " + e.getMessage());
        }
    }

    public void insert(String table, Object ID, Object name, Object age, Object university) throws SQLException {
    	String insertSQL = "INSERT INTO " + table + " VALUES(?, ?, ?, ?, ?, ?)";
    	try (Connection conn = getConnection(); 
               PreparedStatement stmt = conn.prepareStatement(insertSQL)) {
               stmt.setObject(1, ID);
               stmt.setObject(2, name);
               stmt.setObject(3, age);
               stmt.setObject(4, university);
               stmt.setObject(5, null);
               stmt.setObject(6, 0);
               stmt.executeUpdate();
           } catch (SQLException e) {
               throw new SQLException("Lỗi khi chèn sinh viên: " + e.getMessage(), e);
           }
	}
    
    public ResultSet selectOrder(String table, String field) throws SQLException {
    	String sql = "SELECT * FROM " + table + " ORDER BY " + field + " DESC";
        Connection conn = getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql);
        return stmt.executeQuery(); 
    }

    public ResultSet selectAll(String table) throws SQLException {
    	String sql = "SELECT * FROM " + table;
        Connection conn = getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql);
        return stmt.executeQuery(); 
    }
    
    public ResultSet selectEach(String table, Object id, Object value) throws SQLException{
    	String sql = "SELECT * FROM " + table + " WHERE " + id + " like ?";
    	Connection conn = getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setObject(1, value);
        return stmt.executeQuery();	
    }
	
	public ResultSet selectByField(String table, String field, Object value) throws SQLException {
		String sql = "SELECT * FROM " + table + " WHERE " + field + " like ?";
        Connection conn = getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setObject(1, value);
        return stmt.executeQuery();	
	}

	public ResultSet getField(String table, String field, Object ID) throws SQLException {
		String sql = "SELECT * FROM " + table + " WHERE " + field + " like ?";
        Connection conn = getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setObject(1, ID);
        return stmt.executeQuery();	
	}
	
	public ResultSet getAccount() throws SQLException {
		String sql = "SELECT * FROM account";
		Connection conn = getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		return stmt.executeQuery();
	}
	
	public ResultSet getID(String table, String field, Object ID) throws SQLException {
		String sql = "SELECT " + field + " FROM " + table + " WHERE BINARY " + field + " = ?";
	    Connection conn = getConnection();
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setString(1, "%" + ID + "%");
	    return stmt.executeQuery();
	}	
	public ResultSet getListOfField(String table, String field) throws SQLException {
		String sql = "SELECT " + field +" FROM " + table;
		Connection conn = getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		return stmt.executeQuery(sql);
	}


	public void drop(String table, String idField, Object ID) throws SQLException{
		String sql = "DELETE FROM " + table + " WHERE " + idField + " = ?";
    	try (Connection conn = getConnection(); 
               PreparedStatement stmt = conn.prepareStatement(sql)) {
               stmt.setObject(1, ID);
               stmt.executeUpdate();
           } catch (SQLException e) {
               throw new SQLException("Lỗi khi xoá sinh viên: " + e.getMessage(), e);
           }
	}
	
	public void dropMany(String table, String idField, Object ID[]) throws SQLException {
		String sql = "DELETE FROM " + table + " WHERE " + idField + " = ?";
		for(int i = 0; i<ID.length; i++) {					
		try (Connection conn = getConnection();
	               PreparedStatement stmt = conn.prepareStatement(sql)) {
	               stmt.setObject(1, ID[i]);
	               stmt.executeUpdate();
		} catch (SQLException e) {
			throw new SQLException("Lỗi khi xoá sinh viên: " + e.getMessage(), e);
		}
			}
		}
	
	public void updateDepartment(String oldID, String newID, String newName, String newDes) throws SQLException {
	    String insertNewDepartment = "INSERT INTO phongban (IDPB, Tenpb, Mota) VALUES (?, ?, ?)";
	    String updateDepartment = "UPDATE phongban SET Tenpb = ?, Mota = ?  WHERE IDPB = ?";
	    String updateStaff = "UPDATE nhanvien SET IDPB = ? WHERE IDPB = ?";
	    String deleteOldDepartment = "DELETE FROM phongban WHERE IDPB = ?";

	    try (Connection conn = getConnection();
	         PreparedStatement insertDeptStmt = conn.prepareStatement(insertNewDepartment);
		     PreparedStatement updateDeptStmt = conn.prepareStatement(updateDepartment);
	         PreparedStatement updateStaffStmt = conn.prepareStatement(updateStaff);
	         PreparedStatement deleteDeptStmt = conn.prepareStatement(deleteOldDepartment)) {
	    	if(!oldID.equals(newID)) {	    		
		        insertDeptStmt.setString(1, newID);  
		        insertDeptStmt.setString(2, newName);  
		        insertDeptStmt.setString(3, newDes);  
		        insertDeptStmt.executeUpdate();
	
		        updateStaffStmt.setString(1, newID);  
		        updateStaffStmt.setString(2, oldID);  
		        updateStaffStmt.executeUpdate();
	
		        deleteDeptStmt.setString(1, oldID);  
		        deleteDeptStmt.executeUpdate();
	    	}
	    	else {
	    		updateDeptStmt.setString(1, newName);  
	    		updateDeptStmt.setString(2, newDes);
	    		updateDeptStmt.setString(3, oldID);
	    		updateDeptStmt.executeUpdate();
	    	}

	        System.out.println("Update department and staff successful!");
	    } catch (SQLException e) {
	        throw new SQLException("Error updating department and staff: " + e.getMessage(), e);
	    }
	}

	}
