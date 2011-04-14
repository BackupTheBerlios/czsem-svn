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

// Tento soubor obsahuje deklarace funkcí pro čtení a zápis souborů typu fs a jejich převod z textového formátu do struktur, používaných Netgraphem
// 6.8.2004, hlavickovy soubor pridan 24.4.2005

#ifndef _LOADSAVE_H
#define _LOADSAVE_H

#define MAXEXT 5		// přidáno kvůli zrušení <dir.h>

//#include "global.h"
#include "define.h"
#include "trees.h"

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

extern int last_line_length;	// délka posledního řádku na výstupu
// tato proměnná je inicializována při začátku zápisu

// Přečte soubor Path
TFSFile *readFile(const char *Path);
	// čte hlavičku a stromy ze souboru Path

int writeTreeToString (char *dst, TNode *node, TFSFile *fsfile);

// Zapíše definice atributů souboru.
void writeDefs (FILE *File, TFSFile *fsfile);

// Zapíše soubor fsfile pod jménem Path; v případě udání begin a end uloží mimo hlavičky pouze stromy mezi nimi; v Netgraphu není tato funkce použita
int writeFile(const char *Path, TFSFile *fsfile, TTree *begin = 0, TTree *end = 0);

// Přečte hlavičku souboru uk (definice atributů)
TFSFile * readHead(FILE * uk);

#endif
