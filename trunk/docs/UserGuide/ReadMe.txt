DIPLOMOVÁ PRÁCE
Matematicko-fyzikální fakulta
Univerzita Karlova v Praze
Sémantická anotace dat z webovských zdrojù
Jan Dìdek
http://czsem.berlios.de/
________________________________________________________________________________
OBSAH PØILO®ENÉHO CD-ROM

Tento CD-ROM obsahuje:
*** Celý text práce v souboru text_prace.pdf
*** Automaticky anotovaný korpus hasièských zpráv v adresáøi hasici_korpus
*** Obsah SVN repository této práce v adresáøi czsem



________________________________________________________________________________
Korpus hasièských zpráv.

Tato data vznikla pomocí skriptu  czsem/data/hasici/parse
Jejich sta¾ení a automatická anotace probìhlo: 
Mon Aug  6 11:56:25 CEST 2007 -- Mon Aug  6 14:50:49 CEST 2007

Tato data je je mo¾né prohlí¾et pomocí editoru TreEd a analyzovat pomocí btred makry v adresáøi czsem/src/perl.

Souèasné výsledky frekvenèní analýzy se vztahují k tìmto datùm.



________________________________________________________________________________
SVN repository.

Adresáøi czsem obsahuje SVN repository z 10.8.2007. Pøed prohlí¾ením jeho obsahu ho prosím aktualizujte.

Postup aktualizace:
1) Zkopírujte tento adresáø na místo, kde bude mu¾né pøepisovat jeho data.
2) V pøíkayovém øádku se pøepnìte do právì vytvoøeného adrsáøe czsem.
3) Spustìte pøíkaz svn update 

- nutné mít nainstalovaného SVN klienta (napø. http://subversion.tigris.org/)

podrobnosti je té¾ mo¾né naléyt v souboru czsem/docs/UserGuide/Install.txt

________________________________________________________________________________
Skripty pro korpus hasièských zpráv

- jsou umístìny v adresáøi czsem/data/hasici

run_parse_background
Spustí skript parse na pozadí. 

parse
Postupnì spustí celý proces od sta¾ení èlánkù z webu a¾ po jejich lingvistickou anotaci.
Vyu¾ívá následující skripty v poøadí, jak jsou uvedeny.

clear_tmp
Pøed stahováním èlánkù z webu a automatickou lingvistickou anotací sma¾e v¹echny doèasné soubory, které budou nahrazeny novými.

prepare_sources
Postupnì spustí celý proces od sta¾ení èlánkù z webu a¾ po jejich proèi¹tìní. 
Vyu¾ívá následující skripty (a¾ po final_rename) v poøadí, jak jsou uvedeny.

rss/update_url_lists_archive
Podle aktuálního RSS aktualizuje seznamy URL èlánkù v adresáøi czsem/data/hasici/rss/url_lists_archive.
Vyu¾ívá následující tøi skripty. 

rss/get_RSS_feeds
Stáhne aktuální RSS kanály, jejich¾ adresy jsou uvedeny v souboru czsem/data/hasici/rss/RSS_Feeds_list.

rss/make_url_lists
Pomocí XSLT transformace czsem/data/hasici/rss/extract_detail_URLs.xsl pøevede RSS kanály na seznamy URL v adresáøi czsem/data/hasici/rss/url_lists_tmp. 

rss/merge_url_lists
Aktuálnì získané seznamy URL v adresáøi czsem/data/hasici/rss/url_lists_tmp spojí s pùvodními seznamy v adresáøi czsem/data/hasici/rss/url_lists_archive.



get_details_form_web
Podle seznamù URL czsem/data/hasici/rss/url_lists_archive stáhne v¹echny èlánky z webu.

cs_convert
Konvertuje kódování èeských znakù ve sta¾ených textech. Originál z webu je kódovaný cp1250 lingvistické anotátory po¾adují ISO Latin2.

strip_HTML_complete
Ze sta¾ených èlánkù extrahuje jejich prosté texty. 

final_rename
Provede výsledné pøejmenování souborù s doèasnými (pracovními) jmény.
Po provedení tohoto skriptu zùstanou v adresáøi txt_src texty èlánkù pøipravené pro lingvistickou anotaci, která se v následujícím kroku skriptu parse spustí a umístí do adresáøe pml výsledné lingvistické anotace.

make_pls
Z lingvisticky anotovaných PML souborù vytvoøí PLS soubory pro rychlej¹í zpracování programem btred.

make_tpls_list
Vytvoøí seznam hasici_t_pls.fl v¹ech lingvisticky anotovaných souborù.



make_freq
Spustí frekvenèní analýzu hasièského korpusu.
Spu¹tìní tohoto skriptu není souèástí skriptu parse.  





