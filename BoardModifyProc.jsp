<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>

<%request.setCharacterEncoding("euc-kr");%>
<%
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

String realFolder = "";
String saveFolder = "upload_files";
String encType = "euc-kr";
int sizeLimit = 10*1024*1024;
ServletContext context = getServletContext();
realFolder = context.getRealPath(saveFolder);
MultipartRequest multi = null;

try{ 
	String jdbcURL="jdbc:mysql://localhost:3306/jspdb";
	Class.forName("com.mysql.jdbc.Driver");
	conn=DriverManager.getConnection(jdbcURL,"jspuser","jsppass");
	
	multi = new MultipartRequest(request, realFolder, sizeLimit, encType, new DefaultFileRenamePolicy());
	String filename = multi.getFilesystemName("filename");
	
	String mail = multi.getParameter("mail");
	String subject = multi.getParameter("subject");
	String content = multi.getParameter("content");
	String passwd = multi.getParameter("pass");
	
	String Query1 = "select UsrPass,UsrFileName from board where RcdNo=?";
	pstmt = conn.prepareStatement(Query1);
	pstmt.setInt(1,rno);
	rs=pstmt.executeQuery();
	
	rs.next();
	String dbPass = rs.getString(1);
	String oldFilename = rs.getString(2);
	
	if(passwd.equals(dbPass)){
		if(filename !=null){
			if(oldFilename != null){
				String PathAndName = realFolder + "\\" + oldFilename;
				File file1 = new File(PathAndName);
				if(!file1.delete()){
					out.println("파일삭제에 실패했습니다.");
				}
			}
			Enumeration files = multi.getFileNames();
			String fname = (String)files.nextElement();
			File file = multi.getFile(fname);
			int filesize = (int)file.length();
			
			String Query2 = "UPDATE board SET UsrMail=?, UsrSubject=?, UsrContent=?, UsrFileName=?, UsrFileSize=? WHERE RcdNo=?";
			pstmt = conn.prepareStatement(Query2);
			pstmt.setString(1,mail);
			pstmt.setString(2,subject);
			pstmt.setString(3,content);
			pstmt.setString(4,filename);
			pstmt.setInt(5,filesize);
			pstmt.setInt(6,rno);
			
			pstmt.executeUpdate();
		}else{
		
		
		String Query2 = "update board set UsrMail=?, UsrSubject=?, UsrContent=? where RcdNo=?";
		pstmt=conn.prepareStatement(Query2);
		pstmt.setString(1,mail);
		pstmt.setString(2,subject);
		pstmt.setString(3,content);
		pstmt.setInt(4,rno);
		
		pstmt.executeUpdate();
		
		}
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
		out.println("alert('패스워드가 틀렸습니다.')");
		out.println("history.back()");
		out.println("</script>");
		out.flush();
	}
	}catch(SQLException e){ out.print(e);
	}
	
%>

