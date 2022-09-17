<!DOCTYPE html>
<html lang="en">
<head>
    <%@ page contentType="text/html" %>
    <%@ page pageEncoding = "utf-8" %>
    <jsp:useBean id="userBean" class="save.data.Register" scope="request"/><!--使用的bean-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>注册</title>
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

</style>
</head>
<body>
<div class="menu-hd" >
		<div class="l">
		<a href="index.jsp">首页</a>
		</div>
	</div>
    <div align="center">
        <form action="registerServlet" method="post">
            <table>
            	<tr><th colspan="2">注册</th></tr>
                <tr><td class="reg-form-item-label">手机号码</td>
                    <td><input placeholder="请输入你的手机号码" type=text name="phone" value=""></td></tr>
                <tr><td>用 户 名:</td>
                    <td><input placeholder="请输入用户名" type=text id=ok name="logname" /></td></tr>
                <tr><td>设置密码:</td><td>
                    <input type=password id=ok name="password"></td>
                <tr><td>重复密码:</td><td>
                    <input type=password id=ok name="again_password"></td>
                <tr><td>邮寄地址:</td>
                    <td><input type=text id=ok name="address"/></td></tr>
                <tr><td>真实姓名:</td>
                    <td><input type=text id=ok name="realname"/></td>
            </table>
            <a role="button" >
                <input type=submit  id=ok value="注册">
            </a>
        </form>
    </div>
    <div align="center">
    	注册反馈：
    	<jsp:getProperty name="userBean"  property="backNews" /> 
    </div>
    
    
</body>
</html>