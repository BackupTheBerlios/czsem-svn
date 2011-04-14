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

#ifndef _TREES_H
#define _TREES_H

#include <pcre.h> // regulární výrazy schopné zvládnout UTF-8; zde pro definování struktury uchovávající zpracovaný regulární výraz

#include "define.h"

struct Token { // jeden prvek (token) věty
	char *text; // samotný text tokenu
	float index; // jeho index ve větě (ne nutně celé číslo)
	int length; // délka tokenu; obsahuje správnou hodnotu až po zavolání assembleSentence
	int space_before; // TRUE pokud má být před tímto tokenem mezera, jinak FALSE; obsahuje správnou hodnotu až po zavolání assembleSentence
	Token *next; // další token věty
};

struct Sentence { // věta příslušející ke stromu
	char *sentence; // sestavená věta jakožto řetězec
	int filled; // indikátor naplněnosti seznamu tokenů (FALSE=nenaplněn, TRUE=naplněn)
	int assembled; // indikátor sestavenosti věty (FALSE=nesestavena, TRUE=sestavena)
	Token *first_token; // první token věty; spojový seznam je vždy setříděný, nové prvky se zatřiďují
};

struct RegExp { // zpracovaný regulární výraz
  pcre *compilation; // zkompilovaný regulární výraz
  pcre_extra *study; // detailně zkoumaný regulární výraz pro optimalizaci matchování
};

struct TAHLine               // položka tabulky hodnot atributů nebo prvek spojového seznamu hodnot
{
  char value[MAXSHORTVALUELEN+1];    // hodnota atributu (+1 pro pripadnou binarni nulu koncici maximalne dlouhy retezec)
  char *long_value;        // hodnota atributu v případě, že nestačí alokovaná délka value; v tom případě je value=""; jinak je long_value=NULL
  int relation;          // vztah atributu k dané hodnotě (rovnost, nerovnost, větší, menší, ...)
  int contains_reference;     // uchovává informaci, zda je v této hodnotě reference (0 = dosud nezjištěno, 1 = ano, 2 = ne)
  int contains_regexp;     // uchovává informaci, zda je v této hodnotě regulární výraz (0 = dosud nezjištěno, 1 = ano, je zpracován v 2 = ne)
  RegExp regexp;            // uchovává zkompilovaný a prozkoumaný regulární výraz, pokud je tato hodnota atributu reg. výrazem
  struct TAHLine *next;       // ukazatel na další možnou hodnotu atributu
};

struct TValue      			// reprezentuje jednu celou sadu hodnot jednoho vrcholu
{
  TAHLine *AHTable;			// ukazatel na tabulku hodnot (jde o dynamicky alokované pole !!!!!!!!!)
  TValue *Next;				// ukazatal na další sadu
};

struct TTree;           // pro křížovou referenci

struct TNode              // vrchol stromu
{
  TValue *Values;         // ukazatel na seznam sad hodnot atributů
  TNode *father;          // ukazatel na otce vrcholu
  TNode *Brother;         // ukazatel na bratra vrcholu
  TNode *FirstSon;        // ukazatel na nejlevějšího syna
  //TTree *tree;            // ukazatel na strom, do kterého tento uzel patří
  int depth_from_root;    // vzdálenost od kořene stromu; počítáno v dotser.c: preprocessTree; je spočítáno i ve skrytých vrcholech
  int max_depth_to_leaf;  // nejdelší vzdálenost do listu; počítáno v dotser.c: preprocessTree; skryté vrcholy se nepovažují za vrcholy (a samy obsahují nulu)
  int nodes_in_subtree;   // počet neskrytých vrcholů v podstromu včetně tohoto; počítáno v dotser.c: preprocessTree; skryté uzly se nepočítají za vrcholy (a samy obsahují nulu)
  int number_of_sons;     // počet bezprostředních neskrytých synů vrcholu; počítáno v dotser.c: preprocessTree
  int number_of_hidden_sons;  // počet bezprostředních skrytých synů vrcholu; počítáno v dotser.c: preprocessTree
  int number_of_left_brothers; // počet neskrytých levých bratrů (určuje se podle atributu s příznakem ATTR_NUM v hlavičce, a to u skrytých i neskrytých vrcholů)
  int number_of_right_brothers; // počet neskrytých pravých bratrů (určuje se podle atributu s příznakem ATTR_NUM v hlavičce, a to u skrytých i neskrytých vrcholů)
  int hidden;             // jedná se o skrytý vrchol? 0 == neskrytý, 1 == skrytý, 2 == oboje (u dotazu)
  int depth_first_order;  // pořadí vrcholu při průchodu do hloubky; root má pořadí 0; počítají se i skryté vrcholy; počítáno v dotser.c: preprocessTree
  char *name;             // případné pojmenování vrcholu (realizováno meta atributem META_NODE_NAME)
};

struct TDefsLine          // položka tabulky atributů, definovaných v souboru
{
  char ID[MAXATTRLEN];    // jméno atributu
  int IDType;             // typ atributu
  TAHLine *Vals;          // ukazatel na začátek seznamu povolených hodnot (pouze u výčtového atributu)
};

struct TFSFile;           // pro křížovou referenci

struct TTree              // strom
{
  TNode *Root;            // ukazatel na kořen
  Sentence *sentence;  // ukazatel na strukturu použitelnou k získání řetězcové podoby věty reprezentované tímto stromem
  //int AHNum;              // počet atributů, definovaných v původním souboru - nenulové pouze pro strom ve schránce
  //TDefsLine *DefsTable;   // ukazatel na vlastní kopii tabulky atributů souboru - nenulové pouze pro strom ve schránce
  //TFSFile *file;          // ukazatel na soubor stromů, do kterého tento strom patří
  TTree *Next;            // ukazatel na následující strom
  TTree *Prev;            // ukazatel na předchozí strom
};

struct TFSFile            // soubor
{
  int AHNum;              // počet definovaných atributů
  int ResAHNum;           // počet alokovaných položek v definicích a každém vrcholu souboru
  TDefsLine *DefsTable;   // ukazatel na tabulku definovaných atributů
  TTree *Trees;           // ukazatel na obousměrný spojový seznam stromů v souboru
  long TreeNum;           // počet stromů v souboru
};

void printTNode(TNode *node);

// Zkopiruje retezec src o delce length do struktury TAHLine; pouzije bud defaultni kratke alokovane misto nebo alokuje vetsi;
// vysledek zakonci binarni nulou
void setAHLineValue(TAHLine *dst_tahline, char *src, int length);
 
// zařadí nový token do věty; při rovnosti indexů jde nový token za všechny se stejným indexem
void addToken(Sentence *sent, char *text, float index);

// alokuje místo pro novou větu, inicializuje proměnné a vrátí ukazatel na strukturu
Sentence *newSentence();

// uvolní paměť alokovanou pro Sentence sent, rekurzivně uvolní spojový seznam tokenů
void deleteSentence(Sentence *sent);

// vrátí větu reprezentovanou daným stromem jako řetězec; při prvním volání na daný strom vytvoří a naplní strukturu Sentence daného stromu
char *getSentence(TTree *tree, int attr_V_position, int attr_W_position);

// Alokuje novou tabulku atributů souboru, zvětšenou o num, zkopíruje do ní hodnoty ze staré tabulky, kterou smaže a nahradí novou.
void reallocDefsTable(TFSFile *fsfile, int num);

// vrátí ukazatel na hodnotu tohoto prvku TAHline; to může být buď tahline->value nebo tahline->long_value, v závislosti na délce hodnoty
char *getAHLineValue(TAHLine *tahline);

// vrátí délku hodnoty tohoto prvku TAHLine
int getAHLineLength(TAHLine *tahline);

// Zjistí, zda se je daný znak whitespace.
int isWhiteSpace(char c);

//  Zjistí, zda je znak c znakem, který může být uvnitř identifikátoru.
int isIDChar(char c);

// Zjistí, zda se řetězec value skládá pouze z čísel.
int checkNumAttr(const char *value);

// Vrací index atributu typu type v tabulce definic defstable.
int getAttrPos(TDefsLine *defstable, int AHNum, int type);

// Zjistí index atributu s názvem WhatID v tabulce atributů souboru fsfile. Není-li tam , vrací -1.
int isThere(char *WhatID, TFSFile *fsfile);

// Zjistí, zda se ve spojovém seznamu hodnot atributů words nachází hodnota buffer.
// ??? musí se něco tady upravit kvůli jiným relacím než rovnítko?
int isOneOf(TAHLine *words, const char *buffer);

// Alokuje paměť pro TAHLine a inicializuje hodnoty
TAHLine *newTAHLine();

// Uvolní řetězec možných hodnot atributu (v rámci jedné sady).
void freeAHLines(TAHLine *line);

// alokuje pole TAHLine
TAHLine *newTAHLineArray(int number_of_members);

// Uvolní tabulku hodnot jedné sady.
void freeAHTable(TAHLine *lines, int AHNum);

// Uvolní vechny sady hodnot vrcholu.
void freeValues(TValue *value, int AHNum);

// Uvolní podstrom root.
void freeTree(TNode *root, int AHNum);

// Uvolní tabulku definic atributů.
void freeDefsTable(TDefsLine *table, int AHNum);

// Uvolní celý soubor fsfile.
void freeFile(TFSFile *fsfile);

// Alokuje novou tabulku atributů souboru, zvětšenou o num, zkopíruje do ní hodnoty ze staré tabulky, kterou smaže a nahradí novou.
void reallocDefsTable(TFSFile *fsfile, int num);

//void addAttribute (TFSFile *gh, TDefsLine *src); // prida jeden atribut (src) do hlavicky gh

void createAndAddAttribute(TFSFile *head, char *name, int type, char *values); // vytvori specifikovany atribut a prida ho do dane hlavicky

void mergeHeads(TFSFile *dst, TFSFile *src); // prida ze src do dst ty atributy, ktere tam dosud nebyly

#endif
