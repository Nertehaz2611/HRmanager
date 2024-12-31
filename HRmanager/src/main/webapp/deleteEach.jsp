<%@ page import="java.util.ArrayList, model.bean.staff"%>
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
	<%ArrayList<staff> preDeleteList = (ArrayList<staff>)request.getAttribute("preDeleteList"); 
	ArrayList<staff> afterDeleteList = (ArrayList<staff>)request.getAttribute("afterDeleteList"); %>
	<h2 align="center">Danh sach nhan vien</h2>
       <%HttpSession sess = request.getSession(false); 
		if(sess.getAttribute("username") != null){ %>
			
    <a href='<%=request.getContextPath() %>/logout' style="margin-left: 80%"><button>Đăng xuất</button></a>
		<%} %>
    <table border="1">
            <tr>
             	<th>ID</th><th>Tên</th><th>Tuổi</th><th>Trường Đại học</th><th>Xoá</th>
            </tr>
        	<%if(afterDeleteList != null && !afterDeleteList.isEmpty()){
        		for(int i = 0; i<afterDeleteList.size(); i++){%>
        	<tr>
	                <td><%=afterDeleteList.get(i).getID() %></td>
	                <td><%=afterDeleteList.get(i).getName() %></td>
	                <td><%=afterDeleteList.get(i).getDepartmentID() %></td>
	                <td><%=afterDeleteList.get(i).getAddress() %></td>
	                <td><a href='<%= request.getContextPath()%>/deleteEach?ID=<%=afterDeleteList.get(i).getID()%>'>xxx</a></td>
            </tr>
        	<% }
        	}else if (preDeleteList != null && !preDeleteList.isEmpty()){
        		for(int i = 0; i<preDeleteList.size(); i++){%>
        		<tr>
	                <td><%=preDeleteList.get(i).getID() %></td>
	                <td><%=preDeleteList.get(i).getName() %></td>
	                <td><%=preDeleteList.get(i).getDepartmentID() %></td>
	                <td><%=preDeleteList.get(i).getAddress() %></td>
	                <td><a href="<%= request.getContextPath() %>/deleteEach?ID=<%= preDeleteList.get(i).getID() %>">xxx</a></td>
            </tr>
        	<%} 
        	}%>

  	</table>
    <br>
    <p><a href="<%= request.getContextPath()%>">Home page</a></p>
</body>
</html>