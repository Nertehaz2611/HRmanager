<%@ page import="java.util.ArrayList, model.bean.timeKeeping, model.bean.staff"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function validateForm() {
		let isValid = true;
		
		var startDate = document.getElementsByName("startDate")[0].value;
		var endDate = document.getElementsByName("endDate")[0].value;
		const startDateVal = new Date(startDate);
		const endDateVal = new Date(endDate);
		
		if (endDateVal < startDateVal) {
		    isValid = false;
		}

		if(isValid == false){
			alert("Thời gian đích nhỏ hơn thời gian đầu");
		}
		
		return isValid;
	}
</script>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");
	%>
	<%@ include file="header.jsp"%>

	<h2 align="center">Tra cứu chấm công theo ngày</h2>
	<form class="w3-panel w3-border" method="post"
		action="<%=request.getContextPath()%>/timekeepingByTime"
		style="display: block; margin: auto; margin-top: 10px; justify-content: center; width: 600px; background-color: RGB(0, 155, 119); color: white"
		onsubmit="return validateForm()">
		<div>
			<div style="display: flex; justify-content: center;">
				<p>
					<input type="date" name="startDate" value="[now]" required> - <input
						type="date" name="endDate" required>
				</p>
			</div>
			<p style="display: flex; justify-content: center">
				<input class="w3-button" type="submit" value="OK"> <input
					class="w3-button" type="reset" value="Reset">
			</p>
		</div>
	</form>
	<br>
	<%ArrayList<timeKeeping> timeKeepingList = (ArrayList<timeKeeping>)request.getAttribute("timeKeepingList"); 
	ArrayList<staff> staffList = (ArrayList<staff>)request.getAttribute("staffList");%>
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
</body>
</html>