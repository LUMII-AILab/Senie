package corpus.senie.util;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class ExternalProperties
{
    protected Map<String, SingleFileProperties> catalog = new HashMap<>();

    public void loadExternalProperties(File inputPath, PrintStream out)
            throws IOException
    {
        BufferedReader reader = new BufferedReader(new InputStreamReader(
                new FileInputStream(inputPath), StandardCharsets.UTF_8));
        String line = reader.readLine();
        while (line != null)
        {
            if (!line.isEmpty())
            {
                String[] parts = Arrays.stream(line.split("\t"))
                        .map(String::trim).toArray(String[]::new);
                if (parts.length < 10)
                    out.println("Indeksācijas failā ir nesaprotama rinda: " + line);
                else
                {
                    SingleFileProperties properties = new SingleFileProperties();
                    String sourceCode = parts[1].replace("\\", "/").trim();
                    properties.index = IndexType.getByStringCode(parts[0]);
                    if (!parts[2].equals("_")) properties.shortTitle = parts[2];
                    if (!parts[3].equals("_")) properties.author = parts[3];
                    if (!parts[4].equals("_")) properties.orderNo = Double.parseDouble(parts[4]);
                    if (!parts[5].equals("_")) properties.year = parts[5];
                    if (!parts[6].equals("_")) properties.century = parts[6];
                    if (!parts[7].equals("_")) properties.genre = parts[7];
                    if (!parts[8].equals("_"))
                        properties.subgenres = Arrays.stream(parts[7].split(";"))
                                .map(String::trim).collect(Collectors.toList());
                    if (!parts[9].equals("_")) properties.manuscript = Boolean.parseBoolean(parts[9]);

                    catalog.put(sourceCode, properties);
                }
            }
            line = reader.readLine();
        }
    }

    public SingleFileProperties getProperties(String sourceId)
    {
        sourceId = sourceId.replace("\\", "/").trim();
        return catalog.get(sourceId);

    }
    public static class SingleFileProperties
    {
        public IndexType index = null;
        public String shortTitle = null;
        public String author = null;
        public double orderNo = 0;
        public String year = null;
        public String century = null;
        public String genre = null;
        public List<String> subgenres = null;
        public boolean manuscript = false;
    }
}
