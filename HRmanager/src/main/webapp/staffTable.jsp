<%@ page import="java.util.ArrayList, model.bean.staff"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <link rel="stylesheet" href="cssFile.css">
</head>
<body><%
    Object caption = request.getAttribute("caption");
	%>

	<h2 align="center" class="w3-panel"><%= (caption == null) ? "" : caption %></h2>
    <table class="w3-table w3-centered w3-striped w3-hoverable">
        <thead>
            <tr>
                <th>Mã nhân viên</th>
                <th>Họ tên</th>
                <th>Mã phòng ban</th>
                <th>Địa chỉ</th>
                <th>Lần cuối chấm công</th>
                <th>Trạng thái chấm công trong ngày</th>
            </tr>
        </thead>
        <tbody>
            <%
                // Nhận tham số từ Servlet hoặc URL
                ArrayList<staff> staffList = (ArrayList<staff>)request.getAttribute("staffList");
                ArrayList<staff> postUpdateList = (ArrayList<staff>)request.getAttribute("postUpdateList");
                if(postUpdateList != null && !postUpdateList.isEmpty()){
                	for(int i = 0; i<postUpdateList.size(); i++){
            %>
            <tr>
                <td><%=postUpdateList.get(i).getID() %></td>
	                <td><%=postUpdateList.get(i).getName() %></td>
	                <td><%=postUpdateList.get(i).getDepartmentID() %></td>
	                <td><%=postUpdateList.get(i).getAddress() %></td>
	                <td><%=postUpdateList.get(i).getLastTimeKeeping() %></td>
	                <td><%=postUpdateList.get(i).isTimeKeepingStatus() ? "Hoàn thành" : "Chưa chấm công" %></td>
            </tr>
            <%
                    }
                } else if(staffList != null && !staffList.isEmpty()) {
                	for(int i = 0; i<staffList.size(); i++){
                        %>
                        <tr>
                            <td><%=staffList.get(i).getID() %></td>
            	                <td><%=staffList.get(i).getName() %></td>
            	                <td><%=staffList.get(i).getDepartmentID() %></td>
            	                <td><%=staffList.get(i).getAddress() %></td>
            	                <td><%=staffList.get(i).getLastTimeKeeping() %></td>
            	                <td><%=staffList.get(i).isTimeKeepingStatus() ? "Hoàn thành" : "Chưa chấm công" %></td>
                        </tr>
            <% }
             } else{ %>
             	<h3 style="color: red">Không tìm thấy dữ liệu</h3>
             <% }
            %>
        </tbody>
    </table>
</body>
</html>