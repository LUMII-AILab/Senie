<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<%@ page pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<link rel="stylesheet" type="text/css" href="./senie.css">
		<title>Latviešu valodas seno tekstu korpuss</title>
	</head>
	<body background="./images/bg.jpg">

		<center>
		<table border="0" cellpadding="0" cellspacing="0" width="80%" height="100%">
		<tr height="75px">
			<td colspan="2">
				<img src="./images/senie.jpg" width="600px" height="75px" border="0">
			</td>
		</tr>

		<!-- PIESLĒGŠANĀS DB UN VAICĀJUMU INICIALIZĀCIJA ------------------------------->
		<%
			Properties db_access = new Properties();
			String conf = config.getServletContext().getRealPath("/") + File.separator + "WEB-INF" + File.separator + "db.conf";
			db_access.load(new InputStreamReader(new FileInputStream(conf), "UTF-8"));

			Properties params = new Properties();
			params.put("user", db_access.getProperty("user"));
			params.put("password", db_access.getProperty("password"));
			params.put("charSet", "utf8");

			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection con = DriverManager.getConnection(db_access.getProperty("url"), params);

			PreparedStatement selSources = con.prepareStatement(
				"SELECT codificator, name FROM sources ORDER BY codificator;"
			);
			PreparedStatement selBooks = con.prepareStatement(
				"SELECT codificator, name FROM books ORDER BY codificator;"
			);
		%>
		<!------------------------------------------------------------------------------>

		<tr height="30px">
			<td colspan="2" bgcolor="#669933">
				<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
				<tr>
					<td><p class="title">Lietotie saīsinājumi</p></td>
					<td>
						<p class="navig"><a href="./toc.jsp" class="button">&nbsp;SĀKUMLAPA&nbsp;</a></p>
					</td>
				</tr>
				</table>
			</td>
		</tr>

		<tr>
			<td width="10%">&nbsp;</td>
			<td bgcolor="#CCFF99">
				<p class="chapter" style="margin-bottom: 20px;">Avotu saīsinājumi:</p>
				<table border="0" cellpadding="0" cellspacing="0" style="margin-left: 40px;">
				<%
					ResultSet sources = selSources.executeQuery();
					while (sources.next()) {
				%>
				<tr>
					<td width="100px">
						<p class="code"><%= new String(sources.getBytes("codificator"), "UTF-8") %></p>
					</td>
					<td width="50px" align="center">-</td>
					<td>
						<p class="name"><%= new String(sources.getBytes("name"), "UTF-8") %></p>
					</td>
				</tr>
				<% } %>
				</table>

				<p class="chapter">Bībeles grāmatu saīsinājumi</p>
				<p class="subchap" style="margin-left: 40px;">Jaunā Derība:</p>
				<table border="0" cellpadding="0" cellspacing="0" style="margin-left: 60px;">
				<tr>
					<td colspan="3"><br></td>
				</tr>

				<%
					ResultSet books = selBooks.executeQuery();
					while (books.next()) {
				%>
				<tr>
					<td width="40px">
						<p class="code"><%= new String(books.getBytes("codificator"), "UTF-8") %></p>
					</td>
					<td width="25px" align="center">-</td>
					<td>
						<p class="name"><%= new String(books.getBytes("name"), "UTF-8") %></p>
					</td>
				</tr>
				<%
					}
					con.close();
				%>

				<tr>
					<td colspan="3">&nbsp;</td>
				</tr>
				</table>
			</td>
		</tr>

		<tr>
			<td colspan="2">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<p class="copy">
					&copy; LU MII Mākslīgā intelekta laboratorija<br>
					&copy; LU Filoloģijas fakultātes Baltu valodu katedra<br>2002-2015
				</p>
			</td>
		</tr>
		</table>
		</center>

<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-2563945-3");
pageTracker._trackPageview();
} catch(err) {}</script>

	</body>
</html>