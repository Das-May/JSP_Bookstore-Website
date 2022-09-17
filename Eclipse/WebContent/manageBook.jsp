<%@ page import="save.data.Login"%>
<%@ page import="save.data.Record_Bean"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.DataSource"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page contentType="text/html"%>
<%@ page pageEncoding="utf-8"%>
<jsp:useBean id="admLoginBean" class="save.data.AdmLogin"
	scope="session" />
<title>管理网站</title>
<HTML>
<head>
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
<body background=image/back.jpg id=tom>
	<div class="menu-hd">
		<div class="l">
			<a href="index.jsp">首页</a>
		</div>
		<div align="right">
			<a href="manageBook.jsp" class="h"> <jsp:getProperty
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
			//如果管理员还没登录
			if (admLoginBean == null) {
				response.sendRedirect("admLogin.jsp");//重定向到登录页面
				return;
			} else {
				boolean b = admLoginBean.getLogname() == null || admLoginBean.getLogname().length() == 0;
				if (b) {
					response.sendRedirect("admLogin.jsp");//重定向到登录页面
					return;
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
				out.print("<div><form action='manageServlet?id=" + table[i][0] + "' method='post'>");
				out.print("<img src = 'img/" + table[i][0] + ".jpg' width = 200 height = 200></img>");
				out.print("<br><input type=text value =" + table[i][1] + " name =" + "book_name" + ">");
				out.print("<br><input type=text value =" + table[i][2] + " name =" + "book_made" + ">");
				out.print("<br><input type=text value =" + table[i][3] + " name ='book_price'>");
				out.print("<br><input type=text value =" + table[i][4] + " name =" + "book_describe" + ">");
				//out.print("<a href='manageServlet?id=" + table[i][0] + "'>修改</a>");
				out.print("<br><input type=submit value='提交'>");
				out.print("</form></div>");
				out.print("<br><br>");
			}
		%>
	</div>
</body>
</HTML>
