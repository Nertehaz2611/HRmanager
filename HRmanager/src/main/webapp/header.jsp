<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"> 
 <link rel="stylesheet" href="cssFile.css">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
 
</head>
<body>
<body>
	<div class="w3-container" style="background-color: RGB(0, 155, 119);">
		<a href="<%= request.getContextPath()%>/home" class="w3-button"><i class="fa fa-home"></i> Home page</a>
		<div class="w3-dropdown-hover">
			<button class="w3-button"><i class="fa fa-user-circle-o"></i> Nhân viên</button>
			<div class="w3-dropdown-content w3-bar-block w3-border">
				<a href='<%=request.getContextPath()%>/staffList' class="w3-bar-item w3-button" style="width: 200px"><i class="fa fa-bars"></i> Danh sách nhân viên</button></a>
				<a href='<%=request.getContextPath()%>/searchStaff' class="w3-bar-item w3-button"><i class="fa fa-search"></i> Tìm kiếm nhân viên</button></a>
				<a href='<%=request.getContextPath()%>/addStaff' class="w3-bar-item w3-button"><i class="fa fa-plus"></i> Thêm nhân viên</button></a>
				<a href='<%=request.getContextPath()%>/editStaff' class="w3-bar-item w3-button"><i class="fa fa-pencil"></i> Chỉnh sửa thông tin nhân viên</button></a>
				<a href='<%=request.getContextPath()%>/deleteMany' class="w3-bar-item w3-button"><i class="fa fa-trash"></i> Xoá nhân viên</button></a>
			</div>
		</div>
		<div class="w3-dropdown-hover">
			<button class="w3-button"><i class="fa fa-calendar"></i> Chấm công</button>
			<div class="w3-dropdown-content w3-bar-block w3-border">
				<a href='<%=request.getContextPath()%>/timekeepingByTime' class="w3-bar-item w3-button" style="width: 200px"><i class="fa fa-clock-o "></i> Tra cứu theo thời gian</button></a>
				<a href='<%=request.getContextPath()%>/timeKeepingByStaff' class="w3-bar-item w3-button" style="width: 200px"><i class="fa fa-user-circle-o"></i> Tra cứu theo nhân viên</button></a>
			</div>
		</div>
		
		<%HttpSession sess = request.getSession(false); 
		if(sess.getAttribute("username") == null){ %>
	<a href='login.jsp'><button class="w3-button"><i class="fa fa-sign-in"></i> Đăng nhập</button></a>
		<% }else{ %>
	<a href='<%=request.getContextPath() %>/logout'><button class="w3-button"><i class="fa fa-sign-out"></i> Đăng xuất</button></a>
		<% }%>
	</div>
</body>

</body>
</html>