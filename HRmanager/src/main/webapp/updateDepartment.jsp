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
	<%ArrayList<department> preUpdateList = (ArrayList<department>)request.getAttribute("preUpdateList");
	ArrayList<department> afterUpdateList = (ArrayList<department>)request.getAttribute("afterUpdateList");%>
	<h2 align="center">Cap nhat phong ban</h2>
       <%HttpSession sess = request.getSession(false); 
		if(sess.getAttribute("username") != null){ %>
			
    <a href='<%=request.getContextPath() %>/logout' style="margin-left: 80%"><button>Đăng xuất</button></a>
		<%} %>
		
    <table border="1">
            <tr>
             	<th>Mã phòng ban</th><th>Tên phòng ban</th><th>Mô tả</th><th>Cập nhật</th>
            </tr>
        	<%if(afterUpdateList != null && !afterUpdateList.isEmpty()){
        		for(int i = 0; i<afterUpdateList.size(); i++){%>
        	<tr>
	                <td><%=afterUpdateList.get(i).getID() %></td>
	                <td><%=afterUpdateList.get(i).getName() %></td>
	                <td><%=afterUpdateList.get(i).getDescription() %></td>
	                <td><a href='<%=request.getContextPath()%>/updateDepartment?ID=<%=afterUpdateList.get(i).getID() %>'>xxx</a></td>
            </tr>
        	<% }
        	} else {
	        	for(int i = 0; i<preUpdateList.size(); i++){%>
	        	<tr>
		                <td><%=preUpdateList.get(i).getID() %></td>
		                <td><%=preUpdateList.get(i).getName() %></td>
		                <td><%=preUpdateList.get(i).getDescription() %></td>
		                <td><a href='<%=request.getContextPath()%>/updateDepartment?ID=<%=preUpdateList.get(i).getID() %>'>xxx</a></td>
	            </tr>
	        	<% }
        	} %>

  	</table>
    <br>
    <p><a href="<%= request.getContextPath()%>/index.jsp">Home page</a></p>
</body>
</html>