package model.bo;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

import model.bean.timeKeeping;
import model.dao.timeKeepingDAO;

public class timeKeepingBO{
	timeKeepingDAO tkdao = new timeKeepingDAO();
	public ArrayList<timeKeeping> view() throws SQLException{
		return tkdao.view();
	}
	
	public ArrayList<timeKeeping> searchByTime(LocalDate startDate, LocalDate endDate) throws SQLException{
		return tkdao.searchByTime(startDate, endDate);
	}
}