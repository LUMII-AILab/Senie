package corpus.senie.util;

public enum IndexType
{
	GNP, LR, P, GLR;
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
			case 4:
				return GLR;
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
			case "GLR":
			case "glr":
				return GLR;
			default:
				return null;
		}
	}
}
