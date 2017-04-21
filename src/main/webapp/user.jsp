<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ page import="redis.clients.jedis.Jedis" %>
<%@ page import="java.util.Set" %>
<%@ page import="redis.clients.jedis.Tuple" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<form action="${pageContext.request.contextPath}/createuser.jsp">
			<input type="submit" value=create>
	</form>
<hr>

	<%Jedis jedis = new Jedis("localhost");
	int number =1;long topnumber=0;
	long pages=jedis.zcard("student_table");
	String key=null;String key1=null;%>
	<table border="1px;">
	<%String num=request.getParameter("page"); 
	if(request.getParameter("page")!=null){number=Integer.parseInt(num);} 
	if(number*10>pages){topnumber=pages;}else{topnumber=number*10-1;}
	Set<Tuple>  tuples = jedis.zrevrangeWithScores("student_table", (number-1)*10, topnumber); 
	 %><tr> <td>id</td><td>name</td><td>birthday</td><td>discription</td><td>avgscore</td><td>delete</td><td>alter</td></tr>  <%
        for (Tuple t : tuples) {
            	 key1=t.getElement();
            	 key="student"+key1;
            	 
           	%><tr>
           		<td><%=jedis.hmget(key,"id")%></td>
           		<td><%=jedis.hmget(key,"name")%></td>
           		<td><%=jedis.hmget(key,"birthday")%></td>
           		<td><%=jedis.hmget(key,"description")%></td>
           		<td><%=jedis.hmget(key,"avgscore")%></td>
           		<td><a href="${pageContext.request.contextPath}/user.jsp?delete=<%=key1 %>">delete</a><%
           		String deletestudent=request.getParameter("delete");
           		System.out.println(deletestudent);
           		if(deletestudent!=null){
           			jedis.del("student"+deletestudent);
	           		jedis.zrem("student_table", deletestudent);%>
					<script type='javaScript'>;window.location.reload;</script>
					<%}%>
				</td>
           		<td><a href="${pageContext.request.contextPath}/alteruser.jsp?number=<%=key1 %>">alter</a></td>
           	</tr>
        <%}%>
     </table>
     <table>
	<tr><%
	for (int link=1;link<=pages/10+1;link++){
	%><form action="${pageContext.request.contextPath}/user.jsp" method="post">
		<% String s = String.valueOf(link); %>
		<td><a href="${pageContext.request.contextPath}/user.jsp?page=<%=s %>">page<%=s %></a></td> 
		</form>	
	<%} %>
	</tr>
	</table>
</body>
</html>