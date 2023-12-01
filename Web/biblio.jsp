<%@ page import="java.io.*"%>

<%@ page pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<link rel="stylesheet" type="text/css" href="./css/senie.css">
		<title>Senie</title>
	</head>
	<body background="./images/bg.jpg">

		<center>
		<table border="0" cellpadding="0" cellspacing="0" width="80%" height="100%">
		<tr height="75px">
			<td colspan="2">
				<img src="./images/senie.jpg" width="600px" height="75px" border="0"/>
			</td>
		</tr>

		<% String param_codif = request.getParameter("source"); %>

		<tr height="30px">
			<td colspan="2" bgcolor="#669933">
				<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
				<tr>
					<td>
						<p class="title">Bibliogrāfija (<%= param_codif %>)</p>
					</td>
					<td>
						<p class="navig">
							<a href="./source.jsp?codificator=<%= param_codif %>" class="button">&nbsp;<%= param_codif %>&nbsp;</a>&nbsp;
							<a href="." class="button">&nbsp;SĀKUMLAPA&nbsp;</a>
						</p>
					</td>
				</tr>
				</table>
			</td>
		</tr>

		<%
			String txt_path = config.getServletContext().getRealPath("/") + "biblio/special/";
			String jpg_path = config.getServletContext().getRealPath("/") + "biblio/";

			File f_txt = new File(txt_path + param_codif + ".txt");
			File f_jpg = new File(jpg_path + param_codif + ".jpg");
		%>

		<tr>
			<td width="10%">&nbsp;</td>
			<td bgcolor="#CCFF99">
				<center>
					<p class="biblio">
						<%
							if (f_txt.exists()) {
								FileInputStream stream = new FileInputStream(txt_path + param_codif + ".txt");
								InputStreamReader reader = new InputStreamReader(stream, "Cp1257");
								BufferedReader buffer = new BufferedReader(reader);

								String line = null;
								while ((line = buffer.readLine()) != null) {
									out.println(line);
								}
								buffer.close();
							}
							else {
						%>
						SENIESPIEDUMI  LATVIEŠU  VALODĀ<br>
						1525 - 1855<br>
						Kopkatalogs<br>
						Rīga, LNB, 1999.
						<% } %>
					</p>
					<% if (f_jpg.exists()) { %>
					<img src="./biblio/<%= param_codif %>.jpg" border="0">
					<% } %>
					<br><br>
				</center>
			</td>
		</tr>

		<tr>
			<td colspan="2" height="100%">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<p class="copy">
					&copy; LU Matemātikas un informātikas institūta Mākslīgā intelekta laboratorija<br>
					&copy; LU Humanitāro zinātņu fakultātes Baltu valodu katedra<br>
					&copy; LU Latviešu valodas institūts<br>
					2002-2015
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