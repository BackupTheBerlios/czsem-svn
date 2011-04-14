/*
 * This file is part of Netgraph.
 *
 * Netgraph is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * Netgraph is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

///   Dotser.c
//
//////////////////////

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <signal.h>
#include <errno.h>
#include <dirent.h> // práce s adresáři
#include <ctype.h>
#include <pcre.h> // regulární výrazy schopné zvládnout UTF-8
//#include <regex.h> // staré regulární výrazy; nezvládaly UTF-8

#include "mutual.h" // musí být před ifdef _LINUX_VERSION, protože se tam případně definuje

#ifdef _LINUX_VERSION
#include <sys/ipc.h> // sdílení paměti
#include <sys/shm.h> // sdílení paměti
#endif

#include "loadsave.h"
#include "passwd.h"
#include "trees.h"
#include "searching.h"
#include "matching.h"
#include "messages.h"
#include "define.h"


#define THIS_CLIENT_REQUIRED_VERSION "1.75" // minimalni pozadovana verze klienta (kvuli UTF-8 je to 1.75)
#define THIS_CLIENT_RECOMMENDED_VERSION "1.91" // minimalni doporucena verze klienta
#define MAX_VERSION_LENGTH 30  // maximální délka verze klienta (její překročení je ošetřeno)

#define COREFERENCES_FILE "coreferences.txt"   // jméno souboru s koreferenčními schématy
#define MAX_COREFERENCE_LENGTH 1000 // maximální délka koreferencčního schématu v souboru COREFERENCES_FILE
#define COREFERENCE_FILE_COMMENT_CHAR '#'  // znak uvozující komentář v souboru schémat koreferencí

#ifdef _WINDOWS_VERSION
#define EOL_2 13                   // konec radku v docasnem souboru s odkazy na vysledne stromy
#define PATH_SEPARATOR '\\'  // oddělovač adresářů v cestě
#endif

#ifdef _LINUX_VERSION
#define EOL_2 10                   // ve windowsech tohle delalo problem pri hledej_znacku_nahoru
#define PATH_SEPARATOR '/'  // oddělovač adresářů v cestě
#endif

char result_file_reading_mask[20]; // čtecí maska pro funkci fscanf při čtení ze souboru výsledků ve funkci readOneRecord; vytvoří se po startu programu

#define RESULT_FILE_OCCURRENCES_DELIMITER 0   // oddelovac mezi zazn. ve vysledku
#define RESULT_FILE_OCCURRENCES_ERASER 1   // pri odstranovani konkretniho stromu ze souboru vysledku bude oddelovac mezi zaznamy ve vysledku nahrazen timto znakem
#define FILE_STATISTICS_LINE_LENGTH 15  // kolik bajtů na jeden řádek (tj. jedno číslo) v souboru statistik o prohledávání dotazu
#define MAX_QUERY_LOG_LENGTH 10000 // max délka dotazu uloženého pro pozdější výpis (týká se proměnné actual_query)
#define MAX_LOG_EXP_LOG_LENGTH 1000 // max délka logického výrazu k dotazu uloženého pro použití i pro pozdější výpis (týká se proměnné actual_logical_expression)

#define MATCHING_NODES_DELIMITER ',' // oddělovač čísel vrcholů matchujících s dotazem ve výsledku zapsaném na disk
#define MATCHING_NODES_QUERY_DELIMITER ':' // oddělovač čísel vrcholů dotazu a výsledného stromu, které spolu matchují, ve výsledku zapsaném na disk
#define MATCHING_NODES_TREES_DELIMITER ';' // oddělovač stromů dotazu v seznamu čísel vrcholů matchujících s dotazem ve výsledku zapsaném na disk

#define LOG_QUERY  // pro vypis vkladanych dotazu a statistik o jejich prohledavani do stderr

////////////////////////// DEBUG ////////////////////////

//#define TISK - výpis načtené hlavičky stromu
//#define DEBUG	// zakladni ladici vypisy
//#define DEBUG_START_DOTSER // ladi start dotseru
//#define DEBUG_GETVERSION // ladi zasilani verzi klientovi
//#define DEBUG_CD // ladi zmenu adresare
//#define DEBUG_GETDIRS // ladi vypis podadresaru
//#define DEBUG_GETFILES // ladi vypis souboru v adresari
//#define DEBUG_CANONIZE_PATH // ladí převádění cesty do kanonické podoby
//#define DEBUG_SET_FILES // ladi funkci setFiles - prijmuti a zpracovani seznamu souboru
//#define DEBUG_GET_NEXT_TREE // ladí načítání dalšího stromu
//#define DEBUG_GET_PREVIOUS_TREE // ladí načítání předchozího stromu
//#define DEBUG_REMOVE_OCCURRENCE // ladí ostranění aktuálního stromu z výsledného souboru
//#define DEBUG_READ_FILE_NAME_AND_TREE_NUMBER_SAFELY // ladí čtení jména souboru a čísla stromu pro getNextTree a getPreviousTree
//#define DEBUG_ANSWER_GET_TREE // ladí závěrečné sestavení odpovědi klientovi
//#define DEBUG_SEARCHING_FINISHED // ladí funkci searchingFinished - test, zda bylo prohledávání již ukončeno

// následující definice slouží pro ladění částí zpracování dotazu
//#define DEBUG_SET_QUERY // ladí obecné části zpracování dotazu
//#define DEBUG_CREATE_MATCHING_LISTS // ladí funkci createMatchingLists
//#define DEBUG_FIND_SUBTREE // ladí mapování dotazu do podstromu prohledávaného stromu; vnější funkce mající ve jménu findSubtree
//#define DEBUG_TRY_SUBTREE // ladí mapování dotazu do podstromu prohledávaného stromu; vnitřní funkce mající ve jménu trySubtree
//#define DEBUG_IS_SET_TRANSITIVE_EDGE  // ladí funkci isSetTransitiveEdge
//#define DEBUG_TRANSITIVE_EDGE // ladí ostatní zpracování tranzitivní hrany
//#define DEBUG_IS_PREDECESSOR // ladí funkci isPredecessor
//#define DEBUG_STICK_CHAIN // ladí funkci stickChain
//#define DEBUG_MATCHING_NODES  // ladí zápis matchujících vrcholů do souboru a jejich načítání zpět
//#define DEBUG_NUMBER_OF_OCCURRENCES  // ladi zpracovani meta atributu #occurrences
//#define DEBUG_TRANSITIVE_PARENT  // ladi funkci isTransitiveParent
//#define DEBUG_GET_SET_ZERO_OCCURRENCES // ladi funkci getSetZeroOccurrences
//#define DEBUG_STOP_QUERY  // ladí zastavení dotazu uživatelem
//#define DEBUG_IS_OK_REFERENCES  // ladi funkci isOkReferences
//#define DEBUG_IS_OK_REFERENCES_ONE_NODE  // ladi funkci isOkReferencesOneNode
//#define DEBUG_FIND_NODE_NAME  // ladi funkci pro zjistovani pojmenovani vrcholu
//#define DEBUG_STATISTICS_CHILD  // ladí vytváření statistik o prohledávání procesem dotser-child
//#define DEBUG_STATISTICS_PARENT  // ladí zpracovávání statistik o prohledávání procesem dotser-parent
//#define DEBUG_CONTROL_SHARED_MEMORY  // ladí vytváření a přístup ke sdílené paměti pro statistiky a další proměnné
//#define DEBUG_SIGNALS  // ladí zpracování signálů
//#define DEBUG_WRITE_RESULT_TO_FILE  // ladi funkci writeResultToFile
//#define DEBUG_READ_COREFERENCES_FILE  // ladeni cteni schemat koreferenci ze souboru
//#define DEBUG_GET_HIDDEN_VALUE  // ladi funkci getHiddenValue

////////////////////////// GLOBAL ///////////////////////

extern int errno;

char server_version[] = THIS_SERVER_VERSION; // verze serveru
char client_required_version[] = THIS_CLIENT_REQUIRED_VERSION; // pozadovana verze klienta
char client_recommended_version[] = THIS_CLIENT_RECOMMENDED_VERSION; // doporucena verze klienta
char path_separator = PATH_SEPARATOR;

int childpid; // PID dotazovaciho procesu
int bezi_dotaz = FALSE; // rika, zda bezi dotaz
int pozice_out;   // Je ukazovatko OUT ?

int invert_match; // TRUE/FALSE - maji se do vysledku dotazu davat prave stromy nematchujici s dotazem? Nastavuje se v setQuery podle pozadavku od klienta.
int first_only; // TRUE/FALSE - maji se vyhledavat jen prvni vyskyty dotazu v kazdem strome? Nastavuje se v setQuery podle pozadavku od klienta.
int tree_matched; // TRUE/FALSE - signalizuje ve funkci najdi_podstrom, zda ve volane funkci findSubtree byl dotaz v danem strome smatchovan alespon jednou

struct account user_account; // autentizační a autorizační údaje o uživateli

long int max_number_of_trees; // maximalne tolik stromu smi prave prihlaseny uzivatel vyhledat jednim dotazem
long int number_of_actual_occurrence; // pořadí výskytu dotazu naposledy odeslaného klientovi mezi nalezenými stromy
long int number_of_actual_tree; // pořadí stromu naposledy odeslaného klientovi mezi nalezenými stromy

// následující dvě proměnné udržují přehled o počtu odstraněných výskytů dotazu a o počtu v důsledku odstraněných celých stromů
// při posílání statistik klientu se tato čísla odečtou od aktuálních statistik;
// tímto řešením se předejde konfliktu zápis/čtení do/z proměnných obsahujících statistiky o prohledávání
long int number_of_removed_occurrences; // počet uživatelem odstraněných výskytů dotazu z výsledku
long int number_of_removed_trees; // počet uživatelem odstraněných stromů z výsledku (ne každé odstranění výskytu sníží počet stromů, ve kterých jsou zbylé výskyty)

// následující čtyři proměnné budou odkazovat do sdílené paměti
#ifdef _LINUX_VERSION
	long int *number_of_found_trees = NULL; // v tolika stromech byl zatim tento dotaz smatchovan
	long int *number_of_found_occurrences = NULL; // tolik stromu (jednotlivych vyskytu dotazu) bylo zatim nalezeno timto dotazem
	long int *number_of_searched_trees = NULL; // počet stromů zatím prohledaných tímto dotazem
	int *query_stop_flag = NULL; // příznak sloužící jako pokyn pro ukončení prohledávání
	// -----
	int control_shared_memory_id = -1; // tato proměnná bude určovat sdílenou paměť
	void *control_shared_memory_address = NULL; // tato proměnná bude ukazovat na sdílenou paměť
#endif
#ifdef _WINDOWS_VERSION
	long int number_of_found_trees = 0; // v tolika stromech byl zatim tento dotaz smatchovan
	long int number_of_found_occurrences = 0; // tolik stromu (jednotlivych vyskytu dotazu) bylo zatim nalezeno timto dotazem
	long int number_of_searched_trees = 0; // počet stromů zatím prohledaných tímto dotazem
	int query_stop_flag; // příznak sloužící jako pokyn pro ukončení prohledávání
	int number_of_found_trees_position; // pozice cisel v souboru pro sdileni statistik (nastavuji se v createControlSharedMemory
	int number_of_found_occurrences_position;
	int number_of_searched_trees_position;
	int query_stop_flag_position;
#endif
// -----

int searching_break_type; // signalizuje, zda bylo prohledavani ukonceno kvuli dosazeni maxima povolenych nalezenych stromu
// nebo kvuli preruseni klientem

// pro ukladani retezcu
char client_version[MAX_VERSION_LENGTH] = "1.49" ; // pro uschování verze klienta; předpokládám verzi nižší než 1.5,od které už verzi posílá klient
char buff[5000], buff2[MPL], buff3[MPL], buff4[MPL], buff5[MPL]; // docasne retezce pro obecne pouziti

char buff_nodes[1000]; // pro načtení seznamu matchujících vrcholů
char zprava[MAXLENMES];
char path_actual[MPL]; // aktualni adresar v adresarove strukture stromu
char path_initial[MPL]; // vychozi cesta - rootovsky adresar klientovi pristupne adresarove struktury
char pidstr[10];
char fcesta[MPL];  // pro jmeno souboru, ve kterem se prave prohledavaji stromy pro QUERY;
				// plneno ve funkci reseni, pouzito napr. ve funkcich reseni, tisk
char minfcesta[MPL]; // ve funkci setQuery, pro uchovani minule fcesty
char last_sent_tree_file_name[MPL]; // pro uchovani jmena souboru, ze ktereho se posledne posilal strom uzivateli; vyuzivano pri posilani kontextu
int last_sent_tree_number_in_file; // uchovava poradi (v souboru) posledne posilaneho vysledneho stromu uzivateli (tedy bez pripadneho kontextu); vyuzivano pri posilani kontextu
char last_sent_tree_matching_nodes[MPL]; // uchovava mathujici vrcholy posledne posilaneho vysledneho stromu uzivateli (tedy bez pripadneho kontextu); vyuzivano pri posilani kontextu
int last_context_tree_number_in_file; // uchovava poradi stromu v souboru, posilaneho posledne uzivateli (vcetne kontextu); vyuzivano pri posilani kontextu

char actual_query[MAX_QUERY_LOG_LENGTH+1]; // vyuzivano dotser-childem pro uchovani dotazu pro zaverecny tisk statistik o prohledavani tohoto dotazu do stderr; preteceni osetreno
char actual_logical_expression[MAX_LOG_EXP_LOG_LENGTH+1]; // vyuzivano dotser-childem pro uchovani logickeho vyrazu k dotazu pro zpracovani a pro zaverecny tisk statistik o prohledavani tohoto dotazu do stderr; preteceni osetreno

// nazvy pom. souboru
char podadr[] = "/tmp/podadr.                     ";
char soubory[] = "/tmp/soubory.                    ";
char vysledek[] = "/tmp/vysledek.                   ";
char result_stored[] = "/tmp/result_stored.                   ";
char setfiles[] = "/tmp/setfiles.                   ";
char dotaz[] = "/tmp/dotaz.                      ";
#ifdef _WINDOWS_VERSION
char statistics[] = "/tmp/statistics.                      "; // kvuli cygwinu opoustim pouziti sdilene pameti a realizuji ji takto
// tuto sdilenou pamet pouzivam pro predavani statistik o prohledavani a pro predani priznaku o zadosti o ukonceni prohledavani
#endif

FILE * u_podadr = NULL, // pro pomocné soubory
     * u_soubory = NULL,
     * u_vysledek = NULL,
     * u_result_stored = NULL,
     * u_setfiles = NULL,
     * u_dotaz = NULL;
#ifdef _WINDOWS_VERSION
	FILE* u_statistics = NULL;
#endif

////////////////////////// FUNKCE ///////////////////////

void deleteTemporaryFiles() { // zavře a smaže dočasné soubory
	//close(readfd); // zavřu roury (maže je rodič, ale pro jistotu je smažu také)
	//close(writefd);
	//unlink(rour1);
	//unlink(rour2);
	if (u_podadr) {// zavřu a smažu ostatní vytvořené pomocné soubory
		fclose(u_podadr);
		unlink(podadr);
	}
	if (u_soubory) {
		fclose(u_soubory);
		unlink(soubory);
	}
	if (u_vysledek) {
		fclose(u_vysledek);
		unlink(vysledek);
	}
	if (u_result_stored) {
		fclose(u_result_stored);
		unlink(result_stored);
	}
	if (u_setfiles) {
		fclose(u_setfiles);
		unlink(setfiles);
	}
	if (u_dotaz) {
		fclose(u_dotaz);
		unlink(dotaz);
	}
#ifdef _WINDOWS_VERSION
	if (u_statistics) {
		fclose(u_statistics);
		unlink(statistics);
	}
#endif
}

void err_dump (char * message, int rodic = TRUE) { // fatal error -> exit
// rodic urcuje, zda se provede uklid
	if (rodic) { // tj. nejsem jen podproces pro zpracovani dotazu
		// zastaveni ditete
		if (bezi_dotaz)
			kill(childpid, SIGKILL);

		deleteTemporaryFiles();
	}
	fprintf(stderr,message);
	fflush(stderr);
	exit(1);
}

void zapis( int fd, char * p, int delka ) { // zapise do fd z p delka bajtu
	int nwritten;

	#ifdef DEBUG

	fprintf(stderr,"Chci zapsat : (dotser) %i", delka);
 	fflush( stderr );

 	#endif

 	while (delka > 0)
 	{
 		nwritten=write(fd, p, delka);
 	  	if (nwritten <= 0)
 	  		err_dump("\nserver (dotser.c): error in writing");
 	  	delka -= nwritten;
 	  	p += nwritten;
 	}
}

int pozice(char * p, int znak) {
// vraci pozici znaku znak v retezci p (od nuly)
	int index = 0;

	while( p[index] != znak )
		index++;

	return index;
}

int poziceMax(char * p, int znak, int max) { // vraci pozici znaku znak v retezci p (od nuly); pokud se nevyskytne do pozice max, vrati max
	int index = 0;

	while( p[index] != znak ) {
		if (index == max) {
			return max;
		}
		index++;
	}
	return index;
}

int zapis_str_eom(char *dst, char * src, int MAX, int endznak = EOM) {
// zapis retezce do daneho ukoncovaciho znaku (musi byt soucasti retezce) s omezenou max delkou do jiz alokovaneho retezce
// vraci pocet zapsanych znaku vyjma (noveho) ukoncovaciho znaku retezce
  int end = poziceMax(src,endznak,MAX);
  strncpy(dst, src, end);
  dst[end] = '\0'; // místo tam je - alokováno je o jedna víc než MAX
  return end;
}

int zapis_str_eom2(char *dst, char * src, int MAX, int endznak1, int endznak2=EOM) {
// zapis retezce do drivejsiho ze dvou ukoncovacich znaku (musi byt soucasti retezce) s omezenou max delkou do jiz alokovaneho retezce
// vraci pocet zapsanych znaku vyjma (noveho) ukoncovaciho znaku retezce
  int end1 = poziceMax(src,endznak1,MAX);
  int end2 = poziceMax(src,endznak2,MAX);
  int end = end1 > end2 ? end2 : end1;
  strncpy(dst, src, end);
  dst[end] = '\0'; // místo tam je - alokováno je o jedna víc než MAX
  return end;
}

void zapis_eom( int fd, char * p, int endznak = EOM ) {
// zapis s ukonc. znakem (musi byt jiz soucasti retezce)
	zapis( fd, p, pozice( p, endznak ) + 1 );
}

int cti_eom( int fd, char * p, int endznak = EOM ) {
// precte z fd do p po znak endznak (vcetne)
// vraci kolik bajtu precetl (vcetne endznaku)
	int nread;
	int index = -1;

	#ifdef DEBUG

	fprintf(stderr,"Chci cist (dotser)");
 	fflush(stderr);

 	#endif

 	do
 	{
 		index++;
 		nread=read(fd, p + index, 1);
 	  	if (nread <= 0)
 	  		err_dump("\nserver (dotser.c): error in reading");


 	} while( p[index] != endznak );

 	return index + 1;
}

void createTemporaryFile (FILE * & uk, char *jmeno, int pozice, char *pidstr) {
// vytvori pom. soubor se jmenem jmeno, pidstr prida na pozici pozice
// pritom predpoklada dost mista v jmeno. Vraci uk.

	strcpy(jmeno + pozice, pidstr); // vytvori cely nazev souboru

	if (uk) {
		fclose(uk);
	}

	unlink(jmeno);

 	if ((uk = fopen (jmeno, "w+")) == NULL) { // vytvori soubor (smaze pripadny stary)
		fprintf(stderr,"\ndotser.c (createTemporaryFile): Cannot create the temporary file %s", jmeno);
 		err_dump("\nExiting!");
	}
}

int nacti_soubor(FILE * uk, char * dest, int pokracovani, int max_misto) {
// nacte obsah souboru do stringu dest
// string ukonci EOM
// parametr pokracovani == TRUE => pokracovat v souboru v miste, kde se minule skoncilo
//                         FALSE => zacit od zacatku souboru
// vraci FALSE pokud dosel na konec souboru, TRUE pokud zaplnil dest do max_misto

	int neuplne = false; // implicitni navratova hodnota
	char *pom = dest; // kde byl zacatek
	int zbyva_misto = max_misto; // tohle nesmim prekrocit, jinak si sahnu nekam do pameti
	int delka; // delka prave nacteneho retezce
	char files_separator[2] = " "; // určuje, čím oddělovat soubory poslané klientovi
	if (strcmp(client_version, "1.86") < 0) { // klient je starý, soubory odděluje mezerou
		strcpy(files_separator, " ");
		#ifdef DEBUG_GETFILES
			fprintf(stderr,"\ndotser.c (parent): nacti_soubor: The client version is less than 1.86 - files are separated with a space character.");
		#endif
	}
	else { // klienti od 1.86 oddělují soubory tabulátorem
		strcpy(files_separator,"\t");
		#ifdef DEBUG_GETFILES
			fprintf(stderr,"\ndotser.c (parent): nacti_soubor: The client version is at least 1.86 - files are separated with a tabulator.");
		#endif
	}

	if (pokracovani == FALSE) { // mam-li cist od zacatku souboru
        rewind(uk);
        fflush(uk);
	}
	while (! feof(uk)) {
		if (fscanf(uk, "%[^\n]", buff) == 1) {
			#ifdef DEBUG_GETFILES
				fprintf(stderr,"\ndotser.c (parent): nacti_soubor: File or directory '%s' has been read.", buff);
			#endif
			getRidOfTrailingWhites(buff); // ve windows to odstrani \r
			strcat(buff, files_separator);  // oddelovaci znak
			delka = strlen(buff);
			zbyva_misto -= delka;
			strncpy(dest, buff,delka+1); // to +1 je tam kvuli zkopirovani take binarni nuly na konci
			dest += delka;
			fscanf(uk,"%[\n ]",buff); // precti a zapomen konec radku a pripadne okolni mezery
			if (zbyva_misto <= MAXLENFILENAME) { // pozor, buffer pro odpoved je plny! Dalsi soubor po tomto se tam uz nemusi vejit; tenhle je posledni
				//fprintf(stderr,"\ndotser.c: nacti_soubor: error - the message for client is very long - sending one part!\n");
				neuplne = TRUE; // seznam neni uplny
				break; // předčasný konec while cyklu
			}
		}
	}

	*dest = EOM;
	if (feof(uk)) neuplne = FALSE; // nahodou se tam vesly presne vsechny polozky

	return neuplne;
}

int zapis_znacku (FILE * uk) {
// zapise znacku do souboru uk
// vraci 0 pokud doslo k chybe
	char zn = RESULT_FILE_OCCURRENCES_DELIMITER;
	return fwrite (&zn, 1, 1, uk);
}

int dummy (char c) { // test na bile znaky
	if (c == ' ' || c == '\t' || c == '\n' || c == '\r')
		return 1;

	return 0;
}

void odpovidej( FILE * uk )
{
	long dumy = 0;

	for( int i = 1; i < 10; i++ )
	{
		fprintf( uk, "%d %d\n", i, (int)getpid() );
		zapis_znacku( uk );
		fflush( uk );
		for( long z = 1; z < 100000000; z++ )
			dumy += 10;
		fprintf( uk, "\n" );

	}

}


/////////////////// Graph code ////////////////////

//#define TISK

TFSFile * PomHlav = NULL;       // pomocna hlavicka
TFSFile * meta_head = NULL; // hlavicka obsahujici meta atributy

int * zobrazeni_gh;		// uchovava souvislost atributu v uzlech

TFSFile * nacti_hlavicku_sbr( FILE * uk )
{
	TFSFile * hlav;
	FILE * File;
	char cesta[MPL];

	for( ; ; )
	{
		if( fscanf( uk, "%[^\n]\n", cesta ) != 1 )
			return 0;

		getRidOfTrailingWhites(cesta); // odstraním nový řádek na konci jména souboru
		if ( (File = fopen(cesta, "rb")) != 0 )
  		{
			if( (hlav = readHead(File)) != NULL )
			{
				fclose( File );
				return hlav;
			}

			fclose( File );
		}
	}

}

TFSFile* createMetaHead () { // vytvori globalni hlavicku obsahující právě meta atributy
	TFSFile *head;
	head = new TFSFile;		// alokuje strukturu pro novou hlavicku
	head->DefsTable =  new TDefsLine[RESERVEDNUM];
	head->AHNum = 0;			// zatím nebyl přečten jediný atribut
	head->ResAHNum = RESERVEDNUM;
	head->Trees = 0;			// ani ádný strom
	head->TreeNum = 0;
       // ted mám vytvořenu prázdnou hlavičku
	// a mohu do ni vkladat meta atributy
	createAndAddAttribute(head, META_TRANSITIVE_PARENT_EDGE, ATTR_LIST|ATTR_POS, TRANSITIVITY_TYPES_LABELS); // vytvorim a pridam vyctovy meta atribut pro definici transitivní rodičovské hrany
	createAndAddAttribute(head, META_OPTIONAL_NODE, ATTR_LIST|ATTR_POS, "true,false,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20"); // meta atribut pro definici nepovinného vrcholu
	createAndAddAttribute(head, META_NUMBER_OF_SONS, ATTR_LIST|ATTR_POS, "0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20"); // meta atribut pro definici poctu synu vrcholu
	createAndAddAttribute(head, META_NUMBER_OF_HIDDEN_SONS, ATTR_LIST|ATTR_POS, "0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20"); // meta atribut pro definici poctu synu vrcholu
	createAndAddAttribute(head, META_NUMBER_OF_DESCENDANTS, ATTR_LIST|ATTR_POS, "0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20"); // meta atribut pro definici poctu vsech potomku vrcholu
	createAndAddAttribute(head, META_NUMBER_OF_LEFT_BROTHERS, ATTR_LIST|ATTR_POS, "0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20"); // meta atribut pro definici poctu levych bratru vrcholu
	createAndAddAttribute(head, META_NUMBER_OF_RIGHT_BROTHERS, ATTR_LIST|ATTR_POS, "0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20"); // meta atribut pro definici poctu pravych bratru vrcholu
	createAndAddAttribute(head, META_DEPTH_FROM_ROOT, ATTR_LIST|ATTR_POS, "0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20"); // meta atribut pro definici vzdalenosti vrcholu od korene stromu
	createAndAddAttribute(head, META_NUMBER_OF_OCCURRENCES, ATTR_LIST|ATTR_POS, "0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20"); // meta atribut pro definici poctu takovych synu otce daneho uzlu
	createAndAddAttribute(head, META_NODE_NAME, ATTR_POS, ""); // meta atribut pro pojmenování vrcholu
	createAndAddAttribute(head, META_SENTENCE, ATTR_POS, ""); // meta atribut obsahující větu
	//createAndAddAttribute(head, META_DEPENDENCE, ATTR_POS, ""); // meta atribut pro změnu rodičovské hrany na koreferenci !!! tady bude potřeba naplnit možné hodnoty podle coreferences.txt

	return head;
} // createMetaHead

void addMetaAttributes(TFSFile *gh) { // prida do globalni hlavicky meta atributyGoing to match the meta
	//fprintf(stderr,"\nGoing to create the meta head.");
	if (meta_head == NULL) { // prvni volani teto funkce, vytvori se hlavicka obsahujici prave meta atributy
		meta_head = createMetaHead();
	}
	//fprintf(stderr,"\nGoing to match the meta head to the global head.");
	mergeHeads(gh, meta_head);
	//fprintf(stderr,"\nThe heads have been matched.");
} // addMetaAttributes

TFSFile * createGlobalHead (FILE * uk) {
// Prochazi soubor uk. Ze souboru v nem uvedenych vytvori globalni hlavicku.
// Pokud najde v konfiguracnim souboru jine pokyny, udela tu hlavicku jinak
// používá buff2
	TFSFile * gh, * dalsi;
	int finished = FALSE; // je už hlavička vytvořena?
	int first_only = FALSE; // má se hlavička vzít jen z prvního souboru?
	FILE *f;
	
	rewind (uk); // na zacatek souboru

	int cteni_konfiguraku = readConfigFile(buff2, PARAM_NAME_PRESET_HEAD);
	if (cteni_konfiguraku == 0) { // hodnota parametru úspěšně přečtena
		if (strlen(buff2)>0) { // a ta hodnota je neprázdná
			if (strcmp(buff2,PARAM_PRESET_HEAD_VALUE_FIRST)==0) { // glob. hlavička se má vytvořit jen z prvního souboru
				first_only = TRUE;
			}
			else { // jde asi o jméno souboru, ze kterého se má hlavička přečíst
				if ( (f = fopen(buff2, "rb")) != 0 )	{
					if ( (gh = readHead(f)) != NULL ) {
						finished = TRUE;
					}
					fclose(f);
				}
			}
		}
	}
	
	if (!finished) { // hlavička ještě není vytvořena (byla by jedině, kdyby se už přečetla ze spec. souboru)
		if ((gh = nacti_hlavicku_sbr (uk)) == 0)  // hlavicka 1. souboru bude tvorit zaklad globalni hlavicky
			return 0;	// zadna hlavicka

		if (first_only) { // hlavička má být vytvořena jen z prvního souboru
			finished = TRUE;
		}
	}

	if (!finished) { // hlavička se má vytvořit ze sjednocení hlaviček všech souborů
		while ((dalsi = nacti_hlavicku_sbr (uk)) != 0) { // dalsi soubory budou ke globalni hlavicce prispivat jen novymi atributy
			mergeHeads(gh, dalsi); // prida nove atributy z dalsi do gh
			//fprintf(stderr, "\ngoing to free a head");
 			freeFile (dalsi); // uvolneni dalsi hlavicky
			//fprintf(stderr, "\nthe head has been freed");
 		} // konec while
 	}
	
	addMetaAttributes(gh); // prida do globalni hlavicky meta atributy
	return gh;
}

int vypis_hlavicku( TFSFile * hlav, char * pole )
// Vypise hlavicku hlav do stringu pole.
// Vraci delku hlavicky.
{

	char * zac = pole;	// zacatek stringu
	int poc; 		// pocitani znaku

	if( ! hlav )		// hlavicka neexistuje
		return 0;

	// vypis

	for( int h = 0; h < hlav -> AHNum; h++ )
	{
		poc = sprintf( pole, "%s %d", hlav -> DefsTable[ h ].ID,
				    	      hlav -> DefsTable[ h ].IDType );
		pole += poc;

		for( TAHLine * i = hlav -> DefsTable[ h ].Vals; i != NULL;
		     i = i -> next )
		{
			poc = sprintf( pole, " %s", getAHLineValue(i));
			pole += poc;
		}

		poc = sprintf( pole, "\n" );
		pole += poc;
	}


 	return pole - zac;
}

void preved_hlav_na_poz( TFSFile * hlav ) { // upravi vsechny atributy v hlavicce na typ pozicni

	if (! hlav)		// hlavicka neexistuje
		return;

	for (int h = 0; h < hlav -> AHNum; h++) {
		hlav -> DefsTable [h].IDType |= 1;
	}
}


int hledej_znacku_dolu( FILE * uk, long *poz, int zn = RESULT_FILE_OCCURRENCES_DELIMITER ) {
	char c;		// pro cteni znaku
	long pozice;    // pozice v souboru

	pozice = ftell( uk ); // soucasna pozice v souboru

	// posunuti za soucasnou pozici
	if( fread( &c, 1, 1, uk ) < 1 )
	{
		// navrat k predchozi pozici
		fseek( uk, pozice, SEEK_SET );
		return FALSE;
	}

	// hledani znacky
	for( ; ; ) {
		*poz = ftell( uk );

		if( fread( &c, 1, 1, uk ) < 1 )
		{
			// navrat pozice
			fseek( uk, pozice, SEEK_SET );
			return FALSE;
		}

		if( c == zn )
		// znacka nalezena
		{
			fseek( uk, pozice, SEEK_SET );
			return TRUE;
		}

	}

}


int hledej_znacku_nahoru( FILE * uk, long *poz, int zn = RESULT_FILE_OCCURRENCES_DELIMITER )
{
	long soucasna; 	// pozice v souboru
	char c;		// znak ke cteni

	soucasna = ftell( uk );

	for( ; ; )
	{
                //fprintf(stderr,".");
		if( fseek( uk, -1, SEEK_CUR ) != 0 )
		// chyba pri presunu o jedno vys
		{
			fseek( uk, soucasna, SEEK_SET );
			return FALSE;
		}

		*poz = ftell( uk );

		if( fread( &c, 1, 1, uk ) < 1 )
		{
			fseek( uk, soucasna, SEEK_SET );
			return FALSE;
		}
		//fprintf(stderr,"  precten znak: '%d'",c);
		if( c == zn )
		// byla nalezena znacka
		{
			fseek( uk, soucasna, SEEK_SET );
			return TRUE;
		}

		if (fseek(uk,-1,SEEK_CUR) != 0)
		// chyba pri presunu o jedno nahoru
		{
			fseek( uk, soucasna, SEEK_SET );
			return FALSE;
		}

	}

}

// -----------------
// následují funkce pro bezpečné nastavení a změny sdílených proměnných o statistikách
#ifdef _WINDOWS_VERSION
	void changeNumberOfFoundOccurrences(long int diff) { // zvýší  (či sníží) počet nalezených výskytů dotazu
		number_of_found_occurrences += diff;
		if (u_statistics) {
			fseek(u_statistics, number_of_found_occurrences_position, SEEK_SET);
			fprintf(u_statistics, "%ld", number_of_found_occurrences);
			fflush(u_statistics);
		}
	} // changeNumberOfFoundOccurrences

	void changeNumberOfFoundTrees(long int diff) { // zvýší  (či sníží) počet nalezených stromů
		number_of_found_trees += diff;
		if (u_statistics) {
			fseek(u_statistics, number_of_found_trees_position, SEEK_SET);
			fprintf(u_statistics, "%ld", number_of_found_trees);
			fflush(u_statistics);
		}
	} // changeNumberOfFoundTrees

	void changeNumberOfSearchedTrees(long int diff) { // zvýší  (či sníží) počet prohledaných stromů
		number_of_searched_trees += diff;
		if (u_statistics) {
			fseek(u_statistics, number_of_searched_trees_position, SEEK_SET);
			fprintf(u_statistics, "%ld", number_of_searched_trees);
			fflush(u_statistics);
		}
	} // changeNumberOfSearchedTrees

	void setNumberOfFoundOccurrences(long int number) { // nastaví počet nalezených výskytů dotazu
		number_of_found_occurrences = number;
		if (u_statistics) {
			fseek(u_statistics, number_of_found_occurrences_position, SEEK_SET);
			fprintf(u_statistics, "%ld", number_of_found_occurrences);
			fflush(u_statistics);
		}
	} // setNumberOfFoundOccurrences

	void setNumberOfFoundTrees(long int number) { // nastaví počet nalezených stromů
		number_of_found_trees = number;
		if (u_statistics) {
			fseek(u_statistics, number_of_found_trees_position, SEEK_SET);
			fprintf(u_statistics, "%ld", number_of_found_trees);
			fflush(u_statistics);
		}
	} // setNumberOfFoundTrees

	void setNumberOfSearchedTrees(long int number) { // nastaví počet prohledaných stromů
		number_of_searched_trees = number;
		if (u_statistics) {
			fseek(u_statistics, number_of_searched_trees_position, SEEK_SET);
			fprintf(u_statistics, "%ld", number_of_searched_trees);
			fflush(u_statistics);
		}
	} // setNumberOfSearchedTrees

	long int getNumberOfFoundOccurrences() { // vrátí počet nalezených výskytů dotazu
		if (u_statistics) {
			fflush(u_statistics);
			fseek(u_statistics, number_of_found_occurrences_position, SEEK_SET);
			fscanf(u_statistics, "%ld", &number_of_found_occurrences);
		}
		//fprintf(stderr, "\nPocet nactenych vyskytu: %ld", number_of_searched_trees);
		return number_of_found_occurrences;
	} // getNumberOfFoundOccurrences

	long int getNumberOfFoundTrees() { // vrátí počet nalezených stromů
		if (u_statistics) {
			fflush(u_statistics);
			fseek(u_statistics, number_of_found_trees_position, SEEK_SET);
			fscanf(u_statistics, "%ld", &number_of_found_trees);
		}
		return number_of_found_trees;
	} // getNumberOfFoundTrees

	long int getNumberOfSearchedTrees() { // vrátí počet prohledaných stromů
		if (u_statistics) {
			fflush(u_statistics);
			fseek(u_statistics, number_of_searched_trees_position, SEEK_SET);
			fscanf(u_statistics, "%ld", &number_of_searched_trees);
		}
		return number_of_searched_trees;
	} // getNumberOfSearchedTrees
#endif

#ifdef _LINUX_VERSION
	void changeNumberOfFoundOccurrences(long int diff) { // zvýší  (či sníží) počet nalezených výskytů dotazu
		if (number_of_found_occurrences != NULL) {
			(*number_of_found_occurrences) += diff;
		}
	} // changeNumberOfFoundOccurrences

	void changeNumberOfFoundTrees(long int diff) { // zvýší  (či sníží) počet nalezených stromů
		if (number_of_found_trees != NULL) {
			(*number_of_found_trees) += diff;
		}
	} // changeNumberOfFoundTrees

	void changeNumberOfSearchedTrees(long int diff) { // zvýší  (či sníží) počet prohledaných stromů
		if (number_of_searched_trees != NULL) {
			(*number_of_searched_trees) += diff;
		}
	} // changeNumberOfSearchedTrees

	void setNumberOfFoundOccurrences(long int number) { // nastaví počet nalezených výskytů dotazu
		if (number_of_found_occurrences != NULL) {
			(*number_of_found_occurrences) = number;
		}
	} // setNumberOfFoundOccurrences

	void setNumberOfFoundTrees(long int number) { // nastaví počet nalezených stromů
		if (number_of_found_trees != NULL) {
			(*number_of_found_trees) = number;
		}
	} // setNumberOfFoundTrees

	void setNumberOfSearchedTrees(long int number) { // nastaví počet prohledaných stromů
		if (number_of_searched_trees != NULL) {
			(*number_of_searched_trees) = number;
		}
	} // setNumberOfSearchedTrees

	long int getNumberOfFoundOccurrences() { // vrátí počet nalezených výskytů dotazu
		if (number_of_found_occurrences != NULL) {
			return *number_of_found_occurrences;
		}
		else return (long int) 0;
	} // getNumberOfFoundOccurrences

	long int getNumberOfFoundTrees() { // vrátí počet nalezených stromů
		if (number_of_found_trees != NULL) {
			return *number_of_found_trees;
		}
		else return (long int) 0;
	} // getNumberOfFoundTrees

	long int getNumberOfSearchedTrees() { // vrátí počet prohledaných stromů
		if (number_of_searched_trees != NULL) {
			return *number_of_searched_trees;
		}
		else return (long int) 0;
	} // getNumberOfSearchedTrees
#endif

// -----------------

// tyto funkce jsou pro bezpečný přístup do sdílené paměti k příznaku pro předčasné skončení prohledávání dotazu
#ifdef _WINDOWS_VERSION
	void setQueryStopFlag(int flag) { // nastavím příznak ve sdílené paměti
		#ifdef DEBUG_CONTROL_SHARED_MEMORY
			fprintf(stderr,"\npřístup (zápis) do sdílené paměti k příznaku pro skončení prohledávání");
		#endif
		if (u_statistics) {
			fseek(u_statistics, query_stop_flag_position, SEEK_SET);
			fprintf(u_statistics, "%d", flag);
			fflush(u_statistics);
		}
		#ifdef DEBUG_CONTROL_SHARED_MEMORY
			fprintf(stderr," - hotovo");
		#endif
	} // setQueryStopFlag

	int getQueryStopFlag() { // vrátí příznak o žádosti o skončení prohledávání ze sdílené paměti
		int flag = 0;
		#ifdef DEBUG_CONTROL_SHARED_MEMORY
			fprintf(stderr,"\npřístup (čtení) do sdílené paměti k příznaku pro skončení prohledávání");
		#endif
		if (u_statistics) {
			fflush(u_statistics);
			fseek(u_statistics, query_stop_flag_position, SEEK_SET);
			fscanf(u_statistics, "%d", &flag);
		}
		return flag;
	} // getQueryStopFlag
#endif

#ifdef _LINUX_VERSION
	void setQueryStopFlag(int flag) { // nastavím příznak ve sdílené paměti
		#ifdef DEBUG_CONTROL_SHARED_MEMORY
			fprintf(stderr,"\npřístup (zápis) do sdílené paměti k příznaku pro skončení prohledávání");
		#endif
		if (query_stop_flag != NULL) {
			(*query_stop_flag) = flag;
		}
		#ifdef DEBUG_CONTROL_SHARED_MEMORY
			fprintf(stderr," - hotovo");
		#endif
	} // setQueryStopFlag

	int getQueryStopFlag() { // vrátí příznak o žádosti o skončení prohledávání ze sdílené paměti
		#ifdef DEBUG_CONTROL_SHARED_MEMORY
			fprintf(stderr,"\npřístup (čtení) do sdílené paměti k příznaku pro skončení prohledávání");
		#endif
		if (query_stop_flag != NULL) {
			return *query_stop_flag;
		}
		else return FALSE;
	} // getQueryStopFlag
#endif

// -----------------
#ifdef _WINDOWS_VERSION
	void createControlSharedMemory() { // vytvoří sdílenou paměť pro statistiky o prohledávání dotazu a další proměnné
		createTemporaryFile (u_statistics, statistics, 16, pidstr);
		int size_long_int = 20; // tedy ne: sizeof(long int); // místo (s rezervou) pro long int proměnnou zapsanou v desitkove soustave
		number_of_found_trees_position = 0; // pozice cisel v souboru pro sdileni statistik (nastavuji se v createControlSharedMemory
		number_of_found_occurrences_position = number_of_found_trees_position + size_long_int;
		number_of_searched_trees_position = number_of_found_occurrences_position + size_long_int;
		query_stop_flag_position = number_of_searched_trees_position + size_long_int;
		#ifdef DEBUG_CONTROL_SHARED_MEMORY
			fprintf(stderr,"\nsdílená paměť pro statistiky a další proměnné vytvořena.");
		#endif
	} // createControlSharedMemory

	void destroyControlSharedMemory() {
		if (u_statistics) {
			fclose(u_statistics);
			unlink(statistics);
		}
	} // destroyControlSharedMemory

	void attachControlSharedMemory() { // připojí se ke sdílené paměti a nastaví ukazatele proměnných do sdílené paměti (pouziva to dotazovaci proces - rodic)
		fclose (u_statistics);
		if (! (u_statistics = fopen (statistics, "r+")))
			err_dump ("\ndotser.c (child or parent): The query process cannot open the file with statistics!", FALSE);
	} // attachControlSharedMemory*/

	void detachControlSharedMemory() { // odpojí se od sdílené paměti - patrně nepoužito
		fclose(u_statistics);
	}
#endif

#ifdef _LINUX_VERSION
	void createControlSharedMemory() { // vytvoří sdílenou paměť pro statistiky o prohledávání dotazu a další proměnné
		int size = sizeof(long int) * 3; // místo pro tři long int proměnné pro statistiky o prohledávání
		size += sizeof(int); // místo pro jednu int proměnnou pro příznak sloužící k ukončení prohledávání
		control_shared_memory_id = shmget(IPC_PRIVATE, size, 0666|IPC_CREAT); // vytvořím sdílenou paměť
		if (control_shared_memory_id == -1) {
            fprintf(stderr,"\ndotser.c: createControlSharedMemory(): Cannot create the shared memory for statistics and other variables! Error: %d - ", errno);
            switch (errno) {
                case EINVAL: fprintf(stderr, "EINVAL"); break;
                case EEXIST: fprintf(stderr, "EEXIST"); break;
                case ENOSPC: fprintf(stderr, "ENOSPC"); break;
                case ENOENT: fprintf(stderr, "ENOENT"); break;
                case EACCES: fprintf(stderr, "EACCES"); break;
                case ENOMEM: fprintf(stderr, "ENOMEM"); break;
                default: fprintf(stderr, "unknown error"); break;
            }
		}
		#ifdef DEBUG_CONTROL_SHARED_MEMORY
			fprintf(stderr,"\nsdílená paměť pro statistiky a další proměnné vytvořena.");
		#endif
	} // createControlSharedMemory

	void destroyControlSharedMemory() {
		shmctl(control_shared_memory_id, IPC_RMID, NULL);
	} // destroyControlSharedMemory

	void attachControlSharedMemory() { // připojí se ke sdílené paměti a nastaví ukazatele proměnných do sdílené paměti
		if (control_shared_memory_id != -1) {
			control_shared_memory_address = shmat(control_shared_memory_id, 0, 0);
			if (control_shared_memory_address != NULL) {
				number_of_found_occurrences = (long int *) control_shared_memory_address;
				number_of_found_trees = (long int *) control_shared_memory_address + 1;
				number_of_searched_trees = (long int *) control_shared_memory_address + 2;
				query_stop_flag = (int *) (long int *) control_shared_memory_address + 3;
			}
			else {
				fprintf(stderr,"\ndotser.c: attachControlSharedMemory(): Cannot attach the shared memory for statistics and other variables!");
			}
			#ifdef DEBUG_CONTROL_SHARED_MEMORY
				fprintf(stderr,"\nsdílená paměť pro statistiky a další proměnné připojena.");
			#endif
		}
	} // attachControlSharedMemory

	void detachControlSharedMemory() { // odpojí se od sdílené paměti - patrně nepoužito
		number_of_found_occurrences = NULL;
		number_of_found_trees = NULL;
		number_of_searched_trees = NULL;
		query_stop_flag = NULL;
		shmdt((char *)control_shared_memory_address);
		#ifdef DEBUG_CONTROL_SHARED_MEMORY
			fprintf(stderr,"\nsdílená paměť pro statistiky a další proměnné odpojena.");
		#endif
	} // detachControlSharedMemory
#endif

void clearStatistics() { // vynuluje informace o prohledávání
	//fprintf(stderr,"\nclearing statistics");
	//number_of_actual_occurrence = 0;
	//number_of_actual_tree = 0;
	setNumberOfFoundOccurrences(0);
	setNumberOfFoundTrees(0);
	setNumberOfSearchedTrees(0);
} // clearStatistics

// tuto funkci volá dotser-parent během odpovědí klientovi
int writeStatisticsToChars(char *dst) { // zapíše do dst počty nalezených/prohledaných stromů, pokud je klient dostatečně nový, aby to mohl číst
// vrací počet zapsaných znaků
	long int occurrences;
	long int trees;
	long int searched;
	int length;
  if (strcmp(client_version, "1.53") < 0) { // klient příliš starý na zapsání statistik
		#ifdef DEBUG_STATISTICS_PARENT
			fprintf(stderr,"\nThe client is old - no statistics written.");
		#endif
		return 0; // nezapsáno nic
	}
	occurrences = getNumberOfFoundOccurrences() - number_of_removed_occurrences;
	trees = getNumberOfFoundTrees() - number_of_removed_trees;
	searched = getNumberOfSearchedTrees();
	if (strcmp(client_version, "1.75") < 0) { // klient příliš starý na zapsání pořadí stromu
		length = sprintf (dst, "%ld%c%ld%c%ld%c%ld%c", number_of_actual_occurrence, EOL,
													  occurrences, EOL,
													  trees, EOL,
													  searched, EOL);
		// - zapíšu pořadí daného výskytu mezi nalezenými, počet nalezených výskytů dotazu, počet stromů, ve kterých byl dotaz nalezen alespoň jednou, a počet prohledaných stromů
	}
	else { // klient je dostatečně nový na zapsání všech statistik
		length = sprintf (dst, "%ld%c%ld%c%ld%c%ld%c%ld%c", number_of_actual_occurrence, EOL,
		                                              number_of_actual_tree, EOL,
													  occurrences, EOL,
													  trees, EOL,
													  searched, EOL);
		// - zapíšu pořadí daného výskytu mezi nalezenými, pořadí daného stromu mezi nalezenými, počet nalezených výskytů dotazu, počet stromů, ve kterých byl dotaz nalezen alespoň jednou, a počet prohledaných stromů
	}
	#ifdef DEBUG_STATISTICS_PARENT
	fprintf(stderr, "\nstatistics:\n%ld\n%ld\n%ld\n%ld", number_of_actual_occurrence,
		                                              occurrences,
		                                              trees,
		                                              searched);
	#endif
	return length;
} // writeStatisticsToChars

void getStatistics(char *dst) { // vrátí statistiky klientovi - explicitní požadavek pouze na statistiky
	*dst = OK;
	int length = writeStatisticsToChars(dst + 1);
	*(dst + 1 + length) = EOM;
} // getStatistics

int answerMatchingNodesOld(char *dst, char *matching_nodes) { // it writes matching_nodes to dst as required by clients older than 1.80
// returns the number of written characters
	int delka = 0;
	int state = 1; // 1 means "copy", 0 means "skip"
	char c;
	while (c = *matching_nodes) { // go through the whole string of matching nodes
		if (c == MATCHING_NODES_DELIMITER) {
			state = 1; // expecting another matching node from the result tree
			*(dst+delka) = c;
			delka++;
		}
		else if (c == MATCHING_NODES_QUERY_DELIMITER) {
			state = 0; // skipping expected matching node from the query
		}
		else if (c == MATCHING_NODES_TREES_DELIMITER) {
			break; // take only nodes matching the first tree of the query
		}
		else { // now presumably a number character
			if (state == 1) {
				*(dst+delka) = c;
				delka++;
			}
		}
		matching_nodes ++;
	}
	return delka;
} // answerMatchingNodesOld

int answerMatchingNodes(char *dst, char *matching_nodes) { // according to the client version it writes matching_nodes to dst; puts '\n' at the end
// returns the number of written characters
	int delka = 0;
	if (strcmp(client_version, "1.8") < 0) { // the client is too old for the detailed list of matching nodes
		#ifdef DEBUG_MATCHING_NODES
			fprintf(stderr,"\nThe client is older than 1.8 - only simple list of matching nodes will be written.");
		#endif
		delka += answerMatchingNodesOld(dst + delka, matching_nodes);
	}
	else { // client is at least 1.80 - a detailed list of matching nodes will be written
		delka += sprintf(dst + delka, "%s", matching_nodes); // no change needed
	}
	delka += sprintf(dst + delka, "\n");
	return delka;
} // answerMatchingNodes

int readTreeFromFile (char *dst, char *file_name, int tree_number, char *matching_nodes) { // podle údajů načte strom ze souboru a zapíše odpověd do dst
// vrací -1, pokud něco nevyšlo a soubor stromů se nenačetl, jinak vrací počet zapsaných znaků
	static TFSFile *trees = NULL; // seznam stromů z jednoho souboru (přežije mezi jednotlivými voláními této funkce
	static char last_name[MPL] = ""; // zde se bude uchovávat jméno minule (a stále) načteného souboru stromů
	TTree *tree; // jeden strom
	int delka;
	int i;

	if (strcmp(file_name, last_name)) { // pokud je požadován strom z jiného než již načteného souboru
		if (trees) freeFile (trees); // uvolním paměť
		trees = readFile(file_name); // načtu nový soubor stromů
		if (! trees) { // nenacetl se
			return -1; // vracím chybu
    	}
		strcpy (last_name, file_name); // uschovám jméno načteného souboru
	}
	if (! trees) { // nenacetl se
		return -1; // vracím chybu
	}
	//vytvor_zobrazeni_gh (GlobHlav, soubor, zobrazeni_gh); // smatchovani glob. hlavicky (hlavicky dotazu) s hlavickou souboru
	//preved_hlav_na_poz (soubor); // prevede vsechny atributy na typ pozicni

	// cyklus pres stromy
	tree = trees -> Trees; // ukáži na první strom
	for (int i=1; i<tree_number; i++) { // dojdu až ke správnému stromu
		if (tree == NULL) return -1;
		tree = tree -> Next;
	}
	if (tree == NULL) return -1;

	//delka = sprintf (dst, "\n%s\n%s\n", file_name, matching_nodes); // zapisu jmeno souboru, ze ktereho je tento strom; take poradi matchujicich vrcholu
	delka = sprintf(dst, "\n%s\n", file_name); // zapisu jmeno souboru, ze ktereho je tento strom
	delka += answerMatchingNodes(dst + delka, matching_nodes); // zapisu poradi matchujicich vrcholu
	delka += writeStatisticsToChars(dst + delka);
	//zapis_matchujici_vrchol (u_vysledek, NULL, NULL); // dotaz bez kriteria, cili zadny matchujici vrchol

	delka += vypis_hlavicku (trees, dst+delka); // zapisu hlavicku do vysledku
	delka += sprintf (dst + delka, "\n");

	// zapsani stromu
	last_line_length = 0; // init. graph code
	delka += writeTreeToString (dst + delka, tree -> Root, trees);
	//sprintf (dst+delka, "\n");
	return delka;
}

void createResultFileReadingMask() {
	char eol_2[2];
	eol_2[0]=EOL_2;
	eol_2[1]='\0';
	strcpy(result_file_reading_mask,""); // čtecí maska pro funkci fscanf při čtení ze souboru výsledků ve funkci readOneRecord
	strncat(result_file_reading_mask,eol_2,1);
	strncat(result_file_reading_mask,"%[^",3);
	strncat(result_file_reading_mask,eol_2,1);
	strncat(result_file_reading_mask,"]",1);
	strncat(result_file_reading_mask,eol_2,1);
	strncat(result_file_reading_mask,"%d",2);
	strncat(result_file_reading_mask,eol_2,1);
	strncat(result_file_reading_mask,"%s",2);
	strncat(result_file_reading_mask,eol_2,1);
}

int readOneRecord (FILE *uk, char *file_name, int *tree_number, char *matching_nodes) { // přečte ze souboru tyto údaje o stromu
	int error;
	
	error = fscanf (uk, result_file_reading_mask, file_name, tree_number, matching_nodes);
	#ifdef DEBUG_MATCHING_NODES
		fprintf(stderr,"\nFile name read from the result file: %s",file_name);
		fprintf(stderr,"\nTree number read from the result file: %d",*tree_number);
		fprintf(stderr,"\nMatching nodes read from the result file: %s",matching_nodes);
		fprintf(stderr,"\nNumber of matches while reading (should be 3): %d",error);
	#endif
	if (error != 3) return FALSE;
	return TRUE;
}

int nactiDalsiPolozku(FILE * uk, char * buff, int *tree_number, int zn = RESULT_FILE_OCCURRENCES_DELIMITER) {
	// nacte jeden zaznam v souboru (uk) vysledku dotazu (pro dotaz nad vysledkem dotazu)
	// vrati jmeno souboru v buff, cislo stromu v tree_number
	// vraci TRUE pri uspechu, jinak FALSE
	long pocatecni, koncova; // pozice oddelovacich znacek v souboru
	char dummy; // pomocna pro preskoceni znacky v souboru jejim nactenim

	pocatecni = ftell (uk); // pozice pocatecni znacky

	if (! hledej_znacku_dolu (uk, &koncova, zn)) // koncova znacka nenalezena
		return FALSE;

	// precteni pocatecni znacky
	fread (& dummy, 1, 1, uk); // tim jsem se posunul za ni

	if (! readOneRecord(uk, buff, tree_number, buff_nodes)) { // načte údaje o odpovědi (jméno souboru, pořadí stromu a pořadí matchujících vrcholu)
		return FALSE;
	}
	fseek (uk, koncova, SEEK_SET); // vrátím ukazovátko do souboru na původní pozici (proč?)
	return TRUE;
}

int writeCoreferences(char *dst) { // zapíše koreferenční schémata do dst (pro starší klienty než 1.87 do odpovědi za stromem; od verze 1.87 už jen při inicializaci)
// jednotlivá schémata zakončuje znakem EOL
// vrátí počet zapsaných znaků
	#ifdef DEBUG_READ_COREFERENCES_FILE
		fprintf(stderr,"\nreading coreferences file");
	#endif

	FILE * u_konfig;
	int length = 0; // kolik zapíšu znaků do dst
	int line_length;
	char *success;
	if ((u_konfig = fopen (COREFERENCES_FILE, "r")) != NULL) { // soubor s koreferenčními schématy lze otevřít
		while (! feof (u_konfig)) { // dokud není konec souboru
			success = fgets (dst, MAX_COREFERENCE_LENGTH, u_konfig); // čtu rovnou do výsledku; pokud půjde o komentář, přepíšu ho později
			if (success == NULL) break; // nelze číst nebo konec souboru
			if (*dst == COREFERENCE_FILE_COMMENT_CHAR) { // znak komentáře musí být prvním znakem řádky, jinak to neberu jako komentář
				#ifdef DEBUG_READ_COREFERENCES_FILE
					fprintf(stderr,"\nA comment line has been read: '%s'", dst);
				#endif
				continue;
			}
			line_length = strlen(dst);
			if (line_length < 3) { // an empty line
				#ifdef DEBUG_READ_COREFERENCES_FILE
					fprintf(stderr,"\nAn empty line has been read.");
				#endif
				continue;
			}
			#ifdef DEBUG_READ_COREFERENCES_FILE
				fprintf(stderr,"\nA coreference pattern has been read: '%s'", dst);
			#endif
			if (*(dst+line_length-1) == '\n') {
				//fprintf(stderr,"\nA new line has been removed");
        line_length--; // odstraním případný konec řádku
      }
			if (*(dst+line_length-1) == 13) {
				//fprintf(stderr,"\nA new line has been removed (2)");
        line_length--; // odstraním případný konec řádku
      }
			if (*(dst+line_length-1) == '\n') {
				//fprintf(stderr,"\nA new line has been removed");
        line_length--; // odstraním případný konec řádku
      }
			if (*(dst+line_length-1) == 13) {
				//fprintf(stderr,"\nA new line has been removed (2)");
        line_length--; // odstraním případný konec řádku
      }
			#ifdef DEBUG_READ_COREFERENCES_FILE
				fprintf(stderr,"\nAfter a newline has been removed: '%s'", dst);
			#endif
			*(dst+line_length) = EOL; // dám si tam vlastní konec řádku (jednotný s klientem)
			dst += line_length + 1;
			length += line_length + 1; // započítám i konec řádku
		} // while
		fclose (u_konfig);
	}
	#ifdef DEBUG_READ_COREFERENCES_FILE
		fprintf(stderr,"\nEnd of reading coreferences file");
	#endif
	return length; // vrátím počet zapsaných znaků
} // writeCoreferences

int nacti_vysl_strom( FILE * uk, char * dst, int zn = RESULT_FILE_OCCURRENCES_DELIMITER ) { // načte požadovaný strom a zapíše jej do dst (spolu s dalšími informacemi);
//za něj zapíše schémata koreferencí (pro klienty starší než 1.87)
// uk ukazuje na pocatecni znacku v souboru s vysledky vyhledavani
// vracím počet zapsaných znaků
	long pocatecni, koncova; // pozice oddelovacich znacek v souboru
	char dummy; // pomocna pro preskoceni znacky v souboru jejim nactenim
	int tree_number; // poradi stromu v souboru
	int matching_node; // pořadí matchujícího vrcholu

	pocatecni = ftell (uk); // pozice pocatecni znacky

	if (! hledej_znacku_dolu (uk, &koncova, zn)) // koncova znacka nenalezena
		return FALSE;

	// precteni pocatecni znacky
	fread (& dummy, 1, 1, uk); // tim jsem se posunul za ni

	if (! readOneRecord(uk, buff2, &tree_number, buff_nodes)) { // načte údaje o odpovědi (jméno souboru, pořadí stromu, pořadí matchujících vrcholů)
		return 0; // zapsáno 0 znaků - neúspěch
	}

	strcpy(last_sent_tree_file_name, buff2); // uložím jméno souboru, ze kterého je posílaný výsledný strom (využíváno při posílání kontextu)
	strcpy(last_sent_tree_matching_nodes, buff_nodes); // uložím matchující vrcholy posledně posílaného výsledného stromu (využíváno při posílání kontextu)
	last_sent_tree_number_in_file = tree_number; // uložím pořadí (v souboru) posledně posílaného výsledného stromu (využíváno při posílání kontextu)
	last_context_tree_number_in_file = tree_number; // uložím pořadí (v souboru) posledně posílaného stromu (využíváno při posílání kontextu)
	
	int delka = readTreeFromFile(dst, buff2, tree_number, buff_nodes); // přečte daný strom ze souboru a zformuluje skutečnou odpoved
	if (delka < 0) {
		return FALSE; // vyskytla se chyba
	}
	if (strcmp(client_version, "1.87") < 0) { // klient je starý, schémata koreferencí posílá s každým stromem
		*(dst+delka) = EOL;
		delka++;
		delka += writeCoreferences(dst+delka); // za strom zapíšu schémata koreferencí
	}
	fseek (uk, pocatecni, SEEK_SET); // vrátím ukazovátko do souboru na původní pozici (na začátek právě poslaného stromu; při dalším požadavku budu hledat odtamtud)
	return delka;
}

int prazdny_string (char * zacatek, int konec) { // vrati TRUE, pokud retezec zacatek obsahuje same bile znaky az do znaku konec
	while( *zacatek != konec ) {
		if (! dummy (*zacatek))
			return FALSE;

		zacatek++;
	}
	return TRUE;
}


void zapis_string_sbr (FILE * uk, char * buff, int konec) { // zapise retezec do souboru
	while (*buff != konec) {
		fprintf (uk, "%c", *buff);
		buff++;
	}
	fprintf (uk, "\n");
}


////// dotaz //////

TVS special_st_node; // na tento vrchol se budou lepit vrcholy z tranzitivní hrany, pokud je požadována exkluzivní tranzitivita
TVS *special_sticky_node = &special_st_node;


/*int isSetOptionalNode(TVS *d) { // vrátí TRUE, pokud je u vrcholu d v některé sadě nastaven meta atribut META_OPTIONAL_NODE
	TValue *values;
	TAHLine *value;
	values = d -> vrchol -> Values; // vezmu první sadu atributů
	while (values != NULL) { // přes všechny sady atributů
		value = values -> AHTable + meta_optional_node_position_gh; // vezmu první hodnotu v této sadě (z variant)
		while (value != NULL) {
			if ((!strcmp(getAHLineValue(value), "true")) && (value->relation == RELATION_EQ)) { // pokud je to true
				return TRUE;
			}
			if ((!strcmp(getAHLineValue(value), "false")) && (value->relation == RELATION_NEQ)) { // pokud je to true, protoze to neni false
				return TRUE;
			}
			value = value -> next; // projdu i alternativní hodnoty atributu
		}
		values = values -> Next; // projdu i další sady atributů
	}
	return FALSE;
} // isSetOptionalNode
*/

int getSetOptionalNode(TVS *d) { // vrátí 0, pokud u vrcholu d není v žádné sadě nastaven meta-atribute META_OPTIONAL_NODE jinak než false
// v případě, že je v některé sadě nastaven meta-atribut META_OPTIONAL_NODE jinak než false, vrátí:
// -1 v případě, že je nastaven na true
// nastavenou hodnotu > 0 v případě, že je nastaven na hodnotu větší než nula

	TValue *values;
	TAHLine *value;
	values = d -> vrchol -> Values; // vezmu první sadu atributů
	int value_int;
	char *string_value;
	while (values != NULL) { // přes všechny sady atributů
		value = values -> AHTable + meta_optional_node_position_gh; // vezmu první hodnotu v této sadě (z variant)
		if (value != NULL) { // nemusím while, _optional má jen jednu hodnotu
			string_value = getAHLineValue(value);
			if ((!strcmp(string_value, "true")) && (value->relation == RELATION_EQ)) { // pokud je to true
				return -1; // -1 symbolizuje true
			}
			value_int = strtol(string_value, (char **)NULL, 10); // převeď řetězec na číslo
			if (value_int > 0) { // našel jsem hodnotu, která jde převést na kladné celé číslo
				return value_int;
			}
		}
		values = values -> Next; // projdu i další sady atributů
	}
	return 0; // nenašel jsem ani true, ani kladné celé číslo
} // getSetOptionalNode

int getSetZeroOccurrences(TVS *cely_strom_dotazu, TVS *aktualni_vrchol_dotazu, const int resolve_references, TVSList *query_TVSList, char *actual_logical_expression) { // vráti poradi (cislovano od 1) prislusne sady, pokud je u vrcholu d v některé sadě nastaven meta atribut META_NUMBER_OF_OCCURRENCES na 0 (nebo nulu obsahuje v jedne ze svych moznosti)
// jinak vrati 0
	TValue *values;
	TAHLine *value;
	values = aktualni_vrchol_dotazu -> vrchol -> Values; // vezmu první sadu atributů
	int set_number = 0;
	while (values != NULL) { // přes všechny sady atributů
		set_number++;
		value = values -> AHTable + meta_number_of_occurrences_position_gh; // ukážu na první hodnotu v této sadě (z variant)
		if (metaAttribMatch(cely_strom_dotazu, aktualni_vrchol_dotazu, value, 0, resolve_references, query_TVSList, actual_logical_expression)) {
			#ifdef DEBUG_GET_SET_ZERO_OCCURRENCES
				fprintf(stderr, "\ngetSetZeroOccurrences: %d", set_number);
			#endif
			return set_number;
		}
		values = values -> Next; // projdu i další sady atributů
	}
	#ifdef DEBUG_GET_SET_ZERO_OCCURRENCES
		fprintf(stderr, "\ngetSetZeroOccurrences: 0 (not set)");
	#endif
	return 0;
} // getSetZeroOccurrences

int matchHiddenStatuses(TNode *node1, TNode *node2) { // vrátí TRUE, pokud matchují ohodnocení vrcholů jakožto skrytý/neskrytý/oboje; jinak vrátí FALSE
  // volaná z funkce createMatchingLists
  int h2 = node2 -> hidden;
  switch (node1 -> hidden) {
    case 0: if (h2 == 1) return FALSE; // vadí mi kombinace 0 a 1
            break;
    case 1: if (h2 == 0) return FALSE; // a také kombinace 1 a 0
            break;
    default: break;
  }
  return TRUE; // všechny ostatní kombinace jsou v pořádku
} // matchHiddenStatuses

int createMatchingListsTVS (TVS * dot, TVS * str, int * zobrazeni, int delka, TVSList *query_TVSList, char *actual_logical_expression) { // vrati TRUE, pokud vsechny vrcholy dotazu matchuji s nejakym vrcholem stromu
// vrati take TRUE, pokud vsechny vrcholy dotazu az na vrcholy s nastavenym meta atributem META_OPTIONAL_NODE matchuji s nejakym vrcholem stromu
// vrati take TRUE, pokud vsechny vrcholy dotazu az na vrcholy s meta atributem META_NUMBER_OF_OCCURRENCES nastavenym na 0 matchuji s nejakym vrcholem stromu
// vrati FALSE (a ihned skonci dalsi matchovani), pokud nalezne vrchol v dotazu, ktery nematchuje s nicim v prohledavanem stromu a
// nema nastaven meta atribut META_OPTIONAL_NODE a ani nema meta atribut META_NUMBER_OF_OCCURRENCES nastaven na 0
// v dot->match (resp. dot->dalsi->match atd.) vytvori seznamy odkazu na matchujici vrcholy stromu

	TVS *cely_strom_dotazu = dot;
	TVS *pom;
	TSezVrch *kon;
	TValue *values;
  TNode *query_node;
  TNode *tree_node;

	int odp;
	int flag;
	int matching_set; // pořadí sady ve vrcholu dotazu, která matchovala s vrcholem ve stromu
	int matched;

	odp = TRUE;

	#ifdef DEBUG_CREATE_MATCHING_LISTS
		fprintf(stderr, "\nTrying to match the query and a tree.");
	#endif
	while (dot) { // přes všechny vrcholy dotazu
		pom = str;	// zacatek seznamu str
		kon = NULL;     // konec seznamu vrcholu

		flag = FALSE;	// mecuje s nim nekdo?

		#ifdef DEBUG_CREATE_MATCHING_LISTS
			fprintf(stderr, "\nTrying to match the next node in the query.");
		#endif
    query_node = dot -> vrchol;
		while (pom) { // pres vrcholy prohledavaneho stromu
      tree_node = pom -> vrchol;
      if (matchHiddenStatuses(query_node, tree_node)) { // matchují ohodnocení obou vrcholů jakožto skrytý/neskrytý/oboje
        values = query_node -> Values; // vezmu první sadu atributů u aktuálního vrcholu dotazu
        matching_set = 1; // pokud bude sada matchovat, matchovala by 1. sada
        while (values != NULL) { // přes všechny sady atributů
          #ifdef DEBUG_CREATE_MATCHING_LISTS
            fprintf(stderr, "\nTrying to match %d. set of attributes.",matching_set);
          #endif
          matched = sada_vrchol_match (cely_strom_dotazu, dot, values, tree_node, zobrazeni, delka, FALSE, query_TVSList, actual_logical_expression); // matchuje tato sada s timto vrcholem?
          // (FALSE znamená nevyhodnocovat referenční odkazy - to se dělá později po sestavení kandidátského matchujícího stromu)
          if (matched) { // matchují
            flag = TRUE;	// mecuje - tenhle vrchol dotazu (touto svou sadou artributu) matchuje s timhle vrcholem stromu

            // nyní vytvořím místo pro záznam matchujícího vrcholu
            if (kon) { // neni prvni v seznamu
              kon -> next = new TSezVrch;
              kon = kon -> next;
            }
            else {
              dot -> match = new TSezVrch; // zde zacina seznam matchujicich vrcholu
              kon = dot -> match;
            }

            // a zaznamenám matchující vrchol
            kon -> vrchol = pom; // z dotazu si ukazu na ten vrchol ve stromu
            #ifdef DEBUG_CREATE_MATCHING_LISTS
              fprintf(stderr,"\ncreateMatchingListsTVS: the set #%d has been set as matching_set.",matching_set);
            #endif
            kon -> matching_set = matching_set; // sadou s tímto pořadím matchoval vrchol dotazu s vrcholem stromu
            kon -> next = NULL;
          }
          matching_set ++; // příští sada má o jedna vyšší pořadí
          values = values -> Next; // vezmu tu další sadu
        } // while přes sady atributů aktuálního vrcholu dotazu
      } // if matchují statusy hidden
			pom = pom -> dalsi; // zkusim vrchol dotazu smatchovat s dalsim vrcholem stromu
		} // while přes vrcholy prohledávaného stromu
		if (! flag) { // nikdo ze stromu s timto vrcholem nemecoval
			if (! (getSetOptionalNode(dot) != 0 || getSetZeroOccurrences(cely_strom_dotazu, dot, FALSE, query_TVSList, actual_logical_expression))) { // a pokud vrchol není označen meta atributem jako nepovinný nebo jako vrchol s nulovym vyskytem
				#ifdef DEBUG_CREATE_MATCHING_LISTS
					fprintf(stderr, "\nSome nodes in the query do not match with nodes in the tree.");
				#endif
				odp = FALSE; // tento vrchol dotazu s ničím ve stromě nematchoval, přestože musel - to je konec prohledávání tohoto stromu
				return odp;
			}
		}
		dot = dot -> dalsi; // seznam matchujicich vrcholu vyrobim i pro dalsi vrcholy dotazu
	}
	#ifdef DEBUG_CREATE_MATCHING_LISTS
		fprintf(stderr, "\nAll necessary nodes in the query match with some nodes in the tree.");
	#endif
	return odp;
} // createMatchingListsTVS

int createMatchingListsTVSList (TVSList * query_TVSList, TVS * str, int * zobrazeni, int delka, char * actual_logical_expression) { // vrati TRUE, pokud logicky vyraz nad jednotlivymi stromy dotazu je splnitelny vzhledem k matchovani jednotlivych vrcholu jednotlivych stromu dotazu s vrcholy vysledneho stromu
	int global_match; // the overall result
	int match; // possible matching of one tree
	int and_or; // is TRUE if the logical expr. in the query is AND; otherwise is FALSE
	and_or = strcmp(actual_logical_expression, "AND") == 0 ? TRUE : FALSE;
	global_match = and_or == TRUE ? TRUE : FALSE; // in AND case I only need to find one negative example to refuse it; in OR case I only need to find one positive example to accept it
	TVS *query_TVS;
  TVSList *pom_tvs_list = query_TVSList;
	while (pom_tvs_list != NULL) { // over all trees in the query
		query_TVS = pom_tvs_list->tvs;
		match = createMatchingListsTVS(query_TVS, str, zobrazeni, delka, query_TVSList, actual_logical_expression);
		pom_tvs_list->nodes_match = match; // store the value - later it is possible to skip this tree in OR queries if there is FALSE here
		if (!match && and_or) { // a negative example that allows me to refuse the whole AND query
			global_match = FALSE;
			break; // I do not need to check the other trees in the query
		}
		if (match && !and_or) { // a positive example that allows me to accept the whole OR query; I need to create all the remaining matching lists, though; therefore I cannot break the cycle
			global_match = TRUE;
		}
		pom_tvs_list = pom_tvs_list -> next; // take the next tree in the query
	} // while
	#ifdef DEBUG_CREATE_MATCHING_LISTS
		if (global_match) {
			fprintf(stderr, "\ndotser.c: createMatchingListsTVSList: All necessary nodes in the query match with some nodes in the tree.");
		}
		else {
			fprintf(stderr, "\ndotser.c: createMatchingListsTVSList: Some necessary nodes in the query do not match with nodes in the tree.");
		}
	#endif
	return global_match;
} // createMatchingListsTVSList

void writeMatchingNodesTVS(FILE *kam, TVS *cely_strom, TVS *cely_strom_dotazu, int query_tree_order) { // zapise vrcholy matchujici s cely_strom_dotazu do souboru kam
// zapise jejich poradi v sekvencnim zapisu vrcholu (v cely_strom), tj. rovnez poradi pri pruchodu stromem do hloubky, od korene pocinaje
// poradi korene stromu je 0
// jednotlive matchujici vrcholy oddeli znackou MATCHING_NODES_DELIMITER
// prislusne matchujici vrcholy dotazu oddeli znackou MATCHING_NODES_QUERY_DELIMITER
	TSezVrch *pom; // pro pruchod seznamem vrcholu matchujicich s korenem dotazu
	TVS * vrch; // ukazatel na jednotlivy vrchol stromu
	int i; // počítadlo vrcholů stromu
	int first = TRUE; // signalizuje, zda zapisuji první vrchol nebo ne

	i = 0; // začínám od rootu
	if (cely_strom_dotazu!=NULL && cely_strom!=NULL) { // dotaz s kritériem (ověřeno už dřív, ale budiž)
		// naleznou se vrcholy stromu matchujici s vrcholy dotazu
		vrch = cely_strom;
		while (vrch != NULL) { // pres vsechny vrcholy stromu
			#ifdef DEBUG_MATCHING_NODES
				fprintf(stderr,"\ndotser.c: writeMatchingNodesTVS: Trying another node...");
			#endif
			if (vrch->nalepeny != NULL) { // tento vrchol matchuje s dotazem
				#ifdef DEBUG_MATCHING_NODES
					fprintf(stderr," it matches with the query");
				#endif
				if (vrch -> nalepeny != special_sticky_node) { // a nejedná se jen o vrchol z tranzitivní hrany
					#ifdef DEBUG_MATCHING_NODES
						fprintf(stderr,"; it is not only a part of a transitive edge.");
						fprintf(stderr,"\nThe query node matching this node is from %d. tree of the query.",vrch->nalepeny->tvs_list->order);
						fprintf(stderr,"\nWe are looking for nodes from %d. tree of the query.",query_tree_order);
					#endif
					if (vrch->nalepeny->tvs_list->order == query_tree_order) { // jde o vrchol nalepený k právě aktuálnímu cely_strom_dotazu
						#ifdef DEBUG_MATCHING_NODES
							fprintf(stderr," OK, I have found a node. ");
						#endif
						if (first) { // před prvním číslem nevypisuji oddělovač
							#ifdef DEBUG_MATCHING_NODES
								fprintf(stderr,"\nMatching nodes: ");
							#endif
							first = FALSE;
						}
						else {// před druhým a dalším číslem vypisuji oddělovač
							#ifdef DEBUG_MATCHING_NODES
								fprintf(stderr,"%c", MATCHING_NODES_DELIMITER);
							#endif
							fprintf(kam,"%c", MATCHING_NODES_DELIMITER);
						}
						#ifdef DEBUG_MATCHING_NODES
							fprintf(stderr,"%d", i);
							fprintf(stderr,"%c", MATCHING_NODES_QUERY_DELIMITER);
							fprintf(stderr,"%d", vrch->nalepeny->vrchol->depth_first_order);
						#endif
						fprintf(kam,"%d", i); // je to i-ty vrchol - to zapisu do vysledku
						fprintf(kam,"%c", MATCHING_NODES_QUERY_DELIMITER);
						fprintf(kam,"%d", vrch->nalepeny->vrchol->depth_first_order);
					}
				}
			}
			vrch = vrch -> dalsi;
			i++;
		}
	}
} // writeMatchingNodesTVS

void zapis_matchujici_vrcholy (FILE *kam,TVS *cely_strom, TVS *cely_strom_dotazu, TVSList *query_TVSList, char *actual_logical_expression) { // zapise vrcholy matchujici s cely_strom_dotazu do souboru kam
// to aby klient mohl rozpoznat, kde ve strome doslo k vyskytu podstromu = dotazu
// zapise jejich poradi v sekvencnim zapisu vrcholu (v cely_strom), tj. rovnez poradi pri pruchodu stromem do hloubky, od korene pocinaje
// poradi korene stromu je 0
// jednotlive matchujici vrcholy oddeli znackou MATCHING_NODES_DELIMITER
// prislusne matchujici vrcholy dotazu oddeli znackou MATCHING_NODES_QUERY_DELIMITER
// v pripade vice matchujicich stromu (dotaz o vice stromech s relaci AND) oddeli jednotlive stromy znackou MATCHING_NODES_TREES_DELIMITER
// zakonci to EOL. pokud dotaz na vsechny stromy, tedy bez kriteria, tak kam==NULL, zapise se jen EOL
	int and_or;
	int first;

	if (cely_strom_dotazu!=NULL && cely_strom!=NULL && query_TVSList!=NULL && actual_logical_expression!=NULL) { // dotaz s kritériem
		and_or = strcmp(actual_logical_expression, "AND") == 0 ? TRUE : FALSE; // only global AND or OR are supported as logical expression
		first = TRUE;
		if (and_or) { // matching nodes may consist of several trees - the query has AND as logical expression
			while (query_TVSList) {
				#ifdef DEBUG_MATCHING_NODES
					fprintf(stderr,"\nMatching nodes (tree by tree): ");
				#endif
				if (first) {
					first = FALSE;
				}
				else {
					#ifdef DEBUG_MATCHING_NODES
						fprintf(stderr,"%c", MATCHING_NODES_TREES_DELIMITER);
					#endif
					fprintf(kam,"%c", MATCHING_NODES_TREES_DELIMITER);
				}
				writeMatchingNodesTVS(kam, cely_strom, query_TVSList->tvs, query_TVSList->order);
				query_TVSList = query_TVSList->next;
			}
		}
		else { // the query has OR as logical expression - we are only interested in nodes matching this one cely_strom_dotazu
			while (query_TVSList) {
				if (query_TVSList->tvs == cely_strom_dotazu) { // finding out the order of the matching query tree
					writeMatchingNodesTVS(kam, cely_strom, query_TVSList->tvs, query_TVSList->order);
					break;
				}
				query_TVSList = query_TVSList->next;
			}
		}
	}
	fprintf (kam,"%c",EOL_2);
} // zapis_matchujici_vrcholy

void writeResultToFile(int tree_number, TVS * cely_strom, TVS * cely_strom_dotazu, TVSList *query_TVSList, char *actual_logical_expression) { // vypsani stromu do vysledku dotazu
	#ifdef DEBUG_WRITE_RESULT_TO_FILE
		fprintf(stderr,"\ndotser.c: writeResultToFile: writing result (tree number %d) to file.", tree_number);
	#endif
	fprintf(u_vysledek,"%c",EOL_2);
	fprintf(u_vysledek,"%s",fcesta); // zapisu jmeno souboru, ze ktereho je tento strom
	fprintf(u_vysledek,"%c",EOL_2);
	fprintf(u_vysledek,"%d",tree_number); // zapisu poradi stromu
	fprintf(u_vysledek,"%c",EOL_2);
	zapis_matchujici_vrcholy (u_vysledek, cely_strom, cely_strom_dotazu, query_TVSList, actual_logical_expression); // poradi vrcholu smatchovanych s dotazem zapsany v pruchodu od korene do hloubky
	zapis_znacku (u_vysledek); // oddelovac vysledku v souboru
	fflush (u_vysledek);
} // writeResultToFile

int isSetTransitiveEdge(TVS *cely_strom_dotazu, TVS *aktualni_vrchol_dotazu, TSezVrch *s, const int resolve_references, TVSList *query_TVSList, char *actual_logical_expression) {
// vrátí typ tranzitivní hrany, pokud je u vrcholu aktualni_vrchol_dotazu nastavena transitivní hrana v sadě určené atributem matching_set u vrcholu s
	#ifdef DEBUG_IS_SET_TRANSITIVE_EDGE
		fprintf(stderr,"\nisSetTransitiveEdge: entering the function.");
	#endif
	TValue *values = aktualni_vrchol_dotazu -> vrchol -> Values;
	int matching_set;
	if (s == NULL) { // to se muze (ale nemusi) stat u vrcholu s #occurrences=0
		matching_set = getSetZeroOccurrences(cely_strom_dotazu, aktualni_vrchol_dotazu, resolve_references, query_TVSList, actual_logical_expression);
	}
	else {
		matching_set = s->matching_set; // cislovano od 1
	}
	#ifdef DEBUG_IS_SET_TRANSITIVE_EDGE
		fprintf(stderr,"\nisSetTransitiveEdge: finding the right set of attributes: the right number is %d.", matching_set);
	#endif
	for (int i=1; i < matching_set; i++) { // pokud matchující sada nebyla ta první, posunu se na tu správnou
		#ifdef DEBUG_IS_SET_TRANSITIVE_EDGE
			fprintf(stderr,"\nisSetTransitiveEdge: moving to the next (%d) set of attributes.",i+1);
		#endif
		values = values -> Next;
	}
	TAHLine *value = values -> AHTable + meta_transitive_parent_edge_position_gh; // vezmu první hodnotu v této sadě (z variant)
	while (value != NULL) {
		if (! strcmp(getAHLineValue(value), TRANSITIVITY_TYPE_EXCLUSIVE_LABEL)) { // pokud je to exkluzivní tranzitivita (zabírá hrany)
			#ifdef DEBUG_IS_SET_TRANSITIVE_EDGE
				fprintf(stderr,"\nisSetTransitiveEdge: leaving this function - the edge has been defined as exclusively transitive.");
			#endif
			return TRANSITIVITY_TYPE_EXCLUSIVE_INT;
		}
		else if (! strcmp(getAHLineValue(value), TRANSITIVITY_TYPE_TRUE_LABEL)) { // pokud je to plná tranzitivita (nezabírá hrany)
			#ifdef DEBUG_IS_SET_TRANSITIVE_EDGE
				fprintf(stderr,"\nisSetTransitiveEdge: leaving this function - the edge has been defined as fully transitive.");
			#endif
			return TRANSITIVITY_TYPE_TRUE_INT;
		}
		value = value -> next; // projdu i alternativní hodnoty atributu
	}
	#ifdef DEBUG_IS_SET_TRANSITIVE_EDGE
		fprintf(stderr,"\nisSetTransitiveEdge: leaving this function - the edge has not been defined as transitive.");
	#endif
	return TRANSITIVITY_TYPE_NONE_INT;
}

int isSetTransitiveEdge(TVS *d, int matching_set) {
// vrátí typ tranzitivní hrany, pokud je u vrcholu d nastavena transitivní hrana v sadě určené atributem matching_set
	char *string_value;
	#ifdef DEBUG_IS_SET_TRANSITIVE_EDGE
		fprintf(stderr,"\nisSetTransitiveEdge: entering this function.");
	#endif
	TValue *values = d -> vrchol -> Values;
	#ifdef DEBUG_IS_SET_TRANSITIVE_EDGE
		fprintf(stderr,"\nisSetTransitiveEdge: finding the right set of attributes: the right number is %d.", matching_set);
	#endif
	for (int i=1; i < matching_set; i++) { // pokud matchující sada nebyla ta první, posunu se na tu správnou
		#ifdef DEBUG_IS_SET_TRANSITIVE_EDGE
			fprintf(stderr,"\nisSetTransitiveEdge: moving to the next (%d) set of attributes.",i+1);
		#endif
		values = values -> Next;
	}
	TAHLine *value = values -> AHTable + meta_transitive_parent_edge_position_gh; // vezmu první hodnotu v této sadě (z variant)
	while (value != NULL) {
		string_value = getAHLineValue(value);
		if (! strcmp(string_value, TRANSITIVITY_TYPE_TRUE_LABEL)) { // pokud je to true
			#ifdef DEBUG_IS_SET_TRANSITIVE_EDGE
				fprintf(stderr,"\nisSetTransitiveEdge: leaving this function - the edge has been defined as fully transitive.");
			#endif
			return TRANSITIVITY_TYPE_TRUE_INT;
		}
		if (! strcmp(string_value, TRANSITIVITY_TYPE_TRUE_LABEL)) { // pokud je to true
			#ifdef DEBUG_IS_SET_TRANSITIVE_EDGE
				fprintf(stderr,"\nisSetTransitiveEdge: leaving this function - the edge has been defined as exclusively transitive.");
			#endif
			return TRANSITIVITY_TYPE_TRUE_INT;
		}
		value = value -> next; // projdu i alternativní hodnoty atributu
	}
	#ifdef DEBUG_IS_SET_TRANSITIVE_EDGE
		fprintf(stderr,"\nisSetTransitiveEdge: leaving the function - the edge has not been defined as transitive.");
	#endif
	return TRANSITIVITY_TYPE_NONE_INT;
}

int isPredecessor (TVS *predecessor, TVS *successor, int transitive_type) { // vrátí počet oddělujících hran, pokud predecessor je předkem vrcholu nalepeného na successor
// další podmínkou je, že kontroluje nalepenost vrcholů po cestě vzhledem k typu tranzitivity
// při neúspěchu vrátí -1
	if (successor == NULL) return -1;
	int dist = 1; // nejmenší možná vzdálenost těch dvou vrcholů
	TVS *pom = successor -> rodic;
	while (pom != NULL) { // dokud neprojdu vetvi stromu az nad koren
		if (pom -> nalepeny != NULL) {
			#ifdef DEBUG_IS_PREDECESSOR
				fprintf(stderr,"\nisPredecessor: the node is sticked - going to check the target node.");
			#endif
			if (pom -> nalepeny == predecessor) {
				#ifdef DEBUG_IS_PREDECESSOR
					fprintf(stderr,"\nisPredecessor: leaving the function - the node is sticked to the predecessor. OK, the distance is %d", dist);
				#endif
				return dist;
			}
			if (transitive_type == TRANSITIVITY_TYPE_EXCLUSIVE_INT) { // po cestě je nalepený vrchol, ale nesmí být
				#ifdef DEBUG_IS_PREDECESSOR
					fprintf(stderr,"\nisPredecessor: leaving the function - the node is sticked to something else than the predecessor but the transitivity is exclusive. KO.");
				#endif
				return -1;
			}
		}
		#ifdef DEBUG_IS_PREDECESSOR
			fprintf(stderr,"\nisPredecessor: the node is not sticked - going to its parent.");
		#endif
		pom = pom -> rodic;
		dist ++; // uspěje-li test v dalším průchodu, je vzdálenost vrcholů o jedna větší, než kdyby uspěl v tomto průchodu
	}
	#ifdef DEBUG_IS_PREDECESSOR
		fprintf(stderr,"\nisPredecessor: leaving the function - a node sticked to the predecessor has not been found. KO.");
	#endif
	return -1;
} // isPredecessor

void stickChain(TVS *v, TVS *target, int count) { // nalepí na vrchol target všechny vrcholy od vrcholu 'v' (včetně) směrem ke kořeni do počtu count včetně
	TVS *pom = v;
	for (int i = 1; i<=count; i++) { // požadovaný počet počínaje výchozím vrcholem
		#ifdef DEBUG_STICK_CHAIN
			if (v->nalepeny != NULL) {
				if (v->nalepeny != special_sticky_node) {
					fprintf(stderr,"\nstickChain: going to stick a node sticked to non-NULL and non-spec.st.node!");
				}
			}
		#endif
		v -> nalepeny = target;
		v = v -> rodic;
	}
} // stickChain

TVS *getParent(TVS *d) { // vrátí nejbližšího předka vrcholu d, který není skipped optional
	while (d != NULL) {
		d = d -> rodic;
		if (d != NULL) {
			if (d -> skipped_optional_node != TRUE) break; // nalezen správný rodič
		}
	}
	return d; // rodič nenalezen
} // getParent

int isDirectPredecessorButOptional(TVS *node_in_tree, TVS *node_in_query) { //
	TVS *parent_in_query = getParent(node_in_query); // vezmu nejbližšího předka v dotazu, který není skipped optional
	TVS *parent_in_tree;
	int optional = getSetOptionalNode(node_in_query);
	if (optional == 0) { // nejde o optional uzel, vše je jednoduché
		if (parent_in_query == NULL) { // došel jsem až nad kořen, to není dobře
			return FALSE;
		}
		if (node_in_tree->rodic->nalepeny == parent_in_query && node_in_tree->rodic->secondary_stick_to_optional_node != TRUE) { // rodičovství souhlasí s nalepením na dotaz a nestrefil jsem se rodičem doprostřed řetězu uzlů nalepených na optional uzel
			return TRUE;
		}
		return FALSE;
	}
	// nyní vím, že node_in_query je optional uzel, který není skipped optional a node_in_tree je na něj nalepený (respektive bude hned potom, co to tady úspěšně skončí) - to vše je jasné z proměnné optional a tím, že vstoupily jako parametry do této funkce
	// kdyby nebylo možnosti, že optional přeskakuje víc uzlů, byl bych téměř hotov
	// takhle ale musím prověřit nalepení rodičů těchto dvou uzlů s tím, že rodiče node_in_tree se mohou také chtít nalepit na optional node_in_query a vytvořit tak řetěz optional uzlů
	TSezVrch *query_node_match = node_in_query -> match; // vezmu si všechny vrcholy, které matchují s node_in_query
	parent_in_tree = node_in_tree -> rodic; // prověřím rovnou ten první uzel, který je správně nalepený na node_in_query (prověřím hlavně jeho rodiče)
	if (parent_in_tree -> nalepeny == parent_in_query) {
		return TRUE; // všechno v pořádku
	}
	node_in_tree = parent_in_tree; // s jedním optional to nevyšlo, jdu dál
	if (optional != -1) { // pokud není optional neomezené
		optional--; // snížím o jedna povolený počet optional uzlů
	}	
	while (node_in_tree != NULL) { // a pojedu s node_in_tree nahoru ke kořeni
		if (optional == 0) { // už jsem vyčerpal možný počet uzlů matchujících s optional node_in_query
			return FALSE;
		}
		parent_in_tree = node_in_tree -> rodic; // vždy vezmu předka toho vrcholu
		if (parent_in_tree == NULL) { // už jsem dojel příliš vysoko
			return FALSE;
		}
		if (node_in_tree -> nalepeny != NULL) { // uzel také nesmí být ještě na nic nalepený (protože se nalepí na optional node_in_query)
			return FALSE;
		}
		if (!isInTSezVrch(node_in_tree, query_node_match)) { // pokud node_in_tree nematchuje s node_in_query
			return FALSE;
		}
		if (parent_in_tree -> nalepeny == parent_in_query) {
			return TRUE; // vyšlo to
		}
		if (optional != -1) { // pokud není optional neomezené
			optional--; // snížím o jedna povolený počet optional uzlů
		}
		node_in_tree = node_in_tree -> rodic;
	}	
	return FALSE;
} // isDirectPredecessorButOptional

void stickOptionalNodesToValue(TVS *node_in_tree, TVS *node_in_query, TVS *value) { // nalepí na value všechny násobné vrcholy, které tam musejí být nalepené
	TVS *parent_in_query = getParent(node_in_query); // vezmu nejbližšího předka v dotazu, který není skipped optional
	TVS *parent_in_tree;
	int optional = getSetOptionalNode(node_in_query);
	if (optional == 0) { // nejde o optional uzel, nemusím nic lepit
		return;
	}
	// nyní vím, že node_in_query je optional uzel, který není skipped optional a node_in_tree je na něj nalepený - to vše je jasné z proměnné optional a tím, že vstoupily jako parametry do této funkce
	// kdyby nebylo možnosti, že optional přeskakuje víc uzlů, byl bych téměř hotov
	// takhle ale musím prověřit nalepení rodičů těchto dvou uzlů s tím, že rodiče node_in_tree se mohou také chtít nalepit na optional node_in_query a vytvořit tak řetěz optional uzlů
	parent_in_tree = node_in_tree -> rodic; // prověřím rovnou ten první uzel, který je správně nalepený na node_in_query (prověřím hlavně jeho rodiče)
	if (parent_in_tree -> nalepeny == parent_in_query) {
		return; // nemusím nic dalšího nalepovat, byl jen jeden (už nalepený) optional uzel
	}
	node_in_tree = parent_in_tree; // s jedním optional to nevyšlo, jdu dál
	while (node_in_tree != NULL) { // a pojedu s node_in_tree nahoru ke kořeni
		parent_in_tree = node_in_tree -> rodic; // vždy vezmu předka toho vrcholu
		if (parent_in_tree == NULL) { // už jsem dojel příliš vysoko
			return;
		}
		node_in_tree -> nalepeny = value; // nalepím tenhle uzel na danou hodnotu (optional uzel nebo při odlepování NULL)
		if (value != NULL) { // pokud se přilepuje
			node_in_tree -> secondary_stick_to_optional_node = TRUE; // je nalepený na optional vrcho, ale není to poslední vrchol v řetězu nalepených vrcholů na optional vrchol
		}
		else {
			node_in_tree -> secondary_stick_to_optional_node = FALSE; // zruším info
		}
		if (parent_in_tree -> nalepeny == parent_in_query) {
			return; // vyšlo to, vše potřebné jsem cestou nalepil
		}
		node_in_tree = node_in_tree -> rodic;
	}	
	return;
} // stickOptionalNodesToValue

void stickOptionalNodes(TVS *node_in_tree, TVS *node_in_query) { // nalepí na node_in_query všechny násobné optional vrcholy, které tam musejí být nalepené
	stickOptionalNodesToValue(node_in_tree, node_in_query, node_in_query);
}

void unstickOptionalNodes(TVS *node_in_tree, TVS *node_in_query) { // nalepí na NULL všechny násobné optional vrcholy, které musejí být odlepené
	stickOptionalNodesToValue(node_in_tree, node_in_query, NULL);
}

TAHLine* getDefinedNumberOfOccurrences(TVS *d, int number_of_set) { // vrati hodnoty meta atributu META_NUMBER_OF_OCCURRENCES, pokud je v dane sade definovan (cislovano od 1)
// neni-li definovan, vrati NULL
	TValue *values;
	TAHLine *value;

	#ifdef DEBUG_NUMBER_OF_OCCURRENCES
		fprintf(stderr, "\ndotser.c: getDefinedNumberOfOccurrences: Entering the function.");
	#endif	
	values = d -> vrchol -> Values; // vezmu první sadu atribut
	for (int i=1; i<number_of_set; i++) { // dokud se nedostanu ke spravne sade atributu
		values = values -> Next;
		if (values == NULL) {
			#ifdef DEBUG_NUMBER_OF_OCCURRENCES
				fprintf(stderr, "\ndotser.c: getDefinedNumberOfOccurrences: There is no such a set of attributes. Returning NULL");
			#endif	
			return NULL; // sada s takovym poradovym cislem neexistuje
		}
	}
	// nyni jsem u spravne sady atributu
	value = values -> AHTable + meta_number_of_occurrences_position_gh; // vezmu první hodnotu v této sadě (z variant)
	if (value != NULL) {
		#ifdef DEBUG_NUMBER_OF_OCCURRENCES
			fprintf(stderr, "\ndotser.c: getDefinedNumberOfOccurrences: getAHLineValue returns \"%s\".", getAHLineValue(value));
		#endif	
		if (getAHLineLength(value)) {
			return value;
		}
	}
	#ifdef DEBUG_NUMBER_OF_OCCURRENCES
		fprintf(stderr, "\ndotser.c: getDefinedNumberOfOccurrences: Either there is no TAHLine at all or there is no value defined. Returning NULL");
	#endif	
	return NULL;
} // getDefinedNumberOfOccurrences

int isTransitiveParent(TVS* parent, TVS* successor) { // vrati TRUE, pokud parent je tranzitivnim predchudcem successora
	TVS* n=successor;
	int parent_depth = parent->hloubka;
	int succ_depth = n->hloubka;
	while (succ_depth > parent_depth) { // dokud nejsem prilis vysoko (na urovni predka)
		n = n->rodic;
		succ_depth --;
		#ifdef DEBUG_TRANSITIVE_PARENT
			fprintf(stderr, "\nisTransitiveParent: Trying a node with first attribute = %s", n->vrchol->Values->AHTable->Value);
		#endif
		if (n == parent) {
			#ifdef DEBUG_TRANSITIVE_PARENT
				fprintf(stderr, "\nisTransitiveParent: TRUE");
			#endif
			return TRUE;
		}
		#ifdef DEBUG_TRANSITIVE_PARENT
			fprintf(stderr, "\nisTransitiveParent: At the end of the while cycle");
		#endif
	}
	#ifdef DEBUG_TRANSITIVE_PARENT
		fprintf(stderr, "\nisTransitiveParent: FALSE");
	#endif
	return FALSE;
} // isTransitiveParent

int isOKReferencesOneNode(TVS *cely_strom, TVS *cely_strom_dotazu, TVS *aktualni_vrchol_dotazu, TSezVrch *match, TVSList *query_TVSList, char *actual_logical_expression) { // vrátí TRUE, pokud referenční odkazy v sestaveném matchujícím stromě u tohoto aktualniho vrcholu dotazu s nalepeným vrcholem match jsou pravdivé; jinak vrátí FALSE
	// přesunu se ke správné sadě atributů v dotazu (matchující s daným vrcholem stromu)
	#ifdef DEBUG_IS_OK_REFERENCES_ONE_NODE
		fprintf(stderr, "\nisOKReferencesOneNode: Entering the function");
	#endif
	TValue *values = aktualni_vrchol_dotazu -> vrchol -> Values; // vezmu první sadu atributů u daného vrcholu dotazu
	int matching_set = match -> matching_set; // vezmu pořadí matchující sady vrcholu dotazu (číslováno od 1)
	for (int i=1; i<matching_set; i++) { // dokrokuji ke správné sadě
		values = values -> Next; // to by nemělo být nikdy null
	}
	// nyní values ukazuje na tu správnou matchující sadu atributů v daném vrcholu d dotazu
	// ověřím, že platí reference u této sady atributů u tohoto vrcholu
	//TAHLine* def_occur = getDefinedNumberOfOccurrences(aktualni_vrchol_dotazu, matching_set); // vrati hodnoty meta atributu _#occurrences
	int ok;
	ok = sada_vrchol_match(cely_strom_dotazu, aktualni_vrchol_dotazu, values, match->vrchol->vrchol, zobrazeni_gh, GlobHlav->AHNum, TRUE, query_TVSList, actual_logical_expression);
	#ifdef DEBUG_IS_OK_REFERENCES_ONE_NODE
		fprintf(stderr, "\nisOKReferencesOneNode: Leaving the function with return value: %d", ok);
	#endif
	return ok;
} // isOKReferencesOneNode

int isOkNumberOfOccurrences(TVS *cely_strom, TVS *cely_strom_dotazu, TVS *aktualni_vrchol_dotazu, TSezVrch *v, const int resolve_references, TVSList *query_TVSList, char *actual_logical_expression) {
// overi, zda je u vrcholu d dotazu, v sade dane matchujici sadou u v, definovan meta atribut META_NUMBER_OF_OCCURRENCES
// pokud ne, ihned skonci a vrati TRUE, vse v poradku
// pokud ano, zkontroluje, zda pocet vyskytu takoveho vrcholu pod jeho otcem je v poradku
// je-li v poradku, vrati TRUE, jinak FALSE
// pokud check_references == TRUE, overuje navic take reference
// pokud check_references == FALSE a vrchol obsahuje reference,
// vraci rovnou TRUE, protoze je nemuze zatim overit
	#ifdef DEBUG_NUMBER_OF_OCCURRENCES
		fprintf(stderr, "\ndotser.c: isOkNumberOfOccurrences: Entering the function.");
	#endif

	int transitive = FALSE; // indikuje, zda se jedna o tranzitivni pocet vyskytu
	if (isSetTransitiveEdge(cely_strom_dotazu, aktualni_vrchol_dotazu,v, resolve_references, query_TVSList, actual_logical_expression) != TRANSITIVITY_TYPE_NONE_INT) { // pokud je rodicovska hrana uzlu dotazu tranzitivni
		transitive = TRUE;
	}
	if (!resolve_references) { // pokud neoveruji reference
		#ifdef DEBUG_NUMBER_OF_OCCURRENCES
			fprintf(stderr, "\ndotser.c: isOkNumberOfOccurrences: Not checking references.");
		#endif
		if (aktualni_vrchol_dotazu->contains_reference) { // ale vrchol dotazu je obsahuje
			#ifdef DEBUG_NUMBER_OF_OCCURRENCES
				fprintf(stderr, "\ndotser.c: isOkNumberOfOccurrences: But they are present at the query node - returning TRUE right now.");
			#endif
			return TRUE;
		}
		else { // v poradku, vrchol dotazu je neobsahuje
			#ifdef DEBUG_NUMBER_OF_OCCURRENCES
				fprintf(stderr, "\ndotser.c: isOkNumberOfOccurrences: They are not present at the query node - OK, going on checking number of occurrences.");
			#endif
		}
	}
	#ifdef DEBUG_NUMBER_OF_OCCURRENCES
		else { // reference overuji	
			fprintf(stderr, "\ndotser.c: isOkNumberOfOccurrences: Checking everything even with references now.");
		}
	#endif
	int matching_set;
	if (v == NULL) { // to se muze (ale nemusi) stat u vrcholu s #occurrences=0
		matching_set = getSetZeroOccurrences(cely_strom_dotazu, aktualni_vrchol_dotazu, resolve_references, query_TVSList, actual_logical_expression);
	}
	else {
		matching_set = v->matching_set; // cislovano od 1
	}
	TAHLine* value=getDefinedNumberOfOccurrences(aktualni_vrchol_dotazu,matching_set);
	if (value == NULL) { // u daneho vrcholu dotazu neni v dane sade definovan meta atribut "number of occurrences"
		#ifdef DEBUG_NUMBER_OF_OCCURRENCES
			fprintf(stderr, "\ndotser.c: isOkNumberOfOccurrences: There is no meta-attribute number of occurrences defined.");
		#endif
		return TRUE;
	}
	#ifdef DEBUG_NUMBER_OF_OCCURRENCES
		fprintf(stderr, "\ndotser.c: isOkNumberOfOccurrences: There is a defined meta-attribute number of occurrences.");
	#endif
	// nyni projdu vsechny vrcholy matchujici s timto vrcholem d dotazu (vyberu jen ty matchujici s danou sadou) a
	// spocitam, kolik jich je sourozenci vrcholu v, resp. tranzitivnimi potomky nalepeneho (pripadne tranzitivniho) otce vrcholu v
	int number=0;
	#ifdef DEBUG_NUMBER_OF_OCCURRENCES
			int number2=0;
	#endif
	// nyni zjistim, ktery vrchol je nalepeny na predka vrcholu d dotazu
	TVS* p=aktualni_vrchol_dotazu->rodic;
	TVS *parent;
	if (p != NULL) { // vrchol ma predka v dotazu
		parent = getStickedNode(p)->vrchol;
	}
	else { // uzel nema predka v dotazu
		#ifdef DEBUG_NUMBER_OF_OCCURRENCES
			fprintf(stderr, "\ndotser.c: isOkNumberOfOccurrences: The node in the query does not have a parent");
		#endif
		if (transitive) { // tranzitivní případ
			parent = cely_strom; // za tranzitivniho predka zvolim koren prohledavaneho stromu
		}
		else { // netranzitivní případ - jako otec v prohledavanem strome se vybere otec vrcholu nalepeneho na d
			parent = getStickedNode(aktualni_vrchol_dotazu)->vrchol->rodic;
		}
	}
	TSezVrch* match=aktualni_vrchol_dotazu->match;
	if (parent == NULL) { // vrchol d dotazu nemel predka v dotazu a vrchol na nej nalepeny nema predka ve strome (je to tedy koren stromu)
		#ifdef DEBUG_NUMBER_OF_OCCURRENCES
			fprintf(stderr, "\ndotser.c: isOkNumberOfOccurrences: The node in the searched tree does not have a parent");
		#endif
		number = 1; // ten se tam vyskytuje prave jednou
	}
	else {
		#ifdef DEBUG_NUMBER_OF_OCCURRENCES
			fprintf(stderr, "\ndotser.c: isOkNumberOfOccurrences: First attribute of sticked parent = %s", getAHLineValue(parent->vrchol->Values->AHTable));
		#endif
		while (match != NULL) { // pres vsechny ty matchujici vrcholy
			if (match->matching_set == matching_set) { // tento vrchol matchuje se spravnou sadou
				#ifdef DEBUG_NUMBER_OF_OCCURRENCES
					number2++;
					fprintf(stderr, "\ndotser.c: isOkNumberOfOccurrences: Trying a node with first attribute = %s", getAHLineValue(match->vrchol->vrchol->Values->AHTable));
				#endif
				int parentage; // indikuje spravny vztah predek-potomek
				if (transitive) { // tranzitivni pripad
					parentage = isTransitiveParent(parent, match->vrchol); // je tranzitivnim potomkem nalepeneho otce vrcholu v
				}
				else { // netranzitivni pripad
					parentage = match->vrchol->rodic == parent ? TRUE : FALSE;
				}
				if (parentage == TRUE) {
					if (!resolve_references || !aktualni_vrchol_dotazu->contains_reference) { // pokud neoveruji reference nebo nejsou v dotazu pritomny
						#ifdef DEBUG_NUMBER_OF_OCCURRENCES
							fprintf(stderr, "\ndotser.c: isOkNumberOfOccurrences: Not checking references or they are not present at the query node - just counting this node.");
						#endif
						number++;
					}
					else { // overuji reference a jsou pritomny
						#ifdef DEBUG_NUMBER_OF_OCCURRENCES
							fprintf(stderr, "\ndotser.c: isOkNumberOfOccurrences: Checking references and they are present at the query node.");
						#endif
						int refs = isOKReferencesOneNode(cely_strom, cely_strom_dotazu, aktualni_vrchol_dotazu, match, query_TVSList, actual_logical_expression);
						if (refs) { // pokud tento uzel matchuje vcetne referenci
							#ifdef DEBUG_NUMBER_OF_OCCURRENCES
								fprintf(stderr, "\ndotser.c: isOkNumberOfOccurrences: This node matches including the references - counting it.");
							#endif
							number++;
						}
						#ifdef DEBUG_NUMBER_OF_OCCURRENCES
							else {
								fprintf(stderr, "\ndotser.c: isOkNumberOfOccurrences: This node matches only without the references (does not match with them) - not counting it");
							}
						#endif
					}
				} // if parentage
			} // if correct matching set
			match = match->next;
		}
	}
	// nyni mam v number pocet sourozencu vrcholu v (vcetne) matchujicich se spravnou sadou vrcholu d dotazu
	// zbyva zjistit, zda tento pocet souhlasi s definici meta atributu "number of occurrences" v dane sade vrcholu d
	int ok=metaAttribMatch(cely_strom_dotazu, aktualni_vrchol_dotazu, value, number, resolve_references, query_TVSList, actual_logical_expression);
	#ifdef DEBUG_NUMBER_OF_OCCURRENCES
		fprintf(stderr, "\ndotser.c: isOkNumberOfOccurrences: Number of occurrences: %d of %d", number, number2);
	#endif
	return ok;
} // isOkNumberOfOccurrences

int isOkZeroOccurrences(TVS *cely_strom, TVS *cely_strom_dotazu, TVS *aktualni_vrchol_dotazu, int matching_set, TVSList *query_TVSList, char *actual_logical_expression, const int check_references) { // vrati TRUE, pokud je ve strome splnen pozadavek na nulovy vyskyt vrcholu aktualni_vrchol_dotazu na spravnem miste; spravna sada dotazu je zero_set
	// jinak vrati FALSE
	// pokud check_references == TRUE, overuje navic take reference
	// pokud check_references == FALSE a vrchol obsahuje reference,
	// vraci rovnou TRUE, protoze je nemuze zatim overit
	#ifdef DEBUG_NUMBER_OF_OCCURRENCES
		fprintf(stderr, "\ndotser.c: isOkZeroOccurrences: Entering function isOkZeroOccurrences");
	#endif
	int transitive = FALSE;
	if (isSetTransitiveEdge(aktualni_vrchol_dotazu,matching_set) != TRANSITIVITY_TYPE_NONE_INT) { // pokud je rodicovska hrana tranzitivni
		transitive = TRUE;
	}
	if (!check_references) { // pokud neoveruji reference
		#ifdef DEBUG_NUMBER_OF_OCCURRENCES
			fprintf(stderr, "\ndotser.c: isOkZeroOccurrences: Not checking references.");
		#endif
		if (aktualni_vrchol_dotazu->contains_reference) { // ale vrchol dotazu je obsahuje
			#ifdef DEBUG_NUMBER_OF_OCCURRENCES
				fprintf(stderr, "\ndotser.c: isOkZeroOccurrences: But they are present at the query node - returning TRUE right now.");
			#endif
			return TRUE;
		}
		else { // v poradku, vrchol dotazu je neobsahuje
			#ifdef DEBUG_NUMBER_OF_OCCURRENCES
				fprintf(stderr, "\ndotser.c: isOkZeroOccurrences: They are not present at the query node - OK, going on checking zero number of occurrences.");
			#endif
		}
	}
	#ifdef DEBUG_NUMBER_OF_OCCURRENCES
		else { // reference overuji	
			fprintf(stderr, "\ndotser.c: isOkZeroOccurrences: Checking everything even with references now.");
		}
	#endif
	// nyni projdu vsechny vrcholy matchujici s timto vrcholem d dotazu (vyberu jen ty matchujici s danou sadou) a
	// spocitam, kolik jich je sourozenci vrcholu v, respektive v tranzitivnim pripade tranzitivnimi potomky nalepeneho (pripadne tranzitivniho) otce vrcholu v
	int number=0;
	#ifdef DEBUG_NUMBER_OF_OCCURRENCES
		int number2=0;
	#endif
	TVS* p=aktualni_vrchol_dotazu->rodic;
	TVS *parent;
	if (p != NULL) { // vrchol ma predka v dotazu
		parent = getStickedNode(p)->vrchol;
	}
	else { // uzel nema predka v dotazu - jako otec v prohledavanem strome se vybere otec vrcholu nalepeneho na d, respektive v tranzitivnim pripade jeho koren
		#ifdef DEBUG_NUMBER_OF_OCCURRENCES
			fprintf(stderr, "\ndotser.c: isOkZeroOccurrences: The node in the query does not have a parent");
		#endif
		if (transitive) { // tranzitivni pripad
			parent = cely_strom; // za tranzitivniho predka zvolim koren prohledavaneho stromu
		}
		else {
			parent = getStickedNode(aktualni_vrchol_dotazu)->vrchol->rodic;
		}
	}
//	#ifdef DEBUG_NUMBER_OF_OCCURRENCES
//		fprintf(stderr, "\ndotser.c: isOkZeroOccurrences: First attribute of sticked parent = %s", getAHLineValue(parent->vrchol->Values->AHTable));
//	#endif
	TSezVrch* match=aktualni_vrchol_dotazu->match;
	if (parent == NULL) { // vrchol aktualni_vrchol_dotazu nemel predka v dotazu a vrchol na nej nalepeny nema predka ve strome (je to tedy koren stromu)
		#ifdef DEBUG_NUMBER_OF_OCCURRENCES
			fprintf(stderr, "\ndotser.c: isOkZeroOccurrences: The node in the searched tree does not have a parent");
		#endif
		number = 1; // ten se tam vyskytuje prave jednou
	}
	else {
		while (match != NULL) { // pres vsechny ty matchujici vrcholy
			if (match->matching_set == matching_set) { // tento vrchol matchuje se spravnou sadou
				#ifdef DEBUG_NUMBER_OF_OCCURRENCES
					number2++;
					fprintf(stderr, "\ndotser.c: isOkZeroOccurrences: Trying a node with first attribute = %s", getAHLineValue(match->vrchol->vrchol->Values->AHTable));
				#endif
				int parentage; // parentage of the node OK?
				if (transitive) { // transitive case
					parentage = isTransitiveParent(parent, match->vrchol); // je tranzitivnim potomkem nalepeneho otce?
				}
				else { // non-transitive case
					parentage = match->vrchol->rodic == parent ? TRUE : FALSE; // je sourozencem v (nebo primo samotnym v)?
				}
				if (parentage == TRUE) { // vrchol patri do posuzovane mnoziny vrcholu - zapocitam ho (ale pozor na reference)
					#ifdef DEBUG_NUMBER_OF_OCCURRENCES
						fprintf(stderr, "\ndotser.c: isOkZeroOccurrences: Parentage is OK - this node concerns me", getAHLineValue(match->vrchol->vrchol->Values->AHTable));
					#endif
					if (!check_references || !aktualni_vrchol_dotazu->contains_reference) { // pokud neoveruji reference nebo nejsou v dotazu pritomny
						#ifdef DEBUG_NUMBER_OF_OCCURRENCES
							fprintf(stderr, "\ndotser.c: isOkZeroOccurrences: Not checking references or they are not present at the query node - just counting this node (and therefore returning FALSE right away).");
						#endif
						number++;
						return FALSE; // rovnou mohu skoncit, nula uz to nebude
					}
					else { // overuji reference a jsou pritomny
						#ifdef DEBUG_NUMBER_OF_OCCURRENCES
							fprintf(stderr, "\ndotser.c: isOkZeroOccurrences: Checking references and they are present at the query node.");
						#endif
						int refs = isOKReferencesOneNode(cely_strom, cely_strom_dotazu, aktualni_vrchol_dotazu, match, query_TVSList, actual_logical_expression);
						if (refs) { // pokud tento uzel matchuje vcetne referenci
							#ifdef DEBUG_NUMBER_OF_OCCURRENCES
								fprintf(stderr, "\ndotser.c: isOkZeroOccurrences: This node matches including the references - counting it (and therefore returning FALSE right now)");
							#endif
							number++;
							return FALSE; // rovnou mohu skoncit, nula uz to nebude
						}
						#ifdef DEBUG_NUMBER_OF_OCCURRENCES
							else {
								fprintf(stderr, "\ndotser.c: isOkZeroOccurrences: This node matches only without the references (does not match with them) - not counting it");
							}
						#endif
					}
				}
			}
			match = match->next;
		}
	}
	// nyni mam v number pocet sourozencu vrcholu v (vcetne) matchujicich se spravnou sadou vrcholu d dotazu
	// zbyva zjistit, zda je to opravdu nula (mela by byt, jinak uz jsem skoncil driv)
	#ifdef DEBUG_NUMBER_OF_OCCURRENCES
		if (transitive) {
			fprintf(stderr, "\ndotser.c: isOkZeroOccurrences: Number of transitive occurrences: %d of %d", number, number2);
		}
		else {
			fprintf(stderr, "\ndotser.c: isOkZeroOccurrences: Number of occurrences: %d of %d", number, number2);
		}
	#endif
	if (number == 0) {
		return TRUE;
	}
	else {
		return FALSE;
	}
} // isOkZeroOccurrences

int isOKReferencesNode(TVS *cely_strom, TVS *cely_strom_dotazu, TVS *aktualni_vrchol_dotazu, TVSList *query_TVSList, char *actual_logical_expression) { // vrátí TRUE, pokud referenční odkazy v sestaveném matchujícím stromě u tohoto vrcholu d dotazu jsou pravdivé; jinak vrátí FALSE
	// hledám vrchol stromu, nalepený na vrchol d dotazu; měl by být maximálně jeden
	// případ, kdy není ani jeden, se řeší po while cyklu
	TSezVrch *match = aktualni_vrchol_dotazu -> match;
	while (match) { // přes všechny matchující vrcholy
		if (match -> vrchol -> nalepeny == aktualni_vrchol_dotazu) { // našel jsem, víc jich nebude
			TAHLine *number = getDefinedNumberOfOccurrences(aktualni_vrchol_dotazu, match->matching_set);
			if (number == NULL) { // v dané sadě není definován meta-atribut _#occurrences
				return isOKReferencesOneNode(cely_strom, cely_strom_dotazu, aktualni_vrchol_dotazu, match, query_TVSList, actual_logical_expression);
			}
			else { // v dané sadě je definován meta-atribut _#occurrences
				// tady musím ověřit, že vrchol opravdu splňuje podmínky, které jsou u něj uvedeny - protože pro kombinaci _#occurrences a referencí to dosud nebylo provedeno
				int node_matches = isOKReferencesOneNode(cely_strom, cely_strom_dotazu, aktualni_vrchol_dotazu, match, query_TVSList, actual_logical_expression);
				if (node_matches) { // tento vrchol matchuje, teď ověřím, zda souhlasí počet požadovaných výskytů
					return isOkNumberOfOccurrences(cely_strom, cely_strom_dotazu, aktualni_vrchol_dotazu, match, TRUE, query_TVSList, actual_logical_expression);
				}
				else { // tento vrchol nematchuje
					return FALSE;
				}
			}
		}
		match = match -> next;
	} // while
	// Nenalezl jsem nalepený vrchol. To může znamenat asi to, že byl přeskočen vrchol s _optional=true nebo také vrchol s _#occurrences=0.
	// Zkontroluji případ _#occurrences=0
	#ifdef DEBUG_IS_OK_REFERENCES
		fprintf(stderr, "\ndotser.c: isOkReferencesNode: Is there zero occurrence required here?");
	#endif
	int zero_set = getSetZeroOccurrences(cely_strom_dotazu, aktualni_vrchol_dotazu, TRUE, query_TVSList, actual_logical_expression); // je u nektere sady definovan nulovy pocet vyskytu vrcholu?
	if (zero_set) { // tady je to nedoresene - tech sad muze byt vic!
	// tohle by se navic melo zjistit napred, aby se to nezjistovalo milionkrat
		#ifdef DEBUG_IS_OK_REFERENCES
			fprintf(stderr, "\ndotser.c: isOkReferencesNode: Yes, zero occurrence of this node is required.");
		#endif
		if (isOkZeroOccurrences(cely_strom, cely_strom_dotazu, aktualni_vrchol_dotazu, zero_set, query_TVSList, actual_logical_expression, TRUE)) { // pokud ten vyskyt je nulovy i v danem strome na spravnem miste, vcetne referenci
			#ifdef DEBUG_IS_OK_REFERENCES
				fprintf(stderr, "\ndotser.c: isOkReferencesNode: Zero occurrences OK - returning TRUE.");
			#endif
			return TRUE;
		}
		else { // vyskyt neni nulovy
			#ifdef DEBUG_IS_OK_REFERENCES
				fprintf(stderr, "\ndotser.c: isOkReferencesNode: Zero occurrences not OK - returning FALSE.");
			#endif
			return FALSE;
		}
	}
	#ifdef DEBUG_IS_OK_REFERENCES
		fprintf(stderr, "\ndotser.c: isOkReferencesNode: No, zero occurrence of this node is not required.");
	#endif
	// Tady je stále ještě možné, že byl přeskočen vrchol s _optional=true. Tak to nechám projít
	return TRUE;
} // isOKReferencesNode

int isOKReferences(TVS *cely_strom, TVS *cely_strom_dotazu, TVSList *query_TVSList, char *actual_logical_expression) { // vrátí TRUE, pokud referenční odkazy v sestaveném matchujícím stromě jsou pravdivé; jinak vrátí FALSE
	TVS *d = cely_strom_dotazu;
	while (d) { // přes celý dotaz
		if (d->contains_reference == TRUE) { // tento vrchol dotazu obsahuje referenci a je potřeba jej prověřit
			if (!isOKReferencesNode(cely_strom, cely_strom_dotazu, d, query_TVSList, actual_logical_expression)) {
				#ifdef DEBUG_IS_OK_REFERENCES
					fprintf(stderr, "\nisOkReferences: result: 0");
				#endif
				return FALSE;
			}
		}
		d = d -> dalsi; // zkontroluji další vrchol dotazu
	} // while
	#ifdef DEBUG_IS_OK_REFERENCES
		fprintf(stderr, "\nisOkReferences: result: 1");
	#endif
	return TRUE;
} // isOKReferences

int isOKReferencesAND(TVS *cely_strom, TVSList *query_TVSList, char *actual_logical_expression) { // vrátí TRUE, pokud referenční odkazy v sestaveném matchujícím stromě jsou pravdivé; jinak vrátí FALSE
  TVSList *pom_tvs_list = query_TVSList;
	while (pom_tvs_list) { // přes všechny stromy dotazu
		if (isOKReferences(cely_strom, pom_tvs_list->tvs, query_TVSList, actual_logical_expression) == FALSE) { // references in this query tree are not correct
			#ifdef DEBUG_IS_OK_REFERENCES
				fprintf(stderr, "\nisOkReferencesAND: result: 0");
			#endif
			return FALSE;
		}
		pom_tvs_list = pom_tvs_list->next; // zkontroluji další strom dotazu
	} // while
	#ifdef DEBUG_IS_OK_REFERENCES
		fprintf(stderr, "\nisOkReferencesAND: result: 1");
	#endif
	return TRUE;
} // isOKReferencesAND

void trySubtree (int tree_number, TVS *cely_strom, TVS *cely_strom_dotazu, TVS *aktualni_vrchol_dotazu, TVSList *query_TVSList, char *actual_logical_expression) { // pokusi se smatchovat zbytek d dotazu
// aktualni_vrchol_dotazu je uzel dotazu, ktery budeme matchovat v teto urovni rekurze
	if (aktualni_vrchol_dotazu == NULL) { // cely dotaz smatchovan
		//teď je potřeba ověřit referenční odkazy
		//fprintf(stderr, "\nThe whole query has been matched; going to check the references");
		if (isOKReferences(cely_strom, cely_strom_dotazu, query_TVSList, actual_logical_expression)) { // pokud i referenční odkazy jsou v pořádku
			tree_matched = TRUE; // signal pro funkci najdi_podstrom, ze dotaz byl nalezen alespon jednou v tomto strome
			if (!invert_match) { // pokud chci do vysledku prave matchujici stromy
				writeResultToFile(tree_number, cely_strom, cely_strom_dotazu, query_TVSList, actual_logical_expression); // vypsani stromu do vysledku dotazu
				changeNumberOfFoundOccurrences(1); // zvětším počet nalezených výskytů dotazu
				#ifdef DEBUG_STATISTICS_CHILD
					fprintf(stderr, "\nIncreasing number_of_found_occurrences to: %ld", getNumberOfFoundOccurrences());
				#endif
			}
		}
		return;
	}

	// celý dotaz ještě nesmatchován, zkusíme smatchovat další vrchol (aktualni_vrchol_dotazu)

	int zero_set = getSetZeroOccurrences(cely_strom_dotazu, aktualni_vrchol_dotazu, FALSE, query_TVSList, actual_logical_expression); // je u nektere sady definovan nulovy pocet vyskytu vrcholu?
	if (zero_set) { // tady je to nedoresene - tech sad muze byt vic!
	// tohle by se navic melo zjistit napred, aby se to nezjistovalo milionkrat
		if (isOkZeroOccurrences(cely_strom, cely_strom_dotazu, aktualni_vrchol_dotazu, zero_set, query_TVSList, actual_logical_expression, FALSE)) { // pokud ten vyskyt je nulovy i v danem strome na spravnem miste (ignoruji se reference - ty se resi po smatchovani celeho stromu)
			trySubtree (tree_number, cely_strom, cely_strom_dotazu, aktualni_vrchol_dotazu -> dalsi, query_TVSList, actual_logical_expression); // zkusim dalsi vrchol, cely_strom a cely_strom_dotazu predavam jen pro podfunkci tisk
			if (tree_matched && (first_only || invert_match)) { // jeden nalezený výskyt dotazu ve stromě stačí
				return;
			}
		}
	}

	TVS *parent;
	int transitive_type; // typ tranzitivní hrany
	int dist; // vzdálenost předchůdce od potomka v tranzitivní hraně

	TSezVrch *pom = aktualni_vrchol_dotazu -> match; // pruchod seznamem vrcholu stromu matchujicich s aktuálním vrcholem dotazu

	while (pom) { // přes všechny vrcholy matchující s aktuálním vrcholem dotazu
		if (pom -> vrchol -> nalepeny == NULL) { // vrchol ještě není obsazen (nalepen na dotaz)
			if (pom -> vrchol -> rodic != NULL) { // nesmi jit o koren - ten uz je smatchovan a taky by to spadlo
				//if (isDirectPredecessorButOptional(pom -> vrchol -> rodic -> nalepeny, aktualni_vrchol_dotazu)) { // souhlasi navaznost rodice a primeho potomka (až na skipped optional uzly)
				if (isDirectPredecessorButOptional(pom -> vrchol, aktualni_vrchol_dotazu)) { // souhlasi navaznost rodice a primeho potomka (až na skipped optional uzly)
					pom -> vrchol -> nalepeny = aktualni_vrchol_dotazu; // nalep aktualni vrchol
					stickOptionalNodes(pom -> vrchol, aktualni_vrchol_dotazu); // nalep na optional vrchol všechny násobné optional uzly, které na něj bylo potřeba namatchovat v isDirectPredecessorButOptional (tedy možná žádné)
					// nyni zkontroluji meta atribut #occurrences (pro tranzitivni i netranzitivni rodicovskou hranu)
					if (isOkNumberOfOccurrences(cely_strom, cely_strom_dotazu, aktualni_vrchol_dotazu, pom, FALSE, query_TVSList, actual_logical_expression)) { // pokud je definovan pocet vyskytu takoveho vrcholu pod jeho otcem a pokud je v poradku
						trySubtree (tree_number, cely_strom, cely_strom_dotazu, aktualni_vrchol_dotazu -> dalsi, query_TVSList, actual_logical_expression); // rekurze s timto nalepenim, cely_strom a cely_strom_dotazu predavam jen pro podfunkci tisk
						if (tree_matched && (first_only || invert_match)) { // jeden nalezený výskyt dotazu ve stromě stačí
							return;
						}
					}
					pom -> vrchol -> nalepeny = NULL; // odlep
					unstickOptionalNodes(pom -> vrchol, aktualni_vrchol_dotazu); // odlep z optional vrcholu všechny násobné optional uzly, které na něj bylo potřeba namatchovat v isDirectPredecessorButOptional (tedy možná žádné)
				}
				else { // může jít ještě o vrchol s tranzitivní rodičovskou hranou
					transitive_type = isSetTransitiveEdge(cely_strom_dotazu, aktualni_vrchol_dotazu, pom, FALSE, query_TVSList, actual_logical_expression);
					if (transitive_type != TRANSITIVITY_TYPE_NONE_INT) { // jde-li skutečně o vrchol s tranzitivní rodičovskou hranou
						parent = getParent(aktualni_vrchol_dotazu); // vrátí nejbližšího rodiče vrcholu d, který není skipped optional
						dist = isPredecessor(parent, pom->vrchol, transitive_type); // zjistím, zda platí tranzitivní rodičovství (s ohledem na typ tranzitivity); ano-li, vrátím vzdálenost k rodiči
						if (dist > 0) { // otestuji transitivní rodičovství - skutečně je to vzdálený potomek
							//if (isOkNumberOfTransitiveOccurrences(cely_strom, cely_strom_dotazu, aktualni_vrchol_dotazu, pom, query_TVSList, actual_logical_expression)) { // pokud je definovan pocet vyskytu takoveho vrcholu pod jeho otcem a pokud je v poradku
							if (isOkNumberOfOccurrences(cely_strom, cely_strom_dotazu, aktualni_vrchol_dotazu, pom, FALSE, query_TVSList, actual_logical_expression)) { // pokud je definovan pocet vyskytu takoveho vrcholu pod jeho otcem a pokud je v poradku
								pom -> vrchol -> nalepeny = aktualni_vrchol_dotazu; // nalepí vrchol
								if (transitive_type == TRANSITIVITY_TYPE_EXCLUSIVE_INT) {
									stickChain(pom->vrchol->rodic, special_sticky_node, dist-1); // nalepí na spec. vrchol vrcholy od rodice pom po tranzitivní hraně (aby se nemohly na nic nalepit) do počtu dist-1 (tranzitivního rodiče vynechám)
								}
								trySubtree (tree_number, cely_strom, cely_strom_dotazu, aktualni_vrchol_dotazu -> dalsi, query_TVSList, actual_logical_expression); // rekurze s timto nalepenim, cely_strom a cely_strom_dotazu predavam jen pro podfunkci tisk
								if (tree_matched && (first_only || invert_match)) { // jeden nalezený výskyt dotazu ve stromě stačí
									return;
								}
								if (transitive_type == TRANSITIVITY_TYPE_EXCLUSIVE_INT) {
									stickChain(pom->vrchol->rodic, NULL, dist-1); // odlepí pom->rodic a ostatní vrcholy v tranzitivní hraně
								}
								pom -> vrchol -> nalepeny = NULL; // odlepí vrchol
							}
						}
					}
				} // else
			} // if ne root
		} // if nenalepeny
		if (tree_matched && (first_only || invert_match)) { // jeden nalezený výskyt dotazu ve stromě stačí
			return;
		}
		pom = pom -> next; // zkusim dalsi matchujici vrchol
	} // while

	// ještě zkusím, jestli aktuální uzel dotazu není _optional
	if (getSetOptionalNode(aktualni_vrchol_dotazu) != 0) { // je optional - přeskočím tento uzel, jako by tu nebyl
		aktualni_vrchol_dotazu -> skipped_optional_node = TRUE; // označím uzel dotazu jako přeskočený
		trySubtree (tree_number, cely_strom, cely_strom_dotazu, aktualni_vrchol_dotazu -> dalsi, query_TVSList, actual_logical_expression); // rekurze s predchozim nalepenim, cely_strom a cely_strom_dotazu predavam jen pro podfunkci tisk
		aktualni_vrchol_dotazu -> skipped_optional_node = FALSE; // zruším označení uzlu dotazu jako přeskočeného
	}
} // trySubtree

void findSubtreesTVSListANDRecursion(int tree_number, TVS *cely_strom, TVSList *query_TVSList_rest, TVSList *query_TVSList, char *actual_logical_expression); // deklarace pro křížové volání

void trySubtreeAND (int tree_number, TVS *cely_strom, TVS *cely_strom_dotazu, TVS *aktualni_vrchol_dotazu, TVSList *query_TVSList_rest, TVSList *query_TVSList, char *actual_logical_expression) { // pokusi se smatchovat zbytek d dotazu (nikoli uz koren)
// d je uzel dotazu, ktery budeme matchovat v teto urovni rekurze
	#ifdef DEBUG_TRY_SUBTREE
		fprintf(stderr, "\ndotser.c: trySubtreeAND: Entering the function.\nquery_TVSList:");
		printTVSList(query_TVSList);
		fprintf(stderr, "\nquery_TVSList_rest:");
		printTVSList(query_TVSList_rest);
	#endif
	if (aktualni_vrchol_dotazu == NULL) { // cely dotaz smatchovan
		if (query_TVSList_rest == NULL) { // this is the last tree in the query and all previous trees have matched
			//teď je potřeba ověřit referenční odkazy
			#ifdef DEBUG_TRY_SUBTREE
				fprintf(stderr, "\ndotser.c: trySubtreeAND: The whole query has been matched. Final check of references.");
			#endif
			if (isOKReferencesAND(cely_strom, query_TVSList, actual_logical_expression)) { // pokud i referenční odkazy jsou v pořádku
				tree_matched = TRUE; // signal pro funkci najdi_podstrom, ze dotaz byl nalezen alespon jednou v tomto strome
				if (!invert_match) { // pokud chci do vysledku prave matchujici stromy
					writeResultToFile(tree_number, cely_strom, cely_strom_dotazu, query_TVSList, actual_logical_expression); // vypsani stromu do vysledku dotazu
					changeNumberOfFoundOccurrences(1); // zvětším počet nalezených výskytů dotazu
					#ifdef DEBUG_STATISTICS_CHILD
						fprintf(stderr, "\nIncreasing number_of_found_occurrences to: %ld", getNumberOfFoundOccurrences());
					#endif
				}
			}
		}
		else { // this is not the last tree in the query
			findSubtreesTVSListANDRecursion(tree_number, cely_strom, query_TVSList_rest, query_TVSList, actual_logical_expression);
		}
		return;
	}

	// celý dotaz ještě nesmatchován, zkusíme smatchovat další vrchol (aktualni_vrchol_dotazu)

	int zero_set = getSetZeroOccurrences(cely_strom_dotazu, aktualni_vrchol_dotazu, FALSE, query_TVSList, actual_logical_expression); // je u nektere sady definovan nulovy pocet vyskytu vrcholu?
	if (zero_set) { // tady je to nedoresene - tech sad muze byt vic!
	// tohle by se navic melo zjistit napred, aby se to nezjistovalo milionkrat
		if (isOkZeroOccurrences(cely_strom, cely_strom_dotazu, aktualni_vrchol_dotazu, zero_set, query_TVSList, actual_logical_expression, FALSE)) { // pokud ten vyskyt je nulovy i v danem strome na spravnem miste (ignoruji se reference - ty se resi az po smatchovani celeho stromu)
			trySubtreeAND (tree_number, cely_strom, cely_strom_dotazu, aktualni_vrchol_dotazu -> dalsi, query_TVSList_rest, query_TVSList, actual_logical_expression); // zkusim dalsi vrchol, cely_strom a cely_strom_dotazu predavam jen pro podfunkci tisk
			if (tree_matched && (first_only || invert_match)) { // jeden nalezený výskyt dotazu ve stromě stačí
				return;
			}
		}
	}

	TVS *parent;
	int transitive_type; // typ tranzitivní hrany
	int dist; // vzdálenost předchůdce od potomka v tranzitivní hraně

	TSezVrch *pom = aktualni_vrchol_dotazu -> match; // pruchod seznamem vrcholu stromu matchujicich s aktuálním vrcholem dotazu

	while (pom) { // přes všechny vrcholy matchující s aktuálním vrcholem dotazu
		if (pom -> vrchol -> nalepeny == NULL) { // vrchol ještě není obsazen (nalepen na dotaz)
			if (pom -> vrchol -> rodic != NULL) { // nesmi jit o koren - ten uz je smatchovan a taky by to spadlo
				//if (isDirectPredecessorButOptional(pom -> vrchol -> rodic -> nalepeny, aktualni_vrchol_dotazu)) { // souhlasi navaznost rodice a primeho potomka (až na skipped optional uzly)
				if (isDirectPredecessorButOptional(pom -> vrchol, aktualni_vrchol_dotazu)) { // souhlasi navaznost rodice a primeho potomka (až na skipped optional uzly)
					pom -> vrchol -> nalepeny = aktualni_vrchol_dotazu; // nalep
					stickOptionalNodes(pom -> vrchol, aktualni_vrchol_dotazu); // nalep na optional vrchol všechny násobné optional uzly, které na něj bylo potřeba namatchovat v isDirectPredecessorButOptional (tedy možná žádné)
					// nyni zkontroluji meta atribut #occurrences (pro tranzitivni i netranzitivni rodicovskou hranu)
					if (isOkNumberOfOccurrences(cely_strom, cely_strom_dotazu, aktualni_vrchol_dotazu, pom, FALSE, query_TVSList, actual_logical_expression)) { // pokud je definovan pocet vyskytu takoveho vrcholu pod jeho otcem a pokud je v poradku
						trySubtreeAND (tree_number, cely_strom, cely_strom_dotazu, aktualni_vrchol_dotazu -> dalsi, query_TVSList_rest, query_TVSList, actual_logical_expression); // rekurze s timto nalepenim, cely_strom a cely_strom_dotazu predavam jen pro podfunkci tisk
						if (tree_matched && (first_only || invert_match)) { // jeden nalezený výskyt dotazu ve stromě stačí
							return;
						}
					}
					pom -> vrchol -> nalepeny = NULL; // odlep
					unstickOptionalNodes(pom -> vrchol, aktualni_vrchol_dotazu); // odlep z optional vrcholu všechny násobné optional uzly, které na něj bylo potřeba namatchovat v isDirectPredecessorButOptional (tedy možná žádné)
				}
				else { // může jít ještě o vrchol s tranzitivní rodičovskou hranou
					transitive_type = isSetTransitiveEdge(cely_strom_dotazu, aktualni_vrchol_dotazu, pom, FALSE, query_TVSList, actual_logical_expression);
					if (transitive_type != TRANSITIVITY_TYPE_NONE_INT) { // jde-li skutečně o vrchol s tranzitivní rodičovskou hranou
						parent = getParent(aktualni_vrchol_dotazu); // vrátí nejbližšího rodiče vrcholu d, který není skipped optional
						dist = isPredecessor(parent, pom->vrchol, transitive_type);  // zjistím, zda platí tranzitivní rodičovství (s ohledem na typ tranzitivity); ano-li, vrátím vzdálenost k rodiči
						if (dist > 0) { // otestuji transitivní rodičovství - skutečně je to vzdálený potomek
//							if (isOkNumberOfTransitiveOccurrences(cely_strom, cely_strom_dotazu, aktualni_vrchol_dotazu, pom, query_TVSList, actual_logical_expression)) { // pokud je definovan pocet vyskytu takoveho vrcholu pod jeho otcem a pokud je v poradku
							if (isOkNumberOfOccurrences(cely_strom, cely_strom_dotazu, aktualni_vrchol_dotazu, pom, FALSE,query_TVSList, actual_logical_expression)) { // pokud je definovan pocet vyskytu takoveho vrcholu pod jeho otcem a pokud je v poradku
								pom -> vrchol -> nalepeny = aktualni_vrchol_dotazu; // nalepí vrchol
								if (transitive_type == TRANSITIVITY_TYPE_EXCLUSIVE_INT) {
									stickChain(pom->vrchol->rodic, special_sticky_node, dist-1); // nalepí na spec. vrchol vrcholy od rodice pom po tranzitivní hraně (aby se nemohly na nic nalepit) do počtu dist-1 (tranzitivního rodiče vynechám)
								}
								trySubtreeAND (tree_number, cely_strom, cely_strom_dotazu, aktualni_vrchol_dotazu -> dalsi, query_TVSList_rest, query_TVSList, actual_logical_expression); // rekurze s timto nalepenim, cely_strom a cely_strom_dotazu predavam jen pro podfunkci tisk
								if (tree_matched && (first_only || invert_match)) { // jeden nalezený výskyt dotazu ve stromě stačí
									return;
								}
								if (transitive_type == TRANSITIVITY_TYPE_EXCLUSIVE_INT) {
									stickChain(pom->vrchol->rodic, NULL, dist-1); // odlepí pom->rodic a ostatní vrcholy v tranzitivní hraně
								}
								pom -> vrchol -> nalepeny = NULL; // odlepí vrchol
							}
						}
					}
				} // else
			} // if ne root
		} // if nenalepeny
		pom = pom -> next; // zkusim dalsi matchujici vrchol
	} // while

	// ještě zkusím, jestli aktuální uzel dotazu není _optional
	if (getSetOptionalNode(aktualni_vrchol_dotazu) != 0) { // je optional - přeskočím tento uzel, jako by tu nebyl
		aktualni_vrchol_dotazu -> skipped_optional_node = TRUE; // označím uzel dotazu jako přeskočený
		trySubtreeAND (tree_number, cely_strom, cely_strom_dotazu, aktualni_vrchol_dotazu -> dalsi, query_TVSList_rest, query_TVSList, actual_logical_expression); // rekurze s predchozim nalepenim, cely_strom a cely_strom_dotazu predavam jen pro podfunkci tisk
		aktualni_vrchol_dotazu -> skipped_optional_node = FALSE; // zruším označí uzlu dotazu jako přeskočeného
	}
} // trySubtreeAND

void findSubtreesTVS(int tree_number, TVS *cely_strom, TVS * cely_strom_dotazu, TVSList *query_TVSList, char *actual_logical_expression) {
// projde vrcholy matchujici s korenem dotazu a od kazdeho zkusi smatchovat zbytek dotazu
	TSezVrch *pom = cely_strom_dotazu -> match; 	// pruchod seznamem vrcholu stromu matchujicich s korenem dotazu
	#ifdef DEBUG_FIND_SUBTREE
		fprintf(stderr,"\ndotser.c: findSubtreesTVS: Entering the function.");
	#endif
	int zero_set = getSetZeroOccurrences(cely_strom_dotazu, cely_strom_dotazu, FALSE, query_TVSList, actual_logical_expression); // je u nektere sady korene definovan nulovy pocet vyskytu vrcholu?
	if (zero_set) { // tady je to nedoresene - tech sad muze byt vic!
	// tohle by se navic melo zjistit napred, aby se to nezjistovalo milionkrat
		if (isOkZeroOccurrences(cely_strom, cely_strom_dotazu, cely_strom_dotazu, zero_set, query_TVSList, actual_logical_expression, FALSE)) { // pokud ten vyskyt je nulovy i v danem strome na spravnem miste (ignoruji se reference - ty se resi az po smatchovani celeho stromu)
			trySubtree (tree_number, cely_strom, cely_strom_dotazu, cely_strom_dotazu -> dalsi, query_TVSList, actual_logical_expression); // zkusim dalsi vrchol, s a d predavam jen pro podfunkci tisk
			if (tree_matched && (first_only || invert_match)) { // jeden nalezený výskyt dotazu ve stromě stačí
				return;
			}
		}
	}
	while (pom) { // pres vsechny ty matchujici vrcholy
		#ifdef DEBUG_FIND_SUBTREE
			fprintf(stderr,"\ndotser.c: findSubtreesTVS: Trying a node.");
		#endif
		if ((max_number_of_trees != 0) && (getNumberOfFoundOccurrences() >= max_number_of_trees)) { // uzivatel nalezl jiz maximalni povoleny pocet stromu pro jeden dotaz
			searching_break_type = END_OF_SEARCHING_MAX_NUMBER_REACHED;
			break; // konec prohledavani
		}
		if ((getQueryStopFlag() == TRUE)) { // uživatel chce proces prohledávání zastavit
			searching_break_type = END_OF_SEARCHING_USER_INTERRUPTION;
			break; // konec prohledavani
		}
		pom -> vrchol -> nalepeny = cely_strom_dotazu; // zkusime to s timhle vrcholem
		if (isOkNumberOfOccurrences(cely_strom,cely_strom_dotazu, cely_strom_dotazu, pom, FALSE, query_TVSList, actual_logical_expression)) { // pokud je definovan pocet vyskytu takoveho vrcholu pod jeho otcem a pokud je v poradku
			trySubtree (tree_number, cely_strom, cely_strom_dotazu, cely_strom_dotazu -> dalsi, query_TVSList, actual_logical_expression); // zkusi smatchovat zbytek dotazu; pokud se zdari, strom da do vysledku
			if (tree_matched && (first_only || invert_match)) { // jeden nalezený výskyt dotazu ve stromě stačí
				break;
			}
		}
		pom -> vrchol -> nalepeny = NULL; // s timhle vrcholem jsme to uz zkusili
		pom = pom -> next; // zkusime to s dalsim vrcholem
	}
	return;
} // findSubtreesTVS

void findSubtreesTVSListANDRecursion(int tree_number, TVS *cely_strom, TVSList *query_TVSList_rest, TVSList *query_TVSList, char *actual_logical_expression) {
// projde vrcholy matchujici s korenem jednoho stromu dotazu a od kazdeho zkusi smatchovat zbytek tohoto stromu dotazu a pripadne dalsi stromy dotazu
	#ifdef DEBUG_FIND_SUBTREE
		fprintf(stderr,"\ndotser.c: findSubtreesTVSListANDRecursion: Entering the function.");
	#endif
	TVS *cely_strom_dotazu = query_TVSList_rest->tvs;
	TSezVrch *pom = cely_strom_dotazu -> match; 	// pruchod seznamem vrcholu stromu matchujicich s korenem dotazu
	int zero_set = getSetZeroOccurrences(cely_strom_dotazu, cely_strom_dotazu, FALSE, query_TVSList, actual_logical_expression); // je u nektere sady korene definovan nulovy pocet vyskytu vrcholu?
	if (zero_set) { // tady je to nedoresene - tech sad muze byt vic!
	// tohle by se navic melo zjistit napred, aby se to nezjistovalo milionkrat
		if (isOkZeroOccurrences(cely_strom, cely_strom_dotazu, cely_strom_dotazu, zero_set, query_TVSList, actual_logical_expression, FALSE)) { // pokud ten vyskyt je nulovy i v danem strome na spravnem miste (ignoruji se reference - ty se resi az po smatchovani celeho stromu)
			trySubtreeAND (tree_number, cely_strom, cely_strom_dotazu, cely_strom_dotazu -> dalsi, query_TVSList_rest->next, query_TVSList, actual_logical_expression); // zkusim dalsi vrchol, s a d predavam jen pro podfunkci tisk
			if (tree_matched && (first_only || invert_match)) { // jeden nalezený výskyt dotazu ve stromě stačí
				return;
			}
		}
	}
	while (pom) { // pres vsechny ty matchujici vrcholy
		#ifdef DEBUG_FIND_SUBTREE
			fprintf(stderr,"\ndotser.c: findSubtreesTVSListANDRecursion: Trying a node.");
		#endif
		if ((max_number_of_trees != 0) && (getNumberOfFoundOccurrences() >= max_number_of_trees)) { // uzivatel nalezl jiz maximalni povoleny pocet stromu pro jeden dotaz
			searching_break_type = END_OF_SEARCHING_MAX_NUMBER_REACHED;
			break; // konec prohledavani
		}
		if ((getQueryStopFlag() == TRUE)) { // uživatel chce proces prohledávání zastavit
			searching_break_type = END_OF_SEARCHING_USER_INTERRUPTION;
			break; // konec prohledavani
		}
		if (pom -> vrchol -> nalepeny == NULL) { // vrchol ještě není obsazen (nalepen) z předchozích stromů dotazu
			pom -> vrchol -> nalepeny = cely_strom_dotazu; // zkusime to s timhle vrcholem
			#ifdef DEBUG_FIND_SUBTREE
				fprintf(stderr,"\ndotser.c: findSubtreesTVSListANDRecursion: Sticked the node.");
			#endif
			if (isOkNumberOfOccurrences(cely_strom,cely_strom_dotazu, cely_strom_dotazu, pom, FALSE, query_TVSList, actual_logical_expression)) { // pokud je definovan pocet vyskytu takoveho vrcholu pod jeho otcem a pokud je v poradku
				trySubtreeAND (tree_number, cely_strom, cely_strom_dotazu, cely_strom_dotazu -> dalsi, query_TVSList_rest->next, query_TVSList, actual_logical_expression); // zkusi smatchovat zbytek dotazu; pokud se zdari, strom da do vysledku
				if (tree_matched && (first_only || invert_match)) { // jeden nalezený výskyt dotazu ve stromě stačí
					break;
				}
			}
			pom -> vrchol -> nalepeny = NULL; // s timhle vrcholem jsme to uz zkusili
			#ifdef DEBUG_FIND_SUBTREE
				fprintf(stderr,"\ndotser.c: findSubtreesTVSListANDRecursion: Unsticked the node.");
			#endif
		}
		pom = pom -> next; // zkusime to s dalsim vrcholem
	}
	#ifdef DEBUG_FIND_SUBTREE
		fprintf(stderr,"\ndotser.c: findSubtreesTVSListANDRecursion: Leaving the function.");
	#endif
	return;
} // findSubtreesTVSListANDRecursion

void findSubtreesTVSListAND(int tree_number, TVS *cely_strom, TVSList *query_TVSList, char *actual_logical_expression) {
	TVS *query_one_tree;
	tree_matched = FALSE; // vynuluji globalni priznak o nalezeni dotazu v tomto stromu

	#ifdef DEBUG_FIND_SUBTREE
		fprintf(stderr,"\ndotser.c: findSubtreesTVSListAND: Calling findSubtreesTVSListANDRecursion.");
	#endif
	findSubtreesTVSListANDRecursion(tree_number, cely_strom, query_TVSList, query_TVSList, actual_logical_expression);
	#ifdef DEBUG_FIND_SUBTREE
		fprintf(stderr,"\ndotser.c: findSubtreesTVSListAND: I have just returned from findSubtreesTVSListANDRecursion: tree_matched = %d", tree_matched);
	#endif

	if (invert_match) { // pokud davam do vysledku prave stromy nematchujici s dotazem
		if (!tree_matched) { // a pokud dotaz nebyl nalezen ani jednou v tomto strome
			writeResultToFile(tree_number, NULL, NULL, NULL, NULL);
			changeNumberOfFoundTrees(1); // zvětším počet stromů, ve kterých byl dotaz nalezen
		}
	}
	else { // do vysledku mam davat prave stromy matchujici s dotazem
		if (tree_matched) { // dotaz byl nalezen alespon jednou v tomto strome
			changeNumberOfFoundTrees(1); // zvětším počet stromů, ve kterých byl dotaz nalezen
		}
	}
	return;
} // findSubtreesTVSListAND

void findSubtreesTVSListOR(int tree_number, TVS *cely_strom, TVSList *query_TVSList, char *actual_logical_expression) {
	TVS *query_one_tree;
	tree_matched = FALSE; // vynuluji globalni priznak o nalezeni dotazu v tomto stromu
	TVSList *pom_tvslist = query_TVSList;
	while (pom_tvslist) { // go over all trees in the query
		if (pom_tvslist->nodes_match == TRUE) { // if all necessary nodes from this tree match with nodes in the result tree
			query_one_tree = pom_tvslist->tvs;
			//fprintf(stderr, "\nCalling najdi_podstrom");
			findSubtreesTVS(tree_number, cely_strom, query_one_tree, query_TVSList, actual_logical_expression);
			if (tree_matched && (first_only || invert_match)) { // jeden nalezený výskyt dotazu ve stromě stačí
				break;
			}
		}
		pom_tvslist = pom_tvslist->next;
	}
	if (invert_match) { // pokud davam do vysledku prave stromy nematchujici s dotazem
		if (!tree_matched) { // a pokud dotaz nebyl nalezen ani jednou v tomto strome
			writeResultToFile(tree_number, NULL, NULL, NULL, NULL);
			changeNumberOfFoundTrees(1); // zvětším počet stromů, ve kterých byl dotaz nalezen
		}
	}
	else { // do vysledku mam davat prave stromy matchujici s dotazem
		if (tree_matched) { // dotaz byl nalezen alespon jednou v tomto strome
			changeNumberOfFoundTrees(1); // zvětším počet stromů, ve kterých byl dotaz nalezen
		}
	}
} // findSubtreesTVSListOR


// the main function for assembling a tree matching the query; called once for every tree
// it checks the actual logical expression and chooses the right function to call
void findSubtreesTVSList(int tree_number, TVS *cely_strom, TVSList *query_TVSList, char *actual_logical_expression) {
	int and_or = strcmp(actual_logical_expression, "AND") == 0 ? TRUE : FALSE; // only global AND or OR are supported as logical expression
	#ifdef DEBUG_FIND_SUBTREE
		fprintf(stderr,"\ndotser.c: findSubtreesTVSList: Entering the function. The and_or check is: %d", and_or);
	#endif
	if (and_or) { // general AND among trees in the query
		findSubtreesTVSListAND(tree_number, cely_strom, query_TVSList, actual_logical_expression);
	}
	else { // general OR among trees in the query
		findSubtreesTVSListOR(tree_number, cely_strom, query_TVSList, actual_logical_expression);
	}
	return;
}

int searchingFinished(FILE * uk, char *type) {
// testuje (vraci TRUE/FALSE) jestli je vysledny soubor jiz kompletni; ano-li, vrati v type pricinu ukonceni
	long souc;	// aktualni pozice v souboru
	char zn[10];	// pro cteni znaku

	fflush(uk);
	souc = ftell(uk);

	fseek(uk, 0, SEEK_END); // jdi na konec souboru

	if (ftell(uk) < 2) { // Jen pocatecni znacka, vratim se na puvodni pozici a koncim
		#ifdef DEBUG_SEARCHING_FINISHED
			fprintf(stderr,"\ndotser.c: searchingFinished: soubor s vysledky obsahuje jen pocatecni znacku - vracim FALSE");
		#endif
		fseek(uk, souc, SEEK_SET); // obnoveni pozice v souboru
		return FALSE;
	}

	#ifdef _LINUX_VERSION
		fseek(uk, -4, SEEK_CUR); // zpet na znacku
		// ve windowsech v cygwinu tohle popolezlo jen o 3 dozadu
	#endif
#ifdef _WINDOWS_VERSION
		fseek(uk, -5, SEEK_CUR); // zpet na znacku
		// takhle to funguje v cygwinu
#endif

	zn[0] = 32;
	zn[1] = 32;
	zn[2] = 32;

	fread(zn, 1, 3, uk);
	#ifdef DEBUG_SEARCHING_FINISHED
		fprintf(stderr,"\ndotser.c: searchingFinished: z konce souboru s vysledky nacteno: '%c', '%c', '%c'", zn[0], zn[1], zn[2]);
	#endif

	fseek (uk, souc, SEEK_SET); // obnoveni pozice v souboru

	if (zn[0] == RESULT_FILE_OCCURRENCES_DELIMITER && zn[1] == END_OF_SEARCHING) {
		*type = zn[2];
		return TRUE;
	}
	else {
		return FALSE;
	}
}

int writeVersion(int start, char* version) { // zapise verzi serveru/klienta do pole zprava od pozice start
  // vrati pocet zapsanych bajtu
	int delka;
	delka = strlen(version);
	strncpy((char*)(zprava+start),version,delka);
	return delka;
} // writeVersion


int chdirUpperLevel(char *path, int *pos, char del) { // odřízne z path poslední položku cesty; pokud tam není, chyba
	// pos nastaví za konec nové cesty, del je oddělovač položek cesty
	// vrátí 0, pokud v pořádku, jinak nenulu při chybě
	int length; // délka cesty
	char *pos1, *pos2;
	int pos1_int, pos2_int;

	if (! path) return -1;

	#ifdef DEBUG_CANONIZE_PATH
		fprintf(stderr,"\nchdirUpperLevel: na vstupu je cesta: %s", path);
	#endif

	length = strlen(path);
	if (length <= 0) return -1;

	if (length == 1 && path[0] == del) return -1; // nelze se přemístit o adresář výše, žádný tam není

	#ifdef DEBUG_CANONIZE_PATH
		fprintf(stderr,"\nchdirUpperLevel: původní délka cesty je %d.", length);
	#endif

	pos2 = strrchr(path, del); // poslední výskyt oddělovače
	if (! pos2) { // v cestě není oddělovač, ale cesta není prázdná. Je to tedy relativní cesta k jednomu podadresáři
       	strcpy(path, "."); // vrátím aktuální adresář
		*pos = 2;
		return 0;
	}

	if (pos2 == path) { // je na prvním místě, ale něco po něm následuje
		path[1] = '\0'; // ukončím řetězec za oddělovačem; tj. odstraním po něm následující položku
		*pos = 2;
		return 0;
	}

	pos2_int = pos2 - path; // pozice posledního oddělovače
	if (pos2_int == length - 1) { // poslední oddělovač je na poslední pozici
		path[pos2_int] = '\0'; // odstraním poslední oddělovač z řetězce
	}

	pos1 = strrchr(path, del); // nyní poslední výskyt oddělovače
	if (! pos1) { // v cestě není oddělovač, ale cesta není prázdná. Je to tedy relativní cesta k jednomu podadresáři
       	strcpy(path, "."); // vrátím aktuální adresář
		*pos = 2;
		return 0;
	}
	pos1_int = pos1 - path; // pozice posledního oddělovače

	if (pos2_int == length - 1) { // pokud předtím končila cesta oddělovačem, zakončím ji tak i zkrácenou (opravdu pos2_int!)
		*pos = pos1_int + 1;
	} else { // cesta předtím nekončila oddělovačem, nenechám ho tam tedy
		*pos = pos1_int;
	}

	path[*pos] = '\0'; // zakončím řetězec na příslušném místě
	#ifdef DEBUG_CANONIZE_PATH
		fprintf(stderr,"\nchdirUpperLevel: vracím cestu: %s", path);
	#endif
	#ifdef DEBUG_CANONIZE_PATH
		fprintf(stderr,"\nchdirUpperLevel: nová délka cesty je %d.", *pos);
	#endif

	return 0;
}

int canonizePath(char *dst, char *src) { // vyhodnotí v cestě src všechny '..' a '.' a vícenásobné '/' nebo '\'; výsledek vrátí v dst
	// vrátí 0, pokud proběhlo v pořádku, jinak nenulu
	int length_src;
	int pos_src, pos_dst; // pozice ve vstupním a cílovém poli
	char *next, *next1, *next2;
	char c, c2, c3;
	char *s;
	char del; // oddělovač položek cesty
	int next_pos, item_length;

	if (! src || ! dst) return -1;

	dst[0] = '\0'; // vynuluji cílový řetězec
	del = path_separator;

	length_src = strlen(src); // délka vstupu
	if (length_src <= 0) return -1;

	// dále zkontroluji, zda cesta obsahuje jen tisknutelné znaky (tedy ne např. backspace)
	s = src;
	for (pos_src = 0; pos_src < length_src; pos_src ++) {
		if (! isprint(*s++)) return -1; // jiné než tisknutelné znaky nepřipouštím
	}

	pos_dst = 0;
	pos_src = 0;

	c = src[pos_src];
	if (c == del) { // oddělovač v cestě na začátku řetězce přesunu do výsledku
		strncat(dst + pos_dst, src + pos_src, 1);
		pos_dst++;
		pos_src++;
	}

	while (pos_src < length_src) { // přes celý vstup
		c = src[pos_src];
		if (c == del) { // přeskočím vícenásobné oddělovače položek cesty
			#ifdef DEBUG_CANONIZE_PATH
				fprintf(stderr,"\ncanonizePath: preskakuji vicenasobny oddelovac polozek cesty");
			#endif
			pos_src++;
			continue;
		}

		// nyní mám v c znak, který není oddělovačem položek cesty; začíná zde položka cesty; pos_src mi ukazuje na místo, kde je c
		next = strchr(src + pos_src + 1, del); // zjistím nejbližší další výskyt oddělovače
		if (! next) { // oddělovač tam již není - zbytek řetězce je poslední položka cesty
			next_pos = length_src; // takže za pozici dalšího oddělovače považuji ukončovací znak řetězce
		} else { // je tam další oddělovač, zjistím jeho pozici
			next_pos = next - src; // odečtu pozici oddělovače od začátku řetězce - aritmetika pointerů
		}
		item_length = next_pos - pos_src; // délka této položky cesty
		if (item_length == 1 && c == '.') { // tato položka cesty je přechod do aktuálního adresáře, tj. redundantní
              	pos_src += 2; // ukážu až za oddělovač
			continue;
		}

		if (item_length == 2 && c == '.' && src[pos_src + 1] == '.') { // přechod do nadřazeného adresáře
			#ifdef DEBUG_CANONIZE_PATH // ladí převádění cesty do kanonické podoby
				fprintf(stderr,"\ncanonizePath: prechazim do nadrazeneho adresare.");
			#endif
			if (pos_dst>1) {
				if (dst[pos_dst-1]==del) { // odstraním tento delimiter
					dst[pos_dst-1] = '\0';
					pos_dst--;
				}
			}
			if (chdirUpperLevel(dst, &pos_dst, del)) { // nelze vyhodnotit přechod do nadřazeného adresáře
				#ifdef DEBUG_CANONIZE_PATH // ladí převádění cesty do kanonické podoby
					fprintf(stderr,"\ncanonizePath: prechod do nadrazeneho adresare se nezdaril!");
				#endif
				return -1;
			}
			pos_src += 3; // ukážu až za oddělovač
			continue;
		}

		// nyní vím, že se jedná o normální položku - přechod do podadresáře
		#ifdef DEBUG_CANONIZE_PATH
			fprintf(stderr,"\ndosavadni cesta je %s", dst);
			fprintf(stderr,"\ncanonizePath: prechazim do podadresare, delka polozky je %d", item_length);
		#endif
		strncat(dst + pos_dst, src + pos_src, item_length); // přesunu položku
		pos_dst += item_length;
		pos_src += item_length;
	 	if (next) { // a pokud následuje další položka
			strncat (dst + pos_dst, src + pos_src, 1); // přesunu i oddělovač
			pos_dst++;
			pos_src++;
		}
	}
	return 0; // OK
}

int isFsFile (char *name) { // vrátí nulu, pokud name nemá příponu .fs; jinak nenulu
	int delka; // délka name
	delka = strlen(name);
	if (delka < 4) return 0; // příliš krátký soubor
	if (strncmp(name + delka - 3, ".fs", 3)) { // pokud se přípona liší
		return 0; // nemá příponu fs
	}
	else {
		return 1;
	}
}

int legalFileDir(char *dst, char *src) { // převede cestu src do kanonizované verze (vrátí v dst), tj. bez přechodů do nadřazených adresářů apod.
// vrátí 1, pokud je soubor/adresář přístupný klientovi, tj. pokud je v podadresari path_initial
	//char divider; // sem se načte znak oddělující položky v cestě ('/' nebo '\')
	int error; // indikace chyby
	int delka; // delka adresarove cesty
	error = 0; // zatím bez chyby
	//divider = path_separator;
	error = canonizePath(dst, src);
	if (strncmp (path_initial, dst, strlen(path_initial))) { // chyba - pokus o opusteni adresarove struktury pristupne klientovi
		error = 1; // vyskytla se chyba
	}
	//fprintf(stderr,"\nvýsledná cesta je: %s.", dst);
	if (error) {
		return 0; // není to legální soubor pro klienta
	}
	else {
		return 1; // je to legální soubor pro klienta
	}
}


//////  následují funkce obhospodařující jednotlivé požadavky klienta  ///////

void getVersion(char *zpr, char *odp) { // vrátí klientovi verze (serveru a minimální požadovanou klienta)
	int delka;
	switch (zpr[1]) { // o kterou verzi jde
		case SERVER_VERSION: // verze serveru
			delka = writeVersion(1,server_version); // zapisu verzi serveru od pozice 1 do odpovedi
			#ifdef DEBUG_GETVERSION
				fprintf(stderr,"\nGET_SERVER_VERSION: delka=%d", delka);
			#endif
			odp[0] = OK;  // probehlo ok
			odp[delka+1] = EOM;
			#ifdef DEBUG_GETVERSION
				fprintf(stderr,"\nGET_SERVER_VERSION vraci: %s", odp + 1 );
			#endif
			return;
		break;

		case CLIENT_REQUIRED_VERSION: // pozadovana verze klienta
			delka = writeVersion(1,client_required_version); // zapisu verzi klienta od pozice 1 do odpovedi
			#ifdef DEBUG_GETVERSION
				fprintf(stderr,"\nGET_CLIENT_RECUIRED_VERSION: delka=%d", delka);
			#endif
			odp[0] = OK;  // probehlo ok
			odp[delka+1] = EOM;
			#ifdef DEBUG_GETVERSION
				fprintf(stderr,"\nGET_CLIENT_REQUIRED_VERSION vraci: %s", odp + 1 );
			#endif
			return;
		break;

		case CLIENT_RECOMMENDED_VERSION: // doporucena verze klienta
			delka = writeVersion(1,client_recommended_version); // zapisu verzi klienta od pozice 1 do odpovedi
			#ifdef DEBUG_GETVERSION
				fprintf(stderr,"\nGET_CLIENT_RECOMMENDED_VERSION: delka=%d", delka);
			#endif
			odp[0] = OK;  // probehlo ok
			odp[delka+1] = EOM;
			#ifdef DEBUG_GETVERSION
				fprintf(stderr,"\nGET_CLIENT_RECOMMENDED_VERSION vraci: %s", odp + 1 );
			#endif
			return;
		break;

		default:
			odp[0] = ERROR;
			odp[1] = EOM;
			return;
		break;
	}
} // getVersion

int writeCorpusIdentifier(char *dst) { // zapíše do dst identifikátor korpusu, vrátí počet zapsaných znaků
	int delka;
	int error = readConfigFile(dst,PARAM_NAME_CORPUS_IDENTIFIER);
	if (error < 0) { // hodnota není určena v konfiguračním souboru nebo došlo k chybě během čtení
		strcpy(dst, path_initial); // jako identifikátor pošlu výchozí cestu korpusu
		delka = strlen(path_initial);
		return delka;
	}
	else { // identifikátor korpusu byl načten
		delka = strlen(dst);
		return delka;
	}
} // writeCorpusIdentifier

void getInitInfo (char *zpr, char *odp) { // vrátí klientovi iniciální informace najednou - verze a výchozí adresář
	// přečte verzi klienta a vrátí:
	// 1. radek: verze serveru
	// 2. radek: pozadovana verze klienta
	// 3. radek: vychozi cesta
	// 4. radek: doporucena verze klienta
	// 5. radek: identifikátor korpusu (od verze 1.73) - klient to pouziva pro rozliseni nastaveni pro ruzne servery
	// 6. radek a dalsi radky az do prazdneho radku: schemata koreferenci (od verze 1.87)

	char *i = index(zpr+1,EOM); // ukážu si na EOM v přijaté zprávě
	int ln;
	if (i != NULL) ln = i - zpr - 1; // tohle je délka verze klienta (nepočítám první znak zprávy a ukončovací EOM)
	else ln = -1;
	if (ln >= MAX_VERSION_LENGTH) ln = MAX_VERSION_LENGTH - 1;  // abych nepřelezl alokované místo
	if (ln > 0) { // pokud tedy byla klientem poslána jeho verze a nedošlo k větším problémům
		strncpy(client_version, zpr + 1, ln);  // zkopíruji verzi klienta do globální proměnné
		*(client_version + ln) = '\0';  // zakončím řetězec
		#ifdef DEBUG_GETVERSION
			fprintf(stderr,"\nclient version = %s",client_version);
		#endif
	}
	// nyní mohu sestavovat odpověd pro klienta
	int start;
	int delka;
	start = 1; // zapisuji od pozice 1
	delka = writeVersion(start, server_version); // zapisu verzi serveru od pozice start do odpovedi
	#ifdef DEBUG_GETVERSION
		fprintf(stderr,"\nserver version = %s",server_version);
	#endif
	odp[start + delka] = EOL;
	start += delka + 1; // ukazi na dalsi radek
	delka = writeVersion(start,client_required_version); // zapisu pozadovanou verzi klienta na dalsi radek do odpovedi
	#ifdef DEBUG_GETVERSION
		fprintf(stderr,"\nclient required version = %s",client_required_version);
	#endif
	odp[start + delka] = EOL;
	start += delka + 1; // ukazi na dalsi radek
	#ifdef DEBUG_GETVERSION
		fprintf(stderr,"\ninitial path = %s",path_initial);
	#endif
	strcpy(odp + start, path_initial);
	delka = strlen(path_initial);
	if (! delka) { // chyba pri cteni cesty
		fprintf(stderr,"\ndotser.c: getInitInfo: error in initial path reading");
		odp[0] = ERROR;
		odp[1] = EOM;
		return;
	}
	odp[start + delka] = EOL;

	start += delka + 1; // ukazi na dalsi radek
	delka = writeVersion(start,client_recommended_version); // zapisu doporucenou verzi klienta na dalsi radek do odpovedi
	#ifdef DEBUG_GETVERSION
		fprintf(stderr,"\nclient recommended version = %s",client_recommended_version);
	#endif
	odp[start + delka] = EOL;
	
	start += delka + 1; // ukazi na dalsi radek
	delka = writeCorpusIdentifier(odp + start); // zapisu identifikator korpusu na dalsi radek do odpovedi
	odp[start + delka] = EOL;

	start += delka + 1; // ukazi na dalsi radek
	if (strcmp(client_version, "1.87") >= 0) { // klient je dostatečně nový, pošlu mu schémata koreferencí, každé na samostatném řádku, zakončím je prázdným řádkem
		delka = writeCoreferences(odp + start); // zapíšu schémata koreferencí
		odp[start + delka] = EOL;	// zakončím je prázdným řádkem
	}

	odp[0] = OK;  // probehlo ok
	odp[start + delka + 1] = EOM;

	return;
} // getInitInfo

void getActualDirectory (char *zpr, char *odp) { // vrátí klientovi aktuální adresář v procházení adresářové struktury treebanku
	int delka;

	strcpy (odp + 1, path_actual);
	delka = strlen(path_actual);

	#ifdef DEBUG
		fprintf(stderr, " %s ", odp + 1 );
	#endif

	odp[0] = OK;  // probehlo ok
	odp[delka + 1] = EOM;
	return;
}

int changeDirectory(char *zpr, char *odp) { // změní aktuální adresář procházení treebanku; klientovi vrátí nový adresář (to od 1.3)
	// vrací 0, pokud se změnil adresář, jinak nenulu
	int error;
	#ifdef DEBUG_CD
		fprintf(stderr,"\nKlient pozadal o zmenu adresare.");
	#endif

	strcpy (buff, path_actual); // načtu aktuální cestu
	strncat (buff, &path_separator, 1); // přidám oddělovač položek
	strcat (buff, zpr + 1); // načtu požadovaný podadresář
	getRidOfTrailingWhites(buff);
	#ifdef DEBUG_CD
		fprintf(stderr,"\npozadovana cesta: '%s' ", buff);
	#endif

	error = 0; // zatím žádná chyba

	if (!legalFileDir(buff2,buff)) { // převedu cestu do základního tvaru a zkontroluji, zda požadovaný adresář není mimo adresářovou strukturu přístupnou klientovi
		error = 1; // vyskytla se chyba
	}

	#ifdef DEBUG_CD
		fprintf(stderr,"\njeji kanonicka verze je: %s ", buff2 );
	#endif

	if (error) { // pokud se vyskytla chyba
		#ifdef DEBUG_CD
			fprintf(stderr,"\nZmena adresare skoncila s chybou %d ", error );
		#endif
		odp[0] = ERROR;
		odp[1] = EOM;
		return -1;
	}
	else { // vše proběhlo v pořádku
		#ifdef DEBUG_CD
			fprintf(stderr,"\nZmena adresare skoncila v poradku.");
		#endif
		strcpy(path_actual, buff2); // zkopíruji požadovanou cestu do aktuální
		odp[0] = OK;  // probehlo ok
		strcpy(odp+1, path_actual); // zkopíruji požadovanou cestu do odpovědi
		odp[strlen(path_actual) + 1] = EOM;
		return 0;
	}
} // changeDirectory

int getSubdirectories(char *zpr, char *odp, int nova_cesta_adr) { // vrátí seznam podadresářů v aktuální cestě
	// vrací 0, pokdu proběhlo v pořádku, jinak nenulu
	static int adr_pokracovani=false; // signalizuje, jestli se ocekava zadost o pokracovani seznamu adresaru
	int min_pokracovani; // pomocna
	int chyba_casti; // signalizuje chybu v synchronizaci posilanych casti seznamu
	int error; // ostatní chyby
	DIR* directory; // ukazatel na strukturu DIR - na adresář
	dirent *dir_item; // jedna polozka adresare
	char *name; // jmeno polozky adresare
	FILE *file_dirs; // ukazatel na soubor s podadresari aktualniho adresare

	chyba_casti = FALSE;

	if (zpr[1] == PART_MIDDLE && adr_pokracovani == FALSE) { // nekonzistence
		fprintf(stderr,"\nChyba 1 v synchronizaci posilani casti seznamu adresaru");
		chyba_casti = TRUE;
	}
	else if (zpr[1] == PART_FIRST && adr_pokracovani == TRUE) { // nekonzistence
		fprintf(stderr,"\nChyba 2 v synchronizaci posilani casti seznamu adresaru");
		chyba_casti = FALSE; // z této chyby se zotavuji
		adr_pokracovani = FALSE; // takto; cili respektuji novy pozadavek klienta
	}

	if (chyba_casti) { // fatální chyba v synchronizaci, vracím chybu klientovi
		odp[0] = ERROR;
		odp[1] = EOM;
		return -1;
	}

	if (nova_cesta_adr || adr_pokracovani == FALSE) { // aktualizace souboru podadr; tyhle dve podminky se dost prekryvaji
		getcwd(buff2,MPL); // ulozim pracovni adresar
		error = 0;
		chdir(path_actual); // presunu se do aktualniho adresare treebanku

		directory = opendir(path_actual);
		#ifdef DEBUG_GETDIRS
			fprintf(stderr,"\ngetSubdirectories: Going to opendir '%s'",path_actual);
		#endif
		if (!directory) { // nastala chyba pri otvirani aktualniho adresare
			error = 1;
		}
		else { // zatim bez chyby
			file_dirs = fopen(podadr,"w"); // otevru soubor podadr pro zapis; smazu predchozi obsah, prip. vytvorim soubor
			if (!file_dirs) { // nastala chyba pri otvirani souboru pro uchovani podadresaru
				error = 2;
			}
			else { // zatim bez chyby
				while (dir_item = readdir(directory)) { // dokud je dalsi polozka v adresari
					name = (*dir_item).d_name; // ukazu si na jmeno
					if (*(name) != '.') { // adresare zacinajici teckou ignoruji
						if (!chdir(name)) { // pokud se opravdu jedna o adresar
							chdir(path_actual); // vratim se zpet
							#ifdef DEBUG_GETDIRS
								fprintf(stderr,"\npodadresar: %s",name);
							#endif
							fprintf(file_dirs,"%s\n",name); // zapisu podadresar do souboru
						}
					}
				}
				fflush(file_dirs);
				fclose (file_dirs);
			}
			closedir (directory);
		}
		chdir(buff2); // obnovim puvodni pracovni adresar
		if (error) { // Chyba pri vytvareni seznamu podadresaru
			#ifdef DEBUG_GETDIRS
				fprintf(stderr,"\nChyba %d pri vytvareni souboru se seznamem podadresaru.",error);
			#endif
			odp[0] = ERROR;
			odp[1] = EOM;
			return -1;
		}
		adr_pokracovani = FALSE; // zbytecne, to tak musi byt
	}

	odp[0] = OK;  // probehlo ok
	min_pokracovani = adr_pokracovani;
	adr_pokracovani = nacti_soubor (u_podadr, odp + 2, adr_pokracovani, MAXLENMES - 4); // ze souboru se zpet prectou jmena adresaru do odpovedi
	// to MAXLENMES -4 znamena jednu pozici pro OK, druhou pro info o uplnosti, treti pro eom, ctrvta je rezerva
	if (min_pokracovani==FALSE && adr_pokracovani == FALSE) odp[1] = PART_ONLY;
	if (min_pokracovani==FALSE && adr_pokracovani == TRUE) odp[1] = PART_FIRST;
	if (min_pokracovani==TRUE && adr_pokracovani == TRUE) odp[1] = PART_MIDDLE;
	if (min_pokracovani==TRUE && adr_pokracovani == FALSE) odp[1] = PART_LAST;
	return 0;
} // getSubdirectories

/*int isFile(const struct dirent *dir) { // vrací 1, když adresářová položka je soubor nebo se neví, jinak vrací 0; nefunguje na quest
	if (dir->d_type != DT_REG && dir->d_type != DT_REG) {
		return 0;
	}
	return 1;
}*/

int getFiles(char *zpr, char *odp, int nova_cesta_sbr) { // vrátí seznam souborů v aktuální cestě
	// vrací 0, pokud proběhlo v pořádku, jinak nenulu
	static int sbr_pokracovani=false; // signalizuje, jestli se ocekava zadost o pokracovani seznamu souboru
	int min_pokracovani; // pomocna
	int chyba_casti; // signalizuje chybu v synchronizaci posilanych casti seznamu
	int error; // ostatní chyby
	//DIR* directory; // ukazatel na strukturu DIR - na adresář
	//dirent *dir_item; // jedna polozka adresare
	char *name; // jmeno polozky adresare
	FILE *file_files; // ukazatel na soubor se soubory v aktualnim adresari
	struct dirent **namelist;
    int i,n,max;

	chyba_casti = FALSE;

	if (zpr[1] == PART_MIDDLE && sbr_pokracovani == FALSE) { // nekonzistence
		fprintf(stderr,"\nChyba 1 v synchronizaci posilani casti seznamu souboru");
		chyba_casti = TRUE;
	}
	else if (zpr[1] == PART_FIRST && sbr_pokracovani == TRUE) { // nekonzistence
		fprintf(stderr,"\nChyba 2 v synchronizaci posilani casti seznamu souboru");
		chyba_casti = FALSE; // z této chyby se zotavuji
		sbr_pokracovani = FALSE; // takto; cili respektuji novy pozadavek klienta
	}

	if (chyba_casti) { // fatální chyba v synchronizaci, vracím chybu klientovi
		odp[0] = ERROR;
		odp[1] = EOM;
		return -1;
	}

	if (nova_cesta_sbr || sbr_pokracovani == FALSE) { // aktualizace souboru soubory, pokud je nutno aktualizovat
		getcwd(buff2,MPL); // ulozim pracovni adresar
		error = 0;
		chdir(path_actual); // presunu se do aktualniho adresare treebanku

		/*directory = opendir(path_actual);
		if (!directory) { // nastala chyba pri otvirani aktualniho adresare
			error = 1;
		}
		else { // zatim bez chyby
			file_files = fopen(soubory,"w"); // otevru soubor soubory pro zapis; smazu predchozi obsah, prip. vytvorim soubor
			if (!file_files) { // nastala chyba pri otvirani souboru pro uchovani souboru v adresari
				error = 2;
			}
			else { // zatim bez chyby
				/*while (dir_item = readdir(directory)) { // dokud je dalsi polozka v adresari
					name = (*dir_item).d_name; // ukazu si na jmeno
					if (*(name) != '.') { // soubory zacinajici teckou ignoruji
						if (chdir(name)) { // pokud se nejedna o adresar (tedy se jedna o soubor)
							#ifdef DEBUG_GETFILES
								fprintf(stderr,"\nsoubor: %s",name);
							#endif
							fprintf(file_files,"%s\n",name); // zapisu jmeno souboru do souboru
						}
						else chdir(path_actual); // vratim se zpet
					}
				}*/
		file_files = fopen(soubory,"w"); // otevru soubor soubory pro zapis; smazu predchozi obsah, prip. vytvorim soubor
		if (!file_files) { // nastala chyba pri otvirani souboru pro uchovani souboru v adresari
			error = 2;
		}
		else { // zatim bez chyby
			#ifdef DEBUG_GETFILES
				fprintf(stderr,"\ngetFiles: Going to scandir %s",path_actual);
			#endif
	        n = scandir(path_actual, &namelist, 0, alphasort);
    	    if (n < 0)
        		error = 1;
        	else {
				for (i=0; i<n; i++) {
					name = namelist[i]->d_name; // ukazu si na jmeno
					if (*(name) != '.') { // soubory zacinajici teckou ignoruji
						if (chdir(name)) { // pokud se nejedna o adresar (tedy se jedna o soubor)
							#ifdef DEBUG_GETFILES
								fprintf(stderr,"\nsoubor: %s",name);
							#endif
							fprintf(file_files,"%s\n",name); // zapisu jmeno souboru do souboru
						}
						else chdir(path_actual); // vratim se zpet
					}
                	free(namelist[i]);
               	}
               	free(namelist);			
           	}				
			
			fflush(file_files);
			fclose (file_files);
		}
		//closedir (directory);
		//}
		chdir(buff2); // obnovim puvodni pracovni adresar
		if (error) { // Chyba pri vytvareni seznamu souboru
			#ifdef DEBUG_GETDIRS
				fprintf(stderr,"\nChyba %d pri vytvareni souboru se seznamem souboru v adresari.", error);
			#endif
			odp[0] = ERROR;
			odp[1] = EOM;
			return -1;
		}
		sbr_pokracovani = FALSE; // zbytecne, to tak musi byt
	}

	odp[0] = OK;  // probehlo ok
	min_pokracovani = sbr_pokracovani;
	sbr_pokracovani = nacti_soubor (u_soubory, odp + 2, sbr_pokracovani, MAXLENMES - 4);
	// to MAXLENMES -4 znamena jednu pozici pro OK, druhou pro info o uplnosti, treti pro eom, ctrvta je rezerva
	if (min_pokracovani==FALSE && sbr_pokracovani == FALSE) odp[1] = PART_ONLY;
	if (min_pokracovani==FALSE && sbr_pokracovani == TRUE) odp[1] = PART_FIRST;
	if (min_pokracovani==TRUE && sbr_pokracovani == TRUE) odp[1] = PART_MIDDLE;
	if (min_pokracovani==TRUE && sbr_pokracovani == FALSE) odp[1] = PART_LAST;
       return 0;
} // getFiles

void explicitStopQuery(char *zpr, char *odp) { // uživatel chce skončit běžící dotaz
	#ifdef DEBUG_STOP_QUERY
		fprintf(stderr,"\nUživatel chce zastavit dotaz. ");
	#endif
	if (bezi_dotaz) { // ukonceni dotazu
		#ifdef DEBUG_STOP_QUERY
			fprintf(stderr,"Dotaz běžel, zastavuji ho.");
		#endif
		setQueryStopFlag(TRUE); // dávám procesu dotser (child) informaci do sdílené paměti, že má skončit
	}
	#ifdef DEBUG_STOP_QUERY
		else {
			fprintf(stderr,"Žádný dotaz neběžel, není třeba nic zastavovat.");
		}
	#endif
	odp[0] = OK; // zastaveni dotazu probehlo ok
	int pos=1;
	pos += writeStatisticsToChars(odp + pos);
	odp[pos] = EOM;
} // explicitStopQuery

void stopQuery() { // ukončí běžící dotaz, pokud běží
	if (bezi_dotaz) { // ukonceni dotazu
		kill (childpid, SIGKILL);
		wait(NULL);
		bezi_dotaz = FALSE;
	}
} // stopQuery

int isQueryRunning() { // vrátí TRUE, pokud dotaz běží, jinak FALSE
	if (bezi_dotaz) return TRUE;
	else return FALSE;
} // isQueryRunning

int isDir(char *name) { // returns 1 if name is a directory; 0 otherwise
	DIR *directory; // ukazatel na strukturu DIR - na adresář
	directory = opendir(name);
	if (!directory) { // nastala chyba pri otvirani adresare
		if (errno == ENOTDIR) { // není to adresář
			return 0;
		}
	}
	closedir(directory);
	return 1;
} // isDir

void addFilesRecursively(char *dir_name) { // přidá do u_setfiles rekurzivně všechny fs soubory
	// (nesmím měnit buff, mohu měnit buff2)
	DIR *directory; // ukazatel na strukturu DIR - na adresář
	dirent *dir_item; // jedna polozka adresare
	char *name; // jmeno polozky adresare
	int dir_name_length = strlen(dir_name);

	directory = opendir(dir_name);
	if (!directory) { // nastala chyba pri otvirani aktualniho adresare
		fprintf(stderr,"\ndotser.c: addFilesRecursively: An error occured during opening direcotry: %s",dir_name);
		return;
	}
	else { // zatim bez chyby
		while (dir_item = readdir(directory)) { // dokud je dalsi polozka v adresari
			name = (*dir_item).d_name; // ukazu si na jmeno
			if (*(name) != '.') { // adresare a soubory zacinajici teckou ignoruji
				// vytvorim plnou cestu k danemu souboru/adresari
				strcpy(buff2, dir_name);
				buff2[dir_name_length] = path_separator;
				strcpy(buff2 + dir_name_length + 1, name);
				if (isDir(buff2)) { // pokud se opravdu jedna o adresar
					addFilesRecursively(buff2); // jedná se o adresář, musím rekurzivně přidat všechny fs soubory v něm
				}
				else { // není to adresář
					if (isFsFile(buff2)) { // jedná se o fs soubor
						fprintf(u_setfiles, "%s\n", buff2); // soubor zapíšu na disk do seznamu souborů k prohledávání
					}
				}
			}
		}
		closedir (directory);
	}
} // addFilesRecursively

void setFiles(char *zpr, char *odp) { // přijme seznam souborů k prohledávání od klienta
	static int pokracovani=FALSE; // signalizuje, ve které fázi jsem při čtění více částí seznamu souborů posílaného od klienta
	int je_potreba_vytvorit_soubor = TRUE; // pomocná proměnná při řešení přijímání seznamu souborů
	int chyba_casti = FALSE;
	char typ_casti; // identifikuje typ části seznamu souborů
	int delka_hlav;
	int stary_klient_mezera = FALSE; // určuje, zda je klient starší než 1.86 a odděluje soubory mezerou
	if (strcmp(client_version, "1.86") < 0) { // klient je starý, soubory odděluje mezerou
		stary_klient_mezera = TRUE;
		#ifdef DEBUG_SET_FILES
			fprintf(stderr,"\ndotser.c (parent): setFiles: The client version is less than 1.86 - files are separated with a space character.");
		#endif
	}
	// klienti od 1.86 oddělují soubory tabulátorem

	stopQuery(); // stopne se dotaz, pokud běží

	typ_casti = zpr[1];

	switch (typ_casti) { // typ pořadí zprávy (když se nevejde celý seznam do jedné zprávy)

		case PART_ONLY: // první a poslední (jediná) část
			//fprintf(stderr,"\nPřijata jediná část seznamu souborů");
			pokracovani = FALSE; // nebude se pokračovat další částí
			je_potreba_vytvorit_soubor = TRUE;
		break;

		case PART_FIRST: // první z více částí
			//fprintf(stderr,"\nPřijata první z více částí seznamu souborů");
			pokracovani = TRUE;
			je_potreba_vytvorit_soubor = TRUE;
		break;

		case PART_MIDDLE: // střední z více částí (tj. ani první ani poslední)
			//fprintf(stderr,"\nPřijata prostřední z více částí seznamu souborů");
			if (pokracovani != TRUE) chyba_casti = TRUE;
			pokracovani = TRUE;
			je_potreba_vytvorit_soubor = FALSE;
		break;

		case PART_LAST: // poslední z více částí
			//fprintf(stderr,"\nPřijata poslední z více částí seznamu souborů");
			if (pokracovani != TRUE) chyba_casti = TRUE;
			pokracovani = FALSE;
			je_potreba_vytvorit_soubor = FALSE;
		break;

		default:
			chyba_casti = TRUE;
		break;
	}

	if (chyba_casti == TRUE) { // Chyba v posílání a zpracování částí seznamu
		odp[0] = ERROR;
		odp[1] = EOM;
		fprintf(stderr,"\nChyba při přijímání více částí seznamu souborů!");
		return;
	}

	// je-li potreba, vytvori pomocny soubor setfiles.pid; pokud existuje, stahne ho
	if (je_potreba_vytvorit_soubor == TRUE) {
		createTemporaryFile (u_setfiles, setfiles, 14, pidstr);
		je_potreba_vytvorit_soubor = FALSE; // zbytečné, ale pro pořádek
	}

	for (char * uk = zpr + 2; ; ) { // přes celou zprávu, tj. přes všechny soubory oddělené mezerou
		buff[0] = 0; // tato 0 se přepíše při úspěšném načtení jména souboru; jinak podle ní poznám, že se nenačetlo
		while (dummy (*uk)) { // preskocim bile znaky
			uk++;
		}
		if (stary_klient_mezera == TRUE) { // klienti starší než 1.86 oddělují soubory mezerou
			sscanf (uk, "%s", buff); // nactu jmeno jednoho souboru/adresare
		}
		else { // klienti od 1.86 oddělují soubory tabulátory
			sscanf (uk, "%[^\t]", buff); // nactu jmeno jednoho souboru/adresare
		}
		if (buff[0] == 0) { // ukoncovaci podminka cyklu for - pokud nacitani jmena neprobehlo v poradku, tj. nejspis konec seznamu jmen
			break;
		}
		uk += strlen(buff); // ukazu si za jmeno souboru/adresare pro cteni dalsich jmen
		if (legalFileDir(buff2, buff)) { // pokud jde o jméno souboru či adresáře přístupného klientovi, tak v buff2 je jeho kanonizovaná cesta
			#ifdef DEBUG_SET_FILES
				fprintf(stderr,"\ndotser.c (parent): setFiles: Canonized version of the file is: %s.", buff2);
			#endif
			if (isFsFile(buff2)) { // jedná se o fs soubor
				fprintf(u_setfiles, "%s\n", buff2); // soubor zapíšu na disk
			}
			if (isDir(buff2)) { // jedná se o adresář, musím rekurzivně přidat všechny fs soubory v něm (mění buff2)
				addFilesRecursively(buff2);
			}
		}
	} // for

	if (typ_casti == PART_MIDDLE || typ_casti == PART_FIRST) { // je třeba jen čekat do další části
		//fprintf(stderr,"\nCekám na další z více částí seznamu souborů");
		odp[0] = OK;
		odp[1] = EOM;
		return;
	}

	fflush(u_setfiles);

	if (GlobHlav) { // pripadne odstraneni hlavicky
		freeFile (GlobHlav);
		if (zobrazeni_gh)
			delete zobrazeni_gh;
	}

	#ifdef DEBUG_SET_FILES
		fprintf(stderr,"\ndotser.c (parent): setFiles: Creating new global head.");
	#endif
	// vyroba nove hlavicky
	GlobHlav = createGlobalHead (u_setfiles); // ze souboru, jejichz jmena jsou v souboru u_setfiles, vytahni glob. hlavicku
	#ifdef DEBUG_SET_FILES
		fprintf(stderr,"\ndotser.c (parent): setFiles: The new global head has been created.");
	#endif

	// vytvoreni pole pro zobrazeni
	if (GlobHlav)
		zobrazeni_gh = new int [GlobHlav -> AHNum];

	delka_hlav = vypis_hlavicku (GlobHlav, odp + 1); // do odpovedi se vypise globalni hlavicka

	if (GlobHlav)
		preved_hlav_na_poz (GlobHlav);

	odp[0] = OK;	// nastaveni souboru probehlo ok
	odp[delka_hlav + 1] = EOM;
} // setFiles

void childExited(int signal) { // spouštěno signálem SIGCHLD
	// dotazovací proces skončil, otec je o tom timto obeznamen
	#ifdef DEBUG_SIGNALS
		fprintf(stderr,"\ndotser.c (parent): childExited: The process dotser (child) exited.");
	#endif
  wait(NULL);
	bezi_dotaz = FALSE;
}

int copyFile(FILE *dst, FILE *src) { // zkopíruji obsah jednoho souboru do druhého
	// vrací 0, pokud OK, jinak vrací -1
	int error = 0;
	if (! dst || ! src) {
		return -1;
	}
	rewind (src); // přesunu se na začátky obou souborů
    rewind (dst);
    int c;

	while ((c = fgetc(src)) != EOF) { // přes celý soubor po znacích
		if (fputc(c, dst)<0) error = -1;
		//fprintf(stderr,"%c",c);
	}
	fputc(EOF,dst);
	return error;
}

int nextFileName(int above_result, char *dst, int *tree_number) { // v dst vrátí další jméno souboru
	// ze seznamu prohledávaných souborů (tj. v závislosti na above_result).
	// V případě, že above_result == TRUE, vrátí navíc v tree_number číslo stromu; jinak tam vrátí -1
	// vrátí TRUE, pokud bylo načteno další jméno, jinak vrátí FALSE (konec souboru nebo chyba)
	if (above_result) {
		return nactiDalsiPolozku(u_result_stored, dst, tree_number);
	}
	else {
		if (fscanf (u_setfiles, "%[^\n]\n", dst) == 1) {
			getRidOfTrailingWhites(dst); // odstraním \n na konci jména souboru
			*tree_number = -1;
			return TRUE;
		}
		return FALSE;
	}
} // nextFileName

void setLemmaMatching(int *match, char value) {
	if (value == '1') *match = TRUE;
	else *match = FALSE;
}

void logStatistics() { // it writes statistics of searching of one query to stderr for archivation; called by dotser child just before it exits
  fprintf(stderr,"\nQuery statistics: [%d,%d,%d] %s",getNumberOfFoundOccurrences(), getNumberOfFoundTrees(), getNumberOfSearchedTrees(), actual_query);
}

void setTrueFalse(int *dst, char value) {
	if (value == '1') *dst = TRUE;
	else *dst = FALSE;
}

void setQuery(char *zpr, char *odp) { // nastaví dotaz a spustí prohledávání treebanku
	TVS *str;
	TVSList *query_TVSList;
	int query_all_trees; // signalizuje, zda je dotaz prazdny (tj. na vsechny stromy) nebo ne
	int delka_hlav;
	int tree_number; // číslo prohledávaného stromu v souboru
	int query_position; // kde ve zprávě začíná vlastní dotaz
	int above_result; // signalizuje, zda se má provést dotaz nad výsledkem minulého dotazu

	if (! u_setfiles) {  // neex. setfiles (klient nespecifikoval soubory k prohledavani)
		odp[0] = ERROR;
		odp[1] = EOM;
		return;
	}
	if (! GlobHlav) {	// hlavicka je prazdna
		odp[0] = ERROR;
		odp[1] = EOM;
		return;
	}

	#ifdef DEBUG_SET_QUERY
		fprintf(stderr,"\nMessage with the query specification (only printable characters are displayed): ");
		zapis_eom(2,zpr,EOM);
	#endif

	switch (zpr[1]) { // podle rozlišovače dotazu

		case ABOVE_FILES: // stromy dle dotazu nad vybranými soubory
			query_position = zpr[2]; // na tomto místě zprávy je odkaz na začátek vlastního dotazu
			setLemmaMatching(&match_lemma_variants, zpr[3]); // mají se matchovat lemmata bez ohledu na varianty?
			setLemmaMatching(&match_lemma_comments, zpr[4]); // mají se ignorovat vysvětlivky při matchování lemmat?
			setTrueFalse(&invert_match, zpr[5]); // maji se do vysledku dotazu davat prave stromy nematchujici s dotazem?
			if (strcmp(client_version, "1.88") >= 0) { // klient je nový, posílá i případnou žádost o hledání jen prvního výskytu v každém stromě
				setTrueFalse(&first_only, zpr[6]); // má se vyhledávat jen první výskyt v každém stromě?
			}
			else { // klient je starý, vždy se hledají všechny výskyty
				setTrueFalse(&first_only, '0');
			}
			above_result = FALSE;
			break;
		case ABOVE_RESULT: // stromy dle dotazu nad výsledkem minulého dotazu
			if (isQueryRunning()) { // pokud ještě běží minulý dotaz
				odp[0] = REPEAT; // klient má dotaz poslat za chvíli znovu
				odp[1] = EOM;
				//fprintf(stderr,"\nPosílám klientovi výzvu k opětovnému zaslání dotazu.");
				return;
			}
			query_position = zpr[2];
			setLemmaMatching(&match_lemma_variants, zpr[3]); // mají se matchovat lemmata bez ohledu na varianty?
			setLemmaMatching(&match_lemma_comments, zpr[4]); // mají se ignorovat vysvětlivky při matchování lemmat?
			setTrueFalse(&invert_match, zpr[5]); // maji se do vysledku dotazu davat prave stromy nematchujici s dotazem?
			if (strcmp(client_version, "1.88") >= 0) { // klient je nový, posílá i případnou žádost o hledání jen prvního výskytu v každém stromě
				setTrueFalse(&first_only, zpr[6]); // má se vyhledávat jen první výskyt v každém stromě?
			}
			else { // klient je starý, vždy se hledají všechny výskyty
				setTrueFalse(&first_only, '0');
			}
			above_result = TRUE;
			break;
		case ALL_TREES: // všechny stromy z vybraných souborů
			if (strcmp(client_version, "1.88") >= 0) { // klient je nový, tady už neposílá zbytečnosti
				query_position = 2; // tam je EOM, podle kterého se dál pozná dotaz na všechny stromy
			}
			else { // starší klienti tu posílají zbytečnosti
				query_position = zpr[2]; // až tam je EOM
			}
			match_lemma_variants = TRUE; // pro pořádek sem něco nastavím
			match_lemma_comments = TRUE; // a sem taky
			invert_match = FALSE; // u dotazu na vsechny stromy by TRUE nemelo smysl - nevybralo by se nic
			first_only = TRUE;
			above_result = FALSE;
			break;
		default: // stromy dle dotazu nad vybranými soubory pro klienty starší než 1.41
			query_position = 1;
			match_lemma_variants = TRUE; // mají se matchovat lemmata bez ohledu na varianty?
			match_lemma_comments = TRUE; // mají se ignorovat vysvětlivky při matchování lemmat?
			invert_match = FALSE; // takto stary klient by to nechtel
			first_only = FALSE;
			above_result = FALSE;
			break;
	} // switch

	stopQuery(); // stopne se předchozí dotaz, pokud běží

	// vytvori soubor dotaz.pid
	// pokud existuje, stahne ho
	createTemporaryFile(u_dotaz, dotaz, 11, pidstr);

	#ifdef DEBUG_SET_QUERY
		fprintf(stderr,"\nThe query position is: %d", query_position);
	#endif
	if (prazdny_string (zpr + query_position, EOM)) { // dotaz je prazdny
		#ifdef DEBUG_SET_QUERY
			fprintf(stderr,"\nThe query is empty - the client wants all trees");
		#endif
        strcpy(actual_query,"all trees"); // uložení dotazu pro pozdější výpis se statistikami do stderr
		#ifdef LOG_QUERY
			fprintf(stderr,"\nUser %s's query: all trees", user_account.login_name);
		#endif
		query_all_trees = TRUE;
	}
	else { // neni prazdny
		if (*(zpr+query_position) == '[') { // a pure query starts here, no logical expression is given - AND will be used if multiple trees occur in the query
			strcpy(actual_logical_expression,"AND");
			zapis_str_eom(actual_query, zpr+query_position, MAX_QUERY_LOG_LENGTH, EOM); // cisty dotaz do actual_query
		}
		else { // it seems that the query starts with a logical expression; the pure query follows after EOL
			query_position += zapis_str_eom2(actual_logical_expression, zpr+query_position, MAX_LOG_EXP_LOG_LENGTH, EOL, 10); // store logical expression to actual_logical_expression
			// for compatibility with older versions of clients than 1.80, the previous line contains both EOL and 10
			query_position ++; // skip the EOL character, too
			zapis_str_eom(actual_query, zpr+query_position, MAX_QUERY_LOG_LENGTH, EOM); // cisty dotaz do actual_query
		}
		#ifdef DEBUG_SET_QUERY
			fprintf(stderr,"\nThe pure query is:\n");
			fprintf(stderr,actual_query);
			fprintf(stderr,"\nThe end of the query");
			fprintf(stderr,"\nThe logical expression is:\n");
			fprintf(stderr,actual_logical_expression);
			fprintf(stderr,"\nThe end of the logical expression");
		#endif
		#ifdef LOG_QUERY
			fprintf(stderr,"\nUser %s's query: %s", user_account.login_name, actual_query);
			fprintf(stderr,"\nwith logical expression: %s", actual_logical_expression);
		#endif
		query_all_trees = FALSE;
		#ifdef DEBUG_SET_QUERY
			fprintf(stderr,"\ndotser.c (parent): Writing the pure query to file...");
		#endif
		writeDefs (u_dotaz, GlobHlav); // graph code - zapise definice atributu globalni hlavicky do souboru
		//zapis_string_sbr (u_dotaz, zpr + query_position, EOM); // zapise dotaz do souboru (graph code to vyzaduje)
		fprintf(u_dotaz, "%s\n", actual_query);
		fflush (u_dotaz);
		rewind (u_dotaz); // ted je dotaz pripraven v souboru ke cteni graph codem
		#ifdef DEBUG_SET_QUERY
			fprintf(stderr,"done\ndotser.c (parent): Reading the query from the file...");
		#endif

		if (PomHlav = readFile (dotaz)) { // graph code: strom - dotaz precten a zapojen
			#ifdef DEBUG_SET_QUERY
				fprintf(stderr,"done");
			#endif
			freeFile (GlobHlav); // zruseni GlobHlav
			GlobHlav = PomHlav; // novy dotaz
		}
		else { // chyba pri cteni dotazu
			#ifdef DEBUG_SET_QUERY
				fprintf(stderr,"ERROR!");
			#endif
			odp[0] = ERROR;
			odp[1] = EOM;
			return;
		}

		#ifdef DEBUG_SET_QUERY
			fprintf(stderr,"done2");
		#endif
		scanGlobalHead(GlobHlav); // projdu hlavičku dotazu a zapamatuji si pozice význačných atributů a meta atributů
		error_type = preprocessTrees(GlobHlav, TRUE, TRUE, hidden_position_gh); // projdu stromy (od verze 1.80 to muze byt vic stromu) dotazu a opatřím vrcholy informacemi o hloubce apod.
		// první TRUE značí, že chci zjišťovat i případná pojmenování vrcholů pomocí meta atributu META_NODE_NAME
		// druhé TRUE značí, že chci vyhledávat a případně kompilovat regulární výrazy
		if (error_type != 0) {
			odp[0] = ERROR;
			odp[1] = error_type;
			int error_length = fillErrorMessagesToOdp(odp + 2, error_type);
			odp[2 + error_length] = EOM;
			return;
		}
	}

	// pokud dotaz nad výsledkem minulého dotazu, schová se výsledek minulého dotazu
	if (above_result) {
		if (! u_vysledek) { // není předchozí výsledek, vrátím chybu
			odp[0] = ERROR;
			odp[1] = EOM;
			return;
		}
		createTemporaryFile (u_result_stored, result_stored, 19, pidstr);
		if (copyFile(u_result_stored, u_vysledek)) { // zkopíruji výsledek min. dotazu
			odp[0] = ERROR; // pokud chyba, vrátím chybu
			odp[1] = EOM;
			return;
		}
	}

	// vytvori soubor vysledek.pid, do ktereho se budou zapisovat nalezene stromy
	// pokud existuje, stahne ho
	#ifdef DEBUG_SET_QUERY
		fprintf(stderr, "\ndotser.c (parent): Creating the temporary file for storing result...");
	#endif
	createTemporaryFile (u_vysledek, vysledek, 14, pidstr);
	#ifdef DEBUG_SET_QUERY
		fprintf(stderr, "done");
	#endif

	createResultFileReadingMask(); // vytvoří se čtecí maska pro funkci fscanf při čtení ze souboru výsledků ve funkci readOneRecord
	
	// zapise prvni znacku
	zapis_znacku (u_vysledek); // oddelovac mezi zaznamy ve vysledku
	fflush (u_vysledek);
	rewind (u_vysledek); // zpet na zacatek

	pozice_out = TRUE;    // ukazovatko je ve stavu out

        // ve Windows vytvori soubor statistics.pid, do ktereho se budou zapisovat statistiky o poctu nalezenych stromu
        // pokud existuje, stahne ho; v Linuxu vytvori pro stejny ucel sdilenou pamet
        #ifdef DEBUG_CONTROL_SHARED_MEMORY
            fprintf(stderr,"\ndotser.c (parent before fork): Detaching and destroying shared memory for statistics if any exists...");
        #endif
#ifdef LINUX_VERSION
        if (control_shared_memory_id != -1) { // z minulého vyhledávání zůstala sdílená paměť
                #ifdef DEBUG_CONTROL_SHARED_MEMORY
                    fprintf(stderr,"\ndotser.c (parent before fork): Yes it exists...");
                #endif
                detachControlSharedMemory();
                destroyControlSharedMemory();
                #ifdef DEBUG_CONTROL_SHARED_MEMORY
                    fprintf(stderr,"done");
                #endif
        }
        #ifdef DEBUG_CONTROL_SHARED_MEMORY
                else {
                    fprintf(stderr,"it does not exist.");
                }
        #endif
#endif
        #ifdef DEBUG_CONTROL_SHARED_MEMORY
            fprintf(stderr,"\ndotser.c (parent before fork): Creating shared memory for statistics...");
        #endif
        createControlSharedMemory(); // vytvořím sdílenou paměť pro statistiky o prohledávání
        #ifdef DEBUG_CONTROL_SHARED_MEMORY
            fprintf(stderr,"done");
        #endif

	// -------------------------- FORK ----------------------------

	// tvorba noveho procesu, kterym bude prohledavani stromu provedeno

	#ifdef DEBUG_SET_QUERY
	    fprintf(stderr,"\ndotser.c (parent): Going to fork...");
	#endif
	if ((childpid = fork()) < 0)
		err_dump ("\nserver (dotser.c): Error in fork when creating the query process!");
	else {
		if (childpid > 0) { // rodic
			#ifdef DEBUG_SET_QUERY
			    fprintf(stderr, "\ndotser.c (parent): ...fork has been successfull");
			#endif
			bezi_dotaz = TRUE;
			odp[0] = OK;  // na dotazu se pracuje
			if (! query_all_trees) {
				if ((GlobHlav -> TreeNum) == 1)
					odp[1] = '1'; // nacten jeden strom dotazu; odp[1] je klientem ignorovana
				else odp[1] = 'H'; // nacteno vice stromu dotazu
			}
			else odp[1] = 'R'; // prijat dotaz na vsechny stromy
			odp[2] = EOM;
			#ifdef DEBUG_CONTROL_SHARED_MEMORY
				fprintf(stderr, "\ndotser.c (parent): Going to attach shared memory...");
			#endif
			attachControlSharedMemory(); // připojím sdílenou paměť pro statistiky a řízení programu
			#ifdef DEBUG_CONTROL_SHARED_MEMORY
	   		 fprintf(stderr,"done");
			#endif
			number_of_actual_occurrence = 0;
			number_of_actual_tree = 0;
			number_of_removed_occurrences = 0;
			number_of_removed_trees = 0;
			setQueryStopFlag(FALSE); // nastavím tento příznak na nepravdu - dítě tedy nemá zatím končit prohledávání
			return;
		}
		
		else { // dite - zpracovani dotazu

			// znovuotevreni vysledku -> nove ukazovatko pozice
			#ifdef DEBUG_SET_QUERY
			    fprintf(stderr, "\ndotser.c (child): ...dotser child has started");
			#endif
			fclose (u_vysledek);
			if (! (u_vysledek = fopen (vysledek, "a")))
				err_dump ("\nserver (dotser.c): The query process cannot open the destination file!", FALSE);


			#ifdef DEBUG_CONTROL_SHARED_MEMORY
			    fprintf(stderr, "\ndotser.c (child): Going to attach shared memory...");
			#endif
			attachControlSharedMemory(); // připojím sdílenou paměť pro statistiky a řízení programu
			#ifdef DEBUG_CONTROL_SHARED_MEMORY
	   		 fprintf(stderr,"done");
			#endif
			#ifdef DEBUG_SET_QUERY
			    fprintf(stderr, "\ndotser.c (child): Clearing statistics...");
			#endif
			clearStatistics();
			#ifdef DEBUG_SET_QUERY
	   		 fprintf(stderr,"done");
			#endif
			#ifdef DEBUG_SET_QUERY
			    fprintf(stderr, "\ndotser.c (child): Setting query stop flag to FALSE...");
			#endif
			setQueryStopFlag(FALSE); // nastavím tento příznak na nepravdu - nemám tedy zatím končit prohledávání
			#ifdef DEBUG_SET_QUERY
	   		 fprintf(stderr,"done");
			#endif

			/////////////// Odpoved //////////////

			if (above_result) { // na zacatek souboru se seznamem jmen souboru k prohledavani
				rewind (u_result_stored);
			}
			else {
				rewind (u_setfiles);
			}

			// strom dotazu do TVS
			if (! query_all_trees) {
				query_TVSList = treesToTVSList(GlobHlav -> Trees);
			}
			else {
				query_TVSList = NULL;
			}

			max_number_of_trees = user_account.max_number_of_trees; // maximalne tolik stromu smi prave prihlaseny uzivatel vyhledat jednim dotazem
			searching_break_type = END_OF_SEARCHING_NOT_YET; // signalizuje, proc bylo prohledavani ukonceno (v tomto pripade ze tedy dosud ukonceno nebylo)

			int matched; // pomocná
			// cyklus přes soubory určené k prohledání

			// následující 2 řádky mají význam při dotazu nad výsledkem minulého dotazu
			strcpy(minfcesta, ""); // vynuluji místo k uchování minulé cesty
			int prev_tree_number = -1; // zde si uchovám číslo minulého stromu
			int novy_soubor = TRUE; // zde zbytečné
			actualFileOfTrees = NULL;
			while (nextFileName(above_result, fcesta, &tree_number)) {
				if ((max_number_of_trees != 0) && (getNumberOfFoundOccurrences() >= max_number_of_trees)) { // uzivatel nalezl jiz maximalni povoleny pocet stromu pro jeden dotaz
					searching_break_type = END_OF_SEARCHING_MAX_NUMBER_REACHED;
					break; // konec prohledavani
				}
				if (getQueryStopFlag() == TRUE) { // uzivatel chce ukoncit prohledavani
					searching_break_type = END_OF_SEARCHING_USER_INTERRUPTION;
					break; // konec prohledavani
				}
				#ifdef DEBUG_SET_QUERY
					fprintf(stderr,"\nGoing to process the file %s and the tree %d.",fcesta,tree_number);
				#endif
				if (strcmp(minfcesta, fcesta)) { // pokud se liší minulý soubor od nového (v případě dotazu nad výsl. min. dotazu to nemusí nastat)
					#ifdef DEBUG_SET_QUERY
						fprintf(stderr,"\nGoing to read the file %s from the disk.",fcesta);
					#endif
					novy_soubor = TRUE;
					if (actualFileOfTrees) {
						//fprintf(stderr,"\nuvolnuji soubor");
						freeFile( actualFileOfTrees );
						//fprintf(stderr," - hotovo");
					}
					clearSpecialAttributesPositions(); // nastaví výchozí "nedefinované" pozice speciálních atributů hlavičky (N, V, W)
					actualFileOfTrees = readFile (fcesta); // z disku přečtu soubor k prohledání
					scanHead(actualFileOfTrees); // projdu hlavičku a zapamatuji si pozice význačných atributů (např. pro skryté vrcholy)
					// actualFileOfTrees je typu TFSFile
				}
				else { // zustava se u stejneho souboru
					#ifdef DEBUG_SET_QUERY
						fprintf(stderr,"\nThe file %s has already been read from the disk.",fcesta);
					#endif
					novy_soubor = FALSE;
					if (above_result && (prev_tree_number == tree_number)) { // jeden strom beru jen jednou
						#ifdef DEBUG_SET_QUERY
							fprintf(stderr,"\nOne tree is processed only once in case of the query above the result - skipping this tree.",fcesta);
						#endif
						continue; // takže jdu na další strom
					}
				}

				if (! actualFileOfTrees) { // nenacetl se
					#ifdef DEBUG_SET_QUERY
						fprintf(stderr,"\nThe file %s has not been read!",fcesta);
					#endif
					continue; // zotavuji se z chyby - pokracuji dalsim souborem
				}
				#ifdef DEBUG_SET_QUERY
					else { // nacetl se
						fprintf(stderr,"\nThe file %s has been read.",fcesta);
					}
				#endif

				prev_tree_number = tree_number; // uložím si číslo stromu

				if (novy_soubor) {
					strcpy (minfcesta, fcesta); // uschovam nove jmeno
					#ifdef DEBUG_SET_QUERY
						fprintf(stderr,"\nGoing to match global head and the loaded tree head.");
					#endif
					matchHeads(GlobHlav, actualFileOfTrees, zobrazeni_gh); // smatchovani glob. hlavicky (hlavicky dotazu) s hlavickou souboru; meta atributy se nesmatchovávájí

					// hlavicka
					delka_hlav = vypis_hlavicku (actualFileOfTrees, buff);
					buff [delka_hlav] = '\0';

					preved_hlav_na_poz (actualFileOfTrees); // prevede vsechny atributy na typ pozicni
				}

				if (above_result) { // dotaz nad výsledkem minulého dotazu
					int i;
					actual_tree = actualFileOfTrees -> Trees;
					for (i = 1; i < tree_number; i++) {
						actual_tree = actual_tree -> Next; // najdu správný strom
					}
					str = treeToTVS(actual_tree -> Root, NULL);	// strom do TVS
					preprocessTree(actual_tree, FALSE, FALSE, hidden_position, actualFileOfTrees->AHNum);

					matched = createMatchingListsTVSList (query_TVSList, str, zobrazeni_gh, GlobHlav -> AHNum, actual_logical_expression);  // match vrcholů
					if (matched) { // pokud se alespon jednou smatchoval každý vrchol, co musí
						findSubtreesTVSList(tree_number, str, query_TVSList, actual_logical_expression);
					}
					else { // nektere vrcholy se nesmatchovaly
						if (invert_match) { // pokud mame do vysledku davat prave nematchujici stromy
							writeResultToFile (tree_number, NULL, NULL, NULL, NULL); // zapisu vysledek do souboru
							changeNumberOfFoundOccurrences(1);
							changeNumberOfFoundTrees(1);
						}
					}
					changeNumberOfSearchedTrees(1); // prohledal jsem další strom

					deleteTVS(str);  // uklid
					freeTSezVrchs(query_TVSList); // vycistim dotaz pro prohledavani dalsiho stromu (smazu seznamy matchujicich vrcholu)

				}
				else { // dotaz nad všemi vybranými soubory

					tree_number = 0; // budu prohledávat od prvního stromu (číslovány od 1)

					// cyklus pres stromy
					for (actual_tree = actualFileOfTrees -> Trees; actual_tree != NULL; actual_tree = actual_tree -> Next) {
						if ((max_number_of_trees != 0) && (getNumberOfFoundOccurrences() >= max_number_of_trees)) { // uzivatel nalezl jiz maximalni povoleny pocet stromu pro jeden dotaz
							searching_break_type = END_OF_SEARCHING_MAX_NUMBER_REACHED;
							break; // konec prohledavani
						}
						if (getQueryStopFlag() == TRUE) { // uzivatel chce ukoncit prohledavani
							searching_break_type = END_OF_SEARCHING_USER_INTERRUPTION;
							break; // konec prohledavani
						}
						tree_number ++; // prohledávám další strom
						#ifdef DEBUG_SET_QUERY
							fprintf(stderr,"\nprohledávám strom č. %d",tree_number);
						#endif

						if (query_all_trees) { // dotaz prazdny = dotaz na vsechny stromy
							writeResultToFile (tree_number, NULL, NULL, NULL, NULL); // zapisu vysledek do souboru
							changeNumberOfFoundOccurrences(1);
							changeNumberOfFoundTrees(1);
							changeNumberOfSearchedTrees(1); // "prohledal" jsem další strom
						}
						else { // vyber stromu dle neprazdneho dotazu

							str = treeToTVS(actual_tree -> Root, NULL);	// strom do TVS
							preprocessTree(actual_tree, FALSE, FALSE, hidden_position, actualFileOfTrees->AHNum); // projdu strom a opatřím vrcholy informacemi o hloubce apod.

							matched = createMatchingListsTVSList (query_TVSList, str, zobrazeni_gh, GlobHlav -> AHNum, actual_logical_expression); // match vrcholů
							// v dot->match, resp. dot->dalsi->match atd., jsou seznamy vrcholu stromu matchujicich s prislusnym vrcholem dotazu
							if (matched) { // pokud se alespon jednou smatchoval kazdy vrchol dotazu, co musí
								findSubtreesTVSList(tree_number, str, query_TVSList, actual_logical_expression);
							}
							else { // nektere vrcholy se nesmatchovaly
								if (invert_match) { // pokud mame do vysledku davat prave nematchujici stromy
									writeResultToFile (tree_number, NULL, NULL, NULL, NULL); // zapisu vysledek do souboru
									changeNumberOfFoundOccurrences(1);
									changeNumberOfFoundTrees(1);
								}
							}
							changeNumberOfSearchedTrees(1); // prohledal jsem další strom
							deleteTVS(str);  // uklid
							freeTSezVrchs(query_TVSList); // vycistim dotaz pro prohledavani dalsiho stromu (smazu seznamy matchujicich vrcholu)
						}

					} // for cyklus pres stromy jednoho prohledavaneho souboru
				} // if (dotaz nad vysledkem) else ...

			} // while cyklus pres soubory

			deleteTVSList(query_TVSList);
			//fprintf(stderr,"\nnaposledy uvolnuji soubor");
			freeFile( actualFileOfTrees );
			//fprintf(stderr," - hotovo");

			//fprintf(stderr,"\nkonec dítěte");
			if (searching_break_type == END_OF_SEARCHING_NOT_YET) {
				//fprintf(stderr,"\nsetting end of searching type to END_OF_SEARCHING_NO_NEXT_TREE");
				searching_break_type = END_OF_SEARCHING_NO_NEXT_TREE;
			}
			fprintf(u_vysledek, "%c%c\n", END_OF_SEARCHING, searching_break_type);
			fflush(u_vysledek);

      #ifdef LOG_QUERY
          logStatistics(); // print statistics of searching to stderr for archivation
      #endif

			#ifdef DEBUG_SET_QUERY
			    fprintf(stderr,"\ndotser.c (child): Detaching from shared memory...");
			#endif
			detachControlSharedMemory();
			#ifdef DEBUG_SHARED_MEMORY
			    fprintf(stderr,"done");
			#endif
			// dite konci
			// pause();	// a ceka az bude zabito k smrti - to uz neni pravda
			#ifdef DEBUG_SIGNALS
				fprintf(stderr,"\ndotser.c (child): setQuery: Searching finished. Exiting.");
			#endif
			fclose(u_vysledek);
			exit(0);

		} // else (dite)
	}

} // setQuery

void answerGetTree(char *dst, int status, int pos=1) { // sestavi odpoved klientovi na dotaz getNextTree/getPreviousTree podle danych parametru
// volano z getNextTree a getPreviousTree
	char type;
	#ifdef DEBUG_ANSWER_GET_TREE
		fprintf(stderr,"\ndotser.c: answerGetTree: vstup do funkce se status = '%c'", status);
	#endif
  if (status == END_OF_SEARCHING) { // strom neni k dispozici, mozna uz skoncilo prohledavani
    #ifdef DEBUG_ANSWER_GET_TREE
      fprintf(stderr,"\ndotser.c: answerGetTree: testuji, zda je prohledavani ukonceno");
    #endif
    if (searchingFinished(u_vysledek, &type)) { // prohledavani uz skoncilo z duvodu type
      #ifdef DEBUG_ANSWER_GET_TREE
        fprintf(stderr," - je");
      #endif
      dst[1] = type;
      pos=2;
    }
    else { // prohledavani jeste neskoncilo, ale zatim neni k dispozici dalsi strom
      #ifdef DEBUG_ANSWER_GET_TREE
        fprintf(stderr," - neni");
      #endif
      status = ERROR;
      pos = 1;
    }
  }
  dst[0] = status; // ERROR, OK, END_OF_SEARCHING, FILE_BOUNDARY_REACHED
	if (status != OK && status != OK_PREV) { // v pripade OK jsou statistiky uz zapsany
    pos += writeStatisticsToChars(dst + pos);
  }
	dst[pos] = EOM;
	#ifdef DEBUG_ANSWER_GET_TREE
		fprintf(stderr,"\ndotser.c: answerGetTree: odpoved = '%c', number_of_actual_occurrence = %ld, number_of_actual_tree = %ld", dst[0], number_of_actual_occurrence, number_of_actual_tree);
	#endif
	return;
} // answerGetTree

int readFileNameAndTreeNumberSafely(char *file_name, int *tree_number, char *odp, int last_position_in_file, long int last_number_of_actual_occurrence, long int last_number_of_actual_tree) { // načte údaje o minulé odpovědi (jméno souboru, pořadí stromu)
// volano z getNextTree a getPreviousTree
  // v pripade neuspechu sestavi odpoved na getNextTree/getPreviousTree a vrati -1
  // v pripade uspechu vraci 0
  char dummy;
  int poz;
	poz = ftell (u_vysledek); // zapamatuji si aktuální pozici v souboru
  fread (& dummy, 1, 1, u_vysledek); // tim jsem se posunul za znacku
  if (! readOneRecord(u_vysledek, file_name, tree_number, buff_nodes)) {
    fseek (u_vysledek, last_position_in_file, SEEK_SET); // navrat na predchozi znacku
    number_of_actual_occurrence = last_number_of_actual_occurrence;
    number_of_actual_tree = last_number_of_actual_tree;
    answerGetTree(odp, END_OF_SEARCHING, 1); // sestav možný END_OF_SEARCHING odpoved, za uvodni znak dej statistiky
    #ifdef DEBUG_READ_FILE_NAME_AND_TREE_NUMBER_SAFELY
        fprintf(stderr,"\ndotser.c: readFileNameAndTreeNumberSafely: navrat na puvodni znacku");
    #endif
    return -1;
  }
	#ifdef DEBUG_READ_FILE_NAME_AND_TREE_NUMBER_SAFELY
			fprintf(stderr,"\ndotser.c: readFileNameAndTreeNumberSafely: file name is: %s, tree number is: %d", file_name, *tree_number);
	#endif
  fseek (u_vysledek, poz, SEEK_SET); // navrat na predchozi znacku
  return 0;
} // readFileNameAndTreeNumberSafely

int differentTrees (char *file_name1, char *file_name2, int tree_number1, int tree_number2) { // vrati 0, pokud jsou stromy totozne, jinak 1
// volano z getNextTree a getPreviousTree
  if (tree_number1 != tree_number2) return 1;
  if (strcmp(file_name1, file_name2) != 0) return 1;
  return 0;
} // differentTrees

void getNextTree(char *zpr, char *odp) { // zašle klientovi další nalezený strom
	long poz, poz1, pos;
	int tree_number; // poradi stromu v souboru
	int tree_number2; // poradi jineho stromu v souboru
	long int last_number_of_actual_occurrence; // kdyz se nepodari najit ci nacist dalsi strom, poradi aktualniho vysledku se vrati na puvodni hodnotu
	long int last_number_of_actual_tree; // kdyz se nepodari najit ci nacist dalsi strom, poradi aktualniho vysledku se vrati na puvodni hodnotu
	char zn[1]; // pro cteni znaku ze souboru

	#ifdef DEBUG_GET_NEXT_TREE
		fprintf(stderr,"\ndotser.c: getNextTree: žádost klienta o další strom typu: %c",zpr[1]);
	#endif
	
	last_number_of_actual_occurrence = number_of_actual_occurrence;
	last_number_of_actual_tree = number_of_actual_tree;
	number_of_actual_occurrence ++; // optimisticky zvýším pořadí právě zasílaného výskytu
	if (number_of_actual_tree == 0) number_of_actual_tree = 1; // a pokud začínáme, tak optimisticky nastavím pořadí stromu na 1

	if (! u_vysledek) { // neex. soubor s výsledky
		#ifdef DEBUG_GET_NEXT_TREE
			fprintf(stderr,"\ndotser.c: getNextTree: soubor s výsledky neexistuje");
		#endif
		number_of_actual_occurrence = last_number_of_actual_occurrence;
		number_of_actual_tree = last_number_of_actual_tree;
		answerGetTree(odp, ERROR, 1); // sestav ERROR odpoved, za uvodni znak dej statistiky
		return;
	}

	if (pozice_out) { // tzn. první přístup pro čtení do souboru výsledků
		#ifdef DEBUG_GET_NEXT_TREE
			fprintf(stderr,"\ndotser.c: getNextTree: první přístup do souboru s výsledky");
		#endif
		if (pos = nacti_vysl_strom (u_vysledek, odp + 1)) { // zaslání stromu
			#ifdef DEBUG_GET_NEXT_TREE
				fprintf(stderr,"\ndotser.c: getNextTree: zaslání prvního stromu s výsledky");
			#endif
			pozice_out = FALSE;
			answerGetTree(odp, OK, pos+1); // sestav OK odpoved, pred strom dej statistiky
			return;
		}
		else { // strom neni k dispozici
			#ifdef DEBUG_GET_NEXT_TREE
				fprintf(stderr,"\ndotser.c: getNextTree: strom není k dispozici");
			#endif
			number_of_actual_occurrence = last_number_of_actual_occurrence;
			number_of_actual_tree = last_number_of_actual_tree;
			answerGetTree(odp, END_OF_SEARCHING); // sestav odpoved s moznym koncem prohledavani, za status (a pripadne typ) dej statistiky
			return;
		}
	}

	if (zpr[1] == PREV_FIRST_OCCURRENCE) { // pokud hledám úplně první výskyt dotazu
		#ifdef DEBUG_GET_NEXT_TREE
			fprintf(stderr,"\ndotser.c: getNextTree: jdu na prvni vysledek na zacatku souboru");
		#endif
		fseek (u_vysledek, 0L, SEEK_SET);	// presunuti na zacatek souboru s vysledky
		// problem je, ze prvni strom muze byt z vysledku odstranen; v tom pripade musim hledat prvni neodstraneny strom
		zn[0] = 32;
		fread(zn, 1, 1, u_vysledek);
		#ifdef DEBUG_GET_NEXT_TREE
			fprintf(stderr,"\ndotser.c: getNextTree: na zacatku souboru je znak: '%c'", zn[0]);
		#endif
		fseek (u_vysledek, 0L, SEEK_SET); // obnoveni pozice v souboru

		if (zn[0] == RESULT_FILE_OCCURRENCES_DELIMITER) { // je tu platny vysledek
			#ifdef DEBUG_GET_NEXT_TREE
				fprintf(stderr,"\ndotser.c: getNextTree: ... tedy platny vysledek. Posilam ho.");
			#endif
			number_of_actual_occurrence=1;
			number_of_actual_tree=1;
			pos = nacti_vysl_strom (u_vysledek, odp + 1);
			answerGetTree(odp, OK, pos+1); // sestav OK odpoved, pred strom dej statistiky
			return;
		}
		else if (zn[0] == RESULT_FILE_OCCURRENCES_ERASER){ // vysledek byl odstranen
			#ifdef DEBUG_GET_NEXT_TREE
				fprintf(stderr,"\ndotser.c: getNextTree: ... tedy neplatny vysledek. Hledam dalsi platny vysledek.");
			#endif
			number_of_actual_occurrence=1;
			number_of_actual_tree=1;
			// a pokracuji dal ve funkci getNextTree, jaky bych hledal dalsi vyskyt dotazu
		}
		else { // neplatny format souboru s vysledky
			#ifdef DEBUG_GET_NEXT_TREE
				fprintf(stderr,"\ndotser.c: getNextTree: ... to je neplatny format souboru s vysledky. Posilam chybovou odpoved.");
			#endif
			answerGetTree(odp, ERROR, 1); // sestav ERROR odpoved, za uvodni znak dej statistiky
			return;
		}
	} // prev_first_occurrence
	
	if (zpr[1] == NEXT_OR_PREV_CONTEXT) { // pokud klient žádá o poslání kontextu - tj. následujícího stromu v souboru
    #ifdef DEBUG_GET_NEXT_TREE
        fprintf(stderr,"\ndotser.c: getNextTree: Žádost klienta o následující kontext; pořadí aktuálního stromu v aktuálním souboru je: %d", last_context_tree_number_in_file);
    #endif
		number_of_actual_occurrence = last_number_of_actual_occurrence; // zasláním kontextu se nemění číslo aktuálního výskytu/stromu
		number_of_actual_tree = last_number_of_actual_tree;
		// vezmu aktualni soubor, aktualni strom, posledni kontext (last_context_tree_number_in_file; pri pozadavku na vysledek dotazu se musi nastavovat posl. kontext na aktualni strom)
		// ze souboru poslu dalsi/predchozi strom, pokud tam je; kdyz tam nebude, poslu, ze tam neni (kontext jen v ramci souboru)
		last_context_tree_number_in_file ++; // zvýším číslo kontextového stromu v souboru
    	#ifdef DEBUG_GET_NEXT_TREE
   	    	fprintf(stderr,"\ndotser.c: getNextTree: budu číst %d. strom ze souboru %s.", last_context_tree_number_in_file, last_sent_tree_file_name);
   		#endif
		if (last_context_tree_number_in_file == last_sent_tree_number_in_file) { // vrátil jsem se postupným zobrazováním kontextů vpřed a vzad na původní výsledný strom
			pos = readTreeFromFile(odp+1, last_sent_tree_file_name, last_sent_tree_number_in_file, last_sent_tree_matching_nodes); // přečte daný strom ze souboru a zformuluje skutečnou odpoved
		}
		else { // posílám kontextový strom rozdílný od aktuálního výsledného stromu
			pos = readTreeFromFile(odp+1, last_sent_tree_file_name, last_context_tree_number_in_file, "0"); // přečte daný strom ze souboru a zformuluje skutečnou odpoved
		}
		if (pos < 0) {
	    	#ifdef DEBUG_GET_NEXT_TREE
    	    	fprintf(stderr,"\ndotser.c: getNextTree: pri cteni nasledujiciho kontextu se nepodarilo cist ze souboru; pravděpodobně strom s daným pořadím v souboru není, přesáhl jsem konec souboru");
    		#endif
			last_context_tree_number_in_file --; // snížím zpátky číslo kontextového stromu v souboru			
    		answerGetTree(odp, FILE_BOUNDARY_REACHED, 1); // sestav odpoved FILE_BOUNDARY_REACHED, za uvodni znak dej statistiky
			return;
		}
		*(odp+1+pos) = EOL;
		pos++;
		pos += writeCoreferences(odp+1+pos); // za strom zapíšu schémata koreferencí
    	answerGetTree(odp, OK, 1+pos); // sestav OK odpoved, pred strom dej statistiky		
		return;
	} // kontext	
	
	// uz byl drive precten nejaky strom, cili toto neni prvni pristup pro cteni do souboru vysledku
	poz = ftell (u_vysledek); // zapamatuji si aktuální pozici v souboru

	if (!hledej_znacku_dolu (u_vysledek, &poz1)) { // další značka nenalezena, tzn. další strom není k dispozici
		#ifdef DEBUG_GET_NEXT_TREE
			fprintf(stderr,"\ndotser.c: getNextTree: další značka nenalezena");
		#endif
		number_of_actual_occurrence = last_number_of_actual_occurrence;
		number_of_actual_tree = last_number_of_actual_tree;
		answerGetTree(odp, END_OF_SEARCHING); // sestav odpoved s moznym koncem prohledavani, za status (a pripadne typ) dej statistiky
		return;
	}

	// byla nalezena znacka na poz1 (ale jsem stale na puvodni pozici poz)
	if (zpr[1] == NEXT_OR_PREV_TREE) { // pokud hledám první výskyt dotazu v dalším stromě (ne tedy v tom samém); starší klienti na tomto místě posílají EOM, čili by to mělo být bez problémů
		#ifdef DEBUG_GET_NEXT_TREE
			fprintf(stderr,"\ndotser.c: getNextTree: další značka nalezena, bude se hledat další první výskyt ve stromě");
		#endif
		if (readFileNameAndTreeNumberSafely(buff2, &tree_number, odp, poz, last_number_of_actual_occurrence, last_number_of_actual_tree)) return; // načte údaje o minulé odpovědi (jméno souboru, pořadí stromu)
		while (TRUE) {
			fseek (u_vysledek, poz1, SEEK_SET);	// presunuti na znacku (prvni nalezeny dalsi vyskyt dotazu)
			#ifdef DEBUG_GET_NEXT_TREE
				fprintf(stderr,"\ndotser.c: getNextTree: presun na dalsi strom");
			#endif
			if (readFileNameAndTreeNumberSafely(buff3, &tree_number2, odp, poz, last_number_of_actual_occurrence, last_number_of_actual_tree)) return; // načte údaje o dalsi odpovědi (jméno souboru, pořadí stromu)
			if (differentTrees(buff2, buff3, tree_number, tree_number2)) { // pokud jsou odpovedi z ruznych stromu
				#ifdef DEBUG_GET_NEXT_TREE
					fprintf(stderr,"\ndotser.c: getNextTree: stromy jsou rozdilne");
				#endif
				number_of_actual_tree++;
				if (pos = nacti_vysl_strom (u_vysledek, odp + 1)) { // podarilo se nacist strom a sestavila se cast odpovedi
					answerGetTree(odp, OK, pos+1); // sestav OK odpoved, pred stromem uz jsou statistiky
					return;
				}
				else { // strom neni k dispozici - jak to, kdyz se nasla znacka?
					number_of_actual_occurrence = last_number_of_actual_occurrence;
					number_of_actual_tree = last_number_of_actual_tree;
					fseek (u_vysledek, poz, SEEK_SET); // navrat na puvodni znacku
					answerGetTree(odp, END_OF_SEARCHING); // sestav odpoved s moznym koncem prohledavani, za status (a pripadne typ) dej statistiky
					return;
				}
			}
			#ifdef DEBUG_GET_NEXT_TREE
				fprintf(stderr,"\ndotser.c: getNextTree: stromy jsou stejne, bude se hledat dalsi znacka");
			#endif
			// zkusi se najit dalsi vysledek
			if (!hledej_znacku_dolu (u_vysledek, &poz1)) { // další značka nenalezena, tzn. další strom není k dispozici
				number_of_actual_occurrence = last_number_of_actual_occurrence;
				number_of_actual_tree = last_number_of_actual_tree;
				answerGetTree(odp, END_OF_SEARCHING); // sestav odpoved s moznym koncem prohledavani, za status (a pripadne typ) dej statistiky
				return;
			}
			number_of_actual_occurrence ++;
		}
	} // next_or_prev_tree

	else if (zpr[1] == PREV_FIRST_OCCURRENCE) { // pokud hledám úplně první výskyt dotazu
		fseek (u_vysledek, poz1, SEEK_SET);	// presunuti na znacku (prvni nalezeny dalsi vyskyt dotazu)
		if (pos = nacti_vysl_strom (u_vysledek, odp + 1)) { // podarilo se nacist strom a sestavila se cast odpovedi
			answerGetTree(odp, OK, pos+1); // sestav OK odpoved, pred stromem uz jsou statistiky
		}
		else { // strom neni k dispozici - jak to, kdyz se nasla znacka?
			number_of_actual_occurrence = last_number_of_actual_occurrence;
			number_of_actual_tree = last_number_of_actual_tree;
			fseek (u_vysledek, poz, SEEK_SET); // navrat na predchozi znacku
			answerGetTree(odp, END_OF_SEARCHING); // sestav odpoved s moznym koncem prohledavani, za status (a pripadne typ) dej statistiky
		}
		return;
	} // prev_first_occurrence
	
	else { // chci hned prvni dalsi nalezeny vyskyt dotazu (nic nepreskakuju)
		#ifdef DEBUG_GET_NEXT_TREE
			fprintf(stderr,"\ndotser.c: getNextTree: další značka nalezena; pokud není koncová, pošle se hned tento další výskyt");
		#endif
		if (readFileNameAndTreeNumberSafely(buff2, &tree_number, odp, poz, last_number_of_actual_occurrence, last_number_of_actual_tree)) return; // načte údaje o minulé odpovědi (jméno souboru, pořadí stromu)
		fseek (u_vysledek, poz1, SEEK_SET);	// presunuti na znacku (prvni nalezeny dalsi vyskyt dotazu)
		if (readFileNameAndTreeNumberSafely(buff3, &tree_number2, odp, poz, last_number_of_actual_occurrence, last_number_of_actual_tree)) return; // načte údaje o ???minulé odpovědi (jméno souboru, pořadí stromu)
		if (differentTrees(buff2, buff3, tree_number, tree_number2)) { // pokud jsou odpovedi z ruznych stromu
			#ifdef DEBUG_GET_NEXT_TREE
				fprintf(stderr,"\ndotser.c: getNextTree: stromy jsou rozdilne");
			#endif
			number_of_actual_tree++;
		}

		if (pos = nacti_vysl_strom (u_vysledek, odp + 1)) { // podarilo se nacist strom a sestavila se cast odpovedi
			answerGetTree(odp, OK, pos+1); // sestav OK odpoved, pred stromem uz jsou statistiky
			return;
		}
		else { // strom neni k dispozici - jak to, kdyz se nasla znacka?
			number_of_actual_occurrence = last_number_of_actual_occurrence;
			number_of_actual_tree = last_number_of_actual_tree;
			fseek (u_vysledek, poz, SEEK_SET); // navrat na predchozi znacku
			answerGetTree(odp, END_OF_SEARCHING); // sestav odpoved s moznym koncem prohledavani, za status (a pripadne typ) dej statistiky
			return;
		}
	} // next_or_prev_occurrence

} // getNextTree

int noPreviousValidOccurrenceInResultFile() {
// returns TRUE if there is no previous non-removed occurrence in the result file
// otherwise returns FALSE
	long pos_orig, pos_found;
	pos_orig = ftell (u_vysledek); // zapamatuji si aktuální pozici v souboru
	if (!pos_orig) { // zacatek souboru - nelze jit nahoru
		return TRUE;
	}
	if (!hledej_znacku_nahoru (u_vysledek, &pos_found)) { // nenašla se předchozí odpověď
		fseek (u_vysledek, pos_orig, SEEK_SET);	// přesunutí na původní místo
		return TRUE;
	}
	fseek (u_vysledek, pos_orig, SEEK_SET);	// přesunutí na původní místo
	return FALSE;
}

void getPreviousTree(char *zpr, char *odp) { // zašle klientovi předchozí nalezený strom
	long poz, poz1, poz2, pos;
	int tree_number; // poradi stromu v souboru
  int tree_number2; // poradi jineho stromu v souboru
	#ifdef DEBUG_GET_PREVIOUS_TREE
			fprintf(stderr,"\ndotser.c: getPreviousTree: žádost klienta o předchozí strom typu: %c",zpr[1]);
	#endif

  long int last_number_of_actual_occurrence; // kdyz se nepodari najit ci nacist pozadovany strom, poradi aktualniho vysledku se vrati na puvodni hodnotu
  long int last_number_of_actual_tree; // kdyz se nepodari najit ci nacist dalsi strom, poradi aktualniho vysledku se vrati na puvodni hodnotu

  last_number_of_actual_occurrence = number_of_actual_occurrence;
  last_number_of_actual_tree = number_of_actual_tree;

	//fprintf(stderr,"\ndotser.c: getPreviousTree: Entering the function.");
	if (! u_vysledek) { // neex. vysledek
    #ifdef DEBUG_GET_PREVIOUS_TREE
        fprintf(stderr,"\ndotser.c: getPreviousTree: soubor s výsledky neexistuje");
    #endif
    answerGetTree(odp, ERROR, 1); // sestav ERROR odpoved, za uvodni znak dej statistiky
    return;
	}

	if (zpr[1] == NEXT_OR_PREV_CONTEXT) { // pokud klient žádá o poslání kontextu - tj. předchozího stromu v souboru
    #ifdef DEBUG_GET_PREVIOUS_TREE
        fprintf(stderr,"\ndotser.c: getPreviousTree: Žádost klienta o předchozí kontext; pořadí aktuálního stromu v aktuálním souboru je: %d", last_context_tree_number_in_file);
    #endif
		// vezmu aktualni soubor, aktualni strom, posledni kontext (last_context_tree_number_in_file; pri pozadavku na vysledek dotazu se musi nastavovat posl. kontext na aktualni strom)
		// ze souboru poslu dalsi/predchozi strom, pokud tam je; kdyz tam nebude, poslu, ze tam neni (kontext jen v ramci souboru)
		if (last_context_tree_number_in_file == 1) { // jsem na začátku souboru, není žádný předchozí kontext
	    	#ifdef DEBUG_GET_PREVIOUS_TREE
    	    	fprintf(stderr,"\ndotser.c: getPreviousTree: jsem jiz na zacatku souboru - neni zadny predchozi kontext.");
    		#endif
    		answerGetTree(odp, FILE_BOUNDARY_REACHED, 1); // sestav odpoved FILE_BOUNDARY_REACHED, za uvodni znak dej statistiky
			return;
		}
		last_context_tree_number_in_file --; // snížím číslo kontextového stromu v souboru
    	#ifdef DEBUG_GET_PREVIOUS_TREE
   	    	fprintf(stderr,"\ndotser.c: getPreviousTree: budu číst %d. strom ze souboru %s.", last_context_tree_number_in_file, last_sent_tree_file_name);
   		#endif
		if (last_context_tree_number_in_file == last_sent_tree_number_in_file) { // vrátil jsem se postupným zobrazováním kontextů vpřed a vzad na původní výsledný strom
			pos = readTreeFromFile(odp+1, last_sent_tree_file_name, last_sent_tree_number_in_file, last_sent_tree_matching_nodes); // přečte daný strom ze souboru a zformuluje skutečnou odpoved
		}
		else { // posílám kontextový strom rozdílný od aktuálního výsledného stromu
			pos = readTreeFromFile(odp+1, last_sent_tree_file_name, last_context_tree_number_in_file, "0"); // přečte daný strom ze souboru a zformuluje skutečnou odpoved
		}
		if (pos < 0) {
	    	#ifdef DEBUG_GET_PREVIOUS_TREE
    	    	fprintf(stderr,"\ndotser.c: getPreviousTree: pri cteni predchoziho kontextu se nepodarilo cist ze souboru.");
    		#endif
    		answerGetTree(odp, ERROR, 1); // sestav ERROR odpoved, za uvodni znak dej statistiky
			return;
		}
		*(odp+1+pos) = EOL;
		pos++;
		pos += writeCoreferences(odp+1+pos); // za strom zapíšu schémata koreferencí
    	answerGetTree(odp, OK, 1+pos); // sestav OK odpoved, pred strom dej statistiky		
		return;
	} // kontext	
	
	if (! ftell (u_vysledek)) { // zacatek souboru - nelze jit nahoru
    #ifdef DEBUG_GET_PREVIOUS_TREE
        fprintf(stderr,"\ndotser.c: getPreviousTree: jsem jiz na zacatku souboru s vysledky");
    #endif
    answerGetTree(odp, ERROR, 1); // sestav ERROR odpoved, za uvodni znak dej statistiky
		return;
	}

	poz = ftell (u_vysledek); // zapamatuji si aktuální pozici v souboru

	//fprintf(stderr,"dotser.c: getPreviousTree: Going to search for a previous mark");
	if (!hledej_znacku_nahoru (u_vysledek, &poz1)) { // hledá se předchozí odpověď; podmínka by neměla být nikdy splněna, ale pro jistotu:
    answerGetTree(odp, ERROR, 1); // sestav ERROR odpoved, za uvodni znak dej statistiky
		return;
	}

  if (zpr[1] == NEXT_OR_PREV_TREE) { // pokud hledám předchozí první výskyt dotazu ve stromě (ne jiný než první výskyt v tom kterém stromě); starší klienti na tomto místě posílají EOM, čili by to mělo být bez problémů
    #ifdef DEBUG_GET_PREVIOUS_TREE
        fprintf(stderr,"\ndotser.c: getPreviousTree: hleda se predchozi prvni vyskyt ve strome");
    #endif
    if (readFileNameAndTreeNumberSafely(buff3, &tree_number2, odp, poz, last_number_of_actual_occurrence, last_number_of_actual_tree)) return; // načte údaje o minulé odpovědi (jméno souboru, pořadí stromu)
    fseek (u_vysledek, poz1, SEEK_SET);	// presunuti na znacku (prvni predchozi vyskyt dotazu)
    number_of_actual_occurrence--;
    if (readFileNameAndTreeNumberSafely(buff2, &tree_number, odp, poz, last_number_of_actual_occurrence, last_number_of_actual_tree)) return; // načte údaje o té odpovědi (jméno souboru, pořadí stromu); při neúspěchu sestaví odpověď ERROR
    if (differentTrees(buff2, buff3, tree_number, tree_number2)) { // pokud jsou odpovedi z ruznych stromu
      number_of_actual_tree--; // přešel jsem hranici stromů
    }
    while (TRUE) { // hledam hranici odpovedi z ruznych stromu, chci jen prvni odpoved ze stromu
      if (noPreviousValidOccurrenceInResultFile()) { // v souboru výsledků není žádný předchozí nesmazaný výskyt
        if (pos = nacti_vysl_strom (u_vysledek, odp + 1)) { // podarilo se nacist prvni strom a sestavila se cast odpovedi
          answerGetTree(odp, OK, pos+1); // sestav OK odpoved, pred stromem uz jsou statistiky
          return;
        }
      }
      if (!hledej_znacku_nahoru (u_vysledek, &poz2)) { // hledá se předchozí odpověď; podmínka by neměla být nikdy splněna, ale pro jistotu:
        answerGetTree(odp, ERROR, 1); // sestav ERROR odpoved, za uvodni znak dej statistiky
        return;
      }
      fseek (u_vysledek, poz2, SEEK_SET);	// presunuti na znacku (prvni predchozi vyskyt dotazu)
      if (readFileNameAndTreeNumberSafely(buff3, &tree_number2, odp, poz, last_number_of_actual_occurrence, last_number_of_actual_tree)) return; // načte údaje o předchozí odpovědi (jméno souboru, pořadí stromu)
      if (differentTrees(buff2, buff3, tree_number, tree_number2)) { // pokud jsou odpovedi z ruznych stromu
        fseek (u_vysledek, poz1, SEEK_SET);	// presunuti na znacku dalsi odpovedi - prvni v dalsim strome
        if (pos = nacti_vysl_strom (u_vysledek, odp + 1)) { // podarilo se nacist strom a sestavila se cast odpovedi
          answerGetTree(odp, OK, pos+1); // sestav OK odpoved, pred stromem uz jsou statistiky
          return;
        }
        else { // strom neni k dispozici - jak to, kdyz se nasla znacka?
          answerGetTree(odp, ERROR, 1); // sestav ERROR odpoved, za uvodni znak dej statistiky
          return;
        }
      }
      poz1=poz2; // odpovědi byly ze stejného stromu; kandidátem na první odpověď ve stromě se teď stává poz2
      number_of_actual_occurrence--;
    } // sem to nikdy nedojde zevnitr (protoze je tam while(TRUE))
  } // a sem tedy take ne

  // hleda se primo predchozi vyskyt dotazu; to misto uz je nalezeno v poz1, ale ja jsem stale na puvodni pozici poz
  if (readFileNameAndTreeNumberSafely(buff3, &tree_number2, odp, poz, last_number_of_actual_occurrence, last_number_of_actual_tree)) return; // načte údaje o minulé odpovědi (jméno souboru, pořadí stromu)
  fseek (u_vysledek, poz1, SEEK_SET);	// presunuti na znacku (prvni predchozi vyskyt dotazu)
  number_of_actual_occurrence--;
  if (readFileNameAndTreeNumberSafely(buff2, &tree_number, odp, poz, last_number_of_actual_occurrence, last_number_of_actual_tree)) return; // načte údaje o té odpovědi (jméno souboru, pořadí stromu); při neúspěchu sestaví odpověď ERROR
  if (differentTrees(buff2, buff3, tree_number, tree_number2)) { // pokud jsou odpovedi z ruznych stromu
    number_of_actual_tree--; // přešel jsem hranici stromů
  }
  pos = nacti_vysl_strom (u_vysledek, odp + 1);
  answerGetTree(odp, OK, pos+1); // sestav OK odpoved, pred stromem uz jsou statistiky
  return;
} // getPreviousTree


void removeOccurrence(char *zpr, char *odp) { // smaže aktuální výskyt dotazu a pošle klientovi další nalezený výskyt dotazu, pokud je k dispozici
	long pos, poz, poz1, poz3;
	int tree_number_1; // poradi predchoziho stromu v jeho zdrojovem souboru
	int tree_number_2; // poradi aktualniho stromu v jeho zdrojovem souboru
	int tree_number_3; // poradi nasledujiciho stromu v jeho zdrojovem souboru
	char type;
	
	#ifdef DEBUG_REMOVE_OCCURRENCE
		fprintf(stderr,"\ndotser.c: removeOccurrence: žádost klienta o vymazání aktuálního výskytu dotazu");
	#endif

	if (number_of_actual_occurrence == 0) { // už byly dříve vymazány všechny výskyty dotazu ve výsledku
		#ifdef DEBUG_REMOVE_OCCURRENCE
			fprintf(stderr,"\ndotser.c: removeOccurrence: všechny výsledky už vymazány");
		#endif
		answerGetTree(odp, ERROR, 1); // sestav ERROR odpoved, za uvodni znak dej statistiky
		return;
	}
	
	if (! u_vysledek) { // neex. soubor s výsledky
		#ifdef DEBUG_REMOVE_OCCURRENCE
			fprintf(stderr,"\ndotser.c: removeOccurrence: soubor s výsledky neexistuje");
		#endif
		answerGetTree(odp, ERROR, 1); // sestav ERROR odpoved, za uvodni znak dej statistiky
		return;
	}

	if (pozice_out) { // tzn. první přístup pro čtení do souboru výsledků
		#ifdef DEBUG_REMOVE_OCCURRENCE
			fprintf(stderr,"\ndotser.c: removeOccurrence: první přístup do souboru s výsledky");
		#endif
		answerGetTree(odp, ERROR, 1); // sestav ERROR odpoved, za uvodni znak dej statistiky
		return;
	}
	
	// uz byl drive precten nejaky strom, cili toto neni prvni pristup pro cteni do souboru vysledku
	// aktualni pozici v souboru oznacim jako smazanou
    #ifdef DEBUG_REMOVE_OCCURRENCE
        fprintf(stderr,"\ndotser.c: removeOccurrence: mažu aktuální výskyt dotazu (přepisem oddělovače záznamů ve výsledném souboru).");
    #endif
	fprintf(u_vysledek, "%c", RESULT_FILE_OCCURRENCES_ERASER); // nahradím oddělovač záznamů (RESULT_FILE_OCCURRENCES_DELIMITER) tímto znakem a tak zneviditelním tento výskyt
	number_of_removed_occurrences ++;

	poz = ftell (u_vysledek); // zapamatuji si aktuální pozici v souboru

	// nyni se podivam na soubor a cislo predchoziho vysledku
	if (!hledej_znacku_nahoru (u_vysledek, &poz1)) { // hledá se předchozí odpověď; pokud se nenajde, jsem na prvním neodstraněném výsledku v souboru
		tree_number_1 = -1; // předchozí výsledek neexistuje, tedy nemá žádné pořadí ve svém zdrojovém souboru
		strcpy(buff2,"nofile");
	}
	else { // předchozí platný výsledek se našel
		fseek (u_vysledek, poz1, SEEK_SET);	// presunuti na znacku (prvni nalezeny predchozi vyskyt dotazu)
		if (readFileNameAndTreeNumberSafely(buff2, &tree_number_1, odp, poz1, number_of_actual_occurrence, number_of_actual_tree)) { // načte údaje o minulé odpovědi (jméno souboru, pořadí stromu)
			tree_number_1 = -1; // předchozí výsledek nejde přečíst, tedy nemá žádné pořadí ve svém zdrojovém souboru
			strcpy(buff2,"nofile");
		}
	}
    #ifdef DEBUG_REMOVE_OCCURRENCE
        fprintf(stderr,"\ndotser.c: removeOccurrence: předchozí výsledek má pořadí %d v souboru %s.",tree_number_1,buff2);
    #endif

	fseek (u_vysledek, poz, SEEK_SET); // navrat na puvodni znacku (mimochodem, nyni jiz zmenenou na ..._ERASER)

	// nyni se podivam na soubor a cislo aktualniho vysledku
	if (readFileNameAndTreeNumberSafely(buff3, &tree_number_2, odp, poz, number_of_actual_occurrence, number_of_actual_tree)) { // načte údaje o aktuální (právě smazané) odpovědi (jméno souboru, pořadí stromu)
		tree_number_2 = -1; // aktuální výsledek nejde přečíst, tedy nemá žádné pořadí ve svém zdrojovém souboru
		strcpy(buff3,"nofile");
	}
    #ifdef DEBUG_REMOVE_OCCURRENCE
        fprintf(stderr,"\ndotser.c: removeOccurrence: aktuální (smazaný) výsledek má pořadí %d v souboru %s.",tree_number_2,buff3);
    #endif

	fseek (u_vysledek, poz, SEEK_SET); // opet navrat (tady zbytecny) na puvodni znacku
	
	// nyni se podivam na soubor a cislo nasledujiciho vysledku		
	if (!hledej_znacku_dolu (u_vysledek, &poz3)) { // další značka nenalezena, tzn. další strom není k dispozici
		tree_number_3 = -1; // následující výsledek neexistuje, tedy nemá žádné pořadí ve svém zdrojovém souboru
		strcpy(buff4,"nofile");
		// !!! tady je místo potencionálního problému, kdyby vyhledávací proces zrovna ted někdy zapisoval první další výsledek; naštěstí je to velmi nepravděpodobné
	}
	else { // následující značka, snad platný výsledek, se našla
		fseek (u_vysledek, poz3, SEEK_SET);	// presunuti na znacku (prvni nalezeny dalsi vyskyt dotazu)
		if (readFileNameAndTreeNumberSafely(buff4, &tree_number_3, odp, poz3, number_of_actual_occurrence, number_of_actual_tree)) { // načte údaje o následující odpovědi (jméno souboru, pořadí stromu)
			tree_number_3 = -1; // následující výsledek nejde přečíst, tedy nemá žádné pořadí ve svém zdrojovém souboru
			strcpy(buff4,"nofile");
		}
	}
    #ifdef DEBUG_REMOVE_OCCURRENCE
        fprintf(stderr,"\ndotser.c: removeOccurrence: následující výsledek má pořadí %d v souboru %s.",tree_number_3,buff4);
    #endif

	// nyní mám v proměnných buff2, buff3 a buff4 jména souborů, ze kterých jsou tři po sobě následující výsledky (buff2 a buff4 obsahují "noname", pokud se nenašly)
	// a v proměnných tree_number_1, tree_number_2 a tree_number_3 pořadí oněch tří stromů v jejich zdrojových souborech (..._1 a ..._3 obsahují -1, pokud se nenašly)
	// podle toho je můžu porovnat

	if (differentTrees(buff3, buff4, tree_number_2, tree_number_3)) { // stromy 2 a 3 rozdílné
		if (differentTrees(buff2, buff3, tree_number_1, tree_number_2)) { // stromy 1, 2 a 3 všechny rozdílné
			number_of_removed_trees ++;
		}
		else { // stromy 1 a 2 stejné, 3 odlišný
			if (tree_number_3 != -1) { // a strom 3 opravdu existuje
				number_of_actual_tree ++;
			}
		}
	}

	// ted musím klientovi poslat nějaký strom; pokud se našel další strom, pošlu ten; pokud ne a hledá se, pošlu at čeká; pokud
	// se už ani nehledá, pošlu předchozí strom; pokud není ani předchozí, pošlu jen zprávu
	if (tree_number_3 == -1) { // další strom není k dispozici
		#ifdef DEBUG_REMOVE_OCCURRENCE
			fprintf(stderr,"\ndotser.c: removeOccurrence: následující výsledek tedy není k dispozici");
		#endif
		if (searchingFinished(u_vysledek, &type)) { // pokud už prohledávání skončilo
			#ifdef DEBUG_REMOVE_OCCURRENCE
				fprintf(stderr,"\ndotser.c: removeOccurrence: a prohledávání už skončilo");
			#endif
			// vrátím předchozí strom, pokud je k dispozici
			if (tree_number_1 == -1) { // ale ani předchozí strom není k dispozici, tzn. všechny výsledky byly vymazány
				#ifdef DEBUG_REMOVE_OCCURRENCE
					fprintf(stderr,"\ndotser.c: removeOccurrence: všechny výsledky byly vymazány");
				#endif
				number_of_actual_occurrence=0;
				number_of_actual_tree=0;
				fseek (u_vysledek, poz, SEEK_SET); // navrat na puvodni znacku
				answerGetTree(odp, END_OF_SEARCHING); // sestav odpoved s moznym koncem prohledavani, za status (a pripadne typ) dej statistiky
				return;
			}
			else { // předchozí strom je k dispozici
				#ifdef DEBUG_REMOVE_OCCURRENCE
					fprintf(stderr,"\ndotser.c: removeOccurrence: vrátím tedy předchozí strom");
				#endif
				fseek (u_vysledek, poz1, SEEK_SET);	// presunuti na predchozi nalezeny vyskyt
				number_of_actual_occurrence --; // vracím se o výskyt zpátky
				if (differentTrees(buff2, buff3, tree_number_1, tree_number_2)) { // stromy 1 a 2 rozdílné
					number_of_actual_tree --; // vracím se dokonce o strom zpátky
				}
				if (pos = nacti_vysl_strom (u_vysledek, odp + 1)) { // podarilo se nacist strom a sestavila se cast odpovedi
					answerGetTree(odp, OK_PREV, pos+1); // sestav OK odpoved, pred stromem uz jsou statistiky
					return;
				}
				else { // strom neni k dispozici - jak to, kdyz se nasla znacka?
					// ??? co tady?
					fseek (u_vysledek, poz, SEEK_SET); // navrat na puvodni znacku
					answerGetTree(odp, END_OF_SEARCHING); // sestav odpoved s moznym koncem prohledavani, za status (a pripadne typ) dej statistiky
					#ifdef DEBUG_REMOVE_OCCURRENCE
						fprintf(stderr,"\ndotser.c: removeOccurrence: další strom se nepodařilo přečíst!");
					#endif
					answerGetTree(odp, END_OF_SEARCHING); // sestav odpoved s moznym koncem prohledavani, za status (a pripadne typ) dej statistiky
					return;
				}
			}
		}
		else { // vyhledávání ještě neskončilo
			#ifdef DEBUG_REMOVE_OCCURRENCE
				fprintf(stderr,"\ndotser.c: removeOccurrence: prohledávání však ještě neskončilo");
			#endif
			answerGetTree(odp, END_OF_SEARCHING); // sestav odpoved s moznym koncem prohledavani, za status (a pripadne typ) dej statistiky
			return;
		}
	}

	fseek (u_vysledek, poz3, SEEK_SET); // prechod na znacku nasledujiciho vyskytu

    if (pos = nacti_vysl_strom (u_vysledek, odp + 1)) { // podarilo se nacist strom a sestavila se cast odpovedi
      answerGetTree(odp, OK, pos+1); // sestav OK odpoved, pred stromem uz jsou statistiky
      return;
    }
    else { // strom neni k dispozici - jak to, kdyz se nasla znacka?
      fseek (u_vysledek, poz, SEEK_SET); // navrat na predchozi znacku
      answerGetTree(odp, END_OF_SEARCHING); // sestav odpoved s moznym koncem prohledavani, za status (a pripadne typ) dej statistiky
      return;
    }
	
} // removeOccurrence


int readLine(char *dst, const char *src, const char delimiter, int max_length) {
	char c;
	int pos = 0;
	while (((c = *(src + pos)) != delimiter) && ((*(src + pos)) != EOM)) {
		*(dst + pos) = c;
		pos ++;
		if (pos >= max_length) break;
	}
	*(dst + pos) = '\0';
	return pos;
} // readLine

void loginAuthentize(char *zpr, char *odp) { // zašle klientovi odpověď na authentizační žádost
	int r,pos;

	char login_name[LOGIN_NAME_MAX_LENGTH+1];
	char password[ENCODED_PASSWORD_MAX_LENGTH+1];

	// ted je potreba obsadit ty promenne
	pos = readLine(login_name, zpr, EOL, LOGIN_NAME_MAX_LENGTH);
	pos++; // EOL
	//fprintf(stderr,"\nlogin name = %s", login_name);
	pos += readLine(password, zpr + pos, EOL, ENCODED_PASSWORD_MAX_LENGTH);
	//fprintf(stderr,"\nencrypted password = %s", password);

	r = authentizeUser(login_name, password, &user_account);
	if (r != ERROR_OK) {
		fprintf(stderr,"\nError #%d appeared during login of user %s",r,login_name);
		odp[0] = ERROR;
		odp[1] = r;
		odp[2] = EOM;
		return;
	}

	fprintf(stderr,"\n(User %s has logged in)",login_name);
	odp[0] = OK;
	r = writeAuthorizationToChars(odp + 1, &user_account);
	odp [1 + r] = EOM;
	return;
} // loginAuthentize


void loginChangePassword(char *zpr, char *odp) { // pokusí se změnit heslo podle požadavku klienta
	int r,pos;

	char login_name[LOGIN_NAME_MAX_LENGTH+1];
	char old_password[ENCODED_PASSWORD_MAX_LENGTH+1];
	char new_password[ENCODED_PASSWORD_MAX_LENGTH+1];

	pos = readLine(login_name, zpr, EOL, LOGIN_NAME_MAX_LENGTH);
	pos++; // EOL
	pos += readLine(old_password, zpr + pos, EOL, ENCODED_PASSWORD_MAX_LENGTH);
	pos++; // EOL
	pos += readLine(new_password, zpr + pos, EOL, ENCODED_PASSWORD_MAX_LENGTH);

	//fprintf(stderr,"\nzměna hesla: login name = %s, dosavadní heslo = %s, nové heslo = %s.",login_name,old_password,new_password);

	// ted je potreba obsadit ty promenne - v zpr jsou pozadovane udaje kazdy na novem radku

	r = changePassword(login_name, old_password, new_password);

	//fprintf(stderr,"\nzměna hesla: návratová hodnota = %d.",r);

	if (r != ERROR_OK) {
		odp[0] = ERROR;
		odp[1] = r;
		odp[2] = EOM;
		return;
	}
	odp[0] = OK;
	odp[1] = EOM;
	return;
} // loginChangePassword


////////////////////// Reseni zprav ///////////////////////

int reseni (char * zpr, char * odp) {
// resi zpravu zpr ukoncenou EOM
// odpovida do odp ( ukoncuje s EOM )
// vrací FALSE v případě, že přišla zpráva ukončení spojení, jinak vždy TRUE

	static int nova_cesta_adr = TRUE;  // Pri prvnim volani je urcena nova cesta vzhledem k vypisu adresaru
	static int nova_cesta_sbr = TRUE;  // resp. k vypisu souboru

	switch (zpr[0]) { // zpracuje se podle identifikacniho znaku zpravy


		case GETVERSION: // Get Version (of the server or required (at least) version of client)
			getVersion(zpr,odp);
		break;


		case GET_INIT_INFO: // Get Initial Informations At Once (since version 1.3)
			getInitInfo(zpr,odp);
		break; // GET_INIT_INFO


		case PWD: // Print Working Directory
			getActualDirectory(zpr,odp);
		break; // PWD


		case CD: // Change Directory
			if (! changeDirectory(zpr,odp)) { // pokud změna adresáře proběhne v pořádku
				nova_cesta_adr = TRUE;  // zmenila se cesta
				nova_cesta_sbr = TRUE;
			}
		break; // Change Directory


		case GETDIRS: // Get Directories (vrati seznam podadresaru v aktualni ceste)
			if (! getSubdirectories(zpr,odp,nova_cesta_adr)) { // jestliže zaslání (a tedy případné zjištění) podadresářů proběhlo v pořádku
				nova_cesta_adr = false;
			}
		break; // Get Directories


		case GETFILES: // Get Files (vrati seznam souboru v aktualni ceste)
			if (! getFiles(zpr,odp,nova_cesta_sbr)) { // jestliže zaslání (a tedy případné zjištění) souborů v adresáři proběhlo v pořádku
				nova_cesta_sbr = false;
			}
		break; // Get Files


		/*case TEST: // test spojení
			getTest(zpr, odp);
		break;*/


		case SETFILES: // Set Files to query
			setFiles(zpr,odp);
		break; // Set Files


		case QUERY: // zadani vyhledavani stromu
			setQuery(zpr,odp);
		break; // QUERY


		case STOP: // zastavi probihajici prohledavani
			explicitStopQuery(zpr, odp);
		break; // STOP


		case GET_STATISTICS: // vrátí klientovi statistiky o dosavadním prohledávání tímto dotazem
			getStatistics(odp);
		break;


		case GETN:
			getNextTree(zpr,odp);
		break;


		case GETP:
			getPreviousTree(zpr,odp);
		break;

		case REMOVE_OCCURRENCE:
			removeOccurrence(zpr,odp);
		break;
		
		case LOGIN:
			switch (zpr[1]) { // zpracuje se podle dalšího identifikátoru zprávy
				case LOGIN_AUTHENTIZE:
					loginAuthentize(zpr+2,odp);
				break;
				case LOGIN_CHANGE_PASSWORD:
					loginChangePassword(zpr+2,odp);
				break;
				default:
					odp[0] = UNKNOWN; // neznamy druh zpravy
					odp[1] = EOM;
				break;
			}
		break;

		case CLIENT_EXITED: // klient ukončil spojení
			#ifdef DEBUG_SIGNALS
				fprintf(stderr,"\ndotser.c (parent): reseni: The client has ended the connection.");
			#endif
			if (bezi_dotaz) { // ukonceni dotazu
				signal(SIGCHLD, SIG_IGN);
				#ifdef DEBUG_SIGNALS
					fprintf(stderr,"\ndotser.c (parent): reseni: Killing the process dotser (child).");
				#endif
				kill (childpid, SIGKILL);
				bezi_dotaz = FALSE;
			}
			#ifdef DEBUG_CONTROL_SHARED_MEMORY
				fprintf(stderr,"\ndotser.c (parent before exit): Detaching and destroying shared memory for statistics if any exists...");
			#endif
#ifdef LINUX_VERSION
			if (control_shared_memory_id != -1) { // z minulého vyhledávání zůstala sdílená paměť
				#ifdef DEBUG_CONTROL_SHARED_MEMORY
					fprintf(stderr,"\ndotser.c (parent before exit): Yes it exists...");
				#endif
				detachControlSharedMemory();
				destroyControlSharedMemory();
				#ifdef DEBUG_CONTROL_SHARED_MEMORY
					fprintf(stderr,"done");
				#endif
			}
			#ifdef DEBUG_CONTROL_SHARED_MEMORY
				else {
					fprintf(stderr,"it does not exist.");
				}
			#endif
#endif
			return FALSE; // končíme cyklus čekání na zprávy od klienta
		break; // CLIENT_EXITED



		default:
				odp[0] = UNKNOWN; // neznamy druh zpravy
				odp[1] = EOM;
		break;

	} // konec switch

	return TRUE; // pokračujeme čekáním na další zprávu od klienta
} // reseni



// --------------------------------------------
// -----------------MAIN-------------------

main (int argc, char * argv[]) { // main funkce Dotser

	#ifdef DEBUG_START_DOTSER
		fprintf( stderr,"\ndotser.c (parent): The process dotser (parent) has started." );
	//	fprintf( stderr,"\n%s %s %s", argv[0], argv[1], argv[2] );
	#endif

	/*strcpy (rour1, argv[1]); // glob. kopie nazvu FIFO
	strcpy (rour2, argv[2]);

	if ((readfd = open (argv[1], 0)) < 0) {
		err_dump ("\ndotser.c: main: fatal error: cannot opet the pipe roura1!");
	}

	if ((writefd = open( argv[2], 1)) < 0) {
		err_dump ("\ndotser.c: main: fatal error: cannot opet the pipe roura2!");
	}
	#ifdef DEBUG_START_AND_FORK_DOTSER
		fprintf( stderr, "\nRoury otevreny - dotser" );
	#endif
	*/
	// implicitni konfigurace

	sprintf (pidstr, "%d", getpid());

	// tady se nastaví výchozí cesta k treebanku
	// cteni konfiguracniho souboru:
	int set_dir = readConfigFile(path_initial,PARAM_NAME_INITIAL_PATH);

	//fprintf(stderr, "\nvychozi cesta je: %s, navratova hodnota je: %d",path_initial,set_dir);
	if (set_dir < 0) { // výchozí cesta treebanku nebyla specifikována v konfiguračním souboru nebo chyba při jeho čtení
		getcwd(path_initial, MPL); // jako výchozí cestu použiji aktuální adresář
		fprintf(stderr, "\nCannot read the root directory of the treebank from the config file - using current directory.");
	}

	strcpy (path_actual, path_initial); // vychozi cesta se zkopiruje do cesty aktualni
	// path_initial je pouzivano k urceni opravnenosti pristupu klienta k souborum a adresarum (smi jen do podadresaru teto cesty vcetne)

	#ifdef DEBUG
			fprintf (stderr, "\nVYCHOZI CESTA: %s", path_actual);
	#endif

	// vytvoreni pomocnych souboru

	// soubor podadr.pid

	createTemporaryFile (u_podadr, podadr, 12, pidstr);

	// soubor soubory.pid

	createTemporaryFile (u_soubory, soubory, 13, pidstr);

	// inicializace graph codu

	//inicializace_graph();

	signal(SIGCHLD,&childExited); // tahle funkce bude uvědomována o zániku potomka (tj. dotazovacího procesu)

	setDefaultValues(&user_account); // nastavi implicitni autorizacni hodnoty pro anonymniho uzivatele

	// hlavni cyklus: cteni a reseni zprav
	int konec;

	for (;;) {
		cti_eom (0, zprava); // precteni zpravy
		konec = reseni(zprava, zprava); // zpracovani zpravy
		if (konec == FALSE) break; // pripadný konec cyklu
		zapis_eom (1, zprava); // odeslani odpovedi
	}

	// uvolnim pamet
	if (GlobHlav) freeFile(GlobHlav); // uvolnim pamet po globalni hlavicce
	if (meta_head) freeFile(meta_head); // po hlavicce s meta atributy

	// zavřu a smažu všechny dočasné zdroje
	deleteTemporaryFiles();
	#ifdef DEBUG_SIGNALS
		fprintf(stderr,"\ndotser.c (parent): main: Exiting.");
	#endif
	exit(0);

} // main (dotser.c)
