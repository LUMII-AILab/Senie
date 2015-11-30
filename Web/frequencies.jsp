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
			String param_limit = request.getParameter("limit");
			String param_sense = request.getParameter("lower");

			if (param_sense.equals("yes")) {
				param_sense = "nē";
			}
			else {
				param_sense = "jā";
			}

			String filename = getServletContext().getRealPath("/") + File.separator + "freq" + File.separator + param_codif + "_frequencies";
			if (param_sense.equals("nē")) {
				filename = filename + "_lower";
			}
			filename = filename + ".txt";
			File freqfile = new File(filename);

			FileInputStream fis = new FileInputStream(freqfile);
			InputStreamReader isr = new InputStreamReader(fis, "Cp1257");
			BufferedReader reader = new BufferedReader(isr);

			String line = null;
			int count = 0;
			int limit = 0;

			try {
				limit = Integer.parseInt(param_limit);
			}
			catch (Exception e) {}
		%>
		<!------------------------------------------------------------------------------>

		<tr height="30px">
			<td colspan="2" bgcolor="#669933">
				<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
				<tr>
					<td><p class="title">Vārdformu biežuma vārdnīca (<%= param_codif %>)</p></td>
					<td>
						<p class="navig">
							<% if (param_codif.matches("Mt|Mk|Lk|Jn|Apd|Rm|1Kor|2Kor|Gal|Ef|Fil|Kol|1Tes|2Tes|1Tim|2Tim|Tit|Flm|1P|2P|1J|2J|3J|Ebr|Jk|Jud|Atk")) { %>
							<a href="./source.jsp?codificator=JT1685" class="button">&nbsp;JT1685&nbsp;</a>&nbsp;
							<% } else if (param_codif.matches("1Moz|2Moz|3Moz")) { %>
							<a href="./source.jsp?codificator=VD1694" class="button">&nbsp;VD1694&nbsp;</a>&nbsp;
							<% } else if (!param_codif.equals("SENIE")) { %>
							<a href="./source.jsp?codificator=<%= param_codif %>" class="button">&nbsp;<%= param_codif %>&nbsp;</a>&nbsp;
							<% } %>
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
				<p class="text"><b>
					Kopējais vārdformu skaits: <span class="count"><%= reader.readLine() %></span><br>
					Kopējais vārdlietojumu skaits: <span class="count"><%= reader.readLine() %></span>
				</b></p>
				<p class="text"><b>
					Saraksta limits: <span class="count"><%= param_limit %></span><br>
					Reģistrjūtība: <span class="count"><%= param_sense %></span>
				</b></p>

<pre class="text">
<%
	while ((line = reader.readLine()) != null) {
		if (count == limit) break;
		out.print(line + "<br>");
		count++;
	}
	reader.close();
%>
</pre>

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