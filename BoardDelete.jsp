<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<<<<<<< HEAD

=======
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
>>>>>>> version2
<HTML>
<HEAD>
	<META HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=euc-kr"/>
	<LINK REL="stylesheet" type="text/css" href="../include/style.css"/>
	<TITLE>�Խñ� ����</TITLE>
<<<<<<< HEAD
=======
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
>>>>>>> version2
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

<<<<<<< HEAD
<FORM NAME="BoarDelete" METHOD=POST ACTION="BoardDeleteProc.jsp">
=======
<FORM NAME="BoardDelete" METHOD=POST ACTION="BoardDeleteProc.jsp?rno=<%=rno%>&column=<%=column%>&key=<%=encoded_key%>">
>>>>>>> version2

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
		<TD WIDTH=500><%=content%>></TD>
>>>>>>> version2
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
<<<<<<< HEAD

=======
<%
}
catch(SQLException e) { e.printStackTrace();
}finally{ 
			rs1.close();
			pstmt.close();
			conn.close();
}

%>
>>>>>>> version2
<TABLE WIDTH=620 HEIGHT=50 BORDER=0 CELLSPACING=1 CELLPADDING=1 ALIGN=CENTER>

	<TR ALIGN=CENTER>
		<TD>
<<<<<<< HEAD
			<IMG SRC="../images/btn_del.gif" STYLE=CURSOR:HAND>&nbsp;&nbsp;
			<IMG SRC="../images/btn_cancel.gif" STYLE=CURSOR:HAND>
=======
			<IMG SRC="../images/btn_del.gif" onClick="javascript:CheckForm(BoardDelete)" STYLE=CURSOR:HAND>&nbsp;&nbsp;
			<IMG SRC="../images/btn_cancel.gif?rno=<%=rno%>&column=<%=column%>&key=<%=encoded_key%>" STYLE=CURSOR:HAND>
>>>>>>> version2
		</TD>
	</TR>
	
</TABLE>

</BODY>
</HTML>