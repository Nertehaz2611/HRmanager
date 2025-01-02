package controller;

import model.bo.staffBO;
import model.bo.timeKeepingBO;
import model.bean.department;
import model.bean.staff;
import model.bean.timeKeeping;
import model.bo.departmentBO;
import model.bo.loginBO;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet({"/home", "/logout","/login","/staffList", "/departmentList", "/searchStaff", "/deleteEach",
	"/deleteMany", "/updateDepartment", "/addStaff","/timekeepingByTime", "/timekeepingByStaff", "/editStaff"})

public class servletControl extends HttpServlet{
	private static final long serialVersionUID = 1L;
	staffBO stbo = new staffBO();
	departmentBO dpbo = new departmentBO();
	timeKeepingBO tkbo = new timeKeepingBO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sess = request.getSession();
		String sessionUsername = (String) sess.getAttribute("username");
		String path = request.getServletPath();
		String destination = null;
		switch(path) {
		case "/login":{
			destination = "/login.jsp";
			loginBO logbo = new loginBO();
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String preURL = (String) sess.getAttribute("preURL");
			try {
				if(username != null && password != null) {
				if(username.equals("") || password.equals("")) {
					if(username.equals("")) {
						request.setAttribute("loginErr", "Hãy nhập username");
						destination = "/login.jsp";
					}
					if(password.equals("")) {
						request.setAttribute("loginErr", "Hãy nhập mật khẩu");
						destination = "/login.jsp";
					}
				}
				else if(logbo.checkLogin(username, password)) {
					destination = "/staffList";
					sess.removeAttribute("preURL"); 
					sess.setAttribute("username", username);
					sess.setAttribute("password", password);
				}
				else {
					request.setAttribute("loginErr", "Sai username hoặc mật khẩu");
					destination = "/login.jsp";
				}
				}
				
				getServletContext().getRequestDispatcher(destination)
				.forward(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			break;
		}
		
		case "/logout":{
	        HttpSession session = request.getSession(false); 
	        
	        if (session != null) {
	            session.invalidate(); 
	        }
	        getServletContext().getRequestDispatcher("/staffList")
			.forward(request, response);
			break;
		}
		
		case "/home":{
			try {
				ArrayList<timeKeeping> timeKeepingList = tkbo.view();
				request.setAttribute("timeKeepingList", timeKeepingList);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			getServletContext().getRequestDispatcher("/index.jsp")
			.forward(request, response);
			break;
		}
		
		case "/staffList":{
			try {
				String departmentID = request.getParameter("departmentID");
				request.setAttribute("caption", "Danh sách nhân viên");
				if(departmentID != null) {
					request.setAttribute("staffList", stbo.getByField("IDPB", departmentID));
				}
				else {					
					request.setAttribute("staffList", stbo.view());
				}
				getServletContext().getRequestDispatcher("/staffList.jsp")
				.forward(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			break;
		}
		
		case "/departmentList":{
			try {
				request.setAttribute("departmentList", dpbo.view());
			} catch (SQLException e) {
				e.printStackTrace();
			}
			getServletContext().getRequestDispatcher("/departmentList.jsp")
			.forward(request, response);
			break;

		}
		
		case "/searchStaff":{
			String keyword = request.getParameter("searchKeyword");
			Object value = request.getParameter("searchInfo");
			try {
				if(keyword != null && value != null) {					
					request.setAttribute("postUpdateList", stbo.getByField(keyword, value)); //postUpdateList là searchResult
					System.out.println(stbo.getByField(keyword, value));
				}
				else {					
					request.setAttribute("staffList", stbo.view());
				}
				getServletContext().getRequestDispatcher("/searchStaff.jsp")	
				.forward(request, response);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			break;
		}
		
		case "/deleteEach":{
			if(sessionUsername == null) {
				destination = "/login";
			}
			else {
				try {
					destination = "/deleteEach.jsp";
					request.setAttribute("preDeleteList", stbo.view());
					String ID = (request.getParameter("ID"));
					if (ID != null && !ID.isEmpty()) {
						stbo.delete(ID); 
						request.setAttribute("afterDeleteList", stbo.view());
					} else {
						request.setAttribute("afterDeleteList", stbo.view());
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			getServletContext().getRequestDispatcher(destination)
			.forward(request, response);
			break;
		}
		
		case "/deleteMany":{
			if(sessionUsername == null) {
				destination = "/login";
			}
			else {				
				try {
					destination = "/deleteMany.jsp";
					request.setAttribute("preDeleteList", stbo.view());
					String[] ID = request.getParameterValues("ID[]");
					if (ID!=null && ID.length != 0) {
						stbo.deleteMany(ID); 
						request.setAttribute("afterDeleteList", stbo.view());
					} else {
						request.setAttribute("afterDeleteList", stbo.view());
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			getServletContext().getRequestDispatcher(destination)
			.forward(request, response);
			break;
		}
		
		case "/updateDepartment":{
			if(sessionUsername == null) {
				destination = "/login";
			}
			else {
				try {
					request.setCharacterEncoding("UTF-8");
					response.setCharacterEncoding("UTF-8");
					response.setContentType("text/html; charset=UTF-8");
					destination = "/updateDepartment.jsp";
					request.setAttribute("preUpdateList", dpbo.view());
					String ID = (String)request.getParameter("ID");
					System.out.println(ID);
					if(ID != null) {
						destination = "/updateForm.jsp";
						request.setAttribute("targetDepartment", dpbo.getByField("IDPB", ID));
						System.out.println(dpbo.getByField("IDPB", ID));
					}
					String newID = (String)request.getParameter("idInput");
					if(newID != null) {
						System.out.println(dpbo.getByField("IDPB", ID));
						String originID = request.getParameter("originID");
						ArrayList<department> department = dpbo.getByField("IDPB", originID);
						String name = request.getParameter("nameInput");
						String description = request.getParameter("desInput");
						if(department.get(0).getID().equals(newID) && department.get(0).getName().equals(name) && department.get(0).getDescription().equals(description)) {
							request.setAttribute("idInputed", newID);
							request.setAttribute("nameInputed", name);
							request.setAttribute("desInputed", description);
							request.setAttribute("targetDepartment", department);
							destination = "/updateForm.jsp";
							
						}
						else {
							if(dpbo.checkExistedID(newID.toUpperCase()) && !department.get(0).getID().equals(newID)) {
								request.setAttribute("IDcheck", "Mã bị trùng");
								request.setAttribute("idInputed", newID);
								request.setAttribute("nameInputed", name);
								request.setAttribute("desInputed", description);
								request.setAttribute("targetDepartment", department);
								destination = "/updateForm.jsp";
							}
							else {
								dpbo.updateDepartment(originID, newID, name, description);
								request.setAttribute("afterUpdateList", dpbo.view());
								destination = "/updateDepartment.jsp";
							}
							
						}
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
				getServletContext().getRequestDispatcher(destination)
				.forward(request, response);				
			break;
		}
		
		case "/addStaff":{
			if(sessionUsername == null) {
				destination = "/login";
			}
			else {
				try {
					destination = "/addStaff.jsp";
					request.setCharacterEncoding("UTF-8");
					response.setCharacterEncoding("UTF-8");
					response.setContentType("text/html; charset=UTF-8");
					request.setAttribute("staffList", stbo.view());
					request.setAttribute("departmentIDList", dpbo.getListOfField("ID"));
					String ID = request.getParameter("idInput");
					String name = request.getParameter("nameInput");
					String departmentID = request.getParameter("departmentIDinput");
					String address = request.getParameter("addressInput");
					if (ID!=null) {
						if(stbo.checkExistedID(ID.toUpperCase())) {
							request.setAttribute("IDcheck", "Mã bị trùng");
							request.setAttribute("idInputed", ID);
							request.setAttribute("nameInputed", name);
							request.setAttribute("departmentIDinputed", departmentID);
							request.setAttribute("addressInputed", address);
							request.setAttribute("preDeleteList", stbo.view());
						}
						else {	
							stbo.addStaff(ID, name, departmentID, address); 
							request.setAttribute("postUpdateList", stbo.view());
						}
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
			getServletContext().getRequestDispatcher(destination)
			.forward(request, response);
			break;
		}
		
		case "/timekeepingByTime":{
			destination = "/searchTimekeepingByTime.jsp";
			String startDateInput = request.getParameter("startDate");
			String endDateInput = request.getParameter("endDate");
			if(startDateInput != null && endDateInput != null) {
				LocalDate startDate = LocalDate.parse(startDateInput);
				LocalDate endDate = LocalDate.parse(endDateInput);
				ArrayList<timeKeeping> timeKeepingList;
				try {
					timeKeepingList = tkbo.searchByTime(startDate, endDate);
					request.setAttribute("timeKeepingList", timeKeepingList);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}
			request.setCharacterEncoding("UTF-8");
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html; charset=UTF-8");
			getServletContext().getRequestDispatcher(destination)
			.forward(request, response);
			break;
		}
		
		case "/timekeepingByStaff":{
			destination = "/timekeepingByStaff.jsp";
			String staffID = request.getParameter("staffID");
			if(staffID == null) {
				try {
					request.setAttribute("staffList", stbo.view());
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}
			else {
				try {
					request.setAttribute("searchResult", tkbo.searchByStaff(staffID));
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			request.setCharacterEncoding("UTF-8");
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html; charset=UTF-8");
			getServletContext().getRequestDispatcher(destination)
			.forward(request, response);
			break;
		}
		
		case "/editStaff":{
			if(sessionUsername == null) {
				destination = "/login";
			}
			else {
				request.setCharacterEncoding("UTF-8");
				response.setCharacterEncoding("UTF-8");
				response.setContentType("text/html; charset=UTF-8");
				String staffID = request.getParameter("staffID");
				request.setAttribute("caption", "Chỉnh sửa thông tin nhân viên");
				String idInput = request.getParameter("idInput");
				String nameInput = request.getParameter("nameInput");
				String departmentIDinput = request.getParameter("departmentIDinput");
				String addressInput = request.getParameter("addressInput");
				String originID = request.getParameter("originID");
				if(staffID == null) {
					if(idInput != null && nameInput != null
							&& departmentIDinput != null && addressInput != null) {
						try {
								if(stbo.checkExistedID(idInput)) {
									if(!idInput.equals(originID)) {
										request.setAttribute("idInputed", idInput);
										request.setAttribute("nameInputed", nameInput);
										request.setAttribute("departmentIDinputed", departmentIDinput);
										request.setAttribute("addressInputed", addressInput);
										request.setAttribute("idCheck", "Mã nhân viên bị trùng");
										request.setAttribute("departmentIDlist", dpbo.getListOfField("ID"));
										if(originID != null) {
											request.setAttribute("editedStaff", stbo.getByField("IDNV", originID));
										}
										destination = "/editForm.jsp";
									}
									else {
										stbo.editStaff(originID, idInput, nameInput, departmentIDinput, addressInput);
										request.setAttribute("staffList", stbo.view());
										destination = "/editStaff.jsp";
									}
								}
								else {
									stbo.editStaff(originID, idInput, nameInput, departmentIDinput, addressInput);
									request.setAttribute("staffList", stbo.view());
									destination = "/editStaff.jsp";
								}

						} catch (SQLException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
					else {
						try {
							request.setAttribute("staffList", stbo.view());
						} catch (SQLException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						destination = "/editStaff.jsp";
					}

				} 
				else {
					try {
						request.setAttribute("editedStaff", stbo.getByField("IDNV", staffID));
						request.setAttribute("departmentIDlist", dpbo.getListOfField("ID"));
						destination = "/editForm.jsp";
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
			getServletContext().getRequestDispatcher(destination)
			.forward(request, response);
			break;
		}
			
		}
	}
}