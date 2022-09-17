<!DOCTYPE html>
<html lang="en">
<head>
<%@ page contentType="text/html"%>
<%@ page pageEncoding="utf-8"%>
<jsp:useBean id="admLoginBean" class="save.data.AdmLogin" scope="session"/><!--使用的bean-->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>管理员登录</title>
</head>
<body>
	<div align="center">
		<table>
			<tr>
				<th>登录</th>
			</tr>
			<form action="admLoginServlet" method="post">
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
		<jsp:getProperty name="admLoginBean" property="backNews" />
	</div>

</body>
</html>