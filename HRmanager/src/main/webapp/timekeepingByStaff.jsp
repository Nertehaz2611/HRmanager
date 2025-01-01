<%@ page
	import="java.util.ArrayList, java.time.LocalDate, model.bean.staff, model.bean.timeKeeping"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="cssFile.css">
</head>
<body>
	<%@ include file="header.jsp"%>
	<%
	Object caption = request.getAttribute("caption");
	%>

	<h2 align="center" class="w3-panel"><%=(caption == null) ? "" : caption%></h2>

	<%
	// Nhận tham số từ Servlet hoặc URL
	ArrayList<staff> staffList = (ArrayList<staff>) request.getAttribute("staffList");
	ArrayList<timeKeeping> searchResult = (ArrayList<timeKeeping>) request.getAttribute("searchResult");
	if (searchResult != null && !searchResult.isEmpty()) {
	%>
	<table class="w3-table w3-centered w3-striped w3-hoverable">
		<thead>
			<tr>
				<th>Mã nhân viên</th>
				<th>Họ tên</th>
				<th>Mã phòng ban</th>
				<th>Địa chỉ</th>
				<th>Thời gian chấm công</th>
			</tr>
		</thead>
		<tbody>
			<%
			for (int i = 0; i < searchResult.size(); i++) {
			%>
			<tr>
				<td><%=searchResult.get(i).getStaff().getID()%></td>
				<td><%=searchResult.get(i).getStaff().getName()%></td>
				<td><%=searchResult.get(i).getStaff().getDepartmentID()%></td>
				<td><%=searchResult.get(i).getStaff().getAddress()%></td>
				<td><%=searchResult.get(i).getTime()%></td>
			</tr>
			<%
			}
			%>
		</tbody>
	</table>
	<%
	} else if (staffList != null && !staffList.isEmpty()) {
	%>
	<table class="w3-table w3-centered w3-striped w3-hoverable">
		<thead>
			<tr>
				<th>Mã nhân viên</th>
				<th>Họ tên</th>
				<th>Mã phòng ban</th>
				<th>Địa chỉ</th>
				<th>Lần cuối chấm công</th>
				<th>Trạng thái chấm công trong ngày</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<%
			for (int i = 0; i < staffList.size(); i++) {
			%>
			<tr>
				<td><%=staffList.get(i).getID()%></td>
				<td><%=staffList.get(i).getName()%></td>
				<td><%=staffList.get(i).getDepartmentID()%></td>
				<td><%=staffList.get(i).getAddress()%></td>
				<td><%=staffList.get(i).getLastTimeKeeping()%></td>
				<%
				if (staffList.get(i).getLastTimeKeeping() != null) {
					String dateString = staffList.get(i).getLastTimeKeeping().split(" ")[0];
					LocalDate date = LocalDate.parse(dateString);
					if (!date.isEqual(LocalDate.now())) {
				%>
				<td>Chưa chấm công</td>
				<%
				} else {
				%>
				<td>Hoàn thành</td>
				<%
				}
				%>
				<%
				} else {
				%>
				<td>Chưa chấm công</td>
				<%
				}
				%>
				<td><a
					href='<%=request.getContextPath()%>/timekeepingByStaff?staffID=<%=staffList.get(i).getID()%>'>Tra
						cứu</a></td>
			</tr>
			<%
			}
			%>
		</tbody>
	</table>
	<%
	} else {
	%>
	<h3 align="center" style="color: red">Không tìm thấy dữ liệu</h3>
	<%
	}
	%>
</body>
</html>