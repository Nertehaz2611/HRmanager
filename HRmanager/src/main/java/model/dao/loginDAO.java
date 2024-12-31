package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

public class loginDAO{
	public boolean checkLogin(String username, String password) throws SQLException {
		database data = new database();
		boolean check = false;
		ResultSet accounts = data.getAccount();
		while(accounts.next()) {
			if((username.equals(accounts.getString(1)) && password.equals(accounts.getString(2)))) {
				check = true;
				break;
			}
		}
		return check;
	}
}