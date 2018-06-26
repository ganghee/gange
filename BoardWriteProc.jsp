<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%request.setCharacterEncoding("euc-kr");%>

<%
String filename = null;
int filesize =0;
String saveFolder = "upload_files";
ServletContext context = getServletContext();
String realFolder = context.getRealPath(saveFolder);

int sizeLimit = 10*1024*1024;
String encType = "euc-kr";
DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();

Connection conn = null;
Statement stmt = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try{
String jdbcUrl = "jdbc:mysql://localhost:3306/jspdb";
String jdbcId = "jspuser";
String jdbcPw = "jsppass";

Class.forName("com.mysql.jdbc.Driver");
conn = DriverManager.getConnection(jdbcUrl,jdbcId,jdbcPw);

MultipartRequest multi = new MultipartRequest(request, realFolder, sizeLimit, encType, policy);
filename = multi.getFilesystemName("filename");

if(filename!=null){
	Enumeration files = multi.getFileNames();
	String fname = (String)files.nextElement();
	File file = multi.getFile(fname);
	filesize = (int)file.length();
}

String name = multi.getParameter("name");
String mail = multi.getParameter("mail");
String subject = multi.getParameter("subject");
String content = multi.getParameter("content");
String pass = multi.getParameter("pass");

String Query1 = "SELECT max(RcdNo),max(GrpNo) FROM board";
stmt = conn.createStatement();
rs = stmt.executeQuery(Query1);

rs.next();

int uid = (rs.getInt(1))+1;
int gid = (rs.getInt(2))+1;


int refer = 0;
int level = 0;
int order = 1;
long now = System.currentTimeMillis();

String Query2= "INSERT INTO board VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)";
pstmt = conn.prepareStatement(Query2);
pstmt.setInt(1,uid);
pstmt.setInt(2,gid);
pstmt.setString(3,name);
pstmt.setString(4,mail);
pstmt.setString(5,subject);
pstmt.setString(6,content);
pstmt.setString(7,pass);
pstmt.setString(8,filename);
pstmt.setInt(9,filesize);
pstmt.setLong(10,now);
pstmt.setInt(11,refer);
pstmt.setInt(12,level);
pstmt.setInt(13,order);

pstmt.executeUpdate();
}catch (SQLException e){
out.print(e);
}finally{
rs.close();
pstmt.close();
stmt.close();
conn.close();
response.sendRedirect("BoardList.jsp");
}
%>