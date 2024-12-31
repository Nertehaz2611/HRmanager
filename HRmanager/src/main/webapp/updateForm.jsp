<%@ page import="java.util.ArrayList, model.bean.department" %>
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
<script>
    function getParameterByName(name) {
            const urlParams = new URLSearchParams(window.location.search);
            return urlParams.get(name);
    }

    window.onload = function() {
    	window.onload = function() {
        	const inputs = document.querySelectorAll("input, textarea"); // Chọn tất cả input và textarea
            inputs.forEach(input => {
                input.dataset.originalValue = input.value; // Lưu giá trị ban đầu vào thuộc tính `data-original-value`
            });
    	}
    }

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

    
    function validateForm() {
            const id = document.getElementsByName("idInput")[0].value;
            const name = document.getElementsByName("nameInput")[0].value;
            const address = document.getElementsByName("addressInput")[0].value;

            // Xóa các thông báo lỗi trước khi kiểm tra mới
            let isValid = true;

            if (id === "") {
                errorAlert("idInput", "ID không được để trống");
                isValid = false;
            }
            
            if (name === "") {
                errorAlert("nameInput", "Tên không được để trống");
                isValid = false;
            }
        

            if (address === "") {
                errorAlert("addressInput", "Địa chỉ không được để trống");
                isValid = false;
            }
            
            const inputs = document.querySelectorAll("input, textarea");
            let isChanged = false; // Cờ để kiểm tra thay đổi

            inputs.forEach(input => {
                if (input.value !== input.dataset.originalValue) { // So sánh giá trị hiện tại với giá trị ban đầu
                    isChanged = true;
                }
            });

            if (!isChanged) {
                isValid = false;
            }

            return isValid;
        }    
</script>
<body>
	<% ArrayList<department> targetDepartment = (ArrayList<department>)request.getAttribute("targetDepartment");
		String IDcheck = (String)request.getAttribute("IDcheck");
		String idInputed = (String)request.getAttribute("idInputed");
		String nameInputed = (String)request.getAttribute("nameInputed");
		String desInputed = (String)request.getAttribute("desInputed");%>
    <h3 style="text-align: center;">Cập nhật phòng ban</h3>
    <%HttpSession sess = request.getSession(false); 
		if(sess.getAttribute("username") != null){ %>
			
    <a href='<%=request.getContextPath() %>/logout' style="margin-left: 80%"><button>Đăng xuất</button></a>
		<%} %>
		
    <form action="<%=request.getContextPath() %>/updateDepartment?" method="post" accept-charset="UTF-8" style="display: flex;" onsubmit="return validateForm();">
        <input type ="hidden" name="originID" value="<%=targetDepartment.get(0).getID() %>">
        <div style="margin-left: 5%;">
            <p><label for="idInput">Mã phòng ban</label></p>
            <p><label for="nameInput">Tên phòng ban</label></p>
            <p><label for="desIDinput">Mô tả</label></p>
        </div>
        <div style="margin-left: 30%;">
            <p>
            	<input type="text" name="idInput" value="<%= (idInputed != null) ? idInputed : targetDepartment.get(0).getID() %>" id="">
            	<span style="color: red"><%if(IDcheck!=null){ %>
            		<%= IDcheck%>
            	<%}%>
            	</span>
            </p>
            <p><input type="text" name="nameInput" value="<%= (nameInputed != null) ? nameInputed : targetDepartment.get(0).getName() %>" id=""></p>
            <p><input type="text" name="desInput" value="<%= (desInputed != null) ? desInputed : targetDepartment.get(0).getDescription() %>" id=""></p>
            <p>
                <input type="submit" value="OK">
                <input type="reset" value="Reset">
            </p>
        </div>
    </form>
    
    <p><a href="<%=request.getContextPath() %>/index.jsp">Home page</a></p>
</body>
</html>