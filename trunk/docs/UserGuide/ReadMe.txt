DIPLOMOV� PR�CE
Matematicko-fyzik�ln� fakulta
Univerzita Karlova v Praze
S�mantick� anotace dat z webovsk�ch zdroj�
Jan D�dek
http://czsem.berlios.de/
________________________________________________________________________________
OBSAH P�ILO�EN�HO CD-ROM

Tento CD-ROM obsahuje:
*** Cel� text pr�ce v souboru text_prace.pdf
*** Automaticky anotovan� korpus hasi�sk�ch zpr�v v adres��i hasici_korpus
*** Obsah SVN repository t�to pr�ce v adres��i czsem



________________________________________________________________________________
Korpus hasi�sk�ch zpr�v.

Tato data vznikla pomoc� skriptu  czsem/data/hasici/parse
Jejich sta�en� a automatick� anotace prob�hlo: 
Mon Aug  6 11:56:25 CEST 2007 -- Mon Aug  6 14:50:49 CEST 2007

Tato data je je mo�n� prohl�et pomoc� editoru TreEd a analyzovat pomoc� btred makry v adres��i czsem/src/perl.

Sou�asn� v�sledky frekven�n� anal�zy se vztahuj� k t�mto dat�m.



________________________________________________________________________________
SVN repository.

Adres��i czsem obsahuje SVN repository z 10.8.2007. P�ed prohl�en�m jeho obsahu ho pros�m aktualizujte.

Postup aktualizace:
1) Zkop�rujte tento adres�� na m�sto, kde bude mu�n� p�episovat jeho data.
2) V p��kayov�m ��dku se p�epn�te do pr�v� vytvo�en�ho adrs��e czsem.
3) Spust�te p��kaz svn update 

- nutn� m�t nainstalovan�ho SVN klienta (nap�. http://subversion.tigris.org/)

podrobnosti je t� mo�n� nal�yt v souboru czsem/docs/UserGuide/Install.txt

________________________________________________________________________________
Skripty pro korpus hasi�sk�ch zpr�v

- jsou um�st�ny v adres��i czsem/data/hasici

run_parse_background
Spust� skript parse na pozad�. 

parse
Postupn� spust� cel� proces od sta�en� �l�nk� z webu a� po jejich lingvistickou anotaci.
Vyu��v� n�sleduj�c� skripty v po�ad�, jak jsou uvedeny.

clear_tmp
P�ed stahov�n�m �l�nk� z webu a automatickou lingvistickou anotac� sma�e v�echny do�asn� soubory, kter� budou nahrazeny nov�mi.

prepare_sources
Postupn� spust� cel� proces od sta�en� �l�nk� z webu a� po jejich pro�i�t�n�. 
Vyu��v� n�sleduj�c� skripty (a� po final_rename) v po�ad�, jak jsou uvedeny.

rss/update_url_lists_archive
Podle aktu�ln�ho RSS aktualizuje seznamy URL �l�nk� v adres��i czsem/data/hasici/rss/url_lists_archive.
Vyu��v� n�sleduj�c� t�i skripty. 

rss/get_RSS_feeds
St�hne aktu�ln� RSS kan�ly, jejich� adresy jsou uvedeny v souboru czsem/data/hasici/rss/RSS_Feeds_list.

rss/make_url_lists
Pomoc� XSLT transformace czsem/data/hasici/rss/extract_detail_URLs.xsl p�evede RSS kan�ly na seznamy URL v adres��i czsem/data/hasici/rss/url_lists_tmp. 

rss/merge_url_lists
Aktu�ln� z�skan� seznamy URL v adres��i czsem/data/hasici/rss/url_lists_tmp spoj� s p�vodn�mi seznamy v adres��i czsem/data/hasici/rss/url_lists_archive.



get_details_form_web
Podle seznam� URL czsem/data/hasici/rss/url_lists_archive st�hne v�echny �l�nky z webu.

cs_convert
Konvertuje k�dov�n� �esk�ch znak� ve sta�en�ch textech. Origin�l z webu je k�dovan� cp1250 lingvistick� anot�tory po�aduj� ISO Latin2.

strip_HTML_complete
Ze sta�en�ch �l�nk� extrahuje jejich prost� texty. 

final_rename
Provede v�sledn� p�ejmenov�n� soubor� s do�asn�mi (pracovn�mi) jm�ny.
Po proveden� tohoto skriptu z�stanou v adres��i txt_src texty �l�nk� p�ipraven� pro lingvistickou anotaci, kter� se v n�sleduj�c�m kroku skriptu parse spust� a um�st� do adres��e pml v�sledn� lingvistick� anotace.

make_pls
Z lingvisticky anotovan�ch PML soubor� vytvo�� PLS soubory pro rychlej�� zpracov�n� programem btred.

make_tpls_list
Vytvo�� seznam hasici_t_pls.fl v�ech lingvisticky anotovan�ch soubor�.



make_freq
Spust� frekven�n� anal�zu hasi�sk�ho korpusu.
Spu�t�n� tohoto skriptu nen� sou��st� skriptu parse.  





