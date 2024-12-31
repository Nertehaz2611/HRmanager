<%@ page import="java.util.ArrayList, model.bean.department"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table{
            border: solid 1px;
            border-collapse: collapse;
            width: 100%;
            text-align: center;
            font-size: large;
        }
</style>
</head>
<body>
	<%ArrayList<department> departmentList = (ArrayList<department>)request.getAttribute("departmentList"); %>
	<h2 align="center">Danh sach phong ban</h2>
       <%HttpSession sess = request.getSession(false); 
		if(sess.getAttribute("username") == null){ %>
	<a href='login.jsp' style="margin-left: 80%"><button>Đăng nhập</button></a>
		<% }else{ %>
	<a href='<%=request.getContextPath() %>/logout' style="margin-left: 80%"><button>Đăng xuất</button></a>
		<% }%>
    <table border="1">
            <tr>
             	<th>Mã phòng ban</th><th>Tên phòng ban</th><th>Mô tả</th><th>Xem nhân viên</th>
            </tr>
        	<%if(departmentList != null && !departmentList.isEmpty()){
        		for(int i = 0; i<departmentList.size(); i++){%>
        	<tr>
	                <td><%=departmentList.get(i).getID() %></td>
	                <td><%=departmentList.get(i).getName() %></td>
	                <td><%=departmentList.get(i).getDescription() %></td>
	                <td><a href='<%=request.getContextPath()%>/staffList?departmentID=<%=departmentList.get(i).getID() %>'>xxx</a></td>
            </tr>
        	<% }
        	}%>

  	</table>
    <br>
    <p><a href="<%= request.getContextPath()%>/index.jsp">Home page</a></p>
</body>
</html>