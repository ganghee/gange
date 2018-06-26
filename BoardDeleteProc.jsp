<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.net.URLEncoder"%>

<%request.setCharacterEncoding("euc-kr");%>
<% 
String passwd = request.getParameter("pass");
int rno = Integer.parseInt(request.getParameter("rno"));

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String encoded_key = "";
String column = request.getParameter("column");
if(column==null) column="";
String key = request.getParameter("key");
if(key!=null)  encoded_key=URLEncoder.encode(key,"euc-kr");
else{key="";}

try{ 
	String jdbcURL="jdbc:mysql://localhost:3306/jspdb";
	Class.forName("com.mysql.jdbc.Driver");
	conn=DriverManager.getConnection(jdbcURL,"jspuser","jsppass");
	
	String Query1="select UsrPass, UsrFileName from board where RcdNo=?";
	pstmt = conn.prepareStatement(Query1);
	pstmt.setInt(1,rno);
	rs = pstmt.executeQuery();
	
	rs.next();
	String dbPass=rs.getString(1);
	String filename = rs.getString(2);
	
	if(passwd.equals(dbPass)){
		String Query2="delete from board where RcdNo=" + rno;
		pstmt = conn.prepareStatement(Query2);
		pstmt.executeUpdate(Query2);
		
		if(filename!=null){
			String realFolder = "";
			String saveFolder = "upload_files";
			
			ServletContext context = getServletContext();
			realFolder = context.getRealPath(saveFolder);
			
			String PathAndName = realFolder + "\\" + filename;
			File file = new File(PathAndName);
			
			if(!file.delete()){
				out.println("���� ������ �����߽��ϴ�.");
				
			}
		}
		
		
		rs.close();
		pstmt.close();
		conn.close();
		
		String retUrl = "BoardList.jsp?cloumn="+column+"&key="+encoded_key;
		response.sendRedirect(retUrl);
		
	}else{
		
		rs.close();
		pstmt.close();
		conn.close();
		out.println("<script language=\"javascript\">");
		out.println("alert('�н����尡 Ʋ�Ƚ��ϴ�.')");
		out.println("history.back()");
		out.println("</script>");
		out.flush();
	}
	}catch(SQLException e){ out.print(e);
	}
	
%>


	