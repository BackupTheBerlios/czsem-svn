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

#include <stdio.h>
#include <string.h>
#include <ctype.h>

#include "define.h"
#include "trees.h"

//#define DEBUG_AHLINE_VALUE // ladění funkcí getAHLineValue a setAHLineValue 
//#define DEBUG_GET_SENTENCE // ladění funkcí pro sestavení věty 

void printTNode(TNode *node) {
  fprintf(stderr,"\n      Start of TNode:");
  fprintf(stderr,"\n        (to be implemented)");
  fprintf(stderr,"\n      End of TNode");
}

char *getAHLineValue(TAHLine *tahline) {
	if (tahline->long_value == NULL) { // long value does not exists
		if (tahline->value) { // short value exists
			#ifdef DEBUG_AHLINE_VALUE
				fprintf(stderr, "\nloadsave.cpp: getAHLineValue: Returning short value: \"%s\".",tahline->value);
			#endif
			return tahline->value;
		}
		else {
			#ifdef DEBUG_AHLINE_VALUE
				fprintf(stderr, "\nloadsave.cpp: getAHLineValue: Returning NULL");
			#endif
			return NULL; // short value does not exists
		}
	}
	else { // long value exists
		#ifdef DEBUG_AHLINE_VALUE
			fprintf(stderr, "\nloadsave.cpp: getAHLineValue: Returning long value: \"%s\".",tahline->long_value);
		#endif
		return tahline->long_value;
	}
}

int getAHLineLength(TAHLine *tahline) {
	if (tahline->long_value == NULL) { // long value does not exists
		if (tahline->value) { // short value exists
			#ifdef DEBUG_AHLINE_VALUE
				fprintf(stderr, "\nloadsave.cpp: getAHLineLength: returning length of the short value: \"%s\": %d",tahline->value, strlen(tahline->value));
			#endif
			return strlen(tahline->value);
		}
		else {
			#ifdef DEBUG_AHLINE_VALUE
				fprintf(stderr, "\nloadsave.cpp: getAHLineLength: returning 0");
			#endif
			return 0; // short value does not exists
		}
	}
	else { // long value exists
		#ifdef DEBUG_AHLINE_VALUE
			fprintf(stderr, "\nloadsave.cpp: getAHLineLength: returning length of the long value: \"%s\": %d",tahline->long_value, strlen(tahline->long_value));
		#endif
		return strlen(tahline->long_value);
	}
}

// Zkopiruje retezec src o delce length do struktury TAHLine; pouzije bud defaultni kratke alokovane misto nebo alokuje vetsi;
// vysledek zakonci binarni nulou
void setAHLineValue(TAHLine *dst_tahline, char *src, int length) {
	#ifdef DEBUG_AHLINE_VALUE
		fprintf(stderr, "\nloadsave.cpp: setAHLineValue: entering the function with value: %s\nof length: %d",src,length);
	#endif
	if (length <= MAXSHORTVALUELEN) { // hodnota se vejde do již alokovaného místa
		#ifdef DEBUG_AHLINE_VALUE
			fprintf(stderr, "\nloadsave.cpp: setAHLineValue: setting it as a short value");
		#endif
		strncpy(dst_tahline->value,src,length);
		dst_tahline->value[length] = '\0';
		dst_tahline->long_value = NULL; // pro jistotu to nastavím
	}
	else { // hodnota je příliš dlouhá pro již alokované místo
		#ifdef DEBUG_AHLINE_VALUE
			fprintf(stderr, "\nloadsave.cpp: setAHLineValue: setting it as a long value");
		#endif
		dst_tahline->long_value = new char[length+1];
		strncpy(dst_tahline->long_value,src,length);
		dst_tahline->long_value[length]='\0';
		dst_tahline->value[0] = '\0';
	}
	#ifdef DEBUG_AHLINE_VALUE
		fprintf(stderr, "\nloadsave.cpp: setAHLineValue: leaving the function");
	#endif
} // setAHLineValue

Token *newToken() { // alokuje místo pro nový token, inicializuje proměnné a vrátí ukazatel na strukturu
	Token *tok = new Token;
	if (tok == NULL) {
		fprintf(stderr,"\nloadsave.cpp: newToken: Cannot allocate a memory for the structure! Exiting.");
		exit(-1);
	}
	tok->text = NULL;
	tok->index = 0.0f;
	tok->length = 0;
	tok->space_before = TRUE;
	tok->next = NULL;
} // newToken	

void deleteTokens(Token *tok) { // uvolní rekurzivně paměť zabranou tokeny
	if (!tok) {
		return;
	}
	if (tok->next) { // nejde o poslední prvek seznamu
		deleteTokens(tok->next); // rekurzivně mažu zbytek seznamu
	}
	/* na text tokenu se z této struktury jen ukazuje, místo se nealokuje; proto se tady neuvolňuje
	if (tok->text) {
		delete tok->token;
	}*/
	delete tok;
} // deleteTokens

/*char *getToken(Token *tok) { // vrátí token jako řetězec
	return tok->text;
} // getToken*/

void setToken(Token *tok, char *text, float index) {
	if (tok) {
		tok->text = text;
		tok->index = index;
	}
} // setToken

void placeToken(Token **tok, char *text, float index) { // zařadí nový token do seznamu tokenů; při rovnosti indexů jde nový token za všechny se stejným indexem
	Token *rest;
	if (!*tok) { // jsem na konci spojového seznamu
		*tok = newToken();
		setToken(*tok, text, index);
	}
	else {
		if ((*tok)->index > index) { // mám zařadit před tento prvek
			rest = *tok; // uchovám zbytek spojového seznamu
			*tok = newToken(); // zařadím nový prvek spojového seznamu
			(*tok)->next = rest; // zapojím ten zbytek spojového seznamu za nový prvek
			setToken(*tok, text, index);
		}
		else { // nový token sem ještě nepatří - prohledám rekurzivně zbytek seznamu
			placeToken(&((*tok)->next), text, index);
		}
	}
} // placeToken

void addToken(Sentence *sent, char *text, float index) { // zařadí nový token do věty; při rovnosti indexů jde nový token za všechny se stejným indexem
	if (!sent) {
		fprintf(stderr,"\nloadsave.cpp: addToken: The argument Sentence *sent is NULL!");
	}
	placeToken(&(sent->first_token), text, index);
} // addToken

Sentence *newSentence() { // alokuje místo pro novou větu, inicializuje proměnné a vrátí ukazatel na strukturu
	Sentence *sent = new Sentence;
	if (sent == NULL) {
		fprintf(stderr,"\nloadsave.cpp: newSentence: Cannot allocate a memory for the structure! Exiting.");
		exit(-1);
	}
	sent->sentence = NULL;
	sent->filled = FALSE;
	sent->assembled = FALSE;
	sent->first_token=NULL;
} // newSentence

void deleteSentence(Sentence *sent) { // uvolní paměť alokovanou pro Sentence sent, rekurzivně uvolní spojový seznam tokenů
	if (!sent) {
		return;
	}
	if (sent->first_token) {
		deleteTokens(sent->first_token);
	}
	if (sent->sentence) {
		delete [] sent->sentence;
	}
	delete sent;
} // deleteSentence

int spaceBetween(char *text1, char *text2) { // vrací TRUE pokud mezi těmito slovy bývá ve větě mezera; jinak FALSE
// neřeší uvozovky a apostrofy, bere v úvahu jen poslední znak prvního slova a první znak druhého slova
	if ((text1==NULL) || (text2==NULL)) {
		return FALSE;
	}
	char c1 = *(text1 + strlen(text1) - 1); // vezmu poslední znak prvního slova
	switch (c1) {
		case '(': return FALSE;
		case '[': return FALSE;
		case '{': return FALSE;
	}
	char c2 = *text2; // vezmu první znak druhého slova
	switch (c2) {
		case ',': return FALSE;
		case '.': return FALSE;
		case ':': return FALSE;
		case ';': return FALSE;
		case '!': return FALSE;
		case '?': return FALSE;
		case ')': return FALSE;	
		case ']': return FALSE;	
		case '}': return FALSE;	
		default: return TRUE;
	}
} // spaceBetween

void assembleSentence(Sentence *sent) { // z tokenů sestaví větu, alokuje místo a nastaví prvek sent->text
	if (!sent) {
		return;
	}
	// nejprve projdu všechny tokeny a zjistím délku věty
	int length_total = 0;
	Token *tok = sent->first_token;
	char *prev_text = NULL;
	while (tok) {
		if (tok->text) {
			tok->length = strlen(tok->text);
		}
		else {
			tok->length = 0;
		}
		if (tok->length>0) { // tento token přispěje k délce věty
			length_total += tok->length;
			tok->space_before = spaceBetween(prev_text, tok->text);
			prev_text = tok->text;
			if (tok->space_before) {
				length_total ++; // započítám mezeru před slovem
			}
		}
		tok = tok->next;
	}
	// nyní mám v length_total celkovou délku věty včetně mezer
	// vytvořím místo na větu:
	sent->sentence = new char[length_total + 1]; // +1 kvůli zakončení řetězce binární nulou
	// a projdu znovu všechny tokeny a budu kopírovat slova a přidávat mezery do věty
	int position = 0;
	tok = sent->first_token;
	while (tok) {
		if (tok->length>0) {
			if (tok->space_before) {
				*(sent->sentence + position) = ' '; // přidám mezeru
				position ++;
			}
			strncpy(sent->sentence + position, tok->text, tok->length);
			position += tok->length;
		}			
		tok = tok->next;
	}
	*(sent->sentence + position) = '\0'; // řetězec zakončím binární nulou
	sent->assembled = TRUE;
	#ifdef DEBUG_GET_SENTENCE
		fprintf(stderr, "\nloadsave.cpp: assembleSentence: Sentence assembled is:\n'%s'",sent->sentence);
	#endif
} // assembleSentence	

float convertToFloat(char *src) {
	char *nptr, *endptr;
	nptr = endptr = src;
	float number = strtof(nptr, &endptr);
	if (nptr == endptr) { // the conversion didn't succeed
		return -1.0f;
	}
	return number;
} // convertToFloat

void fillSentenceRecursively(Sentence *sent, TNode *node, int attr_V_position, int attr_W_position) { // naplní rekurzivně spojový seznam tokenů struktury Sentence tokeny z uzlů
	char* text = getAHLineValue(node->Values->AHTable + attr_V_position); // string obsahující slovo
	char* poradi_string = getAHLineValue(node->Values->AHTable + attr_W_position); // string obsahující pořadí slova
	float poradi = convertToFloat(poradi_string);
	addToken(sent, text, poradi);
	TNode *son = node->FirstSon;
	while (son) {
		fillSentenceRecursively(sent, son, attr_V_position, attr_W_position);
		son = son->Brother;
	}
} // fillSentenceRucursively

void fillSentence(TTree *tree, int attr_V_position, int attr_W_position) { // naplní spojový seznam tokenů struktury Sentence tohoto stromu tokeny z uzlů tohoto stromu
	Sentence *sent = tree->sentence;
	fillSentenceRecursively(sent, tree->Root, attr_V_position, attr_W_position);
	tree->sentence->filled = TRUE;
	return;
} // fillSentence

char *getSentence(TTree *tree, int attr_V_position, int attr_W_position) { // vrátí větu obsaženou v této struktuře Sentence jako řetězec
	if (!tree) {
		return NULL;
	}
	if (!tree->sentence) { // struktura na vytvoření a uchování věty nebyla ještě vytvořena
		tree->sentence = newSentence();
	}
	Sentence *sent = tree->sentence;
	if (!sent->filled) { // do struktury Sentence je nejprve nutno vložit jednotlivé tokeny s jejich pořadím
		fillSentence(tree, attr_V_position, attr_W_position);	
	}
	if (!sent->assembled) { // větu je nutno nejprve sestavit z jednotlivých tokenů
		assembleSentence(sent);
	}
	return sent->sentence;
} // getSentence

// Alokuje novou tabulku atributů souboru, zvětšenou o num, zkopíruje do ní hodnoty ze staré tabulky, kterou smaže a nahradí novou.
void reallocDefsTable(TFSFile *fsfile, int num) {
	int i = 0;
	TDefsLine *defsline = new TDefsLine[fsfile->AHNum+num];
	for (; i<fsfile->AHNum; i++) {
		defsline[i] = fsfile->DefsTable[i];
	}
	fsfile->ResAHNum = fsfile->AHNum+num;
	delete[] fsfile->DefsTable;
	fsfile->DefsTable = defsline;
}

// Zjistí, zda se je daný znak whitespace.
int isWhiteSpace(char c) {
	if (c==' ' || c=='\n' || c=='\r' || c=='\t' || c=='\x1a')
		 return 1;
	else
		return 0;
}

//  Zjistí, zda je znak c znakem, který může být uvnitř identifikátoru.
int isIDChar(char c) {
	if ((c>='a' && c<='z') || (c>='A' && c<='Z') || (c>='0' && c<='9') || c=='_')
		return 1;
	else
		return 0;
}

// Zjistí, zda se řetězec value skládá pouze z čísel.
int checkNumAttr(const char *value) {
	int i = 0;
	while (value[i]!='\0')
		if (!isdigit(value[i++]))
			return 0;
	return 1;
}

// Vrací index atributu typu type v tabulce definic defstable.
int getAttrPos(TDefsLine *defstable, int AHNum, int type) {
	int i = 0;
	for (; i<AHNum; i++)
		if (defstable[i].IDType & type)
			return i;
	return -1;
}


// Funkce projde stromem root a ze vech vrcholů, které mají hodnotu atributu s polohou index rovnu min, vypíe do parametru
// buffer hodnotu atributu s indexem which, tj. slovo, které reprezentují. Dále najde nejblií vyí hodnotu atributu,
// který se ve stromě vyskytuje na místě index; tu pak vrátí v parametru next; kontroluje se nepřekračování velikosti bufferu,
// zadané v parametru bufsize. Tuto funkci volá pouze funkce GetSentence().
/*void GoThru(TNode *root, int index, int which, int min, int *next, char *buffer, int bufsize)
{
  int i;
  TNode *p = root;
  while (p)
  {
	 i = atoi(p->Values->AHTable[index].Value);
	 if (*next<=min && *next<i)
		*next = i;
	 if (i==min && which>=0 && strlen(buffer)<bufsize-MAXVALUELEN-2)
	 {
		strcat(buffer, p->Values->AHTable[which].Value);
		strcat(buffer, " ");
	 }
	 else
		if (i>min && i<*next)
		  *next = i;
	 GoThru(p->FirstSon, index, which, min, next, buffer, bufsize);
	 p = p->Brother;
  }
}*/

// Vypíe větu, kterou reprezentuje strom s kořenem root, do parametru buffer.
// Index udává polohu atributu, jeho hodnota určuje pořadí slov.
/*void GetSentence(TNode *root, int index, int firstval, int which, char *buffer, int bufsize)
{
  int i = firstval,next = 0;
  buffer[0] = '\0';
  while (1)
  {
	 GoThru(root, index, which, i, &next, buffer, bufsize);
	 if (i>=next)
		break;
	 i = next;
	 next = 0;
  }
}*/

// Zjistí index atributu s názvem WhatID v tabulce atributů souboru fsfile. Není-li tam , vrací -1.
int isThere(char *WhatID, TFSFile *fsfile) {
	TDefsLine *line = fsfile->DefsTable;
	int i = 0;
	for (; i<fsfile->AHNum; i++,line++) {
		if (!strcmp(WhatID,line->ID)) {
			return i;
		}
	}
	return -1;
}

// Zjistí, zda se ve spojovém seznamu hodnot atributů words nachází hodnota buffer.
// ??? musí se něco tady upravit kvůli jiným relacím než rovnítko?
int isOneOf(TAHLine *words, const char *buffer) {
	TAHLine *p = words;
	while (p) {
		if (p->long_value == NULL) { // hodnota atributu je krátká
			if (!strcmp(p->value, buffer)) {
				return 1;
			}
		}
		else { // hodnota atributu je dlouhá - uložena v long_value
			if (!strcmp(p->long_value, buffer)) {
				return 1;
			}			
		}
	p = p->next;
	}
	return 0;
}

// alokuje místo pro TAHline; nastaví implicitní hodnoty
TAHLine *newTAHLine() {
	TAHLine *tahline = new TAHLine;
	tahline->value[0] = '\0';
	tahline->long_value = NULL;
	tahline->relation = RELATION_EQ;
	tahline->contains_reference = 0;
	tahline->contains_regexp = 0;
	tahline->regexp.compilation = NULL;
	tahline->regexp.study = NULL;
	tahline->next = NULL;
	return tahline;
}

void copyTAHLine(TAHLine * zdroj, TAHLine * & cil) {
// Provede kopii TAHLine
	TAHLine * last = NULL,
		* pom = NULL;
	int length;
	
	for( ; zdroj != NULL; zdroj = zdroj -> next )
	{
		pom = newTAHLine();

		if( last )
			last -> next = pom;
		else
			cil = pom;

		strcpy(pom->value, zdroj->value);
		if (zdroj->long_value) {
			length = strlen(zdroj->long_value);
			pom->long_value = new char[length+1];
			strncpy(pom->long_value, zdroj->long_value, length);
			pom->long_value[length]='\0';
		}
		pom -> relation = zdroj -> relation;
		pom -> contains_reference = zdroj -> contains_reference;
		last = pom;
	}

	if( pom )
		pom -> next = NULL;

} // copyTAHLine

// Vytvoří kopii hodnot atributu source v dest; místo si vytvoří.
void copyAHLines(TAHLine *&dest, TAHLine *source) {
	int long_length;
	if (dest!=source) { // jde-li o rozdílné atributy
		freeAHLines(dest->next);	// zrušení dosavadních hodnot (až na první - ta byla alokována jako součást pole)
		strcpy(dest->value, source->value); // naplnění první hodnoty
		long_length = strlen(source->long_value);
		if (long_length > 0) {
			dest->long_value = new char[long_length];
			strncpy(dest->long_value, source->long_value, long_length);
			if (dest->long_value) {
				delete[] dest->long_value;
			}
			dest->long_value[long_length]='\0';
		}
		dest->relation = source->relation; // a relace
		dest->contains_reference = source->contains_reference; // a info o tom, zda je tu reference
		source = source->next;
		while (source) { // dokud je co kopírovat
			dest->next = newTAHLine();	// vytvoř nový prvek
			dest = dest->next;
			strcpy(dest->value, source->value); // a zkopíruj jeho hodnotu
			if (long_length > 0) {
				dest->long_value = new char[long_length];
				strncpy(dest->long_value, source->long_value, long_length);
				dest->long_value[long_length]='\0';
			}
			dest->relation = source->relation; // a relaci
			dest->contains_reference = source->contains_reference; // a info o tom, zda je tu reference
			source = source->next;
		}
		dest->next = NULL;		// "uzemnění" spojového seznamu
	}
}


// Uvolní dynamicky alokovanou paměť uvnitř jedné struktury TAHLine.
void freeInsideTAHLine(TAHLine *line) {
	if (line->long_value != NULL) {
		delete[] line->long_value;
	}
}

// Uvolní řetězec možných hodnot atributu (v rámci jedné sady).
void freeAHLines(TAHLine *line) {
  TAHLine *p;
  while (line) {
	 p = line->next;
	 if (line->long_value != NULL) {
		 delete[] line->long_value;
	 }
	 delete line;
	 line = p;
  }
}

// alokuje pole TAHLine
TAHLine *newTAHLineArray(int number_of_members) {
	TAHLine *tahline_array = new TAHLine[number_of_members];
	int i;
	for (i=0; i<number_of_members; i++) {
		(tahline_array[i].value)[0] = '\0';
		tahline_array[i].long_value = NULL;
		tahline_array[i].contains_reference = 0;
		tahline_array[i].contains_regexp = 0;
		tahline_array[i].regexp.compilation = NULL;
		tahline_array[i].regexp.study = NULL;
		tahline_array[i].next = NULL;
	}
	return tahline_array;
}

// Uvolní tabulku hodnot jedné sady.
void freeAHTable(TAHLine *lines, int AHNum)
{
	int i;

	for (i=0; i<AHNum; i++) {
		freeAHLines(lines[i].next); // uvolni alternativní hodnoty
		freeInsideTAHLine(lines + i); // uvolni dynamicky alokovanou paměť ze struktury první hodnoty
	}
  	delete[] lines; // uvolni pole struktur prvních hodnot
}

// Uvolní vechny sady hodnot vrcholu.
void freeValues(TValue *value, int AHNum)
{
  TValue *r,*p = value;
  while (p)
  {
	 freeAHTable(p->AHTable, AHNum);
	 r = p->Next;
	 delete p;
	 p = r;
  }
}

// Uvolní podstrom root.
void freeTree(TNode *root, int AHNum)
{
  TNode *r,*p = root->FirstSon;
  while (p)
  {
	 r = p;
	 p = p->Brother;
	 freeTree(r, AHNum);
  }
  freeValues(root->Values, AHNum);
  delete root;
}

// Uvolní tabulku definic atributů.
void freeDefsTable(TDefsLine *table, int AHNum)
{
  int i;
  for (i=0; i<AHNum; i++)
	 freeAHLines(table[i].Vals);
  delete[] table;
}

// Uvolní celý soubor fsfile.
void freeFile(TFSFile *fsfile)
{
	if (! fsfile) return;
  TTree *p,*r;
  freeDefsTable(fsfile->DefsTable, fsfile->AHNum);
  p = fsfile->Trees;
  while (p)		// cyklus přes vechny stromy
  {
	 r = p;
	 p = p->Next;
	 freeTree(r->Root, fsfile->AHNum);			// uvolnění stromu
	  deleteSentence(r->sentence); // uvolnění struktury pro sestavení a uchování sestavené věty
	 /*if (r->DefsTable)
		FreeDefsTable(r->DefsTable, r->AHNum);	// a případné kopie tabulky atributů u stromů ze schránky*/
	 delete r;
  }
  delete fsfile;
}

void addAttribute (TFSFile *gh, TDefsLine *src) { // prida jeden atribut (src) do hlavicky gh
	TDefsLine *line;
	if (gh -> AHNum == gh -> ResAHNum) { // je potreba zvetsit misto alokovane pro atributy
		//fprintf(stderr, "\ndotser.c: addAttribute: Reallocating the head.");
		reallocDefsTable (gh, RESERVEDNUM);
	}
	line = gh -> DefsTable + gh -> AHNum;
	gh -> AHNum++;
	strcpy (line -> ID, src -> ID); // zkopiruji jmeno atributu
	line -> IDType = src -> IDType; // jeho typ
	line -> Vals = NULL;
	//fprintf(stderr, "\ndotser.c: addAttribute: Going to copy list of values.");
	copyTAHLine(src -> Vals , line -> Vals); // a povolene hodnoty
} // addAttribute

void freeAttribute(TDefsLine *attribute) { // uvolni pamet zabiranou atributem
	freeAHLines(attribute -> Vals); // uvolni pripadne hodnoty atributu
	delete attribute; // uvolni samotny atribut
} // freeAttribute

TDefsLine* createAttribute(char *name, int type, char *values) { // vytvoreni attributu s danym jmenem, typem a hodnotami
	TDefsLine *attribute;
	attribute = new TDefsLine; // alokuje se misto pro atribut
	strcpy(attribute -> ID, name); // zkopirovani jmena atributu
	attribute -> IDType = type; // zkopirovani typu atributu
	attribute -> Vals = NULL; // hodnota v pripade, ze values je prazdne nebo NULL
	if (values == NULL) return attribute;

	// nyní z řetězce values přečtu jednotlivé položky oddělené čárkou a vytvořím z nich seznam v attribute -> Vals
	int length;
	char *ind;
	TAHLine **dst = &attribute -> Vals; // tady bude prvni polozka
	char *src = values; // budu cist odsud
	int lasts = strlen(src); // zbyvajici delka
	while (lasts > 0) { // dokud neni precten cely retezec
		ind = index(src, ',');	// ukazatel na oddelovac polozek
		if (ind != NULL) { // je-li tam jeste oddelovac (cili zbyvaji alespon dve polozky)
			length = ind - src;
		}
		else { // zbytek retezce je jedna polozka
			length = lasts;
		}
		(*dst) = newTAHLine();
		(*dst) -> next = NULL;
		setAHLineValue(*dst, src, length); // zkopiruji hodnotu atributu
		dst = &((*dst) -> next);
		src += length + 1; // posunu se na zacatek dalsi polozky, pokud tam jeste nejaka je
		lasts -= length + 1; // a o tolik mene znaku zbyva zpracovat
	}

	return attribute;
} // createAttribute

void createAndAddAttribute(TFSFile *head, char *name, int type, char *values) { // vytvori specifikovany atribut a prida ho do dane hlavicky
	TDefsLine *attribute;
	attribute = createAttribute(name, type, values); // vytvoreni meta attributu s danym jmenem, typem a hodnotami
	addAttribute(head, attribute);
	freeAttribute(attribute); // uvolnim pamet
} // createAndAddAttribute

void mergeHeads(TFSFile *dst, TFSFile *src) { // prida ze src do dst ty atributy, ktere tam dosud nebyly
	for (int i = 0; i < src->AHNum; i++) {
		if (isThere (src -> DefsTable[i].ID, dst) == -1 ) { // atr. dosud neni soucasti dst
			//fprintf(stderr, "\nGoing to add an attribute to the head.");
			addAttribute(dst, src -> DefsTable + i); // pridam jeden atribut
			//fprintf(stderr, "\nThe attribute has been added.");
		}
	}
} // mergeHeads
