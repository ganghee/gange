<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>

<%request.setCharacterEncoding("euc-kr");%>
<% 
int rno = Integer.parseInt(request.getParameter("rno"));

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs1 = null;
ResultSet rs2 = null;

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

	String Query1="select max(RcdNo) from board";
	pstmt = conn.prepareStatement(Query1);
	rs1 = pstmt.executeQuery();
	rs1.next();
	
	int new_rno = rs1.getInt(1)+1;
	
	String Query2 = "select GrpNo, RcdLevel, RcdOrder FROM board where RcdNo=?";
	pstmt = conn.prepareStatement(Query2);
	pstmt.setInt(1,rno);
	rs2 = pstmt.executeQuery();
	rs2.next();
	
	int gno = rs2.getInt(1);
	int level = rs2.getInt(2);
	int order = rs2.getInt(3);
	int new_level = level+1;
	int new_order = order+1;
	
	String Query3 = "update board set RcdOrder=RcdOrder+1 where GrpNo=? and RcdOrder>?";
	pstmt = conn.prepareStatement(Query3);
	pstmt.setInt(1,gno);
	pstmt.setInt(2,order);
	pstmt.executeUpdate();
	
	String name = request.getParameter("name");
	String mail = request.getParameter("mail");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String pass = request.getParameter("pass");
	String filename = null;
	int filesize = 0;
	int refer = 0;
	long now = System.currentTimeMillis();
	
	String Query4 = "insert into board values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
	pstmt = conn.prepareStatement(Query4);
	pstmt.setInt(1,new_rno);
	pstmt.setInt(2,gno);
	pstmt.setString(3,name);
	pstmt.setString(4,mail);
	pstmt.setString(5,subject);
	pstmt.setString(6,content);
	pstmt.setString(7,pass);
	pstmt.setString(8,filename);
	pstmt.setInt(9,filesize);
	pstmt.setLong(10,now);
	pstmt.setInt(11,refer);
	pstmt.setInt(12,new_level);
	pstmt.setInt(13,new_order);
	pstmt.executeUpdate();
	
}catch(SQLException e){ e.printStackTrace();
}finally{  	rs2.close();
			rs1.close();
			pstmt.close();
			conn.close();
			String retUrl = "BoardList.jsp?column=" + column + "&key=" + encoded_key ;
			response.sendRedirect(retUrl);
}

%>