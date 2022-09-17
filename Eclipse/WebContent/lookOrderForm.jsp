<%@ page contentType="text/html"%>
<%@ page pageEncoding="utf-8"%>
<%@ page import="javax.sql.DataSource"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="java.sql.*"%>
<jsp:useBean id="loginBean" class="save.data.Login" scope="session" />
<title>查看订单</title>
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
<HTML>
<body id=tom>
	<div class="menu-hd">
		<div class="l">
			<a href="index.jsp">首页</a>
		</div>
		<div align="right">
			<a href="login.jsp" class="h"> <jsp:getProperty name="loginBean"
					property="backNews" /></a>
			<%
				//如果用户还没有登录
				if (loginBean == null) {
					out.print("<a href=" + "register.jsp" + ">免费注册</a>");
				} else {
					boolean b = loginBean.getLogname() == null || loginBean.getLogname().length() == 0;
					if (b) {
						out.print("<a href=" + "register.jsp" + ">免费注册</a>");
					} else {
						out.print("<a href = " + "exitServlet" + "> 退出 </a>");
					}
				}
			%>
			<a href="lookShoppingCart.jsp" target="_top" id="mc-menu-hd">购物车</a>
			<a href="lookOrderForm.jsp" target="_top" id="mc-menu-hd">我的订单</a>
		</div>

	</div>
	<div align="center">
		<%
			if (loginBean == null) {
				response.sendRedirect("login.jsp");//重定向到登录页面。
				return;
			} else {
				boolean b = loginBean.getLogname() == null || loginBean.getLogname().length() == 0;
				if (b) {
					response.sendRedirect("login.jsp");//重定向到登录页面。
					return;
				}
			}
			Context context = new InitialContext();
			Context contextNeeded = (Context) context.lookup("java:comp/env");
			DataSource ds = (DataSource) contextNeeded.lookup("mobileConn");//获得连接池。
			Connection con = null;
			Statement sql;
			ResultSet rs;
			out.print("<table border=1>");
			out.print("<tr>");
			out.print("<th id=tom width=110>" + "订单序号");
			out.print("<th id=tom width=100>" + "用户名称");
			out.print("<th id=tom width=200>" + "订单信息");
			out.print("</tr>");
			try {
				con = ds.getConnection();//使用连接池中的连接。
				sql = con.createStatement();
				String SQL = "SELECT * FROM orderForm where logname='" + loginBean.getLogname() + "'";
				rs = sql.executeQuery(SQL);//查表。
				while (rs.next()) {
					out.print("<tr>");
					out.print("<td id=tom>" + rs.getString(1) + "</td>");
					out.print("<td id=tom>" + rs.getString(2) + "</td>");
					out.print("<td id=tom>" + rs.getString(3) + "</td>");
					out.print("</tr>");
				}
				out.print("</table>");
				con.close();//连接返回连接池。
			} catch (SQLException e) {
				out.print("<h1>" + e + "</h1>");
			} finally {
				try {
					con.close();
				} catch (Exception ee) {
				}
			}
		%>
	</div>
</body>
</HTML>
