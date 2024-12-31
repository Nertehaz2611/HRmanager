<%@ page import="java.util.ArrayList, model.bean.timeKeeping, model.bean.staff"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8"); %>
	<%@ include file="header.jsp" %>
	<%ArrayList<timeKeeping> timeKeepingList = (ArrayList<timeKeeping>)request.getAttribute("timeKeepingList"); 
	ArrayList<staff> staffList = (ArrayList<staff>)request.getAttribute("staffList");%>
	<h2 align="center" class="w3-panel" >Lịch sử chấm công</h2>
    <table class="w3-table w3-centered w3-striped w3-hoverable">
            <tr>
             	<th>Mã nhân viên</th><th>Tên nhân viên</th><th>Mã phòng ban</th><th>Thời gian chấm công</th>
            </tr>
        	<% if(timeKeepingList != null && !timeKeepingList.isEmpty()){
        		for(int i = 0; i<timeKeepingList.size(); i++){%>
        		<tr>
	                <td><%=timeKeepingList.get(i).getStaffID() %></td>
	                <td><%=timeKeepingList.get(i).getStaff().getName() %></td>
	                <td><%=timeKeepingList.get(i).getStaff().getDepartmentID() %></td>
	                <td><%=timeKeepingList.get(i).getTime() %></td>
            </tr>
        	<% }
        	} else {%>
        		<tr><td colspan="4">Không có dữ liệu</td></tr>
        	<% }%>
  	</table>
    <br>
</body>
</html>