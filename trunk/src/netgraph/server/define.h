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

// define.h - 11.10.2006
// Tento hlavičkový soubor je vkládán do všech modulů
 
#ifndef _DEFINE_H
#define _DEFINE_H

#define TRUE 1
#define FALSE 0

#define MAXATTRLEN 30           // max. délka jména atributu
#define MAXSHORTVALUELEN 20     // max. délka hodnoty atributu v automaticky alokovaném místě; překročení je ošetřeno (alokováním nového dynamického odkazu); musí být nejméně 1, protože tam vkládám ukončovací znak řetězce
#define MAXLONGVALUELEN 5000	// max. délka hodnoty atributu; pokud je překročena tato hodnota, zbytek je odříznut
// nejdelší věta uložná v atributu sentence na tekto rovině má téměř 1500 znaků; automatické alokování takového místa pro všechny hodnoty
// atributů znamenalo velkou paměťovou náročnost a několikanásobné zpomalení načítání stromů, potažmo vyhledávání

#define MAXLENFILENAME 256         // max. delka jmena souboru - pouziva se jako dostatecna rezerva na konci zpravy pro jeste jeden soubor
#define MPL 500                    // maximalni delka adresar. cesty

#define ATTR_FAKE_ENCODING -1        // kód pro označení podvrženého atributu pro určení kódování souboru
#define ATTR_KEY 0                   // kód klíčového atributu
#define ATTR_POS 1                    // kód pozičního atributu
#define ATTR_OBL 3                   // kód povinného atributu
#define ATTR_NUMTEST 4					// bit určující číselný atribut
#define ATTR_NUM 7						// kód číselného atributu pro vykreslení stromu
#define ATTR_VAL 8						// kód atributu, jehož hodnota bude použita pro sestavení textu věty
#define ATTR_LIST 16						// kód výčtového atributu
#define ATTR_WNUM 33         // kód číselného atributu pro výpis věty
#define ATTR_WNUMTEST 32  // bit určující atribut pro výpis věty
#define ATTR_HIDE 65                   // kód atributu pro skrývání (hide)
#define ATTR_HIDETEST 64       // bit určující atribut pro skrývání
#define ATTR_FUNC 127    				// funkční maska (bez vlastností zobrazení)
#define ATTR_SHADOW 128    // následují tři kódy atributů, používané při jejich zobrazení
#define ATTR_HILITE 256
#define ATTR_XHILITE 384

#define RESERVEDNUM 30         // počet atributů, pro který je alokována pamět v případě, že dosavadní nestačí (původně tu bylo 3, pak dlouho 20)
// v tektogram. stromech je asi 55 atributů, meta-atributů je kolem 11
// v analytickych stromech je asi 17 atributů, meta-atributů je kolem 11

#define STRINGLENGTH 256      // max. délka řetězce ze zdroje (resource)
#define ATTRTYPESIZE 40        // max. počet znaků, popisujích typ atributu
#define OUTPUTLINELEN 80		// max. délka řádku výstupu tvoří součet OUTPUTLINELEN a MAXVALUELEN

#define RELATION_EQ 0   // relace rovnost
#define RELATION_NEQ 1   // relace nerovnost
#define RELATION_LT 2   // relace menší než
#define RELATION_GT 3   // relace větší než
#define RELATION_LTEQ 4   // relace menší nebo rovno
#define RELATION_GTEQ 5   // relace větší nebo rovno

// definice jména atributu lemmatu (u toho se pak při matchování (ne)ignorují varianty a komentáře
#define LEMMA_LABEL "m/lemma"

// definice jmen metaatributů
#define META_TRANSITIVE_PARENT_EDGE "_transitive"  // meta atribut pro definici tranzitivní hrany k předkovi uzlu
#define META_OPTIONAL_NODE "_optional"  // meta atribut pro definici nepovinného vrcholu
#define META_NUMBER_OF_SONS "_#sons"  // meta atribut pro definici počtu synů
#define META_NUMBER_OF_HIDDEN_SONS "_#hsons"  // meta atribut pro definici počtu skrytých synů
#define META_DEPTH_FROM_ROOT "_depth"  // meta atribut pro definici vzdálenosti od kořene stromu
#define META_NUMBER_OF_DESCENDANTS "_#descendants"  // meta atribut pro definici počtu všech potomků
#define META_NUMBER_OF_LEFT_BROTHERS "_#lbrothers"  // meta atribut pro definici počtu levých bratrů
#define META_NUMBER_OF_RIGHT_BROTHERS "_#rbrothers"  // meta atribut pro definici počtu pravých bratrů
#define META_NUMBER_OF_OCCURRENCES "_#occurrences"  // meta atribut pro definici počtu danych vrcholu primo pod otcem daneho vrcholu
#define META_NODE_NAME "_name"  // meta atribut pro pojmenování vrcholu
#define META_SENTENCE "_sentence"  // meta atribut obsahující celou větu
#define META_DEPENDENCE "_dependence"  // meta atribut pro změnu typu rodičovské hrany na koreferenční odkaz

// typy tranzitivní hrany (popisky (= hodnoty atributů) a integer hodnoty pro testování):
#define TRANSITIVITY_TYPES_LABELS "true,exclusive,false" // souhrn následujícího pro souhrnné předání při vytváření meta-atributu
#define TRANSITIVITY_TYPE_NONE_LABEL "false" // žádná tranzitivita
#define TRANSITIVITY_TYPE_NONE_INT 0
#define TRANSITIVITY_TYPE_TRUE_LABEL "true" // plná tranzitivita = existence v podstromu
#define TRANSITIVITY_TYPE_TRUE_INT 1
#define TRANSITIVITY_TYPE_EXCLUSIVE_LABEL "exclusive" // zabírá hrany po cestě
#define TRANSITIVITY_TYPE_EXCLUSIVE_INT 2


#endif
