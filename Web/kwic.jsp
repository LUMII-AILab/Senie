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

		<script type="text/javascript" language="JavaScript">
			function printPosCount(count) {
				if (document.all){
					document.all['total'].innerText = count;
				}
				else if (document.getElementById){
					document.getElementById('total').innerHTML = count;
				}
			}
		</script>
	</head>
	<body background="./images/bg.jpg">
		<center>
		<table border="0" cellpadding="0" cellspacing="0" width="80%" height="100%">
		<tr height="75px">
			<td colspan="2">
				<img src="./images/senie.jpg" width="600px" height="75px" border="0">
			</td>
		</tr>

		<tr height="30px">
			<td colspan="2" bgcolor="#669933">
				<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
				<tr>
					<td><p class="title">Konkordances rezultāts</p></td>
					<td><p class="navig">
						<a href="./concordance.jsp" class="button">&nbsp;KONKORDANCE&nbsp;</a>&nbsp;
						<a href="./senie.jsp" class="button">&nbsp;SĀKUMLAPA&nbsp;</a>
					</p></td>
				</tr>
				</table>
			</td>
		</tr>


		<!-- PIESLĒGŠANĀS DB UN VAICĀJUMU INICIALIZĀCIJA  ------------------------------>
		<%
			String param_wf = new String(request.getParameter("wordform").getBytes("8859_1"), "UTF-8");
			String param_src[] = request.getParameterValues("source");
			String param_coco = request.getParameter("context");
			String param_limit = request.getParameter("limit");
			String param_page = request.getParameter("page");

			int coco = 30;
			try {
				coco = Integer.parseInt(param_coco);
			}
			catch (Exception e) {}


			String letter;
			int current_page;
			int limit=50;
			int count5 = 0;
			int j = 0;

			if (param_limit != null) {
				limit = Integer.parseInt(param_limit);
			}

			if (param_page == null)
			{
				current_page = 1;
			}
			else
			{
				current_page = Integer.parseInt(param_page);
			}
			int offset = current_page * limit - limit + 1;

			String lr_row = "";
			String lr_page = "";
			String lr_source = "";

			Properties db_access = new Properties();
			String conf = config.getServletContext().getRealPath("/") + File.separator + "WEB-INF" + File.separator + "db.conf";
			db_access.load(new InputStreamReader(new FileInputStream(conf), "UTF-8"));

			Properties params = new Properties();
			params.put("user", db_access.getProperty("user"));
			params.put("password", db_access.getProperty("password"));
			params.put("charSet", "utf8");

			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection con = DriverManager.getConnection(db_access.getProperty("url"), params);

			PreparedStatement sumGNP = con.prepareStatement(
				"SELECT SUM(count) AS summ FROM gnp_positions WHERE crossform = ? ;"
			);
			PreparedStatement sumLR = con.prepareStatement(
				"SELECT SUM(count) AS summ FROM lr_positions WHERE crossform = ? ;"
			);
			PreparedStatement sumP = con.prepareStatement(
				"SELECT SUM(count) AS summ FROM p_positions WHERE crossform = ? ;"
			);
			PreparedStatement selGNP = con.prepareStatement(
				"SELECT b.codificator AS book, p.chapter AS chapter, p.verse AS verse, p.context AS context "+
				"FROM gnp_positions p "+
				"LEFT JOIN books b ON p.book = b.id "+
				"WHERE p.crossform = ? ;"
			);
			PreparedStatement selLR = con.prepareStatement(
				"SELECT id, page, row, context FROM lr_positions WHERE crossform = ? ;"
			);
			PreparedStatement selP = con.prepareStatement(
				"SELECT id, verse, context FROM p_positions WHERE crossform = ? ;"
			);
			PreparedStatement contGNP = con.prepareStatement(
				"SELECT id, plain FROM gnp_contexts WHERE id = ? ;"
			);
			PreparedStatement contLR = con.prepareStatement(
				"SELECT id, source, page, row, plain FROM lr_contexts WHERE id = ? ;"
			);
			PreparedStatement contP = con.prepareStatement(
				"SELECT id, plain FROM p_contexts WHERE id = ? ;"
			);

			PreparedStatement selAll = null;
			PreparedStatement selDistinctAll = null;
			PreparedStatement selSrc = null;
			PreparedStatement selDistinctSrc = null;

			ResultSet words = null;
			ResultSet pos = null;
			ResultSet count = null;
			ResultSet context = null;
			ResultSet context3 = null;

			int wf_count = 0;
			String query = "";

			if (param_src[0].equals("SENIE")) {
			    query = "SELECT id FROM wordforms ";

					query = query + "WHERE LOWER(wordform) LIKE ? ;";
					param_wf = param_wf.toLowerCase();


				selDistinctAll = con.prepareStatement(query);
				selDistinctAll.clearParameters();
			    selDistinctAll.setBytes(1, param_wf.getBytes("UTF-8"));
				count = selDistinctAll.executeQuery();
				count.last();
				wf_count = count.getRow();

				query = "SELECT w.wordform AS wf, s.codificator AS src, c.id AS cf FROM wordforms w LEFT JOIN crossforms c ON w.id = c.wordform LEFT JOIN sources s ON c.source = s.id ";

					query = query + "WHERE LOWER(w.wordform) LIKE ?";  //LIKE ?
					param_wf = param_wf.toLowerCase();


				query = query + "ORDER BY w.wordform;";
				selAll = con.prepareStatement(query);
				selAll.clearParameters();
			    selAll.setBytes(1, param_wf.getBytes("UTF-8"));
				words = selAll.executeQuery();
			}
			else {
				query = "FROM wordforms w LEFT JOIN crossforms c ON w.id = c.wordform LEFT JOIN sources s ON c.source = s.id ";

					query = query + "WHERE (LOWER(w.wordform) LIKE ?) AND (";
					param_wf = param_wf.toLowerCase();


				for (int i = 0; i < param_src.length; i++) {
					query = query + "(s.codificator = '" + param_src[i] + "')";
					if (i + 1 != param_src.length) {
						query = query + " OR ";
					}
				}
				query = query + ") ORDER BY w.wordform;";

				selDistinctSrc = con.prepareStatement("SELECT DISTINCT w.wordform AS wf " + query);
				selDistinctSrc.clearParameters();
			    selDistinctSrc.setBytes(1, param_wf.getBytes("UTF-8"));
				count = selDistinctSrc.executeQuery();
				count.last();
				wf_count = count.getRow();

				selSrc = con.prepareStatement("SELECT w.wordform AS wf, s.codificator AS src, c.id AS cf " + query);
				selSrc.clearParameters();
			    selSrc.setBytes(1, param_wf.getBytes("UTF-8"));
				words = selSrc.executeQuery();
			}
		%>
		<!------------------------------------------------------------------------------>

		<tr>
			<td width="10%">&nbsp;</td>
			<td bgcolor="#CCFF99">
				<p class="text">
					Vārdformas šablons: <b><%= param_wf %></b><br>
					<%
						if (param_src.length > 1) {
							out.print("Avoti: ");
						}
						else {
							out.print("Avots: ");
						}

						for (int i = 0; i < param_src.length; i++) {
							out.print(param_src[i]);
							if (i + 1 != param_src.length) {
								out.print(", ");
							}
						}
					%>
					<br>
					Statistika: vārdformas - <span class="count"><%= wf_count %></span>,
					vārdlietojumi - <span id="total" class="count"></span>
				</p>

				<center>
				<table cellpadding="3" cellspacing="0" style="border: solid 1px #669933; background-color: #EEFFBB;">

		<%
			int total = 0;
			int begin = 0;
			int end = 0;
			int skaits = 0;
			int k = 0;

			String plain = "";
			String temp = "";

			while (words.next()) {
				int cf = words.getInt("cf");
				String wf = new String(words.getBytes("wf"), "UTF-8");
				String src = new String(words.getBytes("src"), "UTF-8");

				sumGNP.clearParameters();
				sumGNP.setInt(1, cf);
				count = sumGNP.executeQuery();
				count.first();
				int summ = count.getInt("summ");

				sumLR.clearParameters();
				sumLR.setInt(1, cf);
				count = sumLR.executeQuery();
				count.first();
				summ = summ + count.getInt("summ");

				sumP.clearParameters();
				sumP.setInt(1, cf);
				count = sumP.executeQuery();
				count.first();
				summ = summ + count.getInt("summ");

				total = total + summ;

				selGNP.clearParameters();
				selGNP.setInt(1, cf);
				pos = selGNP.executeQuery();

				for (j=k;pos.next() && j<(offset-2);j++)
				{
					//out.println(j);
				}
				k=j;
				if (j==0)
				{pos.previous();}
				pos.previous();

				while (pos.next() && count5 < limit) {
					contGNP.clearParameters();
				    contGNP.setInt(1, pos.getInt("context"));

					context = contGNP.executeQuery();
					context.first();

					plain = new String(context.getBytes("plain"), "UTF-8");
					temp = new String(plain);

					while (temp.indexOf(" " + wf + " ") != -1) {
  						temp = temp.substring(0, temp.indexOf(" " + wf + " ")) + "©" +
	    				temp.substring(temp.indexOf(" " + wf + " ") + wf.length() + 2, temp.length());
					}

					begin = 0;
					end = 0;
					skaits = 0;
					while (temp.indexOf("©") != -1) {
						if (temp.indexOf("©") - coco > 0) {
							begin = temp.indexOf("©") + (skaits * (wf.length() + 2)) - coco;
						}
						else {
							begin = 0;
						}
						end = temp.indexOf("©") + (skaits * (wf.length() + 2)) - skaits;

		%>
					<tr>
					<td align="right">
						<span class="text_kwic"><%= plain.substring(begin, end) %></span>
					</td>

					<td align="center">
						<a href="context.jsp?structure=GNP&source=<%= src %>&book=<%= new String(pos.getBytes("book"), "UTF-8") %>&chapter=<%= pos.getString("chapter") %>&verse=<%= pos.getString("verse") %>&wordform=<%= wf %>" title="<%= src %>"><span class="kwic"><%= wf %></span></a>
					</td>
		<%
						begin = end + wf.length() + 1;
						if (begin + coco >= plain.length() - 1)
						{
							end = plain.length() - 1;
						}
						else
						{
							end = begin + coco;
						}
						out.println ("<td align=\"left\">");
						out.println ("<span class=\"text_kwic\">");
		%>
						<%= plain.substring(begin, end) %>
		<%
						out.println ("</span>");
						out.println ("</td>");
		%>
					</tr>
		<%
						temp = temp.substring(0, temp.indexOf("©")) + "®" + temp.substring(temp.indexOf("©") + 1, temp.length());
						skaits++;
						count5++;
						}
				}

				selLR.clearParameters();
				selLR.setInt(1, cf);
				pos = selLR.executeQuery();

				j=k;
				for (j=k;pos.next() && j<(offset-2);j++)
				{
					//out.println(j);
				}
				k=j;
				if (j==0)
				{pos.previous();}
				pos.previous();

				while (pos.next() && count5 < limit) {
					contLR.clearParameters();
				    contLR.setInt(1, pos.getInt("context"));
				    context = contLR.executeQuery();
					context.first();

					plain = new String(context.getBytes("plain"), "UTF-8");
					temp = new String(plain);

					while (temp.indexOf(" " + wf + " ") != -1) {
    					temp = temp.substring(0, temp.indexOf(" " + wf + " ")) + "©" +
			    		temp.substring(temp.indexOf(" " + wf + " ") + wf.length() + 2, temp.length());
					}

					begin = 0;
					end = 0;
					skaits = 0;
					while (temp.indexOf("©") != -1) {
						if (temp.indexOf("©") - coco > 0) {
							begin = temp.indexOf("©") + (skaits * (wf.length() + 2)) - coco;
						}
						else {
							begin = 0;
						}
						end = temp.indexOf("©") + (skaits * (wf.length() + 2)) - skaits;


						if (end == 0)
						{
							lr_row = new String (context.getBytes("row"), "UTF-8");
							lr_page = new String (context.getBytes("page"), "UTF-8");
							lr_source = new String (context.getBytes("source"), "UTF-8");

							int id_LRrow = 0;
							id_LRrow = Integer.parseInt(lr_row);
							id_LRrow--;

							try{
							PreparedStatement s2 = con.prepareStatement(
									"SELECT plain FROM lr_contexts WHERE source=" + lr_source + " and page=" + lr_page + " and row=" + id_LRrow + ";"
									);
								context3 = s2.executeQuery();
								begin = 0;
								end = 0;

								context3.first();
								String con5 = new String(context3.getBytes("plain"), "UTF-8");

								int len = con5.length();
								begin = 0;
								int end2 = len;

								if (len > coco)
								{
									begin = len - coco;
								}
								else
								{
									begin=0;
								}
								end2 = len;
							out.println ("<tr>");
							out.println ("<td align=\"right\">");
							out.println ("<span class=\"text_kwic\">");
		%>
						<%= con5.substring(begin, end2) %>
		<%
							out.println ("</span>");
							out.println ("</td>");
							}catch (Exception e)
							{
							out.println ("<tr>");
							out.println ("<td align=\"right\">");
							out.println ("<span class=\"text_kwic\">");
							out.println ("</span>");
							out.println ("</td>");
							}
						}

						else
						{
		%>
					<tr>
					<td align="right">
						<span class="text_kwic"><%= plain.substring(begin, end) %></span>
					</td>
					<%} %>

					<td align="center">
						<a href="context.jsp?structure=LR&source=<%= src %>&page=<%= new String(pos.getBytes("page"), "UTF-8") %>&row=<%= pos.getString("row") %>&wordform=<%= wf %>" title="<%= src %>"><span class="kwic"><%= wf %></span></a>
					</td>

		<%
						begin = end + wf.length() + 1;
						if (begin + coco >= plain.length() - 1) {
							end = plain.length() - 1;
						}
						else {
							end = begin + coco;
						}

						if (begin == end)
						{
							lr_row = new String (context.getBytes("row"), "UTF-8");
							lr_page = new String (context.getBytes("page"), "UTF-8");
							lr_source = new String (context.getBytes("source"), "UTF-8");

							int id_LRrow = 0;
							id_LRrow = Integer.parseInt(lr_row);
							id_LRrow++;

							try{
							PreparedStatement s2 = con.prepareStatement(
									"SELECT plain FROM lr_contexts WHERE source=" + lr_source + " and page=" + lr_page + " and row=" + id_LRrow + ";"
									);
							context3 = s2.executeQuery();
							begin = 0;
							end = 0;

							context3.first();
							String con5 = new String(context3.getBytes("plain"), "UTF-8");

							begin = 0;
							if (begin + coco >= con5.length() - 1) {
								end = con5.length() - 1;
							}
							else {
								end = begin + coco;
							}
							out.println ("<td align=\"left\">");
							out.println ("<span class=\"text_kwic\">");
							%>
							<%= con5.substring(begin, end) %>
							<%
							out.println ("</span>");
							out.println ("</td>");
							}catch (Exception e){}
						}
						else
						{
							out.println ("<td align=\"left\">");
							out.println ("<span class=\"text_kwic\">");
		%>
							<%= plain.substring(begin, end) %>
		<%					out.println ("</span>");
							out.println ("</td>");
						}
		%>

				</tr>
		<%
						temp = temp.substring(0, temp.indexOf("©")) + "®" + temp.substring(temp.indexOf("©") + 1, temp.length());
						skaits++;
						count5++;
					}
				}


				selP.clearParameters();
				selP.setInt(1, cf);
				pos = selP.executeQuery();

				for (j=k;pos.next() && j<(offset-2);j++)
				{
					//out.println(j);
				}
				k=j;
				if (j==0)
				{pos.previous();}

				pos.previous();

				while (pos.next() && count5 < limit) {
					contP.clearParameters();
				    contP.setInt(1, pos.getInt("context"));

				    context = contP.executeQuery();
					context.first();

					plain = new String(context.getBytes("plain"), "UTF-8");
					temp = new String(plain);

					while (temp.indexOf(" " + wf + " ") != -1) {
  							temp = temp.substring(0, temp.indexOf(" " + wf + " ")) + "©" +
	    				temp.substring(temp.indexOf(" " + wf + " ") + wf.length() + 2, temp.length());
					}

					begin = 0;
					end = 0;
					skaits = 0;
					while (temp.indexOf("©") != -1) {
						if (temp.indexOf("©") - coco >= 0) {
							begin = temp.indexOf("©") + (skaits * (wf.length() + 2)) - coco;
						}
						else {
							begin = 0;
						}
						end = temp.indexOf("©") + (skaits * (wf.length() + 2)) - skaits;

		%>

						<tr>
						<td align="right">
							<span class="text_kwic"><%= plain.substring(begin, end) %></span>
						</td>
						<td align="center">
							<a href="context.jsp?structure=P&source=<%= src %>&verse=<%= new String(pos.getBytes("verse"), "UTF-8") %>&wordform=<%= wf %>" title="<%= src %>"><span class="kwic"><%= wf %></span></a>
						</td>
		<%
						begin = end + wf.length() + 1;
						if (begin + coco >= plain.length() - 1) {
							end = plain.length() - 1;
						}
						else {
							end = begin + coco;
						}
							out.println ("<td align=\"left\">");
							out.println ("<span class=\"text_kwic\">");
		%>
							<%= plain.substring(begin, end) %>

		<%					out.println ("</span>");
							out.println ("</td>");
		%>
				</tr>
		<%
						temp = temp.substring(0, temp.indexOf("©")) + "®" + temp.substring(temp.indexOf("©") + 1, temp.length());
						skaits++;
						count5++;
					}
				}
			}
			con.close();

			//LGL1685_V5
		%>
				</table>
				</center>
				<br/>
				<script type="text/javascript" language="JavaScript">
					printPosCount(<%= total %>);
				</script>
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<!-- Atvērumi START ------------------------------------------------------------------>
			<td bgcolor="#E8E8E8" valign="middle" align="center">
				<p class="seperator">&nbsp;</p>
				<table border="0">
				<tr><td>

				<%

					String encoded_wf = param_wf.replaceAll("%", "%25");

					int page_count = total / limit;

									if (current_page - 5 > 1) {
						int back_page = current_page - 5 - 1;

						out.print("<a href=\"kwic.jsp");

				out.print("?wordform=" + encoded_wf);
				out.print("&context=" + param_coco);
				out.print("&limit=" + limit);
				out.print("&page=" + back_page);

				for (int s = 0; s < param_src.length; s++) {
					out.print("&source=" + param_src[s]);
				}


				out.println("\" class=\"colc\">&lt;&lt;</a>");

						%>



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

						<%
						out.print("<a href=\"kwic.jsp");

						out.print("?wordform=" + encoded_wf);
						out.print("&context=" + param_coco);
						out.print("&limit=" + limit);
						out.print("&page=" + left_page);

						for (int s = 0; s < param_src.length; s++) {
							out.print("&source=" + param_src[s]);
						}

				out.println("\" class=\"colc\">");
				out.println(left_page);
				out.println("</a>");

						%>

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
					if (right_page <= page_count)
					{
				%>

				<td align="left" style="valign: middle;">

				<%
						// Izdrukā labo kontekstlogu (līdz piecām lpp)
						while (right_page <= page_count && right_page - current_page <= 5)
						{
				%>

						<%
							out.print("<a href=\"kwic.jsp");

							out.print("?wordform=" + encoded_wf);
							out.print("&context=" + param_coco);
							out.print("&limit=" + limit);
							out.print("&page=" + right_page);

							for (int s = 0; s < param_src.length; s++) {
								out.print("&source=" + param_src[s]);
							}

										out.println("\" class=\"colc\">");
								out.println(right_page);
								out.println("</a>");

						%>

				<%
							right_page++;
						}

						// Ja labā konteksta logs nesniedzas līdz pēdējam atvērumam,
						// jāpiedāvā "forward" podziņa
						if (right_page <= page_count)
						{
							int forward_page = current_page + 5 + 1;
				%>

						<%
							out.print("<a href=\"kwic.jsp");

							out.print("?wordform=" + encoded_wf);
							out.print("&context=" + param_coco);
							out.print("&limit=" + limit);
							out.print("&page=" + forward_page);

							for (int s = 0; s < param_src.length; s++) {
								out.print("&source=" + param_src[s]);
							}

							out.println("\" class=\"colc\">&gt;&gt;</a>");

						%>

				<%
						}
					}
				%>


				</td></tr>
				</table>
				<p class="seperator">&nbsp;</p>
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
