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

// Tento soubor obsahuje definice globálních proměnných.
// 18.10.2002, hlavickovy soubor pridan 24.2.2005

#include "global.h"

TReadRecord ReadRecord = {0,0,0,0}; // do této proměnné jsou ukládány záznamy o kódové stránce, čísle a pozici případné chyby při čtení souboru
// všechny zbývající řetězce jsou naplněny v konstruktoru aplikace
char str_attribute[MAXATTRLEN]; 	// předdefinovaný název atributu
char str_value[MAXSHORTVALUELEN];	  	// předdefinovaná hodnota atributu
char str_numvalue[MAXSHORTVALUELEN]; 	// předdefinovaná hodnota číselného atributu
char str_new[STRINGLENGTH];	  	// název nového bezejmenného okna
			// následující řetězce určují, co se bude zobrazovat jako typ atributu v Attr:View
char str_attr_num[ATTRTYPESIZE]; // číselný atribut
char str_attr_both[ATTRTYPESIZE];// poziční povinný atribut
char str_attr_obl[ATTRTYPESIZE];	// povinný atribut
char str_attr_pos[ATTRTYPESIZE];	// poziční atribut
char str_attr_key[ATTRTYPESIZE];	// klíčový atribut
char str_attr_val[ATTRTYPESIZE]; // atribut určující slovo, zobrazené ve větě
char str_attr_list[ATTRTYPESIZE];// výčtový atribut

char *str_codepage[CODEPAGENUM];	// přípony souborů, příslušející jednotlivým kódovým stránkám
char convert_table[DIACRITNUM][CODEPAGENUM] = // převodní tabulka kódů jednotlivých znaků s českou diakritikou:
			{{'\xe1', '\xe1', '\xa0', '\xa0'},	// 1. sloupec - Windows
			 {'\xe8', '\xe8', '\x9f', '\x87'},	// 2. sloupec- ISOLATIN2
			 {'\xef', '\xef', '\xd4', '\x83'},	// 3. sloupec - PCLATIN2
			 {'\xe9', '\xe9', '\x82', '\x82'},	// 4. sloupec - KEYBCS2 (Kamenický)
			 {'\xec', '\xec', '\xd8', '\x88'},
			 {'\xed', '\xed', '\xa1', '\xa1'},
			 {'\xf2', '\xf2', '\xe5', '\xa4'},
			 {'\xf3', '\xf3', '\xa2', '\xa2'},
			 {'\xf8', '\xf8', '\xfd', '\xa9'},
			 {'\x9a', '\xb9', '\xe7', '\xa8'},
			 {'\x9d', '\xbb', '\x9c', '\x9f'},
			 {'\xfa', '\xfa', '\xa3', '\xa3'},
			 {'\xf9', '\xf9', '\x85', '\x96'},
			 {'\xfd', '\xfd', '\xec', '\x98'},
			 {'\x9e', '\xbe', '\xa7', '\x91'},
			 {'\xc1', '\xc1', '\xb5', '\x8f'},
			 {'\xc8', '\xc8', '\xac', '\x80'},
			 {'\xc9', '\xc9', '\x90', '\x90'},
			 {'\xcc', '\xcc', '\xb7', '\x89'},
			 {'\xcd', '\xcd', '\xd6', '\x8b'},
			 {'\xcf', '\xcf', '\xd2', '\x85'},
			 {'\xd2', '\xd2', '\xd5', '\xa5'},
			 {'\xd3', '\xd3', '\xe0', '\x95'},
			 {'\xd8', '\xd8', '\xfc', '\x9e'},
			 {'\x8a', '\xa9', '\xe6', '\x9b'},
			 {'\x8d', '\xab', '\x9b', '\x86'},
			 {'\xda', '\xda', '\xe9', '\x97'},
			 {'\xd9', '\xd9', '\xde', '\xa6'},
			 {'\xdd', '\xdd', '\xed', '\x9d'},
			 {'\x8e', '\xae', '\xa6', '\x92'},
			 {'\xe4', '\xe4', '\x84', '\x84'}, // 'ä' (přehlasované 'a')
			 {'\xf4', '\xf4', '\x93', '\x93'}, // 'ô' ('o' se stříškou)
			 {'\xbe', '\xb5', '\x96', '\x8c'}, // '?' (měkké 'l')
			 {'\xe5', '\xe5', '\x92', '\x8d'}, // '?' (dlouhé 'l')
			 {'\xc4', '\xc4', '\x8e', '\x8e'}, // 'Ä' (přehlasované 'A')
			 {'\xd4', '\xd4', '\xe2', '\xa7'}, // 'Ô' ('O' se stříškou)
			 {'\xbc', '\xa5', '\x95', '\x9c'}, // '?' (měkké 'L')
			 {'\xc5', '\xc5', '\x91', '\x8a'}, // '?' (dlouhé 'L')
			 {'\xf6', '\xf6', '\x94', '\x94'}, // 'ö' (přehlasované 'o')
			 {'\xd6', '\xd6', '\x99', '\x99'}, // 'Ö' (přehlasované 'O')
			 {'\xfc', '\xfc', '\x81', '\x81'}, // 'ü' (přehlasované 'u')
			 {'\xdc', '\xdc', '\x9a', '\x9a'}, // 'Ü' (přehlasované 'U')
			 {'\xeb', '\xeb', '\x8a', '\xeb'}, // 'ë' (přehlasované 'e') (v tomto řádku jsou správně jen první tři sloupce)
			 {'\xcb', '\xcb', '\xd3', '\xcb'}}; // 'Ë' (přehlasované 'E') (v tomto řádku jsou správně jen první tři sloupce)
