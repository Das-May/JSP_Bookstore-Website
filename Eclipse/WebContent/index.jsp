<!DOCTYPE html>
<html lang="en">
<head>
	<%@ page import="save.data.Login"%>
	<%@ page import="save.data.Record_Bean"%>
	<%@ page import="java.sql.*"%>
	<%@ page import="javax.sql.DataSource"%>
	<%@ page import="javax.naming.Context"%>
	<%@ page import="javax.naming.InitialContext"%>
	<%@ page contentType="text/html"%>
	<%@ page pageEncoding="utf-8"%>
	<jsp:useBean id="loginBean" class="save.data.Login" scope="session" />
	<jsp:useBean id="admLoginBean" class="save.data.AdmLogin"
		scope="session" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>书城首页</title>
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
		<a href="lookShoppingCart.jsp" target="_top" id="mc-menu-hd">购物车</a> <a
			href="lookOrderForm.jsp" target="_top" id="mc-menu-hd">我的订单</a><a
			href="manageBook.jsp" class="h"> <jsp:getProperty
				name="admLoginBean" property="backNews" /></a>
		</div>
		
	</div>
	<div>
		<%
			//定义初始化
			request.setCharacterEncoding("utf-8");
			Connection con = null;
			Record_Bean dataBean = null;
			//创建bean	
			try {
				dataBean = (Record_Bean) session.getAttribute("dataBean");
				if (dataBean == null) {
					dataBean = new Record_Bean();
					session.setAttribute("dataBean", dataBean);//是session bean。
				}
			} catch (Exception exp) {
			}
			//连接
			try {
				/*连接池*/
				Context context = new InitialContext();
				Context contextNeeded = (Context) context.lookup("java:comp/env");
				DataSource ds = (DataSource) contextNeeded.lookup("mobileConn");//获得连接池
				con = ds.getConnection();//使用连接池中的连接
				/*SQL查询*/
				Statement sql = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
				String query = "SELECT * " + "FROM bookForm";
				ResultSet rs = sql.executeQuery(query);
				ResultSetMetaData metaData = rs.getMetaData();
				int columnCount = metaData.getColumnCount(); //得到结果集的列数。
				rs.last();
				int rows = rs.getRow(); //得到记录数。
				String[][] tableRecord = dataBean.getTableRecord();
				tableRecord = new String[rows][columnCount];
				rs.beforeFirst();
				int i = 0;
				while (rs.next()) {
					for (int k = 0; k < columnCount; k++)
						tableRecord[i][k] = rs.getString(k + 1);
					i++;
				}
				dataBean.setTableRecord(tableRecord); //更新bean
				con.close(); //连接返回连接池
				//response.sendRedirect("index.jsp"); //重定向
			} catch (Exception e) {
				response.getWriter().print("" + e);
			} finally {
				try {
					con.close();
				} catch (Exception ee) {
				}
			}

			//获得dataBean对象
			String[][] table = dataBean.getTableRecord();
			if (table == null) {
				out.print("没有记录");
				return;
			}
			int totalRecord = table.length;
			for (int i = 0; i < totalRecord; i++) {
				if (i == totalRecord)
					break;
				out.print("<div>");
				out.print("<img src = 'img/" + table[i][0] + ".jpg' width = 200 height = 200></img>");
				for (int j = 1; j < table[0].length; j++) {
					if (j < 4)
						out.print("<a>  " + table[i][j] + "  </a>");
					else
						out.print("<br>" + table[i][j]);
				}
				String shopping = "<a class='add' href ='putGoodsServlet?mobileID=" + table[i][0] + "'>添加到购物车</a>";
				out.print("<a>" + shopping + "</a>");
				out.print("</div>");
				out.print("<br><br>");
			}
		%>
		</table>
	</div>
</body>
</html>