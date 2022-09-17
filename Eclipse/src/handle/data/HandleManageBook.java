package handle.data;
import save.data.AdmLogin;

import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
public class HandleManageBook extends HttpServlet {
	public void init(ServletConfig config) throws ServletException { 
		super.init(config);
	}

	public  void  service(HttpServletRequest request,
			HttpServletResponse response) 
					throws ServletException,IOException {
		request.setCharacterEncoding("utf-8");

		Connection con=null;
		PreparedStatement pre=null; //Ԥ������䡣 
		ResultSet rs;
		String id = request.getParameter("id");
		String book_name = request.getParameter("book_name");
		String book_made = request.getParameter("book_made");
		String price = request.getParameter("book_price");
		System.out.print(price);
		if(price == null || price.length() == 0)
		{
			response.getWriter().print("<a>�۸�Ƿ���</a>");
			System.out.print("222");
			return;
		}

		Float book_price = Float.parseFloat(price);
		String book_describe = request.getParameter("book_describe");
		AdmLogin admLoginBean=null;
		HttpSession session=request.getSession(true);
		//�������Ա��û��¼
		try{ 
			admLoginBean = (AdmLogin)session.getAttribute("admLoginBean");
			if(admLoginBean==null){
				response.sendRedirect("admLogin.jsp");//�ض��򵽵�¼ҳ�档
				return;
			}
			else {
				boolean b = admLoginBean.getLogname()==null||
						admLoginBean.getLogname().length()==0;
				if(b){
					response.sendRedirect("admLogin.jsp");//�ض��򵽵�¼ҳ�档
					return;
				}
			}
		}
		catch(Exception exp){
			response.sendRedirect("admLogin.jsp");//�ض��򵽵�¼ҳ�档
			return;
		}

		//�������ݿ�
		try {
			Context  context = new InitialContext();
			Context  contextNeeded=(Context)context.lookup("java:comp/env");
			DataSource ds = (DataSource)contextNeeded.lookup("mobileConn");//������ӳء�
			con= ds.getConnection();//ʹ�����ӳ��е����ӡ�
			String updateSQL = 
					"update bookForm set book_name =?, book_made = ?, book_price = ?, book_describe = ?"
							+ " where id=?"; //������Ʒ��
			//String insertSQL = "insert into shoppingForm values(?,?,?,?,?)";//��ӵ���Ʒ��
			pre = con.prepareStatement(updateSQL); 
			pre.setString(1,book_name);
			pre.setString(2,book_made);
			pre.setFloat(3,book_price);
			pre.setString(4,book_describe);
			pre.setString(5,id);
			pre.executeUpdate(); 
			//rs = pre.executeQuery();
			con.close();
			response.sendRedirect("manageBook.jsp");//�ض���
		}
		catch(SQLException exp){ 
			response.getWriter().print(""+exp);
			System.out.print(""+exp);
		}
		catch(NamingException exp){}
		finally{
			try{
				con.close();
			}
			catch(Exception ee){}
		}  
	}
}
