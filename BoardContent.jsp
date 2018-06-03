<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<<<<<<< HEAD

=======
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.URLEncoder" %>
<% int rno = Integer.parseInt(request.getParameter("rno"));

	Connection conn=null;
	PreparedStatement pstmt = null;
	ResultSet rs1= null;
	
	String encoded_key ="";
	
	String column = request.getParameter("column");
	if(column == null) column="";
	
	String key = request.getParameter("key");
	if(key!=null){
		encoded_key=URLEncoder.encode(key,"euc-kr");
	}else{
		key="";
	}
	
	try{
		String jdbcUrl = "jdbc:mysql://localhost:3306/jspdb";
		String jdbcId = "jspuser";
		String jdbcPw = "jsppass";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection(jdbcUrl,jdbcId,jdbcPw);
		
		String Query1 = "update board set UsrRefer=UsrRefer+1 where RcdNo=?";
		pstmt = conn.prepareStatement(Query1);
		
		pstmt.setInt(1,rno);
		pstmt.executeUpdate();
		
		String Query2 = "select UsrName, UsrMail, UsrSubject, UsrContent from board where RcdNo=?";
		pstmt = conn.prepareStatement(Query2);
		pstmt.setInt(1,rno);
		rs1 = pstmt.executeQuery();
		rs1.next();
		
		String name= rs1.getString(1);
		String mail= rs1.getString(2);
		String subject= rs1.getString(3).trim();
		String content= rs1.getString(4).trim();
		content = content.replaceAll("\r\n","<BR>");
		
		
	
	%>
>>>>>>> version2
<HTML>
<HEAD>
	<META HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=euc-kr"/>
	<LINK REL="stylesheet" type="text/css" href="../include/style.css"/>		
	<TITLE>�Խñ� ���</TITLE>
</HEAD>

<BODY>

<TABLE WIDTH=620 HEIGHT=40 BORDER=0 CELLSPACING=1 CELLPADDING=1 ALIGN=CENTER>
	<TR BGCOLOR=#A0A0A0>
		<TD ALIGN=CENTER><FONT SIZE=4><B>�Խ��� ( �Խñ� ��� )</B></FONT></TD>
	</TR>
</TABLE>

<%
//------------------------------- JSP CODE START ( ���� ������ ���� ���� ���� )
	String member_id = (String)session.getAttribute("member_id");
	if(member_id == null) {
%>
		<jsp:include page="../member/LoginForm.jsp"/>
<% 
	} else { 
%>		
		<jsp:include page="../member/LoginState.jsp"/>	
<% 
	}
//------------------------------- JSP CODE END 	
%>

<BODY>

<TABLE WIDTH=620 BORDER=1 CELLSPACING=0 CELLPADDING=1 ALIGN=CENTER>

	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>�̸�</B></TD>
<<<<<<< HEAD
		<TD WIDTH=500>ȫ�浿</TD>
=======
		<TD WIDTH=500><%=name%></TD>
>>>>>>> version2
	</TR>
	
	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>���ڿ���</B></TD>
<<<<<<< HEAD
		<TD WIDTH=500>hong@abc.com</TD>
=======
		<TD WIDTH=500><%=mail%></TD>
>>>>>>> version2
	</TR>
	
		<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>����</B></TD>
<<<<<<< HEAD
		<TD WIDTH=500>ȫ�浿�Դϴ�.</TD>
=======
		<TD WIDTH=500><%=subject%></TD>
>>>>>>> version2
	</TR>
	
	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>����</B></TD>
<<<<<<< HEAD
		<TD WIDTH=500>�ȳ��ϼ���.<BR>ȫ�浿�Դϴ�.</TD>
=======
		<TD WIDTH=500>�ȳ��ϼ���.<BR><%=content%></TD>
>>>>>>> version2
	</TR>
	
	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>÷������</B></TD>
		<TD WIDTH=500>÷�ε� ������ �����ϴ�.</TD>
	</TR> 
	 
</TABLE>


<TABLE WIDTH=620 HEIGHT=50 BORDER=0 CELLSPACING=1 CELLPADDING=1 ALIGN=CENTER>

	<TR ALIGN=CENTER>
		<TD WIDTH="310" ALIGN=LEFT>
<<<<<<< HEAD
			<IMG SRC="../images/btn_list.gif" STYLE=CURSOR:HAND onClick="javascript:location.replace('BoardList.jsp')">
		</TD>
		<TD WIDTH="310" ALIGN=RIGHT>    	
			<IMG SRC="../images/btn_reply.gif" STYLE=CURSOR:HAND onClick="javascript:location.replace('BoardReply.jsp')">&nbsp;&nbsp;
			<IMG SRC="../images/btn_mdfy.gif" STYLE=CURSOR:HAND onClick="javascript:location.replace('BoardModify.jsp')">&nbsp;&nbsp;
			<IMG SRC="../images/btn_del.gif" STYLE=CURSOR:HAND onClick="javascript:location.replace('BoardDelete.jsp')">
=======
			<IMG SRC="../images/btn_list.gif" STYLE=CURSOR:HAND onClick="javascript:location.replace('BoardList.jsp?column=<%=column%>&key=<%=encoded_key%>')">
		</TD>
		<TD WIDTH="310" ALIGN=RIGHT>    	
			<IMG SRC="../images/btn_reply.gif" STYLE=CURSOR:HAND onClick="javascript:location.replace('BoardReply.jsp?rno=<%=rno%>&column=<%=column%>&key=<%=encoded_key%>')">&nbsp;&nbsp;
			<IMG SRC="../images/btn_mdfy.gif" STYLE=CURSOR:HAND onClick="javascript:location.replace('BoardModify.jsp?rno=<%=rno%>&column=<%=column%>&key=<%=encoded_key%>')">&nbsp;&nbsp;
			<IMG SRC="../images/btn_del.gif" STYLE=CURSOR:HAND onClick="javascript:location.replace('BoardDelete.jsp?rno=<%=rno%>&column=<%=column%>&key=<%=encoded_key%>')">
>>>>>>> version2
		</TD>
	</TR>
	
</TABLE>
<<<<<<< HEAD

=======
<%
}catch(SQLException e){
e.printStackTrace();
}finally{
rs1.close();
pstmt.close();
conn.close();
}%>
>>>>>>> version2
</BODY>
</HTML>