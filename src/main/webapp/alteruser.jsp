
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<%@ page import="java.util.Date"%>
	<%@ page import="java.text.SimpleDateFormat"%>
	<%@ page import="java.util.HashMap"%>
	<%@ page import="java.util.Map"%>
	<%@ page import="redis.clients.jedis.Jedis"%>
	<%@ page import="java.util.Date"%>
	<%
		Jedis jedis = new Jedis("localhost");
		String useridstr = request.getParameter("number");
	%>
	<!-- 将修改数据传到当前页面并，存根据传进的id去覆盖掉redis中的信息 -->
	<form action="${pageContext.request.contextPath}/alteruser.jsp"
		method="post">
		<input type="hidden" name="useridstr" value="<%=useridstr%>">
		username:<input type="text" name="username"><br>
		userbirthday:<input type="text" name="userbirthday"><br>
		usedescription:<input type="text" name="userdescription"><br>
		useravgscore:<input type="text" name="useravgscore"><br>
		<input type="submit" value=alter>
	</form>
	<hr>
	<form action="${pageContext.request.contextPath}/user.jsp">
		<input type="submit" value=user>
	</form>
	<%
		String idstr = request.getParameter("useridstr");
		String name = request.getParameter("username");
		String birthdaystr = request.getParameter("userbirthday");
		String description = request.getParameter("userdescription");
		String avgscorestr = request.getParameter("useravgscore");
		int maxid = Integer.parseInt(jedis.get("maxuserid"));
		//判断均不为空
		if (idstr == null || name == null || birthdaystr == null || description == null || avgscorestr == null) {
	%>
	<script type='text/javaScript'>
		alert('name,birthday,description,avgscore,均不能为空');
		window.location.reload;
	</script>
	<%
		} else {
			//用户名长度限制
			if (name.length() > 40) {
	%>
	<script type='text/javaScript'>
		alert('用户名长度>40');
		window.location.reload;
	</script>
	<%
		}
			//备注长度限制
			if (description.length() > 255) {
	%>
	<script type='text/javaScript'>
		alert('id长度>40');
		window.location.reload;
	</script>
	<%
		}
			//日期格式限制
			boolean date = "0000-00-00".matches("\\d{4}-\\d{2}-\\d{2}");
			if (birthdaystr != null && !date) {
	%>
	<script type='text/javaScript'>
		alert('请按0000-00-00格式输入生日');
		window.location.reload;
	</script>
	<%
		}
			//平均分格式限制
			boolean avg = "00".matches("\\d{2}");
			if (avgscorestr != null && !avg) {
	%>
	<script type='text/javaScript'>
		alert('请按00格式输入平均分');
		window.location.reload;
	</script>
	<%
		}
			int avgscore = 0;
			avgscore = Integer.parseInt(avgscorestr);
			//转化日期类型
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date ibirthday = sdf.parse(birthdaystr);
			//存入redis
			Map<String, String> map = new HashMap<String, String>();
			jedis.set("maxuserid", idstr);
			map.put("id", idstr);
			map.put("name", name);
			map.put("birthday", birthdaystr);
			map.put("description", description);
			map.put("avgscore", avgscorestr);
			jedis.zadd("student_table", avgscore, idstr);
			jedis.hmset("student" + idstr, map);
		}
	%>



</body>
</html>