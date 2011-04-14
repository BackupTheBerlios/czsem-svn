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

// Tento soubor obsahuje deklarace globálních proměnných.
// 18.10.2002, hlavickovy soubor pridan 24.2.2005

#ifndef _GLOBAL_H
#define _GLOBAL_H

#include "define.h"
#include "trees.h"

extern TReadRecord ReadRecord; // do této proměnné jsou ukládány záznamy o kódové stránce, čísle a pozici případné chyby při čtení souboru
// všechny zbývající řetězce jsou naplněny v konstruktoru aplikace
extern char str_attribute[MAXATTRLEN]; 	// předdefinovaný název atributu
extern char str_value[MAXSHORTVALUELEN];	  	// předdefinovaná hodnota atributu
extern char str_numvalue[MAXSHORTVALUELEN]; 	// předdefinovaná hodnota číselného atributu
extern char str_new[STRINGLENGTH];	  	// název nového bezejmenného okna
			// následující řetězce určují, co se bude zobrazovat jako typ atributu v Attr:View
extern char str_attr_num[ATTRTYPESIZE]; // číselný atribut
extern char str_attr_both[ATTRTYPESIZE];// poziční povinný atribut
extern char str_attr_obl[ATTRTYPESIZE];	// povinný atribut
extern char str_attr_pos[ATTRTYPESIZE];	// poziční atribut
extern char str_attr_key[ATTRTYPESIZE];	// klíčový atribut
extern char str_attr_val[ATTRTYPESIZE]; // atribut určující slovo, zobrazené ve větě
extern char str_attr_list[ATTRTYPESIZE];// výčtový atribut

extern char *str_codepage[CODEPAGENUM];	// přípony souborů, příslušející jednotlivým kódovým stránkám
extern char convert_table[DIACRITNUM][CODEPAGENUM]; // převodní tabulka kódů jednotlivých znaků s českou diakritikou:

#endif
