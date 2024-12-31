package model.bo;

import java.net.http.HttpRequest;
import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import model.dao.loginDAO;

public class loginBO{
	loginDAO logdao = new loginDAO();
	public boolean checkLogin(String username, String password) throws SQLException {
		return logdao.checkLogin(username, password);
	}
}