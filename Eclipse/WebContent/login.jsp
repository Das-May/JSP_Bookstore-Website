<!DOCTYPE html>
<html lang="en">
<head>
<%@ page contentType="text/html"%>
<%@ page pageEncoding="utf-8"%>
<jsp:useBean id="loginBean" class="save.data.Login" scope="session"/><!--使用的bean-->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>用户登录</title>
	<style>
blockquote, body, button, dd, dl, dt, fieldset, form, h1, h2, h3, h4, h5,
	h6, hr, input, legend, li, ol, p, pre, td, textarea, th, ul {
	margin: 0;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	margin-left: 0px;
	padding: 0;
	padding-top: 0px;
	padding-right: 0px;
	padding-bottom: 0px;
	padding-left: 0px;
}

.menu-hd {
	background-color: rgb(138, 209, 188);
	height: 30px;
	line-height: 30px;
	overflow: hidden;
}

.l {
	float: left;
	margin-left: 0.5%;
}

a {
	text-decoration: none;
	color: #000;
}

.menu-hd a:hover {
	background-color: white;
}

.add {
	background-color: rgb(37, 79, 52);
	color: white;
}
</style>
</head>
<body>
<div class="menu-hd" >
		<div class="l">
		<a href="index.jsp">首页</a>
		</div>
	</div>
	<div align="center">
		<table>
			<tr>
				<th colspan="2">登录</th>
			</tr>
			<form action="loginServlet" method="post">
				<tr>
					<td>用户名:</td>
					<td><input type=text id=tom name="logname"></td>
				</tr>
				<tr>
					<td>密 码:</td>
					<td><input type=password id=tom name="password"></td>
				</tr>
		</table>
		<a role="button"> <input type=submit id=ok value="登录">
		</a>
		</form>
	</div>
	<div align="center">
		<jsp:getProperty name="loginBean" property="backNews" />
	</div>

</body>
</html>