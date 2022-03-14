package corpus.senie.indexing;

import java.io.*;

public class HtmlWrapperPrinter {

    //private BufferedReader reader;
    private BufferedWriter html;
    private BufferedWriter titleHtm;
    private final String collection;
    private final String source;
    //private Logger log;

    /**
     * Constructor.
     *
     * @param shortSourceId - codificator of source text, will be used as absolute file name for HtmlWrapperPrinter results.
     */
    public HtmlWrapperPrinter(String shortSourceId, String collection) throws IOException {
        //super();
        this.collection = collection;
        this.source = shortSourceId;
        if (collection == null || collection.trim().isEmpty()) collection = shortSourceId;
        //reader = new BufferedReader(new InputStreamReader(new FileInputStream(source + ".txt"), "Cp1257"));
        html = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(shortSourceId + ".html"), "Cp1257"));
        titleHtm = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(shortSourceId + "_title.htm"), "Cp1257"));
        //log = new Logger(source, "TEKSTA MARĶĒŠANA UN GRĀMATZĪMJU SALIKŠANA", true);
    }

    /**
     * Print file named "source.html".
     * @throws IOException
     */
    public void writeHtml() throws IOException {

        html.write(
                "<html>\r\n" +
                "\t<frameset rows=\"90px,*\" border=\"0\" frameborder=\"0\" framespacing=\"0\" marginwidth=\"0\" marginheight=\"0\">\r\n" +
                "\t\t<frame name=\"title\" src=\""+ source +"_title.htm\" noresize style=\"border-bottom: solid #669933 2px;\">\r\n" +
                "\t\t<frameset cols=\"40%,*\" border=\"0\" frameborder=\"0\" framespacing=\"0\" marginwidth=\"0\" marginheight=\"0\">\r\n" +
                "\t\t\t<frame name=\"index\" src=\"" + source + "_indexed_lower.htm\" style=\"border-right: solid #669933 3px;\">\r\n" +
                "\t\t\t<frame name=\"text\" src=\"" + source + "_marked.htm\">\r\n" +
                "\t\t</frameset>\r\n" +
                "\t<frameset>\r\n" +
                "</html>");
        html.flush();
        html.close();
    }

    /**
     * Print file named source_title.htm
     * @param author        author name from @a tag
     * @param title         source title from first @k tag
     * @param wordformsLC   wordform statistic from lowercase index file
     * @param wordsLC       word count statistic from lowercase index file
     * @throws IOException
     */
    public void writeTitleHtm(String author, String title, String wordformsLC, String wordsLC)
            throws IOException {
        if (title == null) title = "~~~";
        titleHtm.write(
                "<html>\n" +
                "\t<head>\r\n" +
                "\t\t<meta http-equiv=\"content-type\" content=\"text/html; charset=windows-1257\">\r\n" +
                "\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"./title.css\">\r\n" +
                "\t</head>\r\n" +
                "\r\n" +
                "\t<body>\r\n" +
                "\t\t<p class=\"author\">" + author +"</p>\r\n" +
                "\t\t<p class=\"source\">" + title +"</p>\r\n" +
                "\t\t<table border=\"0\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n" +
                "\t\t<tr>\r\n" +
                "\t\t\t<td><p class=\"statistic\">Vārdformas: <b>" + wordformsLC + "</b>, vārdlietojumi: <b>" + wordsLC +"</b> (reģistrnejūtība).</p></td>\r\n" +
                "\t\t\t<td><p class=\"navig\">\r\n" +
                "\t\t\t\t<a href=\"../source.jsp?codificator=" + collection + "\" class=\"button\" target=\"_top\">&nbsp;" + collection + "&nbsp;</a>&nbsp;\r\n" +
                "\t\t\t\t<a href=\"../senie.jsp\" class=\"button\" target=\"_top\">&nbsp;SĀKUMLAPA&nbsp;</a>\r\n" +
                "\t\t\t</p></td>\r\n" +
                "\t\t</tr>\r\n" +
                "\t\t</table>\r\n" +
                "\t</body>\r\n" +
                "</html>\r\n");
        titleHtm.flush();
        titleHtm.close();
    }
}
