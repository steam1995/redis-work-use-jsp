<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<form action="/Test/createuser.jsp">
			<input type="submit" value=create>
	</form>
<hr>
<%@ page import="redis.clients.jedis.Jedis" %>
<form action="/Test/user.jsp"method="post">
	row :<input type="text" name="row"><br>
	col :<input type="text" name="col"><br>
	<input type="submit" value="print">
</form>
<hr>
	<form action="/Test/createuser.jsp" meeth="post">
	<input type="submit" value=跳转>
	</form>
<hr>
<%

	String row=request.getParameter("row");
	String col=request.getParameter("col");
	
	int a=0;
	int b=0;
	if(row !=null){a=Integer.parseInt(row);}
	if(col !=null){b=Integer.parseInt(col);}
	
%>
 <table border="1px;">
 <tr>
<td><%="test"%></td>
<%if (a>10){ %>
<script type='text/javaScript'>alert('a>8');window.location.reload;</script>

<%} %>

 </tr>z
 
 </table>
</body>
</html>