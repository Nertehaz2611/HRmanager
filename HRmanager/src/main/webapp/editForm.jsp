<%@page import="java.util.ArrayList, model.bean.staff"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
	<%@ include file="header.jsp"%>
	<%
	ArrayList<staff> stlist = (ArrayList<staff>) request.getAttribute("editedStaff");
	staff st = stlist.get(0);
	String originID = st.getID();
	String originName = st.getName();
	String originDepartmentID = st.getDepartmentID();
	String originAddress = st.getAddress();
	ArrayList<String> departmentIDlist = (ArrayList<String>) request.getAttribute("departmentIDlist");
	String idInputed = (String)request.getAttribute("idInputed");
	String nameInputed = (String)request.getAttribute("nameInputed");
	String departmentIDinputed = (String)request.getAttribute("departmentIDinputed");
	String addressInputed = (String)request.getAttribute("addressInputed");
	String idCheck = (String)request.getAttribute("idCheck");
	%>
	<script>
		function errorAlert(existedElement, content) {
			// Lấy phần tử hiện có
			const existingElement = document.getElementsByName(existedElement)[0];

			// Tạo phần tử mới
			const newElement = document.createElement("span");
			newElement.textContent = content;
			newElement.style.color = "red"; // Đặt màu cho thông báo lỗi

			// Xóa các thông báo lỗi cũ nếu có
			if (existingElement.nextSibling
					&& existingElement.nextSibling.tagName === "SPAN") {
				existingElement.nextSibling.remove();
			}

			// Chèn phần tử mới ngay sau phần tử hiện có
			existingElement.insertAdjacentElement("afterend", newElement);
		}
		
		function validateForm() {
		    let isValid = true;
		    let errorMessage = ""; // Biến lỗi độc lập trong JavaScript
			
		    var id = document.getElementsByName("idInput")[0].value;
		    var name = document.getElementsByName("nameInput")[0].value;
		    var departmentID = document.getElementsByName("departmentIDinput")[0].value;
		    var address = document.getElementsByName("addressInput")[0].value;

		    // Chuyển giá trị từ server thành chuỗi JavaScript hợp lệ
		    var originID = "<%=originID%>";
		    var originName = "<%=originName%>";
		    var originDepartmentID = "<%=originDepartmentID%>";
		    var originAddress = "<%=originAddress%>";

			// So sánh giá trị
			if (id === originID && name === originName
					&& departmentID === originDepartmentID
					&& address === originAddress) {
				isValid = false;
				errorMessage = "Thông tin chưa có gì mới để cập nhật";
			}

			// Hiển thị thông báo lỗi nếu có
			if (!isValid) {
				alert(errorMessage); // Hoặc dùng phương pháp khác để hiển thị
			}

			return isValid;
		}
	</script>
	<h2 align="center">Chỉnh sửa thông tin nhân viên</h2>
	<form class="w3-panel w3-border" method="post"
		action="<%=request.getContextPath()%>/editStaff?originID=<%=originID%>"
		style="display: block; margin: auto; margin-top: 10px; width: 400px; background-color: RGB(0, 155, 119); color: white"
		onsubmit="return validateForm()">
		<p>
			<label>Mã nhân viên: </label>
			<input type="text" name="idInput" value="<%=(idInputed != null) ? idInputed : originID %>" required>
			 <p name="idCheck" style="color: red;"><%=(idCheck != null) ? idCheck : "" %></p>
		</p>
		<p>
			<label>Họ tên: </label> 
			<input type="text" name="nameInput" value="<%=(nameInputed != null) ? nameInputed : originName %>" required>
		</p>
		<p>
			<label>Mã phòng ban: </label> <select name="departmentIDinput"
				required>
				<%
				for (int i = 0; i < departmentIDlist.size(); i++) {
				%>
				<option value="<%=departmentIDlist.get(i)%>"
					<%=(departmentIDlist.get(i).equals(originDepartmentID)) ? "selected" : ""%>>
					<%=departmentIDlist.get(i)%>
				</option>
				<%
				}
				%>
			</select>
		</p>
		<p>
			<label>Địa chỉ: </label> <input type="text" name="addressInput"
				value="<%=(addressInputed != null) ? addressInputed : originAddress %>" required>
		</p>
		<p style="display: flex; justify-content: center">
			<input class="w3-button" type="submit" value="OK"> <input
				class="w3-button" type="reset" value="Reset">
		</p>
	</form>
</body>
</html>