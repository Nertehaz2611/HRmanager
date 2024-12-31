<%@ page import="java.util.ArrayList, model.bean.staff"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="cssFile.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"> 
<script>
        function errorAlert(existedElement, content){
            // Lấy phần tử hiện có
            const existingElement = document.getElementsByName(existedElement)[0];
            
            // Tạo phần tử mới
            const newElement = document.createElement("span");
            newElement.textContent = content;
            newElement.style.color = "red"; // Đặt màu cho thông báo lỗi
            
            // Xóa các thông báo lỗi cũ nếu có
            if (existingElement.nextSibling && existingElement.nextSibling.tagName === "SPAN") {
                existingElement.nextSibling.remove();
            }
            
            // Chèn phần tử mới ngay sau phần tử hiện có
            existingElement.insertAdjacentElement("afterend", newElement);
        }
        function validateForm(){
            let isValid = true;
            var searchInput = document.getElementsByName("searchInfo")[0].value;
            var radioInput = document.querySelector("input[name='searchRadio']:checked");
                if (!radioInput) {
                    errorAlert("radioContainer", "Chưa chọn trường tìm kiếm");
                    isValid = false;
                }
                else if (searchInput === "") {
                    errorAlert("searchInfo", "Chưa nhập thông tin");
                    isValid = false;
                }
            return isValid;
        }
    </script>
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
	<%request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8"); %>
	<%@ include file="header.jsp" %>

            <h2 align="center">Tìm kiếm nhân viên</h2>
    <form class="w3-panel w3-border" method="post" action="<%=request.getContextPath() %>/searchStaff" 
    style="display: block; margin: auto; margin-top: 10px; justify-content: center; width: 600px; background-color: RGB(0, 155, 119); color: white" onsubmit="return validateForm()">
        <div>
        	<div style="display: flex; justify-content: center;">
	            <p>
	            	<select name="searchKeyword">
	            		<option value="IDNV"> Mã nhân viên</option>
	            		<option value="Hoten"> Họ tên</option>
	            		<option value="IDPB"> Mã phòng ban</option>
	            		<option value="Diachi">Địa chỉ</option>
	            	</select>
	                	<span>Nhập thông tin: </span>
	                	<input type="text" name="searchInfo">
	            </p>
            </div>
            <p style="display: flex; justify-content: center">
                <input class="w3-button" type="submit" value="OK">
                <input class="w3-button" type="reset" value="Reset">
            </p>
        </div>
    </form>
    <br>
    <%@ include file="staffTable.jsp" %>
    
</body>
</html>