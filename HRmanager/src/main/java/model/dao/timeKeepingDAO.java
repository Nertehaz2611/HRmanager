package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;

import model.bean.timeKeeping;

public class timeKeepingDAO{
	String table = "chamcong";
	String idField = "ID";
	String staffIDfield = "staffID";
	String timeField = "time";
	staffDAO stdao = new staffDAO();
	
	public ArrayList<timeKeeping> view() throws SQLException {
        ArrayList<timeKeeping> List = new ArrayList<>();
        database data = new database();
        try (ResultSet resultSet = data.selectOrder(this.table, this.idField)) {
            while (resultSet.next()) {
                timeKeeping tk = new timeKeeping();
                tk.setID(resultSet.getInt(1));
                tk.setStaffID(resultSet.getString(2));
                tk.setTime(resultSet.getString(3));
                tk.setStaff(stdao.getEach(resultSet.getString(2)));
                List.add(tk);
            }
        } catch (SQLException e) {
            throw new SQLException("Lỗi khi lấy danh sách sinh viên: " + e.getMessage(), e);
        }
        
        return List;
    }
	
	public ArrayList<timeKeeping> searchByTime(LocalDate startDate, LocalDate endDate) throws SQLException{
		ArrayList<timeKeeping> List = new ArrayList<>();
		database data = new database();
		try (ResultSet resultSet = data.selectOrder(this.table, this.idField)) {
            while (resultSet.next()) {
            	String dateString = resultSet.getString(3).split(" ")[0];
            	System.out.println(dateString);
            	LocalDate date = LocalDate.parse(dateString);
            	if((date.isEqual(startDate) || date.isAfter(startDate)) && (date.isEqual(endDate) || date.isBefore(endDate))) {            		
            		timeKeeping tk = new timeKeeping();
            		tk.setID(resultSet.getInt(1));
            		tk.setStaffID(resultSet.getString(2));
            		tk.setTime(resultSet.getString(3));
            		tk.setStaff(stdao.getEach(resultSet.getString(2)));
            		List.add(tk);
            	}
            }
        } catch (SQLException e) {
            throw new SQLException("Lỗi khi lấy danh sách sinh viên: " + e.getMessage(), e);
        }
		return List;
	}
	
}