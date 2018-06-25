<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.sql.*" %>
<%int rno = Integer.parseInt(request.getParameter("rno"));

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
		
		String Query1 = "select UsrName, UsrMail, UsrSubject, UsrContent from board where RcdNo=?";
		pstmt = conn.prepareStatement(Query1);
		pstmt.setInt(1,rno);
		rs1 = pstmt.executeQuery();
		rs1.next();
		
		String name= rs1.getString(1);
		String mail= rs1.getString(2);
		String subject= rs1.getString(3);
		String content= rs1.getString(4);
		content = content.replaceAll("\n\r","<BR>");
	%>
<HTML>
<HEAD>
	<META HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=euc-kr"/>
	<LINK REL="stylesheet" type="text/css" href="../include/style.css"/>
	<TITLE>�Խñ� ����</TITLE>
	<script type="text/javascript">
	function CheckForm(form){
	if(!form.pass.value){
			alert('�н����带 �Է��Ͻÿ�');
			form.pass.focus();
			return true;
		}
		form.submit();
		
	}
	</script>
</HEAD>

<BODY>

<TABLE WIDTH=620 HEIGHT=40 BORDER=0 CELLSPACING=1 CELLPADDING=1 ALIGN=CENTER>
	<TR BGCOLOR=#A0A0A0>
		<TD ALIGN=CENTER><FONT SIZE=4><B>�Խ��� ( �Խñ� ���� )</B></FONT></TD>
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

<FORM NAME="BoardDelete" METHOD=POST ACTION="BoardDeleteProc.jsp?rno=<%=rno%>&column=<%=column%>&key=<%=encoded_key%>">

<TABLE WIDTH=620 BORDER=1 CELLSPACING=0 CELLPADDING=1 ALIGN=CENTER>

	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>�̸�</B></TD>
		<TD WIDTH=500><%=name%></TD>
	</TR>
	
	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>���ڿ���</B></TD>
		<TD WIDTH=500><%=mail%></TD>
	</TR>
	
	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>����</B></TD>
		<TD WIDTH=500><%=subject%></TD>
	</TR>
	
	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>����</B></TD>
		<TD WIDTH=500><%=content%>></TD>
	</TR>
	
	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>����÷��</B></TD>
		<TD WIDTH=500>÷�ε� ������ �����ϴ�.</TD>
	</TR>
	
	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>�н�����</B></TD>
		<TD WIDTH=500>
			<INPUT TYPE=PASSWORD NAME="pass" SIZE=20>
		</TD>
	</TR>
	
</TABLE>

</FORM>
<%
}
catch(SQLException e) { e.printStackTrace();
}finally{ 
			rs1.close();
			pstmt.close();
			conn.close();
}

%>
<TABLE WIDTH=620 HEIGHT=50 BORDER=0 CELLSPACING=1 CELLPADDING=1 ALIGN=CENTER>

	<TR ALIGN=CENTER>
		<TD>
			<IMG SRC="../images/btn_del.gif" onClick="javascript:CheckForm(BoardDelete)" STYLE=CURSOR:HAND>&nbsp;&nbsp;
			<IMG SRC="../images/btn_cancel.gif?rno=<%=rno%>&column=<%=column%>&key=<%=encoded_key%>" STYLE=CURSOR:HAND>
		</TD>
	</TR>
	
</TABLE>

</BODY>
</HTML>