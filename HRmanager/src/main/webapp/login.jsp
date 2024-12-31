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
<body>
	<form class="w3-panel w3-border" action="<%=request.getContextPath() %>/login" method="post"
	style="display: block; margin: auto; justify-content: center; width: 400px; background-color: RGB(0, 155, 119); color: white">
		<p><label for="username">Username: </label><input type="text" name="username" value="${cookie.username.value }"></p>
		<p><label for="password">Password: </label><input type="password" name="password" value="${cookie.password.value }"></p>
		<p style="display: flex; justify-content: center">
                <input class="w3-button" type="submit" value="Login">
                <input class="w3-button" type="reset" value="Reset">
        </p>
		<h3 style="color:red">
			${loginErr}
		</h3>
	</form>
</body>
</html>