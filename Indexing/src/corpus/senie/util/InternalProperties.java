package corpus.senie.util;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class InternalProperties
{
    public String author;
    public String fullSourceId;
    public String shortSourceId;
    public String collectionId;
    public String bookId;
    public String firstComment;

    /**
     * Helper method for getting contents of the @{....} i.e., author mark form
     * somethere in the file. The whole @{...} must be in a single line.
     * @param sourceFilePath file to check
     * @return array with @z field, @g field, @a field and @k field in that order
     * @throws IOException
     */
    public static InternalProperties loadInternalProperties(String sourceFilePath)
            throws IOException
    {
        if(sourceFilePath == null) return null;
        InternalProperties result = new InternalProperties();
        String sourceCode = null;
        String bookCode = null;
        BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(sourceFilePath), "Cp1257"));
        Pattern codePattern = Pattern.compile(".*?@([agzk])\\{([^}]+)\\}.*");
        String line = reader.readLine();
        int linecount = 0;
        while (line != null && (result.author == null || sourceCode == null || bookCode == null || result.firstComment == null) && linecount < 20)
        {
            Matcher codeMatcher = codePattern.matcher(line);
            if (codeMatcher.matches())
            {
                String code = codeMatcher.group(1);
                String value = codeMatcher.group(2);
                switch (code)
                {
                    case "a" : result.author = value; break;
                    case "g" : bookCode = value; break;
                    case "z" : sourceCode = value; break;
                    case "k" : if (result.firstComment == null || result.firstComment.isEmpty())
                        result.firstComment = value; break;
                }
            }
            line = reader.readLine();
            linecount++;
        }
        if (bookCode == null || bookCode.trim().isEmpty())
        {
            result.shortSourceId = sourceCode;
            result.fullSourceId = sourceCode;
            result.bookId = null;
            result.collectionId = null;
        } else
        {
            result.shortSourceId = bookCode;
            result.bookId = bookCode;
            result.fullSourceId = sourceCode + "/" + bookCode;
            result.collectionId = sourceCode;
        }
        reader.close();
        return result;
    }

}
