package LvSenieTranslit::TranslitTables;
use strict;
use warnings FATAL => 'all';
use utf8;

use Exporter();
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(substTable hasTable encodeString decodeString);

# Human readable substitution tables.
my $ST = {
	'Br1520_PN' => {
		'^Tew' => 'Tēv',
		'uſs\b' => 'ūs',
		'\bexcã\b' => 'iekšan',
		'bb' => 'b',
		'ſs\b' => 's',
		'\bAEth\bpeſ' => 'Atpes',
		'ſ' => 's',
		'\bSwetytz\b' => 'Svētīts',
		'ouw' => 'av',
		'\bwaardt\b' => 'vārds',
		'\bEnac' => 'Ienā',
		'\bwallſti' => 'valstī',
		'atz\b' => 'āts',
		'\bbus\b' => 'būs',
		'\bka\b' => 'kā',
		'\beckſch' => 'iekš',
		'ss' => 's',
		'\bTa\b' => 'Tā',
		'\barriſ' => 'arīdz',
		'\bwurſ' => 'virs',
		'\bſemm' => 'zem',
		'\bden' => 'dien',
		'yſ' => 'iz',
		'\bduth\b' => 'dot',
		'\bſchodeẽ' => 'šodien',
		'mm' => 'm',
		'\bgrec' => 'grē',
		'\bmes\b' => 'mēs',
		'\braduc' => 'ādnie',
		'ekw' => 'iev',
		'\bļou' => 'ļau',
		'\bwy' => 'vi',
	},
	'Manc1638_Run' => {
		'\bẜwähtz\b' => 'svēts',
		'\bSweed' => 'Zvied',
		'\bWehſch\b' => 'Vējš',
		'W' => 'V',
		'\bzeetz\b' => 'ciets',
		'\bzeet' => 'ciet',
		'ee' => 'ie',
		'\bEe' => 'Ie',
		'unna' => 'unā',
		'nn' => 'n',
		'\bChr' => 'Kr',
		'tſch' => 'č',
		'\ballaſch\b' => 'allaž',
		'aſchu\b' => 'āšu',
		'\bdaſſch\b' => 'dažs',
		'ſſch' => 'š',
		'\bScha' => 'Ža',
		'\bSch' => 'Š',
		'\bJaw\b' => 'Jau',
		'\bjaw\b' => 'jau',
		'ẜw' => 'sv',
		'\bſw' => 'sv',
		'waſch' => 'važ',
		'Z' => 'C',
		'ļļ' => 'ļ',
		'\bdries' => 'drīz',
		'ieds' => 'īdz',
		'brieſch' => 'brīž',
		'ieeſch' => 'īž',
		'ie' => 'ī',
		'^Atz' => 'Atc',
		'\bPatz\b' => 'Pats',
		'\bpatz\b' => 'pats',
		'\bpattz\b' => 'pats',
		'\bzitts\b' => 'cits',
		'tt' => 't',
		'\bwätzu\b' => 'vecu',
		'\bwätz\b' => 'vecs',
		'w' => 'v',
		'\bVh' => 'Ū',
		'\bVs' => 'Uz',
		'\bvs' => 'uz',
		'\bDavid\b' => 'Dāvids',
		'v' => 'u',
		'\bDrieß\b' => 'Drīz',
		'\bSarrß\b' => 'Zars',
		'\bSutt' => 'Zut',
		'\bSi' => 'Zi',
		'rr' => 'r',
		'ŗŗ' => 'ŗ',
		'ñ\b' => 'n',
		'\bghajam\b' => 'gājām',
		'gh' => 'g',
		'\bGh' => 'G',
		'ckſch' => 'kš',
		'ck' => 'k',
		'\bmähds\b' => 'mēdz',
		'äh' => 'ē',
		'Ꞩch' => 'Š',
		'Ꞩ' => 'S',
		'\bauxtais\b' => 'augstais',
		'x' => 'ks',
		'nh' => 'n',
		'Nh' => 'N',
		'bahß' => 'bāz',
		'\bKahtz\b' => 'Kāts',
		'\bSah' => 'Zā',
		'ah' => 'ā',
		'\bAhſch' => 'Āž',
		'\bAh' => 'Ā',
		'bb' => 'b',
		'^iß' => 'iz',
		'\bJß' => 'Iz',
		'\bIß' => 'Iz',
		'ß' => 's',
		'ſẜiſch' => 'sīš',
		'ſẜ' => 's',
		'ö' => 'e',
		'uhds\b' => 'ūdz',
		'\bbuhſ\b' => 'būs',
		'uh' => 'ū',
		'^Soh' => 'Zo',
		'oh' => 'o',
		'\bOh' => 'O',
		'\bdauds\b' => 'daudz',
		'ſedds$' => 'sedz',
		'^ẜedds\b' => 'sedz',
		'ddſch' => 'dž',
		'\bdſirehß\b' => 'dzīrēs',
		'dſ' => 'dz',
		'\bDſ' => 'Dz',
		'gg' => 'g',
		'ņņ' => 'ņ',
		'näſ' => 'nes',
		'\bſä' => 'ze',
		'\bmäll' => 'mell',
		'\bMäll' => 'Mell',
		'ä' => 'e',
		'pehts\b' => 'pēc',
		'ehtz\b' => 'ēc',
		'tz' => 'c',
		'eh' => 'ē',
		'\bEh' => 'Ē',
		'à' => 'ā',
		'\bẜch' => 'š',
		'ẜ' => 's',
		'ings\b' => 'iņš',
		'ing' => 'iņ',
		'\bgir\b' => 'jir',
		'\bGir\b' => 'Jir',
		'gk' => 'ķ',
		'ih' => 'ī',
		'\bby\b' => 'bij',
		'\bBy\b' => 'Bij',
		'ſi' => 'zi',
		'ſt' => 'st',
		'ſk' => 'sk',
		'ſp' => 'sp',
		'ſm' => 'zm',
		'ſn' => 'zn',
		'\bſl' => 'sl',
		'llſch\b' => 'ļš',
		'tall' => 'tall',
		'\bJll' => 'Il',
		'llu\b' => 'llu',
		'^ſal' => 'sa',
		'll' => 'l',
		'pp' => 'p',
		'\bpy\b' => 'pi',
		'\bPy\b' => 'Pi',
		'th' => 't',
		'\bTh' => 'T',
		'dd' => 'd',
		'\bNey\b' => 'Nei',
		'\bney\b' => 'nei',
		'ey\b ' => 'ej',
		'\bEy\b' => 'Ej',
		'nj' => 'ņ',
		'mm' => 'm',
		'm̃' => 'm',
		'\bjemb' => 'jem',
		'mbt' => 'mt',
		'\bz' => 'c',
		'kſch' => 'kš',
		'\bſchk' => 'šk',
		'\bdiſch' => 'diž',
		'\bMeeſch' => 'Miež',
		'\bMeſch' => 'Mež',
		'\bMuiſch' => 'Muiž',
		'\bſchuhſt\b' => 'žūst',
		'\blaiſch' => 'laiž',
		'uſchi\b' => 'uši',
		'ſch' => 'š',
		'\bAis' => 'Aiz',
		'\bAis\b' => 'Aiz',
		'\bais' => 'aiz',
		'\bAuſ' => 'Auz',
		'\bSe' => 'Ze',
		'^ſal' => 'sa',
		'\bſe' => 'ze',
		'\bmas' => 'maz',
		'\bMas\b' => 'Maz',
		'\bKaj' => 'Kāj',
		'\bMaj' => 'Māj',
		'\bmaj' => 'māj',
		'\btada' => 'tāda',
		'\bta/' => 'tā/',
		'\bta\b' => 'tā',
		'\bTa\b' => 'Tā',
		'ay' => 'ai',
		'yi\b' => 'ji',
		'\bja=' => 'jā=',
		'ſ' => 'z',
		'z' => 'c',
		'y' => 'ī',
		'\bQu' => 'Kv',
	},
};

# Substitution tables we actually use: here each character in resulting string
# is surrounded by \N{U+E001} and \N{U+E002} to ensure that it is never replaced
# again.
our $EncodedST = encodeST();

sub encodeST
{
	my $resultST = {};
	for my $source (keys %{$ST})
	{
		my $subtable = {};
		for my $target (keys %{$ST->{$source}})
		{
			$subtable->{$target} = encodeString($ST->{$source}->{$target});
		}
		$resultST->{$source} = $subtable;
	}
	return $resultST;
}

sub substTable
{
	my $tableName = shift @_;
	return $EncodedST->{$tableName};
}

sub hasTable
{
	my $tableName = shift @_;
	return exists $EncodedST->{$tableName};
}

sub encodeString
{
	my $string = shift @_;
	$string =~ s/(.)/\N{U+E001}$1\N{U+E002}/g;
	return $string;
}

sub decodeString
{
	my $string = shift @_;
	$string =~ s/[\N{U+E001}\N{U+E002}]//g;
	return $string;
}
1;