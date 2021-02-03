package corpus.senie.indexing;

public enum IndexType
{
	GNP, LR, P;
	public static IndexType getByLegacyCode(int i)
	{
		switch (i)
		{
			case 1:
				return GNP;
			case 2:
				return LR;
			case 3:
				return P;
			default:
				return null;
		}
	}
	public static IndexType getByStringCode(String code)
	{
		switch (code)
		{
			case "GNP":
			case "gnp":
				return GNP;
			case "LR":
			case "lr":
				return LR;
			case "P":
			case "p":
				return P;
			default:
				return null;
		}
	}
}
