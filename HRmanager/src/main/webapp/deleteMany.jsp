<%@ page import="java.util.ArrayList, model.bean.staff"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"> 
 <link rel="stylesheet" href="cssFile.css">
</head>
<body>
	<%request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8"); %>
	<%@ include file="header.jsp" %>
	<%ArrayList<staff> preDeleteList = (ArrayList<staff>)request.getAttribute("preDeleteList"); 
	ArrayList<staff> afterDeleteList = (ArrayList<staff>)request.getAttribute("afterDeleteList"); %>
	<h2 align="center">Xoá nhân viên</h2>
	
		
    <form method="post" action="<%=request.getContextPath() %>/deleteMany">
    <table class="w3-table w3-centered w3-striped w3-hoverable">
            <tr>
             	<th>Mã nhân viên</th><th>Họ tên</th><th>Mã phòng ban</th><th>Địa chỉ</th><th>Xoá</th>
            </tr>
        	<%if(afterDeleteList != null && !afterDeleteList.isEmpty()){
        		for(int i = 0; i<afterDeleteList.size(); i++){%>
        	<tr>
	                <td><%=afterDeleteList.get(i).getID() %></td>
	                <td><%=afterDeleteList.get(i).getName() %></td>
	                <td><%=afterDeleteList.get(i).getDepartmentID() %></td>
	                <td><%=afterDeleteList.get(i).getAddress() %></td>
	                
	                <td><input type="checkbox" name="ID[]" value="<%=afterDeleteList.get(i).getID()%>"></td>
            </tr>
        	<% }
        	}else if (preDeleteList != null && !preDeleteList.isEmpty()){
        		for(int i = 0; i<preDeleteList.size(); i++){%>
        		<tr>
	                <td><%=preDeleteList.get(i).getID() %></td>
	                <td><%=preDeleteList.get(i).getName() %></td>
	                <td><%=preDeleteList.get(i).getDepartmentID() %></td>
	                <td><%=preDeleteList.get(i).getAddress() %></td>
	                <td><input type="checkbox" name="ID[]" value="<%=preDeleteList.get(i).getID()%>"></td>
            </tr>
        	<%} 
        	}%>
        	<tr>
                 <td colspan="5" style="text-align: end;"><input style = "margin-right: 25px" class="w3-button" type="submit" value="Xoá"></td>
           	</tr>

  	</table>
    </form>

</body>
</html>