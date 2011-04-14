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

// Tento soubor obsahuje definice funkcí pro čtení a zápis souborů typu fs a jejich převod z textového formátu do struktur, používaných editorem.
// 5.12.2006

#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include <stdio.h>

#include "loadsave.h"

#define BUFLEN 10		// velikost čtecího bufferu

//#define DEBUG_READ_DEFS // ladění funkce ReadDefs (čtení hlavičky fs souboru)
//#define DEBUG_READ_FILE // ladění funkce ReadFile
//#define DEBUG_READ_TREE // ladění funkce ReadTree
//#define DEBUG_READ_ID // ladění funkce ReadID
//#define DEBUG_READ_NODE // ladění funkce ReadNode

//#define CHECK_FS_HEAD_ENUM_ATTR_VALUES_REPETITION // testovat, zda se v hlavičce souboru u výčtového atributu opakují hodnoty?
//#define FATAL_CHECK_FS_HEAD_ENUM_ATTR_VALUES_REPETITION // na opakující se hodnoty zareagovat nenačtením stromu a souboru?

//#define CHECK_LIST_ATTRIBUTES_RANGE  // testovat, zda jsou hodnoty výčtových atributů v rámci výčtu v hlavičce?
//#define FATAL_CHECK_LIST_ATTRIBUTES_RANGE  // má neúspěch testu způsobit nenačtení stromu a potažmo souboru?

//#define CHECK_NUM_ATTR_NUM_VALUE  // testovat, zda numerický atribut má za hodnotu číslo?
//#define FATAL_CHECK_NUM_ATTR_NUM_VALUE  // zareagovat na nečíslo v numerickém atributu nenačtením stromu a souboru?

//#define CHECK_OBLIGATORY_ATTR_PRESENCE  // testovat, zda jsou u každého vrcholu definovány všechny povinné atributy?
//#define FATAL_CHECK_OBLIGATORY_ATTR_PRESENCE  // zareagovat na nepřítomnost povinného atributu nenačtením stromu a souboru?

//#define CHECK_HEAD_NUM_ATTR_REPEAT  // testovat, zda se v hlavicce nachazi vice definici numerickeho atributu
//#define FATAL_CHECK_HEAD_NUM_ATTR_REPEAT // zareagovat na opakovanou definici numerickeho atributu v hlavicce nenactenim souboru

//#define CHECK_HEAD_VAL_ATTR_REPEAT  // testovat, zda se v hlavicce nachazi vice definici hodnotoveho atributu
//#define FATAL_CHECK_HEAD_VAL_ATTR_REPEAT // zareagovat na opakovanou definici hodnotoveho atributu v hlavicce nenactenim souboru

struct TReadRecord        // záznam o čtení souboru
{
  int x,y;                // sloupec a řádek případné chyby
  int errnum;             // číslo případné chyby
};

TReadRecord ReadRecord = {0,0,0}; // do této proměnné jsou ukládány záznamy o kódové stránce, čísle a pozici případné chyby při čtení souboru
// všechny zbývající řetězce jsou naplněny v konstruktoru aplikace

char UngotBuffer[BUFLEN];	// buffer pro znaky, vrácené zpět funkcí UngetChar()

int last_line_length; // délka posledního řádku na výstupu
// tato proměnná je inicializována při začátku zápisu

// Vrácení znaku zpět do bufferu. Znak bude vrácen při následném volání ReadChar().
// Takto je možné vrátit počet znaků, omezený pouze velikostí bufferu.
void UngetChar(char c) {
	int i = 0;
	while (UngotBuffer[i++]);
	UngotBuffer[i-1] = c;
}

// Přečte znak ze souboru File. Podle záznamu v ReadRecord provede případnou konverzi znaku s českou diakritikou a zajistí, aby sekvence
// CR LF nebo LF CR nebo samostatné znaky CR nebo LF byly považovány za jeden znak konce řádky.
char ReadCharConvert(FILE *File) {
	char d;
	char c = getc(File);
	if (c=='\n' || c=='\r') { // jeden ze dvou znaků CR nebo LF
		d = getc(File); // načtení dalšího
		if ((d!='\n' || c!='\r') && (d!='\r' || c!='\n')) { // není-li to druhý do dvojice, vrátí ho do bufferu
			ungetc(d,File);
		}
		c = '\n'; // přečtený znak je nový řádek
	}
	return c;
}

// Přečtení znaku speciálně pro čtení ze souborů se stromy
char ReadChar(FILE *File) {
	char c;
	int i = 0;
	if (UngotBuffer[0]) { // byl-li předtím vrácen nějaký znak funkci UngetChar()
		while (UngotBuffer[i]) {
			c = UngotBuffer[i++];
		}
		UngotBuffer[i-1] = '\0'; // odstraním ho z bufferu
		return c; // a vrátím ho zpět jako platný
	}
	while ((c=ReadCharConvert(File))=='\\') {
		if ((c=ReadCharConvert(File))!='\n') {
			ungetc(c,File);
			ReadRecord.x++;
			return '\\';
		}
		else { // konec řádky za backslashem je ignorován
			ReadRecord.y++;
			ReadRecord.x = 0;
		}
	}
	if (c=='\n') {
		ReadRecord.y++;		// je třeba přejít na nový řádek
		ReadRecord.x = 0;
	}
	else {
		if (c=='\t') { // tabelátor není povolenou součástí identifikátoru
			c = ' ';
		}
		ReadRecord.x++;

	}
	return c;
}

// Přečte identifikátor maximální délky maxLen do ID. Je-li notEmpty nenulové, identifikátorem nesmí být prázdný řetězec.
// Funkce vrací znak následující za koncem řetězce.
// Pokud je čtený identifikátor delší než maxLen, čte se dále, ale již nezapisuje (tedy se uřízne); nezacyklím se tu, protože
// čtení ukončím tak jako tak po max_readable_length (deklarovaná a definovaná zde)
// v *true_len vrátím skutečnou délku *ID
char ReadID(FILE *File, char *ID, int maxLen, int *true_len, TFSFile* fsfile, int notEmpty) {
	// fsfile předávám kvůli seznamu atributů (abych mohl testovat, zda načtený identifikátor je mezi atributy)
	char c,d;
	int Cur; // pro určení pozice identifikátoru v seznamu atributů
	int flag; // je-li flag nenulový, značí, že byl přečtený znak ocitován backslashem
	flag = 0;
	int length; // zde se uschovává délka čteného řetězce
	int max_readable_length=10000; // maximální počet znaků, které budu číst, bez ohledu na to, zda jsem již překročil maxLen
	// (to abych se tu nemohl úplně zacyklit)
	for (length=0; length<max_readable_length; length++) {
		c = ReadChar(File);
		if (flag) { // jakýkoliv znak ocitován - jeho uložení do identifikátoru
			flag = 0;
			if (length < maxLen) { // pokud jsem ještě nepřekročil maximální délku cílového řetězce
				ID[length] = c;
			}
		} else { // normální neocitovaný znak
			switch (c) {
				case '!': // mozny začátek nerovnítka '!='
							d = ReadChar(File); // prectu nasledujici znak
							if (d == '=') { // je to skutecne '=', a tedy celkove '!='
								if (length < maxLen) { // pokud jsem ještě nepřekročil maximální délku cílového řetězce
									ID[length] = '\0'; // ukoncim identifikator
								}
								else { // cílový řetězec už byl zaplněn
									ID[maxLen-1] = '\0'; // ukoncim identifikator na poslední možné pozici
								}
								if (length || !notEmpty) {
									#ifdef DEBUG_READ_ID
										fprintf(stderr,"\nloadsave.cpp: ReadID: The identifier has been read: '%s', the termination character has been '!='",ID);
									#endif
									*true_len = length;
									return RELATION_NEQ;
								}
								ReadRecord.errnum = 26; // je-li identifikátor prázdný a nesmí - chyba
								*true_len = 0;
								return '\0';
							}
							else { // nenasledovalo '=', a tedy vykricnik byl soucasti identifikatoru
								UngetChar(d); // vratim pismeno d do bufferu, aby bylo priste precteno
								if (length < maxLen) { // pokud jsem ještě nepřekročil maximální délku cílového řetězce
									ID[length] = c; // vykricnik zaradim jako soucast identifikatoru
								}
								break; // za konec switch
							}
				case '>': // většítko nebo začátek "větší nebo rovno"
				case '<': // menšítko nebo začátek "menší nebo rovno"
							if (length < maxLen) { // pokud jsem ještě nepřekročil maximální délku cílového řetězce
								ID[length] = '\0'; // ukoncim identifikator
								*true_len = length;
							}
							else { // cílový řetězec už byl zaplněn
								ID[maxLen-1] = '\0'; // ukoncim identifikator na poslední možné pozici
								*true_len = maxLen-1;
							}
							d = ReadChar(File); // prectu nasledujici znak
							if (d == '=') { // je to skutecne '=', a tedy celkove "<=" nebo ">="
								Cur=isThere(ID, fsfile);
								#ifdef DEBUG_READ_ID
									fprintf(stderr,"\nloadsave.cpp: ReadID: The identifier %s is on the position %d in the head.", ID,Cur);
								#endif
								if (Cur==-1) { // načtený identifikátor není jménem atributu, a tedy '<', resp. '>', bylo součástí identifikátoru
									#ifdef DEBUG_READ_ID
										fprintf(stderr,"\nloadsave.cpp: ReadID: The identifier '%s' is not a name of any attribute!", ID);
									#endif
									UngetChar(d); // vratim pismeno d (rovnitko) do bufferu, aby bylo priste precteno
									if (length < maxLen) { // pokud jsem ještě nepřekročil maximální délku cílového řetězce
										ID[length] = c; // mensitko, resp. vetsitko, zaradim jako soucast identifikatoru
									}
									break; // za konec switch - pokracuji ve cteni identifikatoru
								}
								// nyni vim, ze to bylo "<=", resp. ">=", a ze pred tim byl identifikator, ktery se shoduje se jmenem jednoho z atributů
								if (length || !notEmpty) {
									if (c=='<') {
										#ifdef DEBUG_READ_ID
											fprintf(stderr,"\nloadsave.cpp: ReadID: The identifier has been read: '%s', the termination character has been '<='",ID);
										#endif
										*true_len = length+1;
										return RELATION_LTEQ;
									}
									else {
										#ifdef DEBUG_READ_ID
											fprintf(stderr,"\nloadsave.cpp: ReadID: The identifier has been read: '%s', the termination character has been '>='",ID);
										#endif
										return RELATION_GTEQ;
									}
								}
								ReadRecord.errnum = 26; // je-li identifikátor prázdný a nesmí - chyba
								return '\0';
							}
							else { // nenasledovalo '=', a tedy mensitko (resp. vetsitko) mohlo byt samo relaci nebo soucasti identifikatoru
								UngetChar(d); // vratim pismeno d do bufferu, aby bylo priste precteno
								Cur=isThere(ID, fsfile);
								#ifdef DEBUG_READ_ID
									fprintf(stderr,"\nloadsave.cpp: ReadID: The identifier %s is on the position %d in the head.", ID,Cur);
								#endif
								if (Cur==-1) { // načtený identifikátor není jménem atributu, a tedy '<' bylo součástí identifikátoru
									#ifdef DEBUG_READ_ID
										fprintf(stderr,"\nloadsave.cpp: ReadID: The identifier '%s' is not a name of any attribute!", ID);
									#endif
									if (length < maxLen) { // pokud jsem ještě nepřekročil maximální délku cílového řetězce
										ID[length] = c; // mensitko (resp. vetsitko) zaradim jako soucast identifikatoru
									}
									break; // za konec switch - pokracuji ve cteni identifikatoru
								}
								if (length < maxLen) { // pokud jsem ještě nepřekročil maximální délku cílového řetězce
									*true_len = length;
									ID[length] = '\0'; // ukoncim identifikator
								}
								else { // cílový řetězec už byl zaplněn
									ID[maxLen-1] = '\0'; // ukoncim identifikator na poslední možné pozici
									*true_len = maxLen-1;
								}
								if (length || !notEmpty) {
									if (c=='<') {
										#ifdef DEBUG_READ_ID
											fprintf(stderr,"\nloadsave.cpp: ReadID: The identifier has been read: '%s', the termination character has been '<'",ID);
										#endif
										return RELATION_LT;
									}
									else {
										#ifdef DEBUG_READ_ID
											fprintf(stderr,"\nloadsave.cpp: ReadID: The identifier has been read: '%s', the termination character has been '>'",ID);
										#endif
										return RELATION_GT;
									}
								}
								ReadRecord.errnum = 26; // je-li identifikátor prázdný a nesmí - chyba
								return '\0';
							}
				case '=': // rovnítko
				case ',':
				case '[':
				case ']':
				case '|':
				// case '&': // do budoucnosti (až to bude umět konjunkci)
				case '\n': // tyto funkční znaky ukončují identifikátor
							if (length < maxLen) { // pokud jsem ještě nepřekročil maximální délku cílového řetězce
								ID[length] = '\0'; // ukoncim identifikator
								*true_len = length;
							}
							else { // cílový řetězec už byl zaplněn
								ID[maxLen-1] = '\0'; // ukoncim identifikator na poslední možné pozici
								*true_len = maxLen-1;
							}
							if (length || !notEmpty) {
								#ifdef DEBUG_READ_ID
									fprintf(stderr,"\nloadsave.cpp: ReadID: The identifier has been read: '%s', the termination character has been '%c'",ID,c);
								#endif
								if (c=='=') return RELATION_EQ;
								else return c;
							}
							ReadRecord.errnum = 26; // je-li identifikátor prázdný a nesmí - chyba
							return '\0';
				case '\\': flag = 1; // ocitování následujícího znaku
							length--;
							break;
				default:	if (length < maxLen) { // pokud jsem ještě nepřekročil maximální délku cílového řetězce
								ID[length] = c; // normální znak - je uložen do ID
								*true_len = length+1; // pro jistotu udržuji délku, kterou vrátím, konzistentní po celou dobu načítání
							}
			} // switch
		} // else: neocitovany znak
	} // for
	ReadRecord.errnum = 33;		// identifikátor byl příliš dlouhý
	return '\0';
}

/*
// Zkopiruje maximalne max_length znaku z src do dst; navic to zakonci binarni nulou, takze v dst musi byt navic misto i na ni.
void myStrNCpy(char *dst, char *src, int max_length) {
	strncpy(dst,src,max_length);
	if (strlen(src) > max_length) {
		fprintf(stderr,"\nloadsave.cpp: myStrNCpy: The max value of an attribute has been exceeded!");
	}
	*(dst+max_length)='\0';
}*/

// Přečte hlavičku souboru, tj. definice všech použitých atributů.
TFSFile *ReadDefs(FILE *File) {
	#ifdef DEBUG_READ_DEFS
		fprintf(stderr,"\nloadsave.cpp: ReadDefs: Entering the function.");
	#endif
	TFSFile *fsfile;
	TDefsLine *line;
	TAHLine *temp;
	char buffer[MAXLONGVALUELEN];
	int i,j,NFlag = 0,VFlag = 0;
	int id_length; // sem bude funkce ReadID vracet délku identifikátoru
	char c;
	if (ReadChar(File)!='@') { // soubor musí začínat tímto znakem
		ReadRecord.errnum = 21;
		return 0;
	}
	fsfile = new TFSFile;		// alokuje strukturu pro nový soubor
	fsfile->DefsTable =  new TDefsLine[RESERVEDNUM];
	fsfile->AHNum = 0;			// zatím nebyl přečten jediný atribut
	fsfile->ResAHNum = RESERVEDNUM;
	fsfile->Trees = 0;			// ani žádný strom
	fsfile->TreeNum = 0;
	do { // čtení atributů
		switch (ReadChar(File)) {
			case 'E': j = ATTR_FAKE_ENCODING; // podvržený atribut pro určení kódování souboru
					break;
			case 'K': j = ATTR_KEY; // klíčový atribut
					break;
			case 'P': j = ATTR_POS; // poziční atribut
					break;
			case 'O': j = ATTR_OBL; // povinný atribut
					break;
			case 'L': j = ATTR_LIST; // výčtový atribut
					break;
			case 'N': j = ATTR_NUM; // číselný atribut (atribut určující pořadí uzlů ve stromě)
						#ifdef CHECK_HEAD_NUM_ATTR_REPEAT
							if (NFlag) { // atribut už byl určen
								fprintf(stderr,"\nloadsave.cpp: ReadDefs: Multiple definitions of the numeric attribute!");
								#ifdef FATAL_CHECK_HEAD_NUM_ATTR_REPEAT
									FreeFile(fsfile);   // podruhé specifikovaný číselný atribut
									ReadRecord.errnum = 23;
									return 0;
								#endif
							}
						#endif
						NFlag = 1; // uchovám informaci, že atribut už byl určen
					break;
			case 'V':j = ATTR_VAL; // hodnotový atribut (atribut určující slova v zobrazené větě)
						#ifdef CHECK_HEAD_VAL_ATTR_REPEAT
							if (VFlag) { // atribut už byl určen
								fprintf(stderr,"\nloadsave.cpp: ReadDefs: Multiple definitions of the value attribute!");
								#ifdef FATAL_CHECK_HEAD_VAL_ATTR_REPEAT
									FreeFile(fsfile);   // podruhé specifikovaný hodnotový atribut
									ReadRecord.errnum = 24;
									return 0;
								#endif
							}
						#endif
						VFlag = 1; // uchovám informaci, že atribut už byl určen
					break;
			case 'H': j = ATTR_HIDE; // atribut pro skrývání podstromu
					break;
			case 'W': j = ATTR_WNUM; // atribut pro pořadí slov ve výpisu věty (pokud není přítomen, bere se 'N'
					break;
			default: freeFile(fsfile);	// neznámý typ atributu
						ReadRecord.errnum = 10;
					return 0;
		}
		if ((c=ReadChar(File))!=' ') { // následuje povinná mezera (výjimky viz další řádek)
			if (!(c=='A' || c=='H' || (c>'0' && c<'4')) || ReadChar(File)!=' ') { // nebo typ zobrazení a mezera
				freeFile(fsfile);
				ReadRecord.errnum = 11;
				return 0;
			}
			switch (c) {
				case '1':j |= ATTR_SHADOW;
						break;
				case '2':j |= ATTR_HILITE;
						break;
				case '3':j |= ATTR_XHILITE;
						break;
				case 'A': // kdoví co - ignoruji
						break;
				case 'H': // kdoví co - ignoruji
						break;
			}
		}

		c = ReadID(File, buffer, MAXATTRLEN, &id_length, fsfile, 1); // a název atributu
		if (j==ATTR_FAKE_ENCODING) { // akceptuji stejně jen UTF-8 soubory, takže ignoruji
			//fprintf(stderr,"\nPřečtena informace o kódování souboru: %s; nevertheless, only accepting UTF-8.",buffer);
			continue; // čtení dalších atributů
		}
		if ((!(j&ATTR_LIST) && c!='\n') || (j&ATTR_LIST && c!='|')) { // pro nevýčtový atribut musí řádek končit a pro výčtový pokračovat znakem '|'
			freeFile(fsfile);
			if (!ReadRecord.errnum) {
				if (j!=ATTR_LIST) {
					fprintf(stderr,"1");
					ReadRecord.errnum = 25;
				}
				else {
					ReadRecord.errnum = 32;
				}
			}
			return 0;
		}

		i = isThere(buffer, fsfile); // byl atribut již definován? Pokud ano, na ktere pozici?
		if (i==-1) { // nový atribut
			/*if (j & ATTR_LIST) { // typ výčtového atributu měl již být definován - to mi přijde zbytečné, takže to nekontroluji
			FreeFile(fsfile);
			ReadRecord.errnum = 27;
			return 0;
			}*/
			if (fsfile->AHNum==fsfile->ResAHNum) { // nevejde-li se, je přealokována tabulka
				reallocDefsTable(fsfile, RESERVEDNUM);
			}
			// nyní je zařazen:
			line = fsfile->DefsTable+fsfile->AHNum;
			fsfile->AHNum++;
			strncpy(line->ID, buffer, id_length);
			line->ID[id_length]='\0';
			line->IDType = j;
			line->Vals = 0;
		}
		else { // atribut již byl definován
			line = fsfile->DefsTable + i; // a je tady
/*			if (((line->IDType | j) & ATTR_NUMTEST) || (line->IDType & ATTR_LIST) || ((j & ATTR_LIST) && (line->IDType & ATTR_VAL)) ||
			// předefinován nesmí být numerický ani výčtový atribut, numerickým atributem nesmí být předefinováno a dále není povolena kombinace @V a @L
			 (((line->IDType & j) != (ATTR_OBL & ATTR_POS)) && !((line->IDType | j) & ATTR_VAL))) {
			//  dále musí být nový atribut povinný a předchozí atribut téhož jména poziční nebo naopak anebo musí být jeden z nich hodnotový
				FreeFile(fsfile);
				ReadRecord.y--;
				ReadRecord.errnum = 12;
				return 0;
			}*/
			line->IDType &= ATTR_FUNC; // proč to???
			line->IDType |= j; // rozšířím informaci o typu atributu
			if (j & ATTR_LIST) { // výčtový atribut - následuje čtení povolených hodnot
				temp = line->Vals;
				if (!(line->IDType & ATTR_OBL)) {
					temp = line->Vals = newTAHLine();
				}
				do { // čtení možných hodnot výčtového atributu
					c = ReadID(File, buffer, MAXLONGVALUELEN, &id_length, fsfile, 1);
					if (c!='|' && c!='\n') { // hodnoty musejí být odděleny svislou čárou
						freeFile(fsfile);
						if (!ReadRecord.errnum) {
							ReadRecord.errnum = 28;
						}
						return 0;
					}
					#ifdef CHECK_FS_HEAD_ENUM_ATTR_VALUES_REPETITION
						if (IsOneOf(line->Vals, buffer)) {
							fprintf(stderr,"\nloadsave.cpp: ReadDefs: The value %s of the enumeration attribute has been already defined!", buffer);
							#ifdef FATAL_CHECK_FS_HEAD_ENUM_ATTR_VALUES_REPETITION
								freeFile(fsfile); // dále není dovolena dvojice stejných hodnot
								ReadRecord.errnum = 29;
								return 0;
							#endif
						}
					#endif
					if (!temp) { // konečně následuje zkopírování přečtené hodnoty
						temp = line->Vals = newTAHLine();
					}
					else {
						temp->next = newTAHLine();
						temp = temp->next;
					}
					//strcpy(temp->value, buffer);
					setAHLineValue(temp, buffer, id_length);
				} while (c!='\n');
			}
		}
		#ifdef DEBUG_READ_DEFS
			fprintf(stderr,"\nloadsave.cpp: ReadDefs: Attribute %s has been read.", line->ID);
		#endif
	} while ((c=ReadChar(File))=='@'); // dokud následují další definice atributů
	#ifdef DEBUG_READ_DEFS
		fprintf(stderr,"\nloadsave.cpp: ReadDefs: All attributes have been read.");
	#endif
	if (c!='\n') { // po definicích atributů následuje druhý nový řádek (pokud ne, chyba formátu:)
		freeFile(fsfile);
		fprintf(stderr,"2");
		ReadRecord.errnum = 25;
		return 0;
	}
	while ((c=ReadChar(File))=='\n'); // těch prázdných řádek může být víc
	UngetChar(c);
	#ifdef DEBUG_READ_DEFS
		fprintf(stderr,"\nloadsave.cpp: ReadDefs: Leaving the function after a head had been successfully read.");
	#endif
	return fsfile;
}

// Zjistí index následujícího pozičního atributu po Cur_pos v souboru fsfile.
int Next_pos(int Cur_pos, TFSFile *fsfile) {
	for (Cur_pos++; Cur_pos<fsfile->AHNum; Cur_pos++) {
		if ((fsfile->DefsTable[Cur_pos]).IDType & ATTR_POS) {
			return Cur_pos;
		}
	}
	return -1;
}

// Přečte hodnoty všech atributů pro jeden vrchol.
TAHLine *ReadNode(FILE *File, TFSFile *fsfile) {
	TAHLine *ahtable,*lastword = 0;
	int Cur,Pos;
	char buffer[MAXLONGVALUELEN];
	char c,d;
	int relation;
	int id_length = 0; // sem vrátí funkce ReadID délku načteného identifikátoru
	if ((c=ReadChar(File))!='[') { // začínají hranatou otevírací závorkou (pokud ne, chyba:)
		#ifdef DEBUG_READ_NODE
			fprintf(stderr,"\nloadsave.cpp: ReadNode: The node does not begin with '['!");
		#endif
		ReadRecord.errnum = 20;
		return 0;
	}
	ahtable = newTAHLineArray(fsfile->ResAHNum); // alokuje tabulku
	Pos = Cur = -1;
	while (1) {
		#ifdef DEBUG_READ_ID
			fprintf(stderr,"\nloadsave.cpp: ReadNode: Expecting an attribute name or a value of a positional attribute");
		#endif
		c = ReadID(File, buffer, MAXLONGVALUELEN, &id_length, fsfile, 0); // přečte identifikátor
		switch (c) {
			case ']':
				if (!buffer[0] && Cur==-1) {
					break; // prázdné závorky jsou v pořádku
				}
			case '|':
			case ',':
				if (Cur<0 && (((Pos = Next_pos(Pos, fsfile))==-1) || (ahtable[Pos].value)[0])) {
					// nejde o poziční atribut nebo byla jeho hodnota již určena
					#ifdef DEBUG_READ_NODE
						fprintf(stderr,"\nloadsave.cpp: ReadNode: The attribute has been already defined or it is not a positional attribute!");
					#endif
					freeAHTable(ahtable, fsfile->AHNum);
					ReadRecord.x--;
					if (Pos==-1) {
						ReadRecord.errnum = 13;
					}
					else {
						ReadRecord.errnum = 14;
					}
					return 0;
				}
				#ifdef CHECK_NUM_ATTR_NUM_VALUE
					if ((fsfile->DefsTable[Cur<0?Pos:Cur].IDType & ATTR_NUMTEST) && !CheckNumAttr(buffer)) {
						// hodnotou číselného atributu není číslo
						fprintf(stderr,"\nloadsave.cpp: ReadNode: The attribute type is number, but its value is not a number!");
						#ifdef FATAL_CHECK_NUM_ATTR_NUM_VALUE
							FreeAHTable(ahtable, fsfile->AHNum);
							ReadRecord.x--;
							ReadRecord.errnum = 22;
							return 0;
						#endif
					}
				#endif
				#ifdef CHECK_LIST_ATTRIBUTES_RANGE
					if ((fsfile->DefsTable[Cur<0?Pos:Cur].IDType & ATTR_LIST) && !IsOneOf(fsfile->DefsTable[Cur<0?Pos:Cur].Vals, buffer)) {
						// hodnota výčtového atributu je mimo rozsah
						fprintf(stderr,"\nloadsave.cpp: ReadNode: The value %s of an enumeration attribute is out of bounds!",buffer);
						#ifdef FATAL_CHECK_LIST_ATTRIBUTES_RANGE
							FreeAHTable(ahtable, fsfile->AHNum);
							ReadRecord.x--;
							ReadRecord.errnum = 30;
							return 0;
						#endif
					}
				#endif
				if (Cur<0) { // jde o první hodnotu
					setAHLineValue(ahtable+Pos, buffer, id_length);
					ahtable[Pos].relation = RELATION_EQ; // pozičně či za '|' lze zatím vložit jen hodnoty atributů s relací '='
					ahtable[Pos].contains_reference = 0; // pro jistotu to tam dávám znovu
					if (c=='|') { // a následovat bude další
						lastword = &(ahtable[Pos]);
						Cur = Pos;
					}
				}
				else { // jde o další hodnotu (oddělenou svislítkem)
					lastword->next = newTAHLine();
					setAHLineValue(lastword->next, buffer, id_length);
					lastword->next->relation = RELATION_EQ; // pozičně či za '|' lze zatím vložit jen hodnoty atributů s relací '='
					if (c=='|') {
						lastword = lastword->next;
					}
					else {
						lastword = NULL;
						Cur = -1;
					}
				}
			break;
			case RELATION_LT: // přečtený identifikátor byl zakončen znakem '<'
			case RELATION_LTEQ: // přečtený identifikátor byl zakončen znakem '<='
			case RELATION_GT: // přečtený identifikátor byl zakončen znakem '>'
			case RELATION_GTEQ: // přečtený identifikátor byl zakončen znakem '>='
			case RELATION_NEQ: // precteny identifikator byl zakoncen dvojznakem '!='
			case RELATION_EQ: // precteny identifikator byl zakoncen znakem '='
				if (Cur>=0) { // čtený identifikátor nemohl být jménem atributu (musel být hodnotou)
					#ifdef DEBUG_READ_NODE
						fprintf(stderr,"\nloadsave.cpp: ReadNode: The identifier %s cannot be a name of any attribute!", buffer);
					#endif
					freeAHTable(ahtable, fsfile->AHNum);
					ReadRecord.errnum = 31;
					return 0;
				}
				Cur=isThere(buffer, fsfile);
				#ifdef DEBUG_READ_NODE
					fprintf(stderr,"\nloadsave.cpp: ReadNode: The identifier %s is on the position %d in the head.", buffer,Cur);
				#endif
				if (Cur==-1) { // načtený identifikátor není jménem atributu
					#ifdef DEBUG_READ_NODE
						fprintf(stderr,"\nloadsave.cpp: ReadNode: The identifier '%s' is not a name of any attribute!", buffer);
					#endif
					freeAHTable(ahtable, fsfile->AHNum);
					ReadRecord.x--;
					ReadRecord.errnum = 15;
					return 0;
				}
				if ((ahtable[Cur].value)[0]) { // hodnota tohoto atributu byla již určena
					#ifdef DEBUG_READ_NODE
						fprintf(stderr,"\nloadsave.cpp: ReadNode: The value of the attribute '%s' has already been set!");
					#endif
					freeAHTable(ahtable, fsfile->AHNum);
					ReadRecord.x--;
					ReadRecord.errnum = 14;
					return 0;
				}

				// nyní se podívám, jaká je relace mezi jménem atributu a jeho hodnotou (má význam při zpracování dotazů)
				relation = c; // nyní mám tu správnou relaci v proměnné relation

				if ((fsfile->DefsTable[Cur]).IDType & ATTR_POS) {
					Pos = Cur; // atribut je poziční - přestavení ukazovátka na další poziční
				}
				#ifdef DEBUG_READ_ID
					fprintf(stderr,"\nloadsave.cpp: ReadNode: Expecting a value of the attribute '%s'",buffer);
				#endif
				c = ReadID(File, buffer, MAXLONGVALUELEN, &id_length, fsfile, 0); // přečtení hodnoty
				setAHLineValue(ahtable+Cur, buffer, id_length);
				//c = ReadID(File, ahtable[Cur].Value, MAXLONGVALUELEN, &id_length, fsfile, 0); // přečtení hodnoty
				ahtable[Cur].relation = relation; // nastavení relace
				if (ahtable[Cur].contains_reference != 0) {
					fprintf(stderr,"\nloadsave.cpp: ReadNode: BUG: contains_reference != 0 !!!");
					ahtable[Cur].contains_reference = 0; // jako blázen to tam furt cpu
				}

				#ifdef CHECK_NUM_ATTR_NUM_VALUE
					if ((fsfile->DefsTable[Cur].IDType & ATTR_NUMTEST) && !CheckNumAttr(ahtable[Cur].Value)) {
						// hodnotou číselného atributu není číslo
						fprintf(stderr,"\nloadsave.cpp: ReadNode: (2): The attribute type is number, but its value is not a number!");
						#ifdef FATAL_CHECK_NUM_ATTR_NUM_VALUE
							FreeAHTable(ahtable, fsfile->AHNum);
							ReadRecord.errnum = 22;
							return 0;
						#endif
					}
				#endif
				#ifdef CHECK_LIST_ATTRIBUTES_RANGE
					if ((fsfile->DefsTable[Cur].IDType & ATTR_LIST) && !IsOneOf(fsfile->DefsTable[Cur].Vals, ahtable[Cur].Value)) {
						// hodnota výčtového atributu je mimo rozsah
						fprintf(stderr,"\nloadsave.cpp: ReadNode: (2): The value %s of an enumeration attribute is out of bounds!",ahtable[Cur].Value);
						#ifdef FATAL_CHECK_LIST_ATTRIBUTES_RANGE
							FreeAHTable(ahtable, fsfile->AHNum);
							ReadRecord.errnum = 30;
							return 0;
						#endif
					}
				#endif
				lastword = &(ahtable[Cur]);
				if (c!='|') {
					Cur = -1;
				}
				if (c!=',' && c!=']' && c!='|') { // čtení identifikátoru muselo skončit na jednom z těchto znaků
					#ifdef DEBUG_READ_NODE
						fprintf(stderr,"\nloadsave.cpp: ReadNode: A wrong end of the identifier!");
					#endif
					freeAHTable(ahtable, fsfile->AHNum);
					if (c) {
						ReadRecord.errnum = 16;
					}
					return 0;
				}
			break;
			default:
				freeAHTable(ahtable, fsfile->AHNum);
				#ifdef DEBUG_READ_NODE
					fprintf(stderr,"\nloadsave.cpp: ReadNode: Another error! (the character '%c' as the end of the identifier '%s')", c, buffer);
				#endif
				if (!ReadRecord.errnum) {
					ReadRecord.errnum = 17;
				}
				return 0;
		} // switch
		if (c==']') { // končí čtení jedné sady hodnot atributů vrcholu
			#ifdef CHECK_OBLIGATORY_ATTR_PRESENCE
				// přečtená sada je uložena v ahtable
				for (Cur=0; Cur<fsfile->AHNum; Cur++) {
					if ((fsfile->DefsTable[Cur]).IDType & ATTR_OBL) { // kontrola, zda jsou definovány všechny povinné atributy
						if (!(ahtable[Cur].Value)[0]) {
							fprintf(stderr,"\nloadsave.cpp: ReadNode: Some of the obligatory attributes have not been defined!");
							#ifdef FATAL_CHECK_OBLIGATORY_ATTR_PRESENCE
								FreeAHTable(ahtable, fsfile->AHNum);
								ReadRecord.errnum = 18;
								return 0;
							#endif
						}
					}
				}
			#endif
			break; // while
		}
	} // while
	#ifdef DEBUG_READ_ID
		fprintf(stderr,"\nloadsave.cpp: ReadNode: leaving the function");
	#endif
	return ahtable;
} // ReadNode


// Přečte podstrom
TNode *ReadTree(FILE *File, TFSFile *fsfile, TNode *father) {
	TAHLine *v;
	TValue *values = 0,*val;
	TNode *node,*temp,*last = 0;
	char c;
	do { // cyklus přes alternativní vrcholy
		#ifdef DEBUG_READ_TREE
			fprintf(stderr,"\nloadsave.cpp: ReadTree: Going to read a node.");
		#endif
		if ((v=ReadNode(File, fsfile))==0) { // přečte hodnoty atributů vrcholu
			#ifdef DEBUG_READ_TREE
				fprintf(stderr,"\nloadsave.cpp: ReadTree: Error during reading the node!");
			#endif
			freeValues(values, fsfile->AHNum);
			return 0;
		}
		if (!values) {
			val = values = new TValue;
		}
		else {
			val->Next = new TValue;
			val = val->Next;
		}
		val->AHTable = v;
		val->Next = 0;
		if ((c=ReadChar(File))!='|') {
			UngetChar(c);
		}
	} while (c=='|');
	node = new TNode;
	node->Values = values;
	node->father = father;
	node->Brother = 0;
	node->FirstSon = 0; // nový vrchol vytvořen
	node->depth_from_root = -1; // vzdálenost od kořene stromu
	node->max_depth_to_leaf = -1; // nejdelší vzdálenost do listu
	node->nodes_in_subtree = -1; // počet vrcholů v podstromu včetně tohoto
	node->number_of_sons = -1; // počet bezprostředních synů vrcholu
	node->number_of_hidden_sons = -1; // počet bezprostředních skrytých synů vrcholu
	node->number_of_left_brothers = -1; // počet levých bratrů (určuje se podle atributu s příznakem ATTR_NUM v hlavičce)
	node->number_of_right_brothers = -1; // počet pravých bratrů (určuje se podle atributu s příznakem ATTR_NUM v hlavičce)
	node->hidden = 0; // implicitně je každý vrchol neskrývaný
	node->depth_first_order = -1; // pořadí vrcholu při průchodu do hloubky
	node->name = NULL; // případné pojmenování vrcholu (realizováno meta atributem META_NODE_NAME)
	if ((c=ReadChar(File))=='(') { // následuje podstrom vrcholu
		do { // cyklus po synech vrcholu node
			if (c!=',' && last) { // kromě prvního musí být před každým bratrem čárka
				freeTree(node, fsfile->AHNum);
				ReadRecord.errnum = 19;
				return 0;
			}
			#ifdef DEBUG_READ_TREE
				fprintf(stderr,"\nloadsave.cpp: ReadTree: Going to read a subtree.");
			#endif
			if (temp=ReadTree(File, fsfile, node), ReadRecord.errnum) { // čte podstrom
				#ifdef DEBUG_READ_TREE
					fprintf(stderr,"\nloadsave.cpp: ReadTree: Error by reading the subtree!");
				#endif
				freeTree(node, fsfile->AHNum);
				return 0;
			}
			if (last) {
				last->Brother = temp;
			}
			else {
				node->FirstSon = temp; // zapojí nový vrchol
			}
			last = temp;
		} while ((c=ReadChar(File))!=')');
	}
	else { // vrchol je list
		UngetChar(c);
		if (c=='\n') {
			ReadRecord.y--;
		}
	}
	#ifdef DEBUG_READ_TREE
		fprintf(stderr,"\nloadsave.cpp: ReadTree: leaving the function");
	#endif
	return node;
} // ReadTree


// Tato funkce zjistí, zda v souboru text následuje řetězec cmpword. V případě, že ano, jej přečte,
// jinak vrátí souborový ukazatel zpět. Je-li dontread==TRUE, vrátí ukazatel zpět vždy.
int ReadStr(FILE *text, char *cmpword) {
	long l = ftell(text);
	int j,i = strlen(cmpword);
	for (j=0; j<i; j++) {
		if (getc(text)!=cmpword[j]) {
			fseek(text, l, SEEK_SET);
			return 0;
		}
	}
	return 1;
} // ReadStr


// Přečte soubor Path
TFSFile *readFile(const char *Path) {
	// čte hlavičku a stromy ze souboru Path
	FILE *File;
	TFSFile *fsfile;
	TTree *tree,*last = 0;
	TNode *node;
	int i = 0,step,count;
	signed char c;
	char *temp;
	int ValidChar,b;
	while (i<BUFLEN) {
		UngotBuffer[i++] = '\0';
	}
	ReadRecord.errnum = ReadRecord.x = 0; // inicializace záznamu o čteném souboru
	ReadRecord.y = 1;
	if ((File=fopen(Path, "rb"))==0) {
		#ifdef DEBUG_READ_FILE
			fprintf(stderr,"\nloadsave.cpp: ReadFile: The file %s could not have been opened.",Path);
		#endif
		ReadRecord.errnum = 1;
		return 0;
	}
	if ((fsfile=ReadDefs(File))==0) { // přečtení hlavičky s definicemi atributů
		#ifdef DEBUG_READ_FILE
			fprintf(stderr,"\nloadsave.cpp: ReadFile: The head from the file %s could not have been read.",Path);
		#endif
		fclose(File);
		return 0;
	}
	do { // cyklus přes stromy v souboru
		#ifdef DEBUG_READ_FILE
			fprintf(stderr,"\nloadsave.cpp: ReadFile: Going to read the next tree (#%d) from the file %s.",fsfile->TreeNum+1,Path);
		#endif
		if (node=ReadTree(File, fsfile, NULL), ReadRecord.errnum) { // přečtení stromu
			#ifdef DEBUG_READ_FILE
				fprintf(stderr,"\nloadsave.cpp: ReadFile: Error during the reading the next tree!");
			#endif
			freeFile(fsfile);
			fclose(File);
			return 0;
		}
		fsfile->TreeNum++; // zvětšení počtu stromů
		if (ReadChar(File)!='\n') { // stromy musejí být odděleny novou řádkou
			freeFile(fsfile);
			fclose(File);
			fprintf(stderr,"3");
			ReadRecord.errnum = 25;
			return 0;
		}
		tree = new TTree;
		tree->Root = node;
		tree->sentence = NULL;
		//tree->AHNum = 0;
		//tree->DefsTable = 0;
		tree->Prev = last;
		tree->Next = 0;
		if (last) {
			last->Next = tree;
		}
		else {
			fsfile->Trees = tree; // nově přečtený strom je již zapojen v souboru
		}
		last = tree;
		//if ((c=getc(File))==EOF || c=='\x1a' || c=='(' || c=='/') { // konec souboru - konec cyklu
		if ((c=getc(File))!='[') { // konec souboru - konec cyklu
			break;
		}
		ungetc(c,File);
	} while (1);
	fclose(File);
	#ifdef DEBUG_READ_FILE
		fprintf(stderr,"\nloadsave.cpp: ReadFile: leaving the function");
	#endif
	return fsfile;
} // ReadFile


// Jde o putc(c,file) s tím rozdílem, že rozděluje dlouhé řádky pomocí backspace před CRLF.
void Putc(int c, FILE *file, int inID) {
/*	if (c=='\r' || c=='\n') {
		LineLen = 0;
	}
	else {
		if (LineLen>=OUTPUTLINELEN && !inID) {
			LineLen = 0;
			putc('\\',file);
			putc('\r',file);
			putc('\n',file);
		}
	}*/
	putc(c, file);
	//LineLen++;
}

/*// Překonvertuje znak c do kódové stránky codepage.
char WriteCharConvert(char c, int codepage_src, int codepage_dst) {
	if (codepage_src != codepage_dst) { // pokud je potřeba překódovat
		//if (c>='\x80') { // překladač (většinou) hlásil, že tohle je vždycky pravda due to limited range of data type, tak jsem to vyhodil
			for (int i=0; i<DIACRITNUM; i++) {
				if (c==convert_table[i][codepage_src]) {
					return convert_table[i][codepage_dst];
				}
			}
		//}
	}
	return c;
}
*/

// Zapíše do souboru File identifikátor ID v kódové stránce codepage.
void writeID(FILE *File, char *ID) {
	int i;
	for (i=0; ID[i]; i++) {
		switch (ID[i]) {
			case '[':
			case ']':
			case '=':
			case '!':
			case '<':
			case '>':
			case ',':
			case '|':
//			case '&':
			case '\\':Putc	('\\',File,1);
			//default:Putc(WriteCharConvert(ID[i],codepage_src, codepage_dst),File,1);
			default:Putc(ID[i],File,1);
		}
	}
}

// Zapíše do souboru File tabulku hodnot atributů ahtable.
// (Neumožňuje zápis jiné relace mezi atributem a jeho hodnotou než rovnítka!)
void WriteNode(FILE *File, TValue *value, TFSFile *fsfile) {
	TValue *val = value;
	TAHLine *ahline,*ahl;
	TDefsLine *defsline;
	int PFlag,notfirst,i; // PFlag je příznak přeskočení prázdné hodnoty pozičního atributu - v tom případě je nutné vypsat i jeho jméno
	while (val) { // přes všechny sady atributů
		if (val!=value) {
			Putc('|',File,0);
		}
		Putc('[',File,0); // začátek jedné sady atributů
		i = PFlag = notfirst = 0;
		defsline = fsfile->DefsTable;
		ahline = val->AHTable;
		for (; i<fsfile->AHNum; i++,defsline++,ahline++) { // přes všechny atributy
			if (!((ahline->value)[0] || ahline->long_value) && !ahline->next) {
				if (defsline->IDType & ATTR_POS) {
					PFlag = 1;		// přeskočený poziční atribut
				}
			}
			else {
				if (notfirst) {
					Putc(',',File,0);	// identifikátory odděleny čárkou
				}
				else {
					notfirst = 1;
				}
				if (!(defsline->IDType & ATTR_POS) || PFlag) {
					writeID(File, defsline->ID);	// vypsání jména atributu
					Putc('=',File,0);
					if (defsline->IDType & ATTR_POS) {
						PFlag = 0;
					}
				}
				writeID(File, getAHLineValue(ahline));	// vypsání hodnoty atributu
				ahl = ahline->next;
				while (ahl) { // vypsání všech ostatních hodnot
					Putc('|',File,0);
					writeID(File, getAHLineValue(ahl));
					ahl = ahl->next;
				}
			}
		}
		Putc(']',File,0); // konec jedné sady atributů
		val = val->Next;
	}
} // WriteNode


// Zapíše strom
void writeTree(FILE *File, TNode *node, TFSFile *fsfile) {
	TNode *p,*r;
	WriteNode(File, node->Values, fsfile); // hodnoty atributů vrcholu
	if ((p=node->FirstSon)!=0) {
		Putc('(',File,0); // začátek podstromu
		do {
			r = p->Brother;
			writeTree(File, p, fsfile); // zapíše podstrom
			if (!r) {
				break;
			}
			p = r;
			Putc(',',File,0);
		} while (1);
		Putc(')',File,0); // konec podstromu
	}
}


// Zapíše do řetězce dst identifikátor ID v kódové stránce codepage_dst.
int writeIDToString(char *dst, char *ID) {
	int i;
	char *pom = dst;
	for (i=0; ID[i]; i++) {
		switch (ID[i]) {
			case '[':
			case ']':
			case '=':
			//case '!':
			//case '<':
			//case '>':
			case ',':
			case '|':
//			case '&':
			case '\\': dst += sprintf(dst, "\\");
			//default: *dst++ = WriteCharConvert(ID[i]);
			default: *dst++ = ID[i];
		}
	}
	return dst - pom;
} // writeIDToString

// Zapíše do řetězce dst tabulku hodnot atributů ahtable.
// (Neumožňuje zápis jiné relace mezi atributem a jeho hodnotou než rovnítka!)
int writeNodeToString(char *dst, TValue *value, TFSFile *fsfile) {
	TValue *val = value;
	TAHLine *ahline,*ahl;
	TDefsLine *defsline;
	int PFlag,notfirst,i; // PFlag je příznak přeskočení prázdné hodnoty pozičního atributu - v tom případě je nutné vypsat i jeho jméno
	char *pom = dst;
	while (val) {
		if (val!=value) {
			dst += sprintf(dst,"|");
		}
		dst += sprintf(dst,"[");
		i = PFlag = notfirst = 0;
		defsline = fsfile->DefsTable;
		ahline = val->AHTable;
		for (; i<fsfile->AHNum; i++,defsline++,ahline++) {
			if (!((ahline->value)[0] || ahline->long_value) && !ahline->next) {
				if (defsline->IDType & ATTR_POS) {
					PFlag = 1; // přeskočený poziční atribut
				}
			}
			else {
				if (notfirst) {
	 				dst += sprintf(dst,",");
				}
				else {
					notfirst = 1;
				}
				if (!(defsline->IDType & ATTR_POS) || PFlag) {
					dst += writeIDToString(dst, defsline->ID); // vypsání jména atributu
					dst += sprintf(dst,"=");
					if (defsline->IDType & ATTR_POS) {
						PFlag = 0;
					}
				}
				dst += writeIDToString(dst, getAHLineValue(ahline));	// vypsání hodnoty atributu
				ahl = ahline->next;
				while (ahl) { // vypsání všech ostatních hodnot
					dst += sprintf(dst,"|");
					dst += writeIDToString(dst, getAHLineValue(ahl));
					ahl = ahl->next;
				}
			}
		}
		dst += sprintf(dst,"]");
		val = val->Next;
	}
	return dst - pom;
} // writeNodetoString


int writeTreeToString (char *dst, TNode *node, TFSFile *fsfile) {
	TNode *p,*r;
	char *pom = dst;
	dst += writeNodeToString (dst, node->Values, fsfile);	// hodnoty atributů vrcholu
	if ((p=node->FirstSon)!=0) {
		dst += sprintf(dst,"(");		// začátek podstromu
		do {
			r = p->Brother;
			dst += writeTreeToString(dst, p, fsfile);	// zapíe podstrom
			if (!r) {
				break;
			}
			p = r;
			dst += sprintf(dst,",");
		} while (1);
		dst += sprintf(dst,")");		// konec podstromu
	}
	return dst - pom;
} // WriteTreeToString


// Zapíše definice atributů souboru.
void writeDefs (FILE *File, TFSFile *fsfile) {
	TDefsLine *line = fsfile->DefsTable;
	TAHLine *vals;
	int i = 0,j,c;
	for (; i<fsfile->AHNum; i++,line++) {
		Putc('@',File,0);
		if (line->IDType & ATTR_VAL) { // atribut určující slova věty
			Putc('V',File,0);
			Putc(' ',File,0);
			writeID(File, line->ID);
			//Putc('\r',File,0);
			Putc('\n',File,0);
			Putc('@',File,0);
		}
		switch (line->IDType & ATTR_FUNC) {
			case ATTR_KEY:Putc('K',File,0); // klíčový atribut (není v PDT)
							  break;
			case ATTR_POS:Putc('P',File,0); // poziční atribut
							  break;
			case ATTR_OBL:Putc('P',File,0); // povinný atribut (též poziční)
      					    Putc(' ',File,0);
					          writeID(File, line->ID);
					          Putc('\n',File,0);
					          Putc('@',File,0);
					          Putc('O',File,0);
							  break;
			case ATTR_NUM:Putc('N',File,0); // atribut určující pořadí uzlů ve stromě
							  break;
			case ATTR_WNUM:Putc('W',File,0); // atribut určující pořadí slov ve větě
							  break;
			case ATTR_HIDE:Putc('H',File,0); // atribut určující skrytost uzlu
							  break;
			default:Putc('P',File,0);		// poziční atribut
					//Putc(' ',File,0);
					//WriteID(File, line->ID, codepage_src, codepage_dst);
					//Putc('\n',File,0);
					//Putc('@',File,0);
					//Putc('O',File,0);
          break;
		}
		switch (line->IDType & ~ATTR_FUNC) {
			case ATTR_SHADOW:c = '1';
			break;
			case ATTR_HILITE:c = '2';
			break;
			case ATTR_XHILITE:c = '3';
			break;
			default: c = '\0';
		}
		if (c && !(line->IDType & ATTR_LIST)) {
			Putc(c,File,0);
		}
		Putc(' ',File,0);
		writeID(File, line->ID);
		//Putc('\r',File,0);
		Putc('\n',File,0);
		if (line->IDType & ATTR_LIST) { // výčtový atribut - výpis všech jeho hodnot
			Putc('@',File,0);
			Putc('L',File,0);
			if (c) {
				Putc(c,File,0);
			}
			Putc(' ',File,0);
			writeID(File, line->ID);
			Putc('|',File,0);
			vals = line->Vals;
			if (!(vals->value[0] || vals->long_value)) {
				vals = vals->next;
			}
			for (j=0; vals; vals=vals->next) {
				if (j) {
					Putc('|',File,0);
				}
				else {
					j = 1;
				}
				writeID(File, getAHLineValue(vals));
			}
			//Putc('\r',File,0);
			Putc('\n',File,0);
		}
	}
	//Putc('\r',File,0);
	Putc('\n',File,0);
} // WriteDefs


// Zapíše soubor fsfile pod jménem Path; v případě udání begin a end uloží mimo hlavičky pouze stromy mezi nimi.
int writeFile(const char *Path, TFSFile *fsfile, TTree *begin, TTree *end) {
	FILE *File;
	TTree *p,*r;
	//TMacro *m;
	int i;
	last_line_length = 0;
	if ((File=fopen(Path,"wb"))==0) {
		return 2;
	}
	writeDefs(File, fsfile);	// zapsání hlavičky
	p = begin ? begin : fsfile->Trees;
	r = end ? end->Next : 0;
	do {
		writeTree(File, p->Root, fsfile);	// zapsání stromu
		//Putc('\r',File,0);
		Putc('\n',File,0);
		p = p->Next;
	} while (p!=r);
	//Putc('\r',File,0);
	Putc('\n',File,0);
	//Putc('\r',File,0);
	Putc('\n',File,0);

	fclose(File);
	return 0;
} // WriteFile

TFSFile * readHead(FILE * uk) {
// Nacte hlavicku ze souboru uk do struktury TFSFile,
// kterou vytvori.
	TFSFile * pom = 0;
	int i2;

  		// DULEZITE - vyprazdneni bufferu

  		i2 = 0;
  		while (i2<BUFLEN)
	      		UngotBuffer[i2++] = '\0';

			ReadRecord.errnum = ReadRecord.x = 0;
  		ReadRecord.y = 1;

  		if ((pom=ReadDefs( uk ))==0)      // precteni hlavicky
  		{
				fprintf (stderr,"\nNetgraph: loadsave.cpp: nacti_hlavicku(...): Chyba %d při čtení hlavičky!\n", ReadRecord.errnum);
         		return 0;
  		}
	return pom;
}
