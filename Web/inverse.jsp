<%@ page import="java.io.*"%>

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

		<!-- PARAMETRU INICIALIZĀCIJA UN PIESLĒGŠANĀS TXT ------------------------------>
		<%
			String param_codif = request.getParameter("source");

			String filename = getServletContext().getRealPath("/") + File.separator + "inverse" + File.separator + param_codif + "_inverse.txt";
			File freqfile = new File(filename);
			BufferedReader reader = null;
			String line = null;

			if (freqfile.exists()) {
				FileInputStream fis = new FileInputStream(freqfile);
				InputStreamReader isr = new InputStreamReader(fis, "Cp1257");
				reader = new BufferedReader(isr);
			}
		%>
		<!------------------------------------------------------------------------------>

		<tr height="30px">
			<td colspan="2" bgcolor="#669933">
				<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
				<tr>
					<td><p class="title">Vārdformu inversā vārdnīca (<%= param_codif %>)</p></td>
					<td>
						<p class="navig">
							<a href="./source.jsp?codificator=<%= param_codif %>" class="button">&nbsp;<%= param_codif %>&nbsp;</a>&nbsp;
							<a href="./statistic.jsp" class="button">&nbsp;STATISTIKA&nbsp;</a>
							<a href="./toc.jsp" class="button">&nbsp;SĀKUMLAPA&nbsp;</a>
						</p>
					</td>
				</tr>
				</table>
			</td>
		</tr>

		<tr>
			<td width="10%">&nbsp;</td>
			<td bgcolor="#CCFF99">
				<p class="text">
				<%
					if (freqfile.exists()) {
						while ((line = reader.readLine()) != null) {
							out.print(line + "<br>");
						}
						reader.close();
					} else {
						out.print("Vārdnīcas fails nav atrasts...");
					}
				%>
				</p>
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