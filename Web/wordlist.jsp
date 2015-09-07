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

		<%
			int current_page = 1; // Tekošās lpp (atvēruma) numurs
			int cursor = 0; // Tekošais DB ieraksts
			int limit = 50; // Līdz kuram DB ierakstam lasīt (drukāt uz ekrāna)

			String param_wf = new String(request.getParameter("wordform").getBytes("8859_1"), "UTF-8");
			String param_limit = request.getParameter("limit");
			String param_page = request.getParameter("page");


				param_wf = param_wf.toLowerCase();

			if (param_page != null) {
				current_page = Integer.parseInt(param_page);
			}

			int offset = current_page * limit - limit + 1; // No kura DB ieraksta lasīt (drukāt uz ekrāna)

			// Pieslēgšanās DB un vaicājumu inicializācija ----------------------------------------
			Properties db_access = new Properties();
			String conf = config.getServletContext().getRealPath("/") + File.separator + "WEB-INF" + File.separator + "db.conf";
			db_access.load(new InputStreamReader(new FileInputStream(conf), "UTF-8"));

			Properties params = new Properties();
			params.put("user", db_access.getProperty("user"));
			params.put("password", db_access.getProperty("password"));
			params.put("charSet", "utf8");

			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection con = DriverManager.getConnection(db_access.getProperty("url"), params);

			PreparedStatement selCaseSensitive = con.prepareStatement(
				"SELECT wordform FROM wordforms WHERE wordform LIKE ? ORDER BY wordform;"
			);
			PreparedStatement selLowerCase = con.prepareStatement(
				"SELECT DISTINCT LOWER(wordform) AS wordform FROM wordforms " +
				"WHERE LOWER(wordform) LIKE ? ORDER BY wordform;"
			);

			ResultSet list = null;
			// ------------------------------------------------------------------------------------


				selLowerCase.clearParameters();
				selLowerCase.setBytes(1, param_wf.getBytes("UTF-8"));
				list = selLowerCase.executeQuery();


			// Saskaita cik ir kopā ierakstu
			int count = 0;
			while (list.next())	{
				count++;
			}
			list.beforeFirst();

			// Aprēķina nepieciešamo atvērumu skaitu
			int page_count = (count / limit) + 1;
		%>

		<tr height="30px">
			<td colspan="2" bgcolor="#669933">
				<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
				<tr>
					<td><p class="title">Vārdformu saraksts</p></td>
					<td>
						<p class="navig">
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
					Vārdformu šablons: <b><%= param_wf %></b><br>
					Vārdformu skaits: <span class="count"><%= count %></span>
				</p>
				<p class="text">

		<%
			// Aiziet līdz tekošās lpp OFFSETam
			for (cursor = 0; list.next() && cursor < (offset - 2); cursor++) {
				// Neko pa ceļam nedara
			}

			// Lasa un drukā līdz nav vairs ierakstu vai ir sasniegts LIMITs
			int temp_limit = 0;
			while (list.next() && temp_limit < limit) {
				out.println(new String(list.getBytes("wordform"), "UTF-8") + "<br>");
				temp_limit++;
			}

			con.close();
		%>

				</p>
			</td>
		</tr>

		<tr>
			<td>&nbsp;</td>
			<!-- Atvērumi START -->
			<td bgcolor="#E8E8E8" valign="middle" align="center">
				<p class="seperator">&nbsp;</p>
				<table border="0">
				<tr><td>

				<%
					// Tā kā vārdforma var būt norādīta kā šablons,
					// "jāeskeipo" procentzīmes
					// TODO: bez %-zīmēm var parādīties vēl kādi "eskeipojami" simboli -
					// String.replaceAll vietā labāk izmantot java.net.URLEncoder
					// TODO: no % vajadzētu pāriet uz * un no _ uz .
					String encoded_wf = param_wf.replaceAll("%", "%25");

					// Ja kreisā konteksta logs nesniedzas līdz pirmajam atvērumam,
					// jāpiedāvā "back" podziņa
					if (current_page - 5 > 1) {
						int back_page = current_page - 5 - 1;
				%>

					<a href="wordlist.jsp?wordform=<%= encoded_wf %>&limit=<%= limit %>&page=<%= back_page %>"
						class="colc">&lt;&lt;</a>

				<%
					}

					// Aprēķina kreisā konteksta logu (līdz piecām lpp)
					int left_page = current_page - 5;
					if (left_page < 1) {
						left_page = 1;
					}

					// Izdrukā kreiso kontekstlogu
					while (left_page < current_page) {
				%>

					<a href="wordlist.jsp?wordform=<%= encoded_wf %>&limit=<%= limit %>&page=<%= left_page %>"
						class="colc"><%= left_page %></a>

				<%
						left_page++;
					}
				%>

				</td>
				<!-- Tekošais atvērums -->
				<td><span class="colcx"><%= current_page %></span></td>

				<%
					int right_page = current_page + 1; // Nākošais potenciālais atvērums

					// Ja vēl ir kāds neizdrukāts DB ieraksts...
					if (right_page <= page_count) {
				%>

				<td align="left" style="valign: middle;">

				<%
						// Izdrukā labo kontekstlogu (līdz piecām lpp)
						while (right_page <= page_count && right_page - current_page <= 5) {
				%>

					<a href="wordlist.jsp?wordform=<%= encoded_wf %>&limit=<%= limit %>&page=<%= right_page %>"
						class="colc"><%= right_page %></a>

				<%
							right_page++;
						}

						// Ja labā konteksta logs nesniedzas līdz pēdējam atvērumam,
						// jāpiedāvā "forward" podziņa
						if (right_page <= page_count) {
							int forward_page = current_page + 5 + 1;
				%>

					<a href="wordlist.jsp?wordform=<%= encoded_wf %>&limit=<%= limit %>&page=<%= forward_page %>"
						class="colc">&gt;&gt;</a>

				<%
						}
					}
				%>

				</td></tr>
				</table>
				<p class="seperator">&nbsp;</p>
			</td>
			<!-- Atvērumi END -->
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