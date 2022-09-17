package handle.data;
import save.data.*;
import java.sql.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
public class HandleAdmLogin extends HttpServlet{
   public void init(ServletConfig config) throws ServletException{
      super.init(config);
   }
   public void service(HttpServletRequest request,
                       HttpServletResponse response) 
                       throws ServletException,IOException{
      request.setCharacterEncoding("utf-8");
      Connection con =null; 
      Statement sql; 
      String logname = request.getParameter("logname").trim(),
      password = request.getParameter("password").trim();
      boolean boo=(logname.length()>0)&&(password.length()>0);  
      try{ 
           Context  context = new InitialContext();
           Context  contextNeeded=(Context)context.lookup("java:comp/env");
           DataSource ds = (DataSource)contextNeeded.lookup("mobileConn");//������ӳء�
            con = ds.getConnection();//ʹ�����ӳ��е����ӡ�
           String condition="select * from adm where logname = '"+logname+
            "' and password ='"+password+"'";
           sql=con.createStatement();  
           if(boo){
              ResultSet rs=sql.executeQuery(condition);
              boolean m=rs.next();
              if(m==true){ 
                  //���õ�¼�ɹ��ķ���:
                  success(request,response,logname,password); 
                  RequestDispatcher dispatcher = request.getRequestDispatcher("manageBook.jsp");//ת��
                  dispatcher.forward(request,response);
              }
              else{
                  String backNews="��������û��������ڣ������벻����";
                  //���õ�¼ʧ�ܵķ���:
                  fail(request,response,logname,backNews); 
              }
           }
           else{
                  String backNews="�������û���������";
                  fail(request,response,logname,backNews);
           }
           con.close();//���ӷ������ӳء�
      }
      catch(SQLException exp){
          String backNews=""+exp;
          fail(request,response,logname,backNews);
      }
      catch(NamingException exp){
          String backNews="û���������ӳ�"+exp;
          fail(request,response,logname,backNews); 
      }
      finally{
        try{
             con.close();
        }
        catch(Exception ee){}
      } 
   }
   //��¼�ɹ�
   public void success(HttpServletRequest request,
                       HttpServletResponse response,
                       String logname,String password) {
      AdmLogin admLoginBean = null;//�������Ա��¼bean
      HttpSession session=request.getSession(true);
      try{ admLoginBean=(AdmLogin)session.getAttribute("admLoginBean");
            if(admLoginBean==null){
              admLoginBean = new AdmLogin();  //�����µ�����ģ�� ��
               session.setAttribute("admLoginBean",admLoginBean);
               admLoginBean = (AdmLogin)session.getAttribute("admLoginBean");
            }
            String name = admLoginBean.getLogname();
            if(name.equals(logname)) {
              admLoginBean.setBackNews("����Ա"+logname+"���ѵ�¼");
              admLoginBean.setLogname(logname);
            }
            else {  //����ģ�ʹ洢�µĵ�¼�û�:
               admLoginBean.setBackNews("���ã�����Ա" + logname);
               admLoginBean.setLogname(logname);
            }
      }
      catch(Exception ee){
           admLoginBean=new AdmLogin();  
            session.setAttribute("admLoginBean", admLoginBean);
           admLoginBean.setBackNews(ee.toString());
           admLoginBean.setLogname(logname);
      }
   }
   
   
   //��¼ʧ��
   public void fail(HttpServletRequest request,
                    HttpServletResponse response,
                    String logname,String backNews) {
        response.setContentType("text/html;charset=utf-8");
        try {
            PrintWriter out=response.getWriter();
            out.println("<html><body>");
            out.println("<h2>"+logname+"��¼�������<br>"+backNews+"</h2>") ;
            out.println("���ص�¼ҳ�����ҳ<br>");
            out.println("<a href =admLogin.jsp>��¼ҳ��</a>");
            out.println("<br><a href =index.jsp>��ҳ</a>");
            out.println("</body></html>");
        }
        catch(IOException exp){}
    }
}
