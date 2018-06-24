<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>

<%request.setCharacterEncoding("euc-kr");%>
<% int rno = Integer.parseInt(request.getParameter("rno"));

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
	
	String mail = request.getParameter("mail");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String passwd = request.getParameter("pass");
	
	String Query1 = "select UsrPass from board where RcdNo=?";
	pstmt = conn.prepareStatement(Query1);
	pstmt.setInt(1,rno);
	rs=pstmt.executeQuery();
	
	rs.next();
	String dbPass = rs.getString(1);
	
	if(passwd.equals(dbPass)){
		String Query2 = "update board set UsrMail=?, UsrSubject=?, UsrContent=? where RcdNo=?";
		pstmt=conn.prepareStatement(Query2);
		pstmt.setString(1,mail);
		pstmt.setString(2,subject);
		pstmt.setString(3,content);
		pstmt.setInt(4,rno);
		
		pstmt.executeUpdate();
		
		rs.close();
		pstmt.close();
		conn.close();
		String retUrl = "BoardContent.jsp?rno="+rno+ "&column="+column+ "&key="+encoded_key;
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

