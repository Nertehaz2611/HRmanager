<%@ page import="java.util.ArrayList, model.bean.staff" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="cssFile.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"> 
</head>
<script>
	document.getElementById("myIframe").addEventListener("load", function () {
	    try {
	        // Truy cập nội dung của iframe
	        const iframeDocument = this.contentDocument || this.contentWindow.document;
	
	        // Tìm phần tử muốn xóa (thay 'selector' bằng selector phù hợp)
	        const elementToRemove = iframeDocument.querySelector("a");
	
	        if (elementToRemove) {
	            elementToRemove.remove(); // Loại bỏ phần tử
	            console.log("Phần tử đã bị loại bỏ.");
	        } else {
	            console.log("Không tìm thấy phần tử cần xóa.");
	        }
	    } catch (e) {
	        console.error("Không thể truy cập nội dung của iframe. Có thể do chính sách same-origin.");
	    }
	});
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
	<%request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8"); %>
	<%@ include file="header.jsp" %>
	<% ArrayList<String> departmentIDList = (ArrayList<String>)request.getAttribute("departmentIDList");
		String IDcheck = (String)request.getAttribute("IDcheck");
		String idInputed = (String)request.getAttribute("idInputed");
		String nameInputed = (String)request.getAttribute("nameInputed");
		String departmentIDinputed = (String)request.getAttribute("departmentIDinputed");
		String addressInputed = (String)request.getAttribute("addressInputed");
		ArrayList<staff> preDeleteList = (ArrayList<staff>)request.getAttribute("preDeleteList"); 
		ArrayList<staff> afterDeleteList = (ArrayList<staff>)request.getAttribute("afterDeleteList");
	%>
	
    <h2 style="text-align: center;">Thêm nhân viên</h2>
    
    <form class="w3-panel w3-border" action="<%=request.getContextPath() %>/addStaff" method="post" accept-charset="UTF-8" 
    	style="display: block; margin: auto; justify-content: center; width: 400px; background-color: RGB(0, 155, 119); color: white" onsubmit="return validateForm();">
        <div style="margin-left: 5%;">
            <p>
            	<label style="width: 120px; display: inline-block" for="idInput">Mã nhân viên</label>
            	<input type="text" name="idInput" value="<%if(idInputed != null)%><%=idInputed %>" id="">
            	<span style="color: red"><%if(IDcheck!=null){ %>
            		<%= IDcheck%>
            	<%}%>
            	</span>
            </p>
            <p>
            	<label style="width: 120px; display: inline-block" for="nameInput">Họ tên</label>
            	<input type="text" name="nameInput" value="<%if(nameInputed != null)%><%=nameInputed %>" id="">
            </p>
            <p>
            	<label style="width: 120px; display: inline-block" for="departmentIDinput">Mã phòng ban</label>
            	<select name="departmentIDinput" id="">
                    <%for(int i = 0; i<departmentIDList.size(); i++){
                    	if(departmentIDList.get(i).equals(departmentIDinputed)){
                    		%><option value="<%=departmentIDList.get(i) %>" selected><%=departmentIDList.get(i) %></option>
                    	<%} else{
                    		
                    	%><option value="<%=departmentIDList.get(i) %>"><%=departmentIDList.get(i) %></option>
                    	<%}
                    }%>
                </select>
            </p>
            <p>
            	<label style="width: 120px; display: inline-block" for="addressInput">Địa chỉ</label>
            	<input type="text" name="addressInput" value="<%if(addressInputed != null)%><%=addressInputed %>" id="">
            </p>
            <p style="display: flex; justify-content: center">
                <input class="w3-button" type="submit" value="OK">
                <input class="w3-button" type="reset" value="Reset">
            </p>
        </div>
    </form>
    <%@ include file="staffTable.jsp" %>
    
    <p><a href="<%=request.getContextPath() %>/index.jsp">Home page</a></p>
</body>
</html>