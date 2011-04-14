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

#include <string.h>
#include <stdio.h>

#include "matching.h"
#include "messages.h"
#include "mutual.h"
#include "define.h"

//#define DEBUG_SCAN_GLOBAL_HEAD  // ladi funkci scanGlobalHead
//#define DEBUG_SCAN_HEAD  // ladi funkci scanHead
//#define DEBUG_PREPROCESS_REGEXPS // ladí předzpracování regulárních výrazů v dotazu
//#define DEBUG_PREPROCESS_TREE // ladí předzpracování stromů

//#define DEBUG_MATCH_DOUBLE_VALUES  // ladí porovnávání číselných hodnot v hodnotách atributů
//#define DEBUG_MATCH_STRING_VALUES  // ladí porovnávání řetězců v hodnotách atributů
//#define DEBUG_MATCH_REGEXP_VALUES  // ladí matchování regulárních výrazů v hodnotách atributů
//#define DEBUG_NUMBER_OF_BROTHERS  // ladi zpracovani meta atributu META_NUMBER_OF_LEFT_BROTHERS a *_RIGHT_*
//#define DEBUG_CHECK_REFERENCE_VALUE // ladi funkci pro zjistovani, zda hodnota atributu obsahuje odkaz na hodnotu atributu jiného uzlu
//#define DEBUG_GET_DEREFERENCED_VALUE // ladi funkci pro dereferencovani referenci v hodnotach atributu dotazu
//#define DEBUG_GET_ONE_DEREFERENCED_VALUE  // ladi funkci getOneDereferencedValue
//#define DEBUG_MATCH_VALUES  // ladí porovnávání hodnot atributů
//#define DEBUG_MATCH_META_VALUES  // ladí porovnávání hodnot meta atributů
//#define DEBUG_SADY_MATCH  // ladi funkci sady_match
//#define DEBUG_SADA_VRCHOL_MATCH  // ladi funkci sada_vrchol_match

// operátory pro funkci convertToDoubleAddSub
#define OP_NULL 0 // operátor pro nic nedělání
#define OP_ADD 1 // operátor pro sčítání
#define OP_SUB 2 // operátor pro odečítání

#define NIC -1   // pro zobrazeni hlavicek - neex. obraz (ovšem pro metaatribut viz META_ATTRIBUTE v hlavickovem souboru)

TFSFile * GlobHlav = NULL;	// Globalni Hlavicka
TFSFile *actualFileOfTrees; // seznam stromů načtených z jednoho souboru

TTree *actual_tree; // aktuálně prohledávaný strom

char refValueRestricted[MAXLONGVALUELEN]; // používá se pro vracení ukazatele na zúženou hodnotu ve funkci getOneDereferencedValue

int match_lemma_variants; // TRUE/FALSE - mají se matchovat lemmata bez ohledu na varianty?
int match_lemma_comments; // TRUE/FALSE - mají se ignorovat poznámky a vysvětlivky při matchování lemmat?

int attr_N_position; // pro nový soubor není pozice numerického atributu ještě určena
int attr_V_position; // ani atributu se slovy věty
int attr_W_position; // ani atributu určujícího pořadí slov věty

int lemma_position_gh; // pozice lemmatu v globální hlavičce (-1, pokud v hlavičce není, ale u PDT je vždycky)
int hidden_position_gh; // pozice atributu pro skryté vrcholy v globální hlavičce (-1, pokud v hlavičce není)
int hidden_position; // pozice atributu pro skryté vrcholy v prohledávaných stromech (-1, pokud v hlavičce není)

// pro následující pozice meta atributů v glob. hlavičce je -1 defaultní hodnota (tj. pokud atribut není v hlavičce přítomen)
int meta_transitive_parent_edge_position_gh; // pozice meta atributu pro transitivní hranu v glob. hlavičce
int meta_optional_node_position_gh; // pozice meta atributu pro nepovinný vrchol v glob. hlavičce
int meta_number_of_sons_position_gh; // pozice meta atributu pro počet synů v glob. hlavičce
int meta_number_of_hidden_sons_position_gh; // pozice meta atributu pro počet skrytých synů v glob. hlavičce
int meta_depth_from_root_position_gh; // pozice meta atributu pro počet synů v glob. hlavičce
int meta_number_of_descendants_position_gh; // pozice meta atributu pro počet všech potomků v glob. hlavičce
int meta_number_of_occurrences_position_gh; // pozice meta atributu pro počet takovych synu predka daneho vrcholu
int meta_node_name_position_gh; // pozice meta atributu pro pojmenování vrcholu v glob. hlavičce
int meta_number_of_left_brothers_position_gh; // pozice meta atributu pro počet levých bratrů v glob. hlavičce
int meta_number_of_right_brothers_position_gh; // pozice meta atributu pro počet pravých bratrů v glob. hlavičce
int meta_sentence_position_gh; // pozice meta atributu obsahujícího větu v glob. hlavičce
int meta_dependence_position_gh; // pozice meta atributu pro změnu rodičovské hrany na koreferenci v glob. hlavičce

int safeStrLen(char *str) {
	if (str) {
		return strlen(str);
	}
	else {
		return 0;
	}
}

int isMetaAttribute(char *attribute_name) { // rozpozná meta atribut podle počátečního podtržítka
	if (*attribute_name == '_') return TRUE;
	else return FALSE;
}

void matchHeads( TFSFile * vzor, TFSFile * obraz, int * vysl ) {
// urci zobrazeni hlavicky vzor (Glob. hlavicka) do hlavicky obraz (hlavicka souboru)
// vysledek zapise do vysl
	char *vzorID;
	int pocetCilID, pocetVzorID;
	pocetCilID = obraz -> AHNum;
	pocetVzorID = vzor -> AHNum;
	for( int i = 0; i < pocetVzorID; i++ ) { // přes všechny atributy globální hlavičky
		vysl[i] = NIC;
		vzorID = vzor -> DefsTable[i].ID;
		if (isMetaAttribute(vzorID)) { // meta atributy dostanou obraz -2, tak se potom poznají
			vysl[i] = META_ATTRIBUTE;
		}
		else {
			for( int j = 0; j < pocetCilID; j++ ) {
				if (! strcmp(vzorID, obraz -> DefsTable[j].ID)) {
					vysl[i] = j;
					break;
				}
			}
		}
	}
} // matchHeads

int scanGlobalHead(TFSFile *tree_file) { // prohlédne hlavičku souboru stromů - zapamatuje si pozice význačných atributů a meta atributů; používá se pro globální hlavičku
	// dříve se to provádělo v matchHeads (odtud názvy některých proměnných), ale to se zbytečně dělalo opakovaně při načtení každého nového souboru se stromy; stačí to jednou po vložení dotazu
	char *vzorID;
	int attr_type;
	int pocetID;
	pocetID = tree_file -> AHNum;
	lemma_position_gh = -1; // pozice lemma v globální hlavičce; zatím neurčena
	hidden_position_gh = -1; // pozice atributu pro skrývání vrcholů v globální hlavičce; zatím neurčena
	meta_transitive_parent_edge_position_gh = -1; // pozice meta atributu v glob. hlavičce
	meta_optional_node_position_gh = -1; // pozice meta atributu v glob. hlavičce
	meta_number_of_sons_position_gh = -1; // pozice meta atributu v glob. hlavičce
	meta_number_of_hidden_sons_position_gh = -1; // pozice meta atributu v glob. hlavičce
	meta_depth_from_root_position_gh = -1; // pozice meta atributu v glob. hlavičce
	meta_number_of_descendants_position_gh = -1; // pozice meta atributu v glob. hlavičce
	meta_number_of_left_brothers_position_gh = -1; // pozice meta atributu v glob. hlavičce
	meta_number_of_right_brothers_position_gh = -1; // pozice meta atributu v glob. hlavičce
	meta_number_of_occurrences_position_gh = -1; // pozice meta atributu v glob. hlavičce
	meta_node_name_position_gh = -1; // pozice meta atributu v glob. hlavičce
	for( int i = 0; i < pocetID; i++ ) { // přes všechny definované atributy
		vzorID = tree_file -> DefsTable[i].ID; // ukážu si na jméno atributu
		attr_type = tree_file -> DefsTable[i].IDType; // vezmu si typ atributu
		#ifdef DEBUG_SCAN_GLOBAL_HEAD
			fprintf (stderr,"\ndotser.c: scanGlobalHead: the attribute name is %s, its type is %d",vzorID,attr_type);
		#endif
		if (! strcmp(vzorID, LEMMA_LABEL)) { // zapamatuji si pozici lemma v Globalni hlavicce
			lemma_position_gh = i;
		}
		else {
			if (attr_type & ATTR_HIDETEST) { // je to atribut pro skrývání vrcholů
				hidden_position_gh = i;
			}
			else {
				if (isMetaAttribute(vzorID)) { // z dalších atributů už mě zajímají jenom meta atributy
					if (! strcmp(vzorID, META_TRANSITIVE_PARENT_EDGE)) { // zapamatuji si pozici meta atributu v Globalni hlavicce
						meta_transitive_parent_edge_position_gh = i;
					}
					else {
						if (! strcmp(vzorID, META_OPTIONAL_NODE)) { // zapamatuji si pozici meta atributu v Globalni hlavicce
							meta_optional_node_position_gh = i;
						}
						else {
							if (! strcmp(vzorID, META_NUMBER_OF_SONS)) { // zapamatuji si pozici meta atributu v Globalni hlavicce
								meta_number_of_sons_position_gh = i;
							}
							else {
								if (! strcmp(vzorID, META_NUMBER_OF_HIDDEN_SONS)) { // zapamatuji si pozici meta atributu v Globalni hlavicce
									meta_number_of_hidden_sons_position_gh = i;
								}
								else {
									if (! strcmp(vzorID, META_DEPTH_FROM_ROOT)) { // zapamatuji si pozici meta atributu v Globalni hlavicce
										meta_depth_from_root_position_gh = i;
									}
									else {
										if (! strcmp(vzorID, META_NUMBER_OF_DESCENDANTS)) { // zapamatuji si pozici meta atributu v Globalni hlavicce
											meta_number_of_descendants_position_gh = i;
										}
										else {
											if (! strcmp(vzorID, META_NUMBER_OF_LEFT_BROTHERS)) { // zapamatuji si pozici meta atributu v Globalni hlavicce
												meta_number_of_left_brothers_position_gh = i;
											}
											else {
												if (! strcmp(vzorID, META_NUMBER_OF_RIGHT_BROTHERS)) { // zapamatuji si pozici meta atributu v Globalni 	hlavicce
													meta_number_of_right_brothers_position_gh = i;
												}
												else {
													if (! strcmp(vzorID, META_NUMBER_OF_OCCURRENCES)) { // zapamatuji si pozici meta atributu v Globalni 	hlavicce
														meta_number_of_occurrences_position_gh = i;
													}
													else {
														if (! strcmp(vzorID, META_NODE_NAME)) { // zapamatuji si pozici meta atributu v Globalni hlavicce
															meta_node_name_position_gh = i;
														}
														else {
															if (! strcmp(vzorID, META_SENTENCE)) { // zapamatuji si pozici meta atributu v Globalni hlavicce
																meta_sentence_position_gh = i;
															}
															else {
																if (! strcmp(vzorID, META_DEPENDENCE)) { // zapamatuji si pozici meta atributu v Globalni hlavicce
																	meta_dependence_position_gh = i;
																}
															}
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
} // scanGlobalHead


int scanHead(TFSFile *tree_file) { // prohlédne hlavičku souboru stromů - zapamatuje si pozice význačných atributů; používá se pro prohledávané soubory
// v současné době jediný význačný atribut je atribut pro skryté vrcholy
	char *vzorID;
  int attr_type;
	int pocetID;
	pocetID = tree_file -> AHNum;
	hidden_position = -1; // pozice atributu pro skrývání vrcholů v prohledávaných stromech; zatím neurčena
	for( int i = 0; i < pocetID; i++ ) { // přes všechny definované atributy
		vzorID = tree_file -> DefsTable[i].ID; // ukážu si na jméno atributu
    attr_type = tree_file -> DefsTable[i].IDType; // vezmu si typ atributu
	#ifdef DEBUG_SCAN_HEAD
		fprintf (stderr,"\ndotser.c: scanHead: the attribute name is %s, its type is %d",vzorID,attr_type);
	#endif
    if (attr_type & ATTR_HIDETEST) { // je to atribut pro skrývání vrcholů
      hidden_position = i;
    }
	}
} // scanHead

int getHiddenValue(TNode *node, int local_hidden_position) { // vrátí 0, pokud je uzel neskrytý,
// 1, pokud je skrytý, 2, pokud oboje (to je možné u dotazu)
// pokud local_hidden_position == -1, vrátí 0
	#ifdef DEBUG_GET_HIDDEN_VALUE
		fprintf (stderr,"\ndotser.c: getHiddenValue: Entering the function; local_hidden_position = %d",local_hidden_position);
	#endif
  if (local_hidden_position == -1) return 0; // atribut pro skrytí vrcholů není v hlavičce
	if (node == NULL) return 0;
	TValue *values = node -> Values;
	if (values == NULL) return 0;
	TAHLine *set = values -> AHTable;
	if (set == NULL) return 0;
  int ret_value = -1;
	// nyní set ukazuje na začátek první sady atributů; ostatní sady budu ignorovat!!!
	set += local_hidden_position; // posunu se na ten správný atribut
  char *name;
  while (set != NULL) { // přes všechny varianty
    name = getAHLineValue(set); // a ukážu si na hodnotu (první variantu)
    if (name == NULL) { // beru to jako prazdnou hodnotu, cili neskryvany
      if (ret_value == -1) ret_value = 0;
      else if (ret_value == 1) ret_value = 2;
    }
    else if (strlen(name)<1) { // prazdna hodnota, cili neskryvany
      if (ret_value == -1) ret_value = 0;
      else if (ret_value == 1) ret_value = 2;
    }
    else if (strcmp(name,"0")==0) { // nula znamena neskryvany
      if (ret_value == -1) ret_value = 0;
      else if (ret_value == 1) ret_value = 2;
    }
    else if (strcmp(name,"false")==0) { // "false" znamena neskryvany
      if (ret_value == -1) ret_value = 0;
      else if (ret_value == 1) ret_value = 2;
    }
    else if (ret_value == -1) ret_value = 1; // ostatni hodnoty znamenaji skryvany
         else if (ret_value == 0) ret_value = 2;

    set = set -> next; // dalsi varianta
  }
	#ifdef DEBUG_GET_HIDDEN_VALUE
		fprintf (stderr,"\ndotser.c: getHiddenValue: return value is %d", ret_value);
	#endif
	return ret_value;
} // getHiddenValue

// Zkompiluje regulární výraz. Odstraní úvodní a koncový ohraničující znak, přidá (pokud tam nejsou)
// kotvy pro matchování od začátku řetězce do konce a výsledek zkompiluje
pcre* regexpValueCompile(char *d_regexp, char *error_message_regexp, char *error_message_offset, char *error_message_reason) {
  pcre *re;
  const char *error;
  int erroffset;
  int shift_start, shift_end, pure_length;

  char d_regexp_pure[MPL]; // pro uložení vlastního regulárního výrazu (bez úvodního a koncového znaku)
  int length = strlen(d_regexp);
  d_regexp_pure[0]='^'; // vždy matchuj od začátku hodnoty atributu stromu
  if (*(d_regexp+1)=='^') { // přeskoč, pokud už uživatel sám explicitně určil matchování od začátku hodnot
    shift_start = 2;
  }
  else { // uživatel to explicitně nevyjádřil, přeskoč tedy jen uvozující znak regulárního výrazu
    shift_start = 1;
  }
  if (*(d_regexp+length-2)=='$') { // vynech poslední znak, pokud uživatel sám explicitně určil matchování do konce hodnot
    shift_end = 2;
  }
  else { // uživatel to explicitně nevyjádřil, vynech tedy jen ukončující znak regulárního výrazu
    shift_end = 1;
  }
  pure_length = length - shift_start - shift_end + 1;
  strncpy(d_regexp_pure + 1, d_regexp + shift_start, pure_length); // zkopírování hodnoty atributu dotazu bez obalujících znaků označujících regulární výraz
  d_regexp_pure[pure_length]='$'; // zakončení čistého regulárního výrazu - matchovat vždy do konce hodnot
  d_regexp_pure[pure_length + 1]='\0'; // ukončení řetězce čistého regulárního výrazu

  re = pcre_compile(
    d_regexp_pure,        /* the pattern */
    PCRE_UTF8,            /* options */
    &error,               /* for error message */
    &erroffset,           /* for error offset */
    NULL);                /* use default character tables */

  if (re == NULL) { /* Compilation failed: print the error message and return NULL */
  	#ifdef DEBUG_MATCH_REGEXP_VALUES
	  	fprintf(stderr,"\ndotser.c: regexpValueCompile: An error occurred during the regexp compilation of '%s' at offset %d: %s", d_regexp_pure, erroffset, error);
	  #endif
    fillErrorMessageString(error_message_1, d_regexp_pure);
    fillErrorMessageInt(error_message_2, erroffset+1);
    fillErrorMessageString(error_message_3, error);
    return NULL;
  }
  return re;
} // regexpValueCompile

// Detailně prozkoumá zkompilovaný regulární výraz.
pcre_extra* regexpValueStudy(pcre *re) {
  pcre_extra *study;
  const char *error=NULL;
  int erroffset;

  study = pcre_study(
     re,          /* result of pcre_compile() */
     0,           /* no options exist */
     &error);     /* set to NULL or points to a message */

  if (study == NULL) { /* Studying of the compilation failed: print the error message and return NULL */
  	#ifdef DEBUG_MATCH_REGEXP_VALUES
	  	fprintf(stderr,"\ndotser.c: regexpValueStudy: The detailed studying of the regexp compilation has not bring any additional information or an error has occurred: %s", error);
	  #endif
    return NULL;
  }
  return study;
} // regexpValueStudy

int preprocessRegexpsAtAHTables(TAHLine *ahtable) {
  int err_value = 0; // předpokládám dobrý konec
  char *d; // řetězcová jedna hodnota atributu
  int d_length;
  while (ahtable != NULL) {
    #ifdef DEBUG_PREPROCESS_REGEXPS
      fprintf(stderr,"\ndotser.c: preprocessRegexpsAtAHTables: checking for regexps at a set of values - checking one value");
    #endif
    ahtable->contains_regexp = 2; // nastaví se nepřítomnost reg. výrazu a kdyžtak se to při úspěšné kompilaci opraví
    d = getAHLineValue(ahtable);
    if (d != NULL) {
      d_length = strlen(d);
      if (strlen(d) > 2) {
        #ifdef DEBUG_PREPROCESS_REGEXPS
          fprintf(stderr,"\ndotser.c: preprocessRegexpsAtAHTables: the value is %s", d);
        #endif
        if (*d==REGEXP_START && *(d+d_length-1)==REGEXP_END) { // hodnota atributu v dotazu začíná a končí znaky označujícími regulární výraz
          #ifdef DEBUG_PREPROCESS_REGEXPS
            fprintf(stderr,"\ndotser.c: preprocessRegexpsAtAHTables: jdu4");
          #endif
          if ((ahtable->relation == RELATION_EQ) || (ahtable->relation == RELATION_NEQ)) { // regulární výrazy se berou v potaz jen s RELATION_EQ a RELATION_NEQ
            #ifdef DEBUG_PREPROCESS_REGEXPS
              fprintf(stderr,"\ndotser.c: preprocessRegexpsAtAHTables: the query attribute value is a regular expression, going to compile it");
            #endif
            ahtable->regexp.compilation = regexpValueCompile(d, error_message_1, error_message_2, error_message_3);
            if (ahtable->regexp.compilation != NULL) { // úspěšná kompilace
              ahtable->contains_regexp = 1; // nastavím příznak, že reg. výraz tu je a je úspěšně zkompilován
              ahtable->regexp.study = regexpValueStudy(ahtable->regexp.compilation); // detailní prozkoumání regulárního výrazu pro optimální rychlost matchování
              #ifdef DEBUG_PREPROCESS_REGEXPS
                fprintf(stderr,"\ndotser.c: preprocessRegexpsAtAHTables: the regular expression has been compiled.");
              #endif
            }
            else {
              #ifdef DEBUG_PREPROCESS_REGEXPS
                fprintf(stderr,"\ndotser.c: preprocessRegexpsAtAHTables: an error occurred during the regexp compilation.");
              #endif
              err_value = ERROR_REGEXP_COMPILATION;
            }
          }
        }
        if (err_value != 0) {
          return err_value;
        }
      }
    }
    ahtable = ahtable->next;
  }
  return err_value; // tady to musí být 0, čili vše v pořádku
}

int preprocessRegexpsAtSetOfAttrs(TValue *set, int number_of_attributes) {
  int i;
  int err_value = 0; // předpokládám dobrý konec
  for (i = 0; i<= number_of_attributes; i++) { // přes všechny atributy jedné sady
    #ifdef DEBUG_PREPROCESS_REGEXPS
      fprintf(stderr,"\ndotser.c: preprocessRegexpsAtSetOfAttrs: checking for regexps at a set of attrs - checking one set of values");
    #endif
    err_value = preprocessRegexpsAtAHTables((set->AHTable)+i);
    if (err_value != 0) { // došlo k nějaké chybě
      return err_value;
    }
  }
  return err_value; // tady to musí být 0, čili vše v pořádku
}

int preprocessRegexpsAtNode(TNode *node, int number_of_attributes) {
  int err_value = 0; // předpokládám dobrý konec
  if (node == NULL) return 0;
  TValue *set = node->Values;
  while (set != NULL) {
    #ifdef DEBUG_PREPROCESS_REGEXPS
      fprintf(stderr,"\ndotser.c: preprocessRegexpsAtNode: checking for regexps at a node - checking one set of attrs");
    #endif
    err_value = preprocessRegexpsAtSetOfAttrs(set, number_of_attributes);
    if (err_value != 0) { // došlo k nějaké chybě
      return err_value;
    }
    set = set->Next;
  }
  return err_value; // tady to musí být 0, čili vše v pořádku
}

char * findNodeName(TNode *node) { // vrátí jméno vrcholu, pokud je specifikováno metaatributem META_NODE_NAME v první sadě atributů
	// jinak vrací NULL
	// předpokládám, že již je nastavena proměnná meta_node_name_position_gh (to určitě je)
	#ifdef DEBUG_FIND_NODE_NAME
		fprintf (stderr,"\ndotser.c: findNodeName: Entering the function; meta_node_name_position_gh = %d",meta_node_name_position_gh);
	#endif
	if (node == NULL) return NULL;
	TValue *values = node -> Values;
	if (values == NULL) return NULL;
	TAHLine *set = values -> AHTable;
	if (set == NULL) return NULL;
	// nyní set ukazuje na první sadu atributů
	set += meta_node_name_position_gh; // posunu se na ten správný atribut
	char *name = getAHLineValue(set); // a ukážu si na hodnotu (první variantu, ostatní u tohoto metaatributu neberu v úvahu)
	if (name == NULL) return NULL;
	if (strlen(name)<1) return NULL;
	#ifdef DEBUG_FIND_NODE_NAME
		fprintf (stderr,"\ndotser.c: findNodeName: Found a name of a node - %s",name);
	#endif
	return name;
} // findNodeName

int preprocessSubtree(TNode *node, int depth, int depth_first_order, int *depth_leaf, int *non_hidden_descendants, int check_name, int check_regexps, int local_hidden_position, int *error_value, int number_of_attributes) { // projde podstrom do hloubky a nastaví u každého vrcholu
// včetně předaného kořene pomocné hodnoty depth_from_root, max_depth_to_leaf, nodes_in_subtree a depth_first_order
// funkce vrací počet všech vrcholů v podstromu včetně předaného kořene podstromu
// v proměnné non_hidden_descendants vrací počet všech neskrytých vrcholů v podstromu včetně předaného kořene podstromu
// v proměnné depth_leaf vrátí maximální vzdálenost do neskrytého listu
// je-li check_name TRUE, zjišťuje i případné nastavení meta atributu META_NODE_NAME a nastavuje u vrcholu ještě proměnnou name
// pokud je check_regexps TRUE, zjistuje pritomnost regularnich vyrazu a pripadne je kompiluje
// v local_hidden_position se predava pozice atributu pro skryté vrcholy; -1 znamená nepřítomnost atributu
// v *error_value vrací 0 nebo případný kód chyby (ERROR_*)
// před voláním této funkce zvenčí je potřeba nastavit *error_value na 0

	TNode *son;
	int err_v;

	if (node == NULL) { // pojistná ukončovací podmínka rekurze; sem by to nemělo dojít
		*depth_leaf = 0;
		*non_hidden_descendants = 0;
		return 0;
	}

	node -> depth_from_root = depth; // to už mohu nastavit ted
	node -> depth_first_order = depth_first_order; // tohle též
	depth_first_order ++; // další vrchol bude mít o jedna vyšší pořadí
	node -> hidden = getHiddenValue(node, local_hidden_position); // nastaví, zda je uzel skrytý

	if (check_regexps == TRUE) {
		#ifdef DEBUG_PREPROCESS_REGEXPS
			fprintf(stderr,"\ndotser.c: preprocessSubtree: preprocessing a node - going to check for regexps");
		#endif
		err_v = preprocessRegexpsAtNode(node, number_of_attributes);
		if (err_v != 0) { // došlo k chybě v předzpracování regulárních výrazů
			#ifdef DEBUG_PREPROCESS_REGEXPS
				fprintf(stderr,"\ndotser.c: preprocessSubtree: an error occurred during checking for regexps");
			#endif
			*error_value = err_v;
			// nedám teď return, ale v klidu dokončím vše ostatní; na konci zůstane poslední chyba v *error_value;
		}
	}

	if (node -> FirstSon == NULL) { // jsem v listu - ukončím rekurzi
		*depth_leaf = 0; // vracím se z nulové hloubky od listu (tj. z listu)
		node -> max_depth_to_leaf = 0;
		node -> nodes_in_subtree = 1; // počítám sám sebe
		node -> number_of_sons = 0;
		node -> number_of_hidden_sons = 0;
		node -> number_of_left_brothers = -1; // tohle se počítá až v případě, že je to opravdu potřeba
		node -> number_of_right_brothers = -1; // tohle se počítá až v případě, že je to opravdu potřeba
		if (node -> hidden == 1) {
			*non_hidden_descendants = 0;  // nula je u všech skrytých vrcholů
		}
		else {
			*non_hidden_descendants = 1; // neskrytý list - počítá se sám do počtu neskrytých vrcholů v podstomu
		}
		if (check_name == TRUE) {
			node -> name = findNodeName(node); // vezmu jméno vrcholu, pokud je specifikováno metaatributem META_NODE_NAME
		}
		return node -> nodes_in_subtree;
	}

	// nejsem v listu, takže se projdou synové
	int total_nodes = 0; // sem spočítám celkový počet vrcholů v podstromu včetně sebe
	int total_non_hidden = 0; // sem spočítám celkový počet neskrytých vrcholů v podstromu včetně sebe
	int max_depth = 0; // sem dám maximální hloubku
	int son_depth; // hloubka získaná z jednoho syna
	int son_nodes; // počet všech vrcholů v podstromu jednoho syna včetně
	int son_nhd; // počet neskrytých vrcholů v podstromu jednoho syna včetně
	int number_of_sons = 0; // sem spočítám (bezprostřední) neskryté syny
	int number_of_hidden_sons = 0; // sem spočítám (bezprostřední) skryté syny

	son = node -> FirstSon;

	while (son != NULL) { // pres vsechny syny
		son_nodes = preprocessSubtree (son, depth+1, depth_first_order, &son_depth, &son_nhd, check_name, check_regexps, local_hidden_position, error_value, number_of_attributes);
	    #ifdef DEBUG_PREPROCESS_TREE
    	  fprintf(stderr,"\ndotser.c: preprocessSubtree: There were %d nodes in the subtree, %d of them non-hidden.",son_nodes, son_nhd);
    	#endif
		total_nodes += son_nodes;
		total_non_hidden += son_nhd;
		depth_first_order += son_nodes;
		if (son->hidden != 1)	{ // tento syn není skrytý
			if (max_depth <= son_depth) { // pozor, son_depth == max_depth znamená zvýšení max_depth o 1
				max_depth = son_depth + 1;
			}
			number_of_sons ++; // připočtu tohoto neskrytého syna
		}
		else {
			number_of_hidden_sons ++; // připočtu tohoto skrytého syna
		}
		son = son -> Brother; // přejdu na dalšího syna
	}

	total_nodes ++; // přímo tento vrchol také započítám do počtu vrcholů v podstromu
	if (node->hidden != 1) {
		total_non_hidden ++; // neskrytý vrchol počítám do počtu neskrytých vrcholů v podstromu
	}

	*depth_leaf = max_depth;
	node -> max_depth_to_leaf = max_depth; // skryté vrcholy se nepočítají za vrcholy
	node -> nodes_in_subtree = total_non_hidden; // spočteno správně pro skryté i neskryté vrcholy (skryté mají nulu)
	node -> number_of_sons = number_of_sons; // to je správně spočteno pro skryté i neskryté vrcholy; skryté vrcholy se nezapočítávají
	node -> number_of_hidden_sons = number_of_hidden_sons; // to je správně spočteno pro skryté i neskryté vrcholy; zde se započítávají právě jen skryté vrcholy
	node -> number_of_left_brothers = -1; // tohle se počítá až v případě, že je to opravdu potřeba
	node -> number_of_right_brothers = -1; // tohle se počítá až v případě, že je to opravdu potřeba
	if (check_name == TRUE) {
		node -> name = findNodeName(node); // vezmu jméno vrcholu, pokud je specifikováno metaatributem META_NODE_NAME
	}

	*non_hidden_descendants = total_non_hidden; // vracím pro rekurzi; pro skrytý vrchol se vrací 0, pro neskrytý celkový počet neskrytých vrcholů v podstromu včetně tohoto
	return total_nodes; // vracím celkový počet všech uzlů v podstromu včetně tohoto
} // preprocessSubtree


int preprocessTree(TTree *tree, int check_name, int check_regexps, int local_hidden_position, int number_of_attributes) { // projde strom a u vrcholů nastaví pomocné hodnoty
// (tj. depth_from_root, max_depth_to_leaf, nodes_in_subtree, depth_first_order)
// pomocnou hodnotu name nastavuje pouze, pokud je check_name TRUE
// pokud je check_regexps TRUE, zjistuje pritomnost regularnich vyrazu a pripadne je kompiluje
// v local_hidden_position se predava pozice atributu pro skryté vrcholy; -1 znamená nepřítomnost atributu
// vrací 0, pokud vše v pořádku, jinak typ chyby (ERROR_*)

	//fprintf(stderr,"\nJsem ve funkci preprocessTree");
	int ret_value = 0; // předpokládám, že vše bude OK
	if (tree == NULL) {
		fprintf(stderr,"\ndotser.c: preprocessTree: argument is NULL !");
		return 0;
	}
	int refuse, refuse2; // jen pro volání funkce, vrácené hodnoty však nepotřebuji
	//fprintf(stderr,"\nJsem stále ve funkci preprocessTree");
	ret_value = 0; // je potřeba nastavit na 0 před voláním násl. funkce

	preprocessSubtree(tree->Root, 0, 0, &refuse, &refuse2, check_name, check_regexps, local_hidden_position, &ret_value, number_of_attributes); // začínám v hloubce 0 s kořenem stromu

	#ifdef DEBUG_PREPROCESS_REGEXPS
		fprintf(stderr,"\ndotser.c: preprocessTree: The ret_value after preprocessSubtree is %d", ret_value);
	#endif
	return ret_value;
} // preprocessTree

int preprocessTrees(TFSFile *trees, int check_name, int check_regexps, int local_hidden_position) { // předzpracuje všechny stromy ze souboru stromů
// pomocnou hodnotu name nastavuje u vrcholu pouze, pokud je check_name TRUE
// pokud je check_regexps TRUE, zjistuje pritomnost regularnich vyrazu a pripadne je kompiluje
// v local_hidden_position se predava pozice atributu pro skryté vrcholy; -1 znamená nepřítomnost atributu
// vrací 0, pokud vše v pořádku, jinak typ chyby (ERROR_*)
  int ret_value = 0; // předpokládám, že vše bude OK
  int i;
	int total = trees -> TreeNum;
	TTree *tree = trees -> Trees;
	for (i = 1; i <= total; i++) {
		if (tree == NULL) {
			fprintf(stderr,"\ndotser.c: preprocessTrees: TreeNum nesouhlasí se skutečným počtem stromů!"); // závažná chyba - nekonzistence TreeNum se skutečností
		}
		ret_value = preprocessTree(tree, check_name, check_regexps, local_hidden_position, trees->AHNum); // předzpracování jednoho stromu
    #ifdef DEBUG_PREPROCESS_REGEXPS
      fprintf(stderr,"\ndotser.c: preprocessTrees: The ret_value after preprocessTree is %d", ret_value);
    #endif
    if (ret_value != 0) { // chyba ve zpracování stromu - ukončuji předzpracování ostatních stromů
      return ret_value;
    }
		tree = tree -> Next;
	}
	//fprintf(stderr,"\ninformace u kořene prvního stromu jsou: nodes_in_subtree = %d, max_depth_to_leaf = %d", trees->Trees->Root->nodes_in_subtree, trees->Trees->Root->max_depth_to_leaf);
  return ret_value; // pokud to dojde sem, musí to být 0, čili bez chyby
} // preprocessTrees

// vlastní porovnání dvou řetězcových hodnot atributů - hodnoty v dotazu a hodnoty v prohledávaném stromu
int stringValuesMatch (int relation, char * d, char * s, int poradi_gh) { // porovná dva řetězce s přihlédnutím k žolíkům (mohou být pouze v d) a k relaci relation
	int lomeny = FALSE;	// byl znak lomeny
	char * p;

	if (*d == ESCAPE_CHAR) { // prepinac
		lomeny = TRUE;
		d++;
	}

	if (*d == 0) { // konec d (dotazu)
		if (*s == 0) { // konec s (kandidata); skoncily obe hodnoty (a byly stejné)
			#ifdef DEBUG_MATCH_STRING_VALUES
				fprintf(stderr,"\ndotser.c: stringValuesMatch: end of both values");
			#endif
			switch (relation) {
				case RELATION_EQ: return TRUE;
				case RELATION_NEQ: return FALSE;
				case RELATION_LTEQ: return TRUE;
				case RELATION_GTEQ: return TRUE;
				case RELATION_LT: return FALSE;
				case RELATION_GT: return FALSE;
				default: return FALSE;
			}
		}
		else { // hodnota atributu v dotazu skončila, ale ve skutečném stromě je delší
			if (poradi_gh == lemma_position_gh) { // jedná-li se o lemma
				if (*s == '-') { // jedná-li se o variantu lemmatu
					if (match_lemma_variants) { // varianty beru
						switch (relation) {
							case RELATION_EQ: return TRUE;
							case RELATION_NEQ: return FALSE;
							case RELATION_LTEQ: return TRUE;
							case RELATION_GTEQ: return TRUE;
							case RELATION_LT: return FALSE;
							case RELATION_GT: return TRUE;
							default: return TRUE;
						}
					}
					else { // varianty neberu
						switch (relation) {
							case RELATION_EQ: return FALSE;
							case RELATION_NEQ: return TRUE;
							case RELATION_LTEQ: return FALSE;
							case RELATION_GTEQ: return TRUE;
							case RELATION_LT: return FALSE;
							case RELATION_GT: return TRUE;
							default: return FALSE;
						}
					}
				}
				if (*s == '`' || *s == '_') { // jedná-li se o popis lemmatu
					if (match_lemma_comments) { // vysvětlivky beru
						switch (relation) {
							case RELATION_EQ: return TRUE;
							case RELATION_NEQ: return FALSE;
							case RELATION_LTEQ: return TRUE;
							case RELATION_GTEQ: return TRUE;
							case RELATION_LT: return FALSE;
							case RELATION_GT: return TRUE;
							default: return TRUE;
						}
					}
					else { // vysvětlivky neberu
						switch (relation) {
							case RELATION_EQ: return FALSE;
							case RELATION_NEQ: return TRUE;
							case RELATION_LTEQ: return FALSE;
							case RELATION_GTEQ: return TRUE;
							case RELATION_LT: return FALSE;
							case RELATION_GT: return TRUE;
							default: return FALSE;
						}
					}
				}
			}
			// nejedna se o lemma, dotaz skoncil a kandidat pokracuje
			#ifdef DEBUG_MATCH_STRING_VALUES
				fprintf(stderr,"\ndotser.c: stringValuesMatch: end of value of the query node, the value of the tree node continues");
			#endif
			switch (relation) {
				case RELATION_EQ: return FALSE;
				case RELATION_NEQ: return TRUE;
				case RELATION_LTEQ: return FALSE;
				case RELATION_GTEQ: return TRUE;
				case RELATION_LT: return FALSE;
				case RELATION_GT: return TRUE;
				default: return FALSE;
			}
		}
	}

	if (*d == WILD_CARD_ONE_CHAR) {
		if (lomeny) { // obyc. otaznik
			if (*s == WILD_CARD_ONE_CHAR) {
				return stringValuesMatch (relation, d + 1, s + 1, poradi_gh);
			}
			else { // *s nebyl otazník
				switch (relation) {
					case RELATION_EQ: return FALSE;
					case RELATION_NEQ: return TRUE;
					case RELATION_LTEQ: if (*s < WILD_CARD_ONE_CHAR) return TRUE;
					                    else return FALSE;
					case RELATION_GTEQ: if (*s > WILD_CARD_ONE_CHAR) return TRUE;
					                    else return FALSE;
					case RELATION_LT: if (*s < WILD_CARD_ONE_CHAR) return TRUE;
					                    else return FALSE;
					case RELATION_GT: if (*s > WILD_CARD_ONE_CHAR) return TRUE;
					                    else return FALSE;
					default: return FALSE;
				}
			}
		}
		else { // spec. otaznik
			if (*s != '\0') { // cokoliv krome konce
				return stringValuesMatch (relation, d + 1, s + 1, poradi_gh);
			}
			else { // hodnota atributu ve stromu je kratsi nez v dotazu, ale ve sve delce byly totozne
				switch (relation) {
					case RELATION_EQ: return FALSE;
					case RELATION_NEQ: return TRUE;
					case RELATION_LTEQ: return TRUE;
					case RELATION_GTEQ: return FALSE;
					case RELATION_LT: return TRUE;
					case RELATION_GT: return FALSE;
					default: return FALSE;
				}
			}
		}
	} // konec otazniku

	if (*d == WILD_CARD_STRING) {
		if (lomeny) { // obyc. hvezda
			if (*s == WILD_CARD_STRING) {
				return stringValuesMatch (relation, d + 1, s + 1, poradi_gh);
			}
			else {
				switch (relation) {
					case RELATION_EQ: return FALSE;
					case RELATION_NEQ: return TRUE;
					case RELATION_LTEQ: if (*s < WILD_CARD_STRING) return TRUE;
					                    else return FALSE;
					case RELATION_GTEQ: if (*s > WILD_CARD_STRING) return TRUE;
					                    else return FALSE;
					case RELATION_LT: if (*s < WILD_CARD_STRING) return TRUE;
					                    else return FALSE;
					case RELATION_GT: if (*s > WILD_CARD_STRING) return TRUE;
					                    else return FALSE;
					default: return FALSE;
				}
			}
		}
		else { // spec. hvezda
			p = s - 1;
			do {
				p++;
				#ifdef DEBUG_MATCH_STRING_VALUES
					fprintf(stderr,"\ndotser.c: stringValuesMatch: trying to match rest of values: '%s', '%s'",d+1,p);
				#endif
				if (stringValuesMatch (relation, d + 1, p, poradi_gh)) {
					#ifdef DEBUG_MATCH_STRING_VALUES
						fprintf(stderr,"\ndotser.c: stringValuesMatch: match!");
					#endif
					switch (relation) {
						case RELATION_EQ: return TRUE;
						case RELATION_NEQ: return FALSE;
						case RELATION_LTEQ: return TRUE;
						case RELATION_GTEQ: return TRUE;
						case RELATION_LT: return TRUE; // těžko tady vymýšlet nějakou sémantiku
						case RELATION_GT: return TRUE; // - '' -
						default: return TRUE;
					}
				}
				#ifdef DEBUG_MATCH_STRING_VALUES
					fprintf(stderr,"\ndotser.c: stringValuesMatch: skipping character '%c' in the result.",*p);
				#endif
			} while (*p != 0);
			switch (relation) {
				case RELATION_EQ: return FALSE;
				case RELATION_NEQ: return TRUE;
				case RELATION_LTEQ: return TRUE;
				case RELATION_GTEQ: return TRUE;
				case RELATION_LT: return TRUE; // těžko tady vymýšlet nějakou sémantiku
				case RELATION_GT: return TRUE; // - '' -
				default: return FALSE;
			}
		}
	}

	// obyc. znak

	if (*s == *d) {
		return stringValuesMatch (relation, d + 1, s + 1, poradi_gh);
	}
	else {
		switch (relation) {
			case RELATION_EQ: return FALSE;
			case RELATION_NEQ: return TRUE;
			case RELATION_LTEQ: if (*s < *d) return TRUE;
			                    else return FALSE;
			case RELATION_GTEQ: if (*s > *d) return TRUE;
			                    else return FALSE;
			case RELATION_LT: if (*s < *d) return TRUE;
			                    else return FALSE;
			case RELATION_GT: if (*s > *d) return TRUE;
			                    else return FALSE;
			default: return FALSE;
		}
	}
} // konec stringValuesMatch

// vlastní porovnání regulárního výrazu v dotazu a hodnoty v prohledávaném stromu
// relace může být v tomto případě jen RELATION_EQ, takže se nemusí předávat jako parametr
// tato funkce používá knihovnu pcre, která zvládá regulární výrazy s UTF-8
int regexpValuesMatch(TAHLine *d_tahline, const char * s) {
  int match_result;
  int s_length = strlen(s);
	#ifdef DEBUG_MATCH_REGEXP_VALUES
		fprintf(stderr,"\ndotser.c: regexpValuesMatch: Going to compare regexp %s and value %s", d_tahline->Value, s);
	#endif
  match_result = pcre_exec(
    d_tahline->regexp.compilation, /* the compiled pattern */
    d_tahline->regexp.study,  /* extra data - the detailed study of the pattern for optimalization */
    s,                    /* the subject string */
    s_length,             /* the length of the subject */
    0,                    /* start at offset 0 in the subject */
    PCRE_NO_UTF8_CHECK,   /* do not check the UTF-8 validity of the subject string */
    NULL,                 /* output vector for substring information */
    0);                   /* number of elements in the output vector */

  if (match_result < 0) { /* Matching failed */
    #ifdef DEBUG_MATCH_REGEXP_VALUES
      fprintf(stderr," - no match.");
    #endif
    return FALSE;
  }
  // regulární výraz matchuje s hodnotou atributu ve stromě
  #ifdef DEBUG_MATCH_REGEXP_VALUES
    fprintf(stderr," - it matches!");
  #endif
  return TRUE;
} // regexpValuesMatch

// vlastní porovnání dvou číselných hodnot atributů - hodnoty v dotazu a hodnoty v prohledávaném stromu
int doubleValuesMatch(int relation, double d_double, double s_double) { // porovná dvě čísla vzhledem k relaci relation
	#ifdef DEBUG_MATCH_DOUBLE_VALUES
		fprintf(stderr,"\ndotser.c: doubleValuesMatch: comparing values %e and %e", d_double, s_double);
	#endif
	switch (relation) {
		case RELATION_EQ: if (s_double == d_double) return TRUE;
		                  else return FALSE;
		case RELATION_NEQ: if (s_double != d_double) return TRUE;
		                  else return FALSE;
		case RELATION_LTEQ: if (s_double <= d_double) return TRUE;
		                  else return FALSE;
		case RELATION_GTEQ: if (s_double >= d_double) return TRUE;
		                  else return FALSE;
		case RELATION_LT: if (s_double < d_double) return TRUE;
		                  else return FALSE;
		case RELATION_GT: if (s_double > d_double) return TRUE;
		                  else return FALSE;
		default: return FALSE;
	}
} // doubleValuesMatch

int convertToDoubleAddSub(double left_argument, int oper, double *dst, char *src) { // converts a string src to double number dst
	// src can be a mathematical expression containing additions and subtractions of numbers
	// if the string consists not only of double number (or adds/subs of numbers), -1 is returned; zero otherwise
	// if oper==OP_ADD or oper==OP_SUB, the first number in src is added/subtracted to/from left_argument before
	// the function proceeds to potential other numbers in src (after +/-)
	#ifdef DEBUG_MATCH_DOUBLE_VALUES
		fprintf(stderr,"\ndotser.c: convertToDoubleAddSub: trying to convert string %s to a double number", src);
	#endif
	char *nptr, *endptr;
	(*dst) = 0.0; // default converted value
	nptr = endptr = src;
	double number = strtod(nptr, &endptr);
	if (nptr == endptr) { // the conversion didn't succeed
		return -1;
	}
	switch (oper) {
		case OP_ADD:
			number = left_argument + number;
			break;
		case OP_SUB:
			number = left_argument - number;
			break;
		default:
			break;
	} // switch
	switch (*endptr) {
		case '\0': // OK - end of the string
			break;
		case '+': // maybe an addition
			if (convertToDoubleAddSub(number, OP_ADD, &number, endptr+1)) { // if the conversion of the rest of the string has not succeeded
				return -1;
			}
			break;
		case '-': // maybe a subtraction
			if (convertToDoubleAddSub(number, OP_SUB, &number, endptr+1)) { // if the conversion of the rest of the string has not succeeded
				return -1;
			}
			break;
		default: // other characters
			return -1;
	} // switch
	(*dst) = number;
	#ifdef DEBUG_MATCH_DOUBLE_VALUES
		fprintf(stderr," - OK: %e", number);
	#endif
	return 0; // the conversion succeeded
} // convertToDoubleAddSub

int convertToDouble(double *dst, char *src) { // converts a string src to double number dst
	// src can be a mathematical expression containing additions and subtractions of numbers
	// if the string consists not only of double number (or adds/subs of numbers), -1 is returned; zero otherwise
	convertToDoubleAddSub(0,OP_NULL, dst, src);
}

TVS *getNodeWithNameTVS(const char *name, TVS *cely_strom_dotazu) { // vrátí ukazatel na položku TVS s vrcholem s daným jménem, pokud existuje, jinak NULL
	TVS *pom = cely_strom_dotazu;
	char *node_name;
	#ifdef DEBUG_CHECK_REFERENCE_VALUE
		fprintf(stderr,"\ndotser.c: getNodeWithNameTVS: Entering the function; the value to be checked is '%s'", name);
	#endif
	while (pom != NULL) { // přes všechny vrcholy dotazu v seznamu TVS
		node_name = pom -> vrchol -> name; // tady by neměl být problém s NULL v pom->vrchol
		if (node_name != NULL) {
			if (! strcmp(name, node_name)) { // jméno nalezeno
				return pom;
			}
		}
		pom = pom -> dalsi;
	}
	return NULL;
} // getNodeWithNameTVS

TVS *getNodeWithNameTVSList(const char *name, TVSList *query_TVSList) { // vrátí ukazatel na položku TVS s vrcholem s daným jménem, pokud existuje, jinak NULL
	TVS *pom;
	char *node_name;
	#ifdef DEBUG_CHECK_REFERENCE_VALUE
		fprintf(stderr,"\ndotser.c: getNodeWithNameTVSList: Entering the function; the value to be checked is '%s'", name);
	#endif
	while (query_TVSList != NULL) { // přes všechny stromy dotazu v seznamu TVSList
		pom = getNodeWithNameTVS(name, query_TVSList->tvs);
		if (pom != NULL) { // the node has been found
			return pom;
		}
		query_TVSList = query_TVSList->next;
	}
	return NULL;
} // getNodeWithNameTVSList

TVS *getNodeWithName(const char *name, TVS *cely_strom_dotazu, TVSList *query_TVSList, char *actual_logical_expression) { // vrátí ukazatel na položku TVS s vrcholem s daným jménem, pokud existuje, jinak NULL
	int and_or; // is TRUE if the logical expr. in the query is AND; otherwise is FALSE
	and_or = strcmp(actual_logical_expression, "AND") == 0 ? TRUE : FALSE;

	if (and_or) { // AND
		return getNodeWithNameTVSList(name, query_TVSList);
	}
	else { // OR - checking only one tree of the query
		return getNodeWithNameTVS(name, cely_strom_dotazu);
	}
} // getNodeWithName

/*int notOddBackslashes(char *query, int position) {
            int number = 0;
            position--; // dívám se tedy doleva od udané pozice
            while (position>0 && *(query+position) == '\\' ) { // dokud trvá souvislá sekvence escape znaků
                position--;
                number++;
            }
            if (evenNumber(number)) { // sudé číslo
                return TRUE;
            }
            else { // liché číslo
                return FALSE;
            }
} // notOddBackshlashes
*/

int getPositionOfFunctionalAttribute(TFSFile *file, int attr_mask) { // vrátí pozici funkčního atributu (určeného maskou attr_mask) v hlavičce souboru stromů file
	int position = 0;
	TDefsLine *tree_head = file->DefsTable;
	int number_of_attributes = file->AHNum;
	while (number_of_attributes) { // projdu definované atributy
		#ifdef DEBUG_NUMBER_OF_BROTHERS
			fprintf(stderr,"\ndotser.c: getPositionOfFunctionalAttribute: comparing IDType %d and mask %d", tree_head->IDType, attr_mask);
		#endif
		if (tree_head->IDType & attr_mask) { // je to atribut chtěného typu
			return position;
		}
		tree_head++; // posunu se na další atribut, je-li tam
		position++;
		number_of_attributes--; // zbývá mi jich ještě tolik
	}
	#ifdef DEBUG_NUMBER_OF_BROTHERS
		fprintf(stderr,"\ndotser.c: getPositionOfFunctionalAttribute: the required type of attribute has not been found.");
	#endif
	return -1; // nenalezen
}

void countNumbersOfBrothers(TNode *node) { // spočítá počty levých a pravých neskrytých bratrů vrcholu node
	int number_of_left_brothers = 0;
	int number_of_right_brothers = 0;
	TNode *father = node -> father;
	#ifdef DEBUG_NUMBER_OF_BROTHERS
		fprintf(stderr,"\ndotser.c: countNumbersOfBrothers: Entering the function");
	#endif
	if (father != NULL) { // nejedná se o kořen stromu
		#ifdef DEBUG_NUMBER_OF_BROTHERS
			fprintf(stderr,"\ndotser.c: countNumbersOfBrothers: A father exists.");
		#endif
		TNode *brother = father -> FirstSon;
		if (attr_N_position == -1) { // pokud pozice tohoto atributu v hlavičce nebyla ještě určena pro tento načtený soubor stromů
			attr_N_position = getPositionOfFunctionalAttribute(actualFileOfTrees, ATTR_NUMTEST); // chci pozici numerického atributu v hlavičce
		}
		#ifdef DEBUG_NUMBER_OF_BROTHERS
			fprintf(stderr,"\ndotser.c: countNumbersOfBrothers: Pozice numerického atributu v hlavičce je %d.",attr_N_position);
		#endif
		char* node_N_value_string = getAHLineValue(node->Values->AHTable + attr_N_position); // string určující N hodnotu
		double node_N_value;
		convertToDouble(&node_N_value, node_N_value_string);
		char * brother_N_value_string;
		double brother_N_value;
		while (brother != NULL) { // přes všechny bratry
      if (brother -> hidden != 1) { // v úvahu beru jen neskryté bratry
        brother_N_value_string = getAHLineValue(brother->Values->AHTable + attr_N_position); // string určující N hodnotu
        convertToDouble(&brother_N_value, brother_N_value_string);
        if (brother_N_value < node_N_value) number_of_left_brothers ++;
        else if (brother_N_value > node_N_value) number_of_right_brothers ++;
      }
			brother = brother->Brother;
		}
	}
	node -> number_of_left_brothers = number_of_left_brothers;
	node -> number_of_right_brothers = number_of_right_brothers;
} // countNumberOfBrothers

int getNumberOfBrothers(TNode *node, int direction) { // vrátí počet levých (pokud direction==-1) nebo pravých //(pokud direction==1) bratrů vrcholu node.
// pokud je to potřeba, ta čísla nejprve spočítá
	int number_of_brothers;
	switch (direction) {
		case -1: // počet levých bratrů
			if (node->number_of_left_brothers == -1) { // ještě to nebylo spočítáno
				countNumbersOfBrothers(node);
			}
			number_of_brothers = node->number_of_left_brothers;
			break;
		case 1: // počet pravých bratrů
			if (node->number_of_right_brothers == -1) { // ještě to nebylo spočítáno
				countNumbersOfBrothers(node);
			}
			number_of_brothers = node->number_of_right_brothers;
			break;
		default: // sem to nedojde, pokud není nesprávně zadána direction
			number_of_brothers = -1;
	}
	#ifdef DEBUG_NUMBER_OF_BROTHERS
		fprintf(stderr,"\ndotser.c: getNumberOfBrothers: number_of_brothers = %d", number_of_brothers);
	#endif
	return number_of_brothers;
}

int checkReferenceValue(TVS *cely_strom_dotazu, TVS *aktualni_vrchol_dotazu, TAHLine *valuetl, TVSList *query_TVSList, char *actual_logical_expression) { // vrátí TRUE, pokud valuetl->Value obsahuje referenci na hodnotu atributu jiného uzlu (tj. je tvaru *{node_name.attr_name[.character_order]}*)
	#ifdef DEBUG_CHECK_REFERENCE_VALUE
		fprintf(stderr,"\ndotser.c: checkReferenceValue: Entering the function; the value to be checked is '%s'", getAHLineValue(valuetl));
	#endif
	// následující dvě podmínky mi zaručí, že se tato funkce nebude provádět zbytečně opakovaně u jedné hodnoty jednoho dotazu
	if (valuetl->contains_reference == 1) return TRUE; // už to bylo zjištěno dřív - obsahuje
	if (valuetl->contains_reference == 2) return FALSE; // už to bylo zjištěno dřív - neobsahuje
	// nyní vím, že se dosud nezjišťovalo, zda tato hodnota tohoto vrcholu dotazu obsahuje referenci
	#ifdef DEBUG_CHECK_REFERENCE_VALUE
		fprintf(stderr,"\ndotser.c: checkReferenceValue: It has not been found yet.");
	#endif
	char node_name[MAXLONGVALUELEN];
	char attr_name[MAXATTRLEN];
	char *pos,*pos1,*pos2,*pos3,*pos4,*end;
	char *value = getAHLineValue(valuetl);
	int length = getAHLineLength(valuetl);
	end = value + length;
	pos = value;
	while (end > pos) { // kontroluji celý řetězec
		pos1 = index(pos, NODE_REFERENCE_START); // naleznu začátek referenčního odkazu
		if (pos1 == NULL) { // nejběžnější případ - znak nenalezen, žádná reference
			valuetl->contains_reference = 2; // uchovám tuto informaci
			return FALSE;
		}
		pos1++; // posunu se za ten znak
		/*if (!notOddBackshlashes(pos, length)) { // znaku začátku referenčního odkazu předcházel lichý počet escape znaků '\', takže je třeba jej brát jako obyčejný znak
			pos = pos1;
			continue; // a hledám dále v řetězci výskyt referenčního odkazu
		}*/
		pos2 = index(pos1, NODE_REFERENCE_DIVIDER); // naleznu první výskyt oddělovače jména uzlu a jména atributu
		if (pos2 == NULL) { // znak nenalezen, žádná reference v tomto vrcholu
			valuetl->contains_reference = 2; // uchovám tuto informaci
			return FALSE; // ani žádná další reference se v řetězci už nemůže bez takového znaku vyskytnout - vracím tedy rovnou FALSE
		}
		// teď bych měl zkontrolovat, zda tady nepředcházel lichý počet escape znaků '\', ale nechám to být; ani u dalších znaků už to nebudu testovat
		// řetězec obsahuje oddělovač jména uzlu a atributu, ještě zjistím, zda před tím oddělovačem je skutečně jméno uzlu
		length = pos2 - pos1; // toto je délka řetězce před tím oddělovačem
		strncpy(node_name, pos1, length); // zkopíruji jen část řetězce value, která je za začátkem reference a před oddělovačem jmen - kandidáta na jméno vrcholu
		node_name[length]='\0'; // zakončím řetězec binární nulou
		if (getNodeWithName(node_name, cely_strom_dotazu, query_TVSList, actual_logical_expression) == NULL) { // vrchol s takovým jménem neexistuje
			pos = pos1; // musím se vrátit až sem, abych případně nepřehlédnul nějaký dřívější začátek reference
			continue;
		}
		#ifdef DEBUG_CHECK_REFERENCE_VALUE
			fprintf(stderr,"\ndotser.c: checkReferenceValue: Found a name of a node: %s", node_name);
		#endif
		// nyní vím, že před oddělovačem jmen je jméno uzlu
		// dále se bude zjišťovat, zda je za oddělovačem jmen jméno atributu, případně ještě omezeno na určitý znak
		pos2++; // posunu se za oddělovač
		pos3 = index(pos2, CHARACTER_ORDER_DIVIDER); // naleznu případný výskyt oddělovače pořadí znaku
		pos4 = index(pos2, NODE_REFERENCE_END); // a výskyt ukončovacího znaku reference
		if (pos4 == NULL) { // neukončená reference je žádná reference
			valuetl->contains_reference = 2; // uchovám tuto informaci
			return FALSE; // žádná další reference už v řetězci být nemůže, byla by rovněž neukončená - tedy vracím rovnou FALSE
		}
		if (pos3 == NULL) { // znak nenalezen, ukážu tedy na konec reference (hodnota atributu není omezena na znak s určitým pořadím)
			pos3 = pos4;
		}
		// nyní pro zjednodušení vezmu nižší z pos3 a pos4
		if (pos4<pos3) { // vypadá to, že není odkaz na určitý znak hodnoty atributu a oddělovač pořadí znaku je až někde za referencí
			pos3 = pos4;
		}
		length = pos3 - pos2; // toto je délka řetězce kandidujícího na jméno atributu
		if (length>=MAXATTRLEN) { // to je příliš dlouhé, a tudíž to nemůže být jménem atributu
			pos = pos1; // ruším dosavadní nalezené a hledám jinou referenci se začátkem kousek dál než začínala tahle
			continue;
		}
		strncpy(attr_name, pos2, length); // zkopíruji jen část řetězce value, která je kandidátem na jméno atributu
		attr_name[length]='\0'; // zakončím řetězec binární nulou
		if (isThere(attr_name, GlobHlav) == -1) { // atribut s takovým jménem neexistuje
			pos = pos1; // ruším dosavadní nalezené a hledám jinou referenci se začátkem kousek dál než začínala tahle
			continue;
		}
		#ifdef DEBUG_CHECK_REFERENCE_VALUE
			fprintf(stderr,"\ndotser.c: checkReferenceValue: Found a name of an attribute: %s", attr_name);
		#endif
		// tady bych měl ještě správně zjistit, že dál už je jen číslo, ale to si odpustím
		valuetl->contains_reference = 1; // uchovám tuto informaci o této hodnotě
		aktualni_vrchol_dotazu->contains_reference = TRUE; // a rovněž globálně o vrcholu
		return TRUE;
	} // while
	valuetl->contains_reference = 2; // uchovám tuto informaci
	return FALSE;
} // checkReferenceValue

TSezVrch *getStickedNode(TVS *d_node) { // vrátí ukazatel na vrchol nalepený na d_node - položku seznamu matchujících vrcholů daného vrcholu dotazu; NULL, pokud žádný nalepený nenajde
	TSezVrch *matching_node = d_node->match; // ukážu na první matchující vrchol
	while (matching_node) { // přes všechny matchující vrcholy
		if (matching_node->vrchol->nalepeny == d_node) { // našel jsem vrchol nalepený na d_node
			return matching_node;
		}
		matching_node = matching_node->next;
	}
	return NULL; // žádný vrchol nebyl nalepený na d_node
} // getStickedNode

char *getOneDereferencedValue(TVS *cely_strom_dotazu, char *node_name, char *attr_name, TVSList *query_TVSList, char *actual_logical_expression, char *char_order = NULL) { // vrátí hodnotu jednoho referenčního odkazu
	TVS *d_node = getNodeWithName(node_name, cely_strom_dotazu, query_TVSList, actual_logical_expression); // vrátí ukazatel na položku TVS s vrcholem s daným jménem, pokud existuje, jinak NULL
	if (d_node == NULL) return ""; // reference ukazuje na neexistující místo, vracím prázdný řetězec
	TSezVrch *s_node = getStickedNode(d_node); // vrátí ukazatel na nalepený vrchol - položku seznamu matchujících vrcholů daného vrcholu dotazu
	if (s_node == NULL) { // žádný vrchol stromu není nalepený na tento vrchol dotazu
		return ""; // je tohle správně???
	}
	int meta_value;
	if (isMetaAttribute(attr_name)) { // jedná se o referenci na hodnotu meta atributu; to má smysl jen u _#sons, _#hsons, _#descendants, _depth a _#occurrences
		#ifdef DEBUG_GET_ONE_DEREFERENCED_VALUE
			fprintf(stderr,"\ndotser.c: getOneDereferencedValue: The attribute %s is a meta attribute", attr_name);
		#endif
		if (!strcmp(attr_name, META_NUMBER_OF_SONS)) { // jedná se o meta atribut META_NUMBER_OF_SONS
			meta_value = s_node->vrchol->vrchol->number_of_sons;
			#ifdef DEBUG_GET_ONE_DEREFERENCED_VALUE
				fprintf(stderr,"\ndotser.c: getOneDereferencedValue: number of sons is: %d", meta_value);
			#endif
		}
		else if (!strcmp(attr_name, META_NUMBER_OF_HIDDEN_SONS)) { // jedná se o meta atribut META_NUMBER_OF_HIDDEN_SONS
			meta_value = s_node->vrchol->vrchol->number_of_hidden_sons;
			#ifdef DEBUG_GET_ONE_DEREFERENCED_VALUE
				fprintf(stderr,"\ndotser.c: getOneDereferencedValue: number of hidden sons is: %d", meta_value);
			#endif
		}
		else if (!strcmp(attr_name, META_NUMBER_OF_DESCENDANTS)) { // jedná se o meta atribut META_NUMBER_OF_DESCENDANTS
			meta_value = s_node->vrchol->vrchol->nodes_in_subtree - 1;
		}
		else if (!strcmp(attr_name, META_NUMBER_OF_LEFT_BROTHERS)) { // jedná se o meta atribut META_NUMBER_OF_LEFT_BROTHERS
			meta_value = getNumberOfBrothers(s_node->vrchol->vrchol, -1);
		}
		else if (!strcmp(attr_name, META_NUMBER_OF_RIGHT_BROTHERS)) { // jedná se o meta atribut META_NUMBER_OF_RIGHT_BROTHERS
			meta_value = getNumberOfBrothers(s_node->vrchol->vrchol, 1);
		}
		else if (!strcmp(attr_name, META_DEPTH_FROM_ROOT)) { // jedná se o meta atribut META_DEPTH_FROM_ROOT
			meta_value = s_node->vrchol->vrchol->depth_from_root;
		}
		else if (!strcmp(attr_name, META_NUMBER_OF_OCCURRENCES)) { // jedná se o meta atribut META_DEPTH_FROM_ROOT
			return ""; // zatím neumím
		}
		else return ""; // odkazy na ostatní meta atributy nemají význam

		// ignoruji případnou restrikci na konkrétní znak, nemá u čísel smysl
		sprintf(refValueRestricted, "%d", meta_value); // převedu číslo na řetězec, protože funkce vrací řetězec
		return refValueRestricted; // na vrácení této hodnoty používám globálně umístěné pole
	} // if meta atribut
	int attr_order;
	if ((attr_order = isThere(attr_name, actualFileOfTrees)) == -1) { // atribut s takovým jménem neexistuje
		return "";
	}
	char *value = getAHLineValue(s_node->vrchol->vrchol->Values->AHTable+attr_order); // tady vezmu první hodnotu první sady; to je také trochu nedořešené!!!
	if (char_order == NULL) { // pokud není specifikován jen jeden znak z nalezené hodnoty
		return value; // vracím celou hodnotu
	}
	// musím vybrat jen jeden znak
	#ifdef DEBUG_GET_ONE_DEREFERENCED_VALUE
		fprintf(stderr,"\ndotser.c: getOneDereferencedValue: The restriction to one character has been set");
	#endif
	char *endptr;
	int order = strtol(char_order, &endptr, 10); // zkusím převést řetězec na číslo v desítkové soustavě
	if (char_order == endptr) { // konverze na číslo neuspěla
		// co teď?
		return value; // prozatím vrátím opět celou hodnotu
	}
	order --; // uživatel odkazuje na první znak číslem 1, v poli má index 0
	if (order<0 || order>=safeStrLen(value)) { // mimo rozsah
		// co teď?
		return value; // prozatím vrátím opět celou hodnotu
	}
	refValueRestricted[0] = *(value+order); // na vrácení této hodnoty používám globálně umístěné pole
	refValueRestricted[1] = '\0'; // ukončím řetězec
	return refValueRestricted;
} // getOneDereferencedValue

void getDereferencedValue(char *der_value, TVS *cely_strom_dotazu, char *value, TVSList *query_TVSList, char *actual_logical_expression) { // v der_value, kde musí být dost místa, vrátí nový řetězec vzniklý z value nahrazením referencí jejich hodnotami (původní obsah value zůstane nezměněn)
	// po dereferencování bude hodnota atributu v řetězci der_value; ani v tomto případě nesmí překročit MAXVALUELEN, protože by pak těžko matchoval s něčím kratším
	int der_pos; // pozice v dereferencované hodnotě
	#ifdef DEBUG_GET_DEREFERENCED_VALUE
		fprintf(stderr,"\ndotser.c: getDereferencedValue: going to dereference value: %s", value);
	#endif
	der_pos = 0;
	char node_name[MAXLONGVALUELEN]; // sem se bude načítat jméno vrcholu
	char attr_name[MAXATTRLEN]; // sem se bude načítat jméno atributu
	char char_order[MAXLONGVALUELEN]; // sem se bude načítat případné pořadí znaku; pro jistotu tomu dávám tuto maximální velikost
	char *pos,*pos1,*pos2,*pos3,*pos4,*end;
	char *co; // pomocná
	char *deref_value; // bude ukazovat na jednu dereferencovanou hodnotu
	int length = safeStrLen(value);
	end = value + length;
	pos = value;
	while (end > pos) { // kontroluji celý řetězec; dokud nenajdu začátek reference, kopíruji znaky na výstup
		if (*pos == NODE_REFERENCE_START) { // nalezen možný začátek reference
			pos1 = pos+1; // posunu se za ten znak
			/*if (!notOddBackshlashes(pos, length)) { // znaku začátku referenčního odkazu předcházel lichý počet escape znaků '\', takže je třeba jej brát jako obyčejný znak
				pos = pos1;
				continue; // a hledám dále v řetězci výskyt referenčního odkazu
			}*/
			pos2 = index(pos1, NODE_REFERENCE_DIVIDER); // naleznu první výskyt oddělovače jména uzlu a jména atributu
			if (pos2 == NULL) { // znak nenalezen, žádná další reference v tomto vrcholu
				*(der_value+der_pos) = NODE_REFERENCE_START; // znak začátku reference byl normálním znakem, zkopíruji ho na výstup a budu normálně pokračovat dál - dokopíruje se zbytek řetězce
				der_pos++;
				pos++;
				continue; // jdu na další znak
			}
			// teď bych měl zkontrolovat, zda tady nepředcházel lichý počet escape znaků '\', ale nechám to být; ani u dalších znaků už to nebudu testovat
			// řetězec obsahuje oddělovač jména uzlu a atributu, ještě zjistím, zda před tím oddělovačem je skutečně jméno uzlu, a jaké
			length = pos2 - pos1; // toto je délka řetězce před tím oddělovačem
			strncpy(node_name, pos1, length); // zkopíruji jen část řetězce value, která je za začátkem reference a před oddělovačem jmen - kandidáta na jméno vrcholu
			node_name[length]='\0'; // zakončím řetězec binární nulou
			if (getNodeWithName(node_name, cely_strom_dotazu, query_TVSList, actual_logical_expression) == NULL) { // vrchol s takovým jménem neexistuje
				*(der_value+der_pos) = NODE_REFERENCE_START; // znak začátku reference byl normálním znakem, zkopíruji ho na výstup a budu normálně pokračovat dál - hledat jiný začátek reference
				der_pos++;
				pos++;
				continue; // jdu na další znak
			}
			#ifdef DEBUG_GET_DEREFERENCED_VALUE
				fprintf(stderr,"\ndotser.c: getDereferencedValue: Found a name of a node: %s", node_name);
			#endif
			// nyní vím, že před oddělovačem jmen je jméno uzlu
			// dále se bude zjišťovat, zda je za oddělovačem jmen jméno atributu, případně ještě omezeno na určitý znak
			pos2++; // posunu se za oddělovač
			pos3 = index(pos2, CHARACTER_ORDER_DIVIDER); // naleznu případný výskyt oddělovače pořadí znaku
			pos4 = index(pos2, NODE_REFERENCE_END); // a výskyt ukončovacího znaku reference
			if (pos4 == NULL) { // neukončená reference je žádná reference; tzn. žádná další reference v tomto vrcholu
				*(der_value+der_pos) = NODE_REFERENCE_START; // znak začátku reference byl normálním znakem, zkopíruji ho na výstup a budu normálně pokračovat dál - dokopíruje se zbytek řetězce
				der_pos++;
				pos++;
				continue; // jdu na další znak
			}
			if (pos3 == NULL) { // znak nenalezen, ukážu tedy na konec reference (hodnota atributu není omezena na znak s určitým pořadím)
				pos3 = pos4;
			}
			// nyní pro zjednodušení vezmu nižší z pos3 a pos4
			if (pos4<pos3) { // vypadá to, že není odkaz na určitý znak hodnoty atributu a oddělovač pořadí znaku je až někde za referencí
				pos3 = pos4;
			}
			length = pos3 - pos2; // toto je délka řetězce kandidujícího na jméno atributu
			if (length>=MAXATTRLEN) { // to je příliš dlouhé, a tudíž to nemůže být jménem atributu
				*(der_value+der_pos) = NODE_REFERENCE_START; // ruším dosavadní nalezené; znak začátku reference byl normálním znakem, zkopíruji ho na výstup a budu normálně pokračovat dál - hledat jiný začátek reference
				der_pos++;
				pos++;
				continue; // jdu na další znak
			}
			strncpy(attr_name, pos2, length); // zkopíruji jen část řetězce value, která je kandidátem na jméno atributu
			attr_name[length]='\0'; // zakončím řetězec binární nulou
			if (isThere(attr_name, GlobHlav) == -1) { // atribut s takovým jménem neexistuje
				*(der_value+der_pos) = NODE_REFERENCE_START; // ruším dosavadní nalezené; znak začátku reference byl normálním znakem, zkopíruji ho na výstup a budu normálně pokračovat dál - hledat jiný začátek reference
				der_pos++;
				pos++;
				continue; // jdu na další znak
			}
			#ifdef DEBUG_GET_DEREFERENCED_VALUE
				fprintf(stderr,"\ndotser.c: getDereferencedValue: Found a name of an attribute: %s", attr_name);
			#endif
			if (pos3<pos4) { // byl tam odkaz na určitý znak
				length = pos4 - pos3;
				pos3++; // posunu se za oddělující znak
				strncpy(char_order, pos3, length); // zkopíruji jen část řetězce value, která určuje pořadí znaku
				char_order[length]='\0'; // zakončím řetězec binární nulou
				// kontrola, zda jde o přípustnou hodnotu, se provede ve fci getOneDereferencedValue
				co = char_order;
			}
			else  { // nebyl tam odkaz na určitý znak
				co = NULL;
			}
			deref_value = getOneDereferencedValue(cely_strom_dotazu, node_name, attr_name, query_TVSList, actual_logical_expression, co);
			length = strlen(deref_value);
			if (der_pos + length >= MAXLONGVALUELEN) { // chyba - překročil jsem maximální možnou délku dereferencované hodnoty
				length = MAXLONGVALUELEN - der_pos - 1; // zkrátím tu dereferencovanou jednu hodnotu
				*(der_value+der_pos) = '\0'; // ukončím řetězec (smažu tím poslední přidávaný znak); to je pro výpis chyby, jinak ten řetězec se ukončí znovu za cyklem
				fprintf(stderr,"\ndotser.c: getDereferencedValue: The dereferenced value is longer than MAXVALUELEN; cutting it: %s", der_value);
				break; // vyskočím z cyklu

			}
			strncpy(der_value+der_pos, deref_value, length); // zkopíruji dereferencovanou hodnotu do výstupního pole
			der_pos += length; // posunu se za tu dereferencovanou hodnotu
			pos = pos4; // také ve vstupním poli se posunu na konec reference
			#ifdef DEBUG_GET_DEREFERENCED_VALUE
				fprintf(stderr,"\ndotser.c: getDereferencedValue: The one reference has been dereferenced to: %s", deref_value);
			#endif
		}
		else { // normální znak mimo referenci - kopíruji na výstup
			*(der_value+der_pos) = *pos;
			der_pos++;
			if (der_pos >= MAXLONGVALUELEN) { // chyba - překročil jsem maximální možnou délku dereferencované hodnoty
				der_pos--; // pole může být alokované přesně na MAXVALUELEN a já potřebuji vložit i koncový znak řetězce
				*(der_value+der_pos) = '\0'; // ukončím řetězec (smažu tím poslední přidávaný znak); to je pro výpis chyby, jinak ten řetězec se ukončí znovu za cyklem
				fprintf(stderr,"\ndotser.c: getDereferencedValue: The dereferenced value is longer than MAXVALUELEN; cutting it: %s", der_value);
				break; // vyskočím z cyklu
			}
		}
		pos++; // ukážu na další znak ve vstupním poli
	} // while
	*(der_value+der_pos) = '\0'; // ukončím řetězec
	#ifdef DEBUG_GET_DEREFERENCED_VALUE
		fprintf(stderr,"\ndotser.c: getDereferencedValue: The value has been dereferenced to: %s", der_value);
	#endif
	return;
} // getDereferencedValue

// vlastní porovnání dvou hodnot atributů - hodnoty v dotazu a hodnoty v prohledávaném stromu
int valuesMatch(TVS *cely_strom_dotazu, TVS *aktualni_vrchol_dotazu, int relation, int real_relation, TAHLine *dtl, char *s, int poradi_gh, int resolve_references, TVSList *query_TVSList, char *actual_logical_expression) {
  // porovná dva řetězce buď jako regulární výrazy, nebo jako čísla, případně jako řetězce s přihlédnutím k žolíkům (mohou být pouze v d) a k relaci relation
  // cely_strom_dotazu: kořen dotazu
  // aktualni_vrchol_dotazu: aktualni vrchol dotazu
  // relation: relace pro porovnání hodnot v dotazu a ve stromě pro účely této funkce; může být RELATION_EQ, RELATION_NEQ, RELATION_LT, RELATION_GT, RELATION_LTEQ, RELATION_GTEQ
  // real_relation: skutečná relace pro porovnání hodnot v dotazu a ve stromě
  // dtl: struktura uchovávající jednu hodnotu dotazu
  // s: řetězec prohledávaného stromu, se kterým se matchuje daná hodnota dotazu
  // poradi_gh: pořadí aktuálně zvažovaného atributu v globální hlavičce
	// resolve_references = TRUE/FALSE urcuje, zda vyhodnocovat referencni odkazy
	// Tato funkce je volána dvakrát - poprvé v první fázi, tj. při sestavování matchujících vrcholů, podruhé při druhé fázi, kdy se ověřují reference již v sestaveném matchujícím stromě.

	// první věc - zjistit, zda se nejedná o odkaz na hodnotu atributu v jiném uzlu (tzn. *d by byl tvaru .*{node_name.attr_name}.*)
	int result;
  int d_length;
	char der_value[MAXLONGVALUELEN+1]; // po dereferencování bude hodnota atributu v tomto řetězci; ani v tomto případě nesmí překročit MAXVALUELEN, protože by pak těžko matchoval s něčím kratším
	char *d = getAHLineValue(dtl); // tento řetězec už je ta vlastní hodnota dotazu
	#ifdef DEBUG_MATCH_VALUES
		fprintf(stderr,"\ndotser.c: valuesMatch: Entering the function with values: %s and %s (relation %d, real relation %d)", s, d, relation, real_relation);
	#endif
	if (checkReferenceValue(cely_strom_dotazu, aktualni_vrchol_dotazu, dtl, query_TVSList, actual_logical_expression)) { // pokud je v dotazu dtl uveden odkaz na jiný uzel
		#ifdef DEBUG_MATCH_VALUES
			fprintf(stderr,"\ndotser.c: valuesMatch:   the value %s contains a reference", d);
		#endif
		if (!resolve_references) { // toto je volání této funkce v první fázi - vytváření matchujících vrcholů; reference nemohu obecně v tuto chvíli vyhodnotit; nechám to tedy projít
			#ifdef DEBUG_MATCH_VALUES
				fprintf(stderr," - ignoring it at this stage");
			#endif
			if (real_relation == RELATION_NEQ) {
				#ifdef DEBUG_MATCH_VALUES
					fprintf(stderr,"\ndotser.c: valuesMatch: result: 0 (the real relation is RELATION_NEQ)");
				#endif
				return FALSE; // takto to projde, pokud se v této funkci jedná o relaci rovnost z původní relace nerovnosti
			}
			else {
				#ifdef DEBUG_MATCH_VALUES
					fprintf(stderr,"\ndotser.c: valuesMatch: result: 1 (the real relation is not RELATION_NEQ)");
				#endif
				return TRUE;
			}
		}
		else { // toto je volání této funkce v druhé fázi - po sestavení matchujícího stromu; nyní je potřeba ověřit reference
			#ifdef DEBUG_MATCH_VALUES
				fprintf(stderr," - going to dereference it");
			#endif
			getDereferencedValue(der_value,cely_strom_dotazu,d, query_TVSList, actual_logical_expression); // v der_value vrátí nový řetězec vzniklý z d nahrazením referencí jejich hodnotami (původní obsah d, tedy dtl->Value, zůstane nezměněn)
			d = der_value; // proměnnou d si ukážu na tu dereferencovanou hodnotu
		}
	}
	/* tuto zakomentovanou větev nelze bohužel obecně zařadit - v případě alternativních hodnot je potřeba znovu ověřit platnost celé disjunkce
	else {
		if (resolve_references) { // hodnota neobsahovala referenci a jsem již ve druhé fázi - ověřování referencí
			return TRUE; // rovnou vracím TRUE - hodnoty bez referencí byly ověřeny již v první fázi (při sestavování matchujících vrcholů)
		}
	}*/
	// sem to dojde v první fázi, pokud hodnota atributu v dotazu neobsahuje referenci, a každopádně ve druhé fázi (viz zakomentovaná předchozí else větev) s dereferencovanými případnými referencemi
	// v d je ta vlastní hodnota dotazu bez referencí
	#ifdef DEBUG_MATCH_VALUES
		fprintf(stderr,"\ndotser.c: valuesMatch:   trying to match values %s and %s (relation %d)", s, d, relation);
	#endif
	// teď zkusím, zda d není regulární výraz - pak bych porovnával přes regulární výrazy
  if (dtl->contains_regexp == 1) { // hodnota dotazu je už zkompilovaný a prozkoumaný regulární výraz
    //a relace je RELATION_EQ (real_relation může být tedy i RELATION_NEQ)
    #ifdef DEBUG_MATCH_VALUES
      fprintf(stderr,"\ndotser.c: valuesMatch:     the query attribute value is a regular expression, entering function regexpValuesMatch");
    #endif
    result = regexpValuesMatch(dtl, s);
    #ifdef DEBUG_MATCH_VALUES
      fprintf(stderr,"\ndotser.c: valuesMatch: result: %d", result);
    #endif
    return result;
  }
  // teď zkusím, zda to nejsou čísla - pak bych porovnával číselně
	double d_double, s_double;
	if (!convertToDouble(&d_double, d)) { // pokud je d číslo
		if (!convertToDouble(&s_double, s)) { // a pokud je i s číslo
			#ifdef DEBUG_MATCH_VALUES
				fprintf(stderr,"\ndotser.c: valuesMatch:     both the values are double numbers, entering function doubleValuesMatch");
			#endif
			result=doubleValuesMatch(relation, d_double, s_double);
			#ifdef DEBUG_MATCH_VALUES
				fprintf(stderr,"\ndotser.c: valuesMatch: result: %d", result);
			#endif
			return result;
		}
	}
	// alespoň jedna z hodnot není číslo, takže porovnám řetězce po písmenkách
	#ifdef DEBUG_MATCH_VALUES
		fprintf(stderr,"\ndotser.c: valuesMatch:     at least one of the values is not a double number, entering function stringValuesMatch");
	#endif
	result=stringValuesMatch(relation,d,s,poradi_gh);
	#ifdef DEBUG_MATCH_VALUES
		fprintf(stderr,"\ndotser.c: valuesMatch: result: %d", result);
	#endif
	return result;
} // valuesMatch



/*
int valuesMatch( char * d, char * s ) // nejprimitivnější historické matchování hodnot
{
	return ! strcmp( d, s );
}
*/

int attrib_match(TVS *cely_strom_dotazu, TVS *aktualni_vrchol_dotazu, TAHLine * d, TAHLine *s, int poradi_gh, int resolve_references, TVSList *query_TVSList, char *actual_logical_expression) { // porovnám, zda matchují dva atributy (beru v úvahu alternativní hodnoty)
	// resolve_references = TRUE/FALSE urcuje, zda vyhodnocovat referencni odkazy
	TAHLine * pom;
	int relation, real_relation;
	relation = real_relation = d->relation; // relaci beru pro jistotu z prvni hodnoty atributu
	if (relation == RELATION_NEQ) { // k této negaci na atributu se chovám jinak - otestuji rovnost a pak převrátím výsledek (kvůli správné interpretaci alternativních hodnot - např. dotaz tag!=N*|A*)
		relation = RELATION_EQ;
	}
	while (d) { // zkouším alternativní hodnoty v dotazu
		pom = s;
		while (pom) { // a tady zkouším alternativní hodnoty v prohledávaném stromě
			if (valuesMatch (cely_strom_dotazu, aktualni_vrchol_dotazu, relation, real_relation, d, getAHLineValue(pom), poradi_gh, resolve_references, query_TVSList, actual_logical_expression)) {
				if (real_relation == RELATION_NEQ) return FALSE; // převracím výsledek, protože jsem na začátku převrátil nerovnítko na rovnítko
				return TRUE;
			}
			pom = pom -> next;
		}
		d = d -> next;
	}
	if (real_relation == RELATION_NEQ) return TRUE; // převracím výsledek, protože jsem na začátku převrátil nerovnítko na rovnítko
	return FALSE;
}

int metaValuesMatch(TVS *cely_strom_dotazu, TVS *aktualni_vrchol_dotazu, const int relation, const int real_relation, TAHLine *dtl, const int int_value, const int resolve_references, TVSList *query_TVSList, char *actual_logical_expression) { // vrátí TRUE/FALSE podle toho, zda hodnota metaatributu matchuje s danou hodnotou
	char der_value[MAXLONGVALUELEN+1]; // po dereferencování bude hodnota atributu v tomto řetězci; ani v tomto případě nesmí překročit MAXLONGVALUELEN, protože by pak těžko matchoval s něčím kratším
	char *d = getAHLineValue(dtl); // tento řetězec už je ta vlastní hodnota dotazu
	#ifdef DEBUG_MATCH_META_VALUES
		fprintf(stderr,"\ndotser.c: metaValuesMatch: Entering the function with values: %d and %s (relation %d, real relation %d)", int_value, d, relation, real_relation);
	#endif
	if (checkReferenceValue(cely_strom_dotazu, aktualni_vrchol_dotazu, dtl, query_TVSList, actual_logical_expression)) { // pokud je v dotazu dtl uveden odkaz na jiný uzel
		#ifdef DEBUG_MATCH_META_VALUES
			fprintf(stderr,"\ndotser.c: metaValuesMatch:   the value %s contains a reference", d);
		#endif
		if (!resolve_references) { // toto je volání této funkce v první fázi - vytváření matchujících vrcholů; reference nemohu obecně v tuto chvíli vyhodnotit; nechám to tedy projít
			#ifdef DEBUG_MATCH_META_VALUES
				fprintf(stderr," - ignoring it at this stage");
			#endif
			if (real_relation == RELATION_NEQ) {
				#ifdef DEBUG_MATCH_META_VALUES
					fprintf(stderr,"\ndotser.c: metaValuesMatch: result: 0 (the real relation is RELATION_NEQ)");
				#endif
				return FALSE; // takto to projde, pokud se v této funkci jedná o relaci rovnost z původní relace nerovnosti
			}
			else {
				#ifdef DEBUG_MATCH_META_VALUES
					fprintf(stderr,"\ndotser.c: metaValuesMatch: result: 1 (the real relation is not RELATION_NEQ)");
				#endif
				return TRUE;
			}
		}
		else { // toto je volání této funkce v druhé fázi - po sestavení matchujícího stromu; nyní je potřeba ověřit reference
			#ifdef DEBUG_MATCH_META_VALUES
				fprintf(stderr," - going to dereference it");
			#endif
			getDereferencedValue(der_value,cely_strom_dotazu,d, query_TVSList, actual_logical_expression); // v der_value vrátí nový řetězec vzniklý z d nahrazením referencí jejich hodnotami (původní obsah d, tedy dtl->Value, zůstane nezměněn)
			d = der_value; // proměnnou d si ukážu na tu dereferencovanou hodnotu
		}
	}
	/* tuto zakomentovanou větev nelze bohužel obecně zařadit - v případě alternativních hodnot je potřeba znovu ověřit platnost celé disjunkce
	else {
		if (resolve_references) { // hodnota neobsahovala referenci a jsem již ve druhé fázi - ověřování referencí
			return TRUE; // rovnou vracím TRUE - hodnoty bez referencí byly ověřeny již v první fázi (při sestavování matchujících vrcholů)
		}
	}*/
	// sem to dojde v první fázi, pokud hodnota meta atributu v dotazu neobsahuje referenci, a každopádně ve druhé fázi (viz zakomentovaná předchozí else větev) s dereferencovanými případnými referencemi
	// v d je ta vlastní hodnota meta atributu dotazu bez referencí
	#ifdef DEBUG_MATCH_META_VALUES
		fprintf(stderr,"\ndotser.c: metaValuesMatch:   trying to match values %d and %s (relation %d)", int_value, d, relation);
	#endif
	// nyní se pokusím převést hodnotu dotazu d na číslo
	double v_double;
	if (convertToDouble(&v_double, d)) { // pokud d není číslo (ani po případném sečítání a odečítání) - konverze na číslo neuspěla
		return FALSE;
	}
	double double_int_value = int_value;
	/*char *endptr;
	int v = strtol(d, &endptr, 10);
	if (d == endptr) return FALSE; // konverze na číslo neuspěla*/
	switch (relation) {
		case RELATION_EQ: if (double_int_value == v_double) {
							#ifdef DEBUG_MATCH_META_VALUES
								fprintf(stderr,"\ndotser.c: metaValuesMatch: result: 1");
							#endif
							return TRUE;
						  }
		                  else {
							#ifdef DEBUG_MATCH_META_VALUES
								fprintf(stderr,"\ndotser.c: metaValuesMatch: result: 0");
							#endif
						    return FALSE;
						  }
		case RELATION_NEQ: if (double_int_value != v_double) {
							#ifdef DEBUG_MATCH_META_VALUES
								fprintf(stderr,"\ndotser.c: metaValuesMatch: result: 1");
							#endif
							return TRUE;
						  }
		                  else {
							#ifdef DEBUG_MATCH_META_VALUES
								fprintf(stderr,"\ndotser.c: metaValuesMatch: result: 0");
							#endif
						    return FALSE;
						  }
		case RELATION_LTEQ: if (double_int_value <= v_double) {
							#ifdef DEBUG_MATCH_META_VALUES
								fprintf(stderr,"\ndotser.c: metaValuesMatch: result: 1");
							#endif
							return TRUE;
						  }
		                  else {
							#ifdef DEBUG_MATCH_META_VALUES
								fprintf(stderr,"\ndotser.c: metaValuesMatch: result: 0");
							#endif
						    return FALSE;
						  }
		case RELATION_GTEQ: if (double_int_value >= v_double) {
							#ifdef DEBUG_MATCH_META_VALUES
								fprintf(stderr,"\ndotser.c: metaValuesMatch: result: 1");
							#endif
							return TRUE;
						  }
		                  else {
							#ifdef DEBUG_MATCH_META_VALUES
								fprintf(stderr,"\ndotser.c: metaValuesMatch: result: 0");
							#endif
						    return FALSE;
						  }
		case RELATION_LT: if (double_int_value < v_double) {
							#ifdef DEBUG_MATCH_META_VALUES
								fprintf(stderr,"\ndotser.c: metaValuesMatch: result: 1");
							#endif
							return TRUE;
						  }
		                  else {
							#ifdef DEBUG_MATCH_META_VALUES
								fprintf(stderr,"\ndotser.c: metaValuesMatch: result: 0");
							#endif
						    return FALSE;
						  }
		case RELATION_GT: if (double_int_value > v_double) {
							#ifdef DEBUG_MATCH_META_VALUES
								fprintf(stderr,"\ndotser.c: metaValuesMatch: result: 1");
							#endif
							return TRUE;
						  }
		                  else {
							#ifdef DEBUG_MATCH_META_VALUES
								fprintf(stderr,"\ndotser.c: metaValuesMatch: result: 0");
							#endif
						    return FALSE;
						  }
		default:
				 #ifdef DEBUG_MATCH_META_VALUES
					fprintf(stderr,"\ndotser.c: metaValuesMatch: default (!) result: 0");
				 #endif
			    return FALSE;
	} // switch
} // metaValuesMatch

int metaValuesMatchString(TVS *cely_strom_dotazu, TVS *aktualni_vrchol_dotazu, const int relation, const int real_relation, TAHLine *dtl, char *string_value, int poradi_gh, const int resolve_references, TVSList *query_TVSList, char *actual_logical_expression) { // vrátí TRUE/FALSE podle toho, zda hodnota metaatributu matchuje s danou hodnotou
	char der_value[MAXLONGVALUELEN+1]; // po dereferencování bude hodnota atributu v tomto řetězci; ani v tomto případě nesmí překročit MAXLONGVALUELEN, protože by pak těžko matchoval s něčím kratším
	char *d = getAHLineValue(dtl); // tento řetězec už je ta vlastní hodnota dotazu
	int result;
	#ifdef DEBUG_MATCH_META_VALUES
		fprintf(stderr,"\ndotser.c: metaValuesMatchString: Entering the function with values: %s and %s (relation %d, real relation %d)", string_value, d, relation, real_relation);
	#endif
	if (checkReferenceValue(cely_strom_dotazu, aktualni_vrchol_dotazu, dtl, query_TVSList, actual_logical_expression)) { // pokud je v dotazu dtl uveden odkaz na jiný uzel
		#ifdef DEBUG_MATCH_META_VALUES
			fprintf(stderr,"\ndotser.c: metaValuesMatchString:   the value %s contains a reference", d);
		#endif
		if (!resolve_references) { // toto je volání této funkce v první fázi - vytváření matchujících vrcholů; reference nemohu obecně v tuto chvíli vyhodnotit; nechám to tedy projít
			#ifdef DEBUG_MATCH_META_VALUES
				fprintf(stderr," - ignoring it at this stage");
			#endif
			if (real_relation == RELATION_NEQ) {
				#ifdef DEBUG_MATCH_META_VALUES
					fprintf(stderr,"\ndotser.c: metaValuesMatchString: result: 0 (the real relation is RELATION_NEQ)");
				#endif
				return FALSE; // takto to projde, pokud se v této funkci jedná o relaci rovnost z původní relace nerovnosti
			}
			else {
				#ifdef DEBUG_MATCH_META_VALUES
					fprintf(stderr,"\ndotser.c: metaValuesMatchString: result: 1 (the real relation is not RELATION_NEQ)");
				#endif
				return TRUE;
			}
		}
		else { // toto je volání této funkce v druhé fázi - po sestavení matchujícího stromu; nyní je potřeba ověřit reference
			#ifdef DEBUG_MATCH_META_VALUES
				fprintf(stderr," - going to dereference it");
			#endif
			getDereferencedValue(der_value,cely_strom_dotazu,d, query_TVSList, actual_logical_expression); // v der_value vrátí nový řetězec vzniklý z d nahrazením referencí jejich hodnotami (původní obsah d, tedy dtl->Value, zůstane nezměněn)
			d = der_value; // proměnnou d si ukážu na tu dereferencovanou hodnotu
		}
	}
	/* tuto zakomentovanou větev nelze bohužel obecně zařadit - v případě alternativních hodnot je potřeba znovu ověřit platnost celé disjunkce
	else {
		if (resolve_references) { // hodnota neobsahovala referenci a jsem již ve druhé fázi - ověřování referencí
			return TRUE; // rovnou vracím TRUE - hodnoty bez referencí byly ověřeny již v první fázi (při sestavování matchujících vrcholů)
		}
	}*/
	// sem to dojde v první fázi, pokud hodnota meta atributu v dotazu neobsahuje referenci, a každopádně ve druhé fázi (viz zakomentovaná předchozí else větev) s dereferencovanými případnými referencemi
	// v d je ta vlastní hodnota meta atributu dotazu bez referencí
	#ifdef DEBUG_MATCH_META_VALUES
		fprintf(stderr,"\ndotser.c: metaValuesMatchString:   trying to match values %s and %s (relation %d)", string_value, d, relation);
	#endif

	// teď zkusím, zda d není regulární výraz - pak bych porovnával přes regulární výrazy
	if (dtl->contains_regexp == 1) { // hodnota dotazu je už zkompilovaný a prozkoumaný regulární výraz
    	//a relace je RELATION_EQ (real_relation může být tedy i RELATION_NEQ)
    	#ifdef DEBUG_MATCH_META_VALUES
      		fprintf(stderr,"\ndotser.c: metaValuesMatchString:     the query attribute value is a regular expression, entering function regexpValuesMatch");
		#endif
    	result = regexpValuesMatch(dtl, string_value);
    	#ifdef DEBUG_MATCH_META_VALUES
			fprintf(stderr,"\ndotser.c: metaValuesMatchString: result: %d", result);
		#endif
		return result;
	}
	/*// teď zkusím, zda to nejsou čísla - pak bych porovnával číselně
	double d_double, s_double;
	if (!convertToDouble(&d_double, d)) { // pokud je d číslo
		if (!convertToDouble(&s_double, s)) { // a pokud je i s číslo
			#ifdef DEBUG_MATCH_VALUES
				fprintf(stderr,"\ndotser.c: valuesMatch:     both the values are double numbers, entering function doubleValuesMatch");
			#endif
			result=doubleValuesMatch(relation, d_double, s_double);
			#ifdef DEBUG_MATCH_VALUES
				fprintf(stderr,"\ndotser.c: valuesMatch: result: %d", result);
			#endif
			return result;
		}
	}*/
	// alespoň jedna z hodnot není číslo, takže porovnám řetězce po písmenkách
	#ifdef DEBUG_MATCH_META_VALUES
		fprintf(stderr,"\ndotser.c: metaValuesMatchString:     at least one of the values is not a double number, entering function stringValuesMatch");
	#endif
	result=stringValuesMatch(relation,d,string_value,poradi_gh);
	#ifdef DEBUG_MATCH_META_VALUES
		fprintf(stderr,"\ndotser.c: metaValuesMatchString: result: %d", result);
	#endif
	return result;

} // metaValuesMatchString

int metaAttribMatch(TVS *cely_strom_dotazu, TVS *aktualni_vrchol_dotazu, TAHLine * dtl, const int value, const int resolve_references, TVSList *query_TVSList, char *actual_logical_expression) { // vrátí TRUE/FALSE podle toho, zda metaatribut matchuje s danou hodnotou

	if (dtl == NULL) return FALSE;
	int relation, real_relation;
	relation = real_relation = dtl->relation; // relaci beru pro jistotu (a prozatim) z prvni hodnoty atributu
	if (relation == RELATION_NEQ) { // k této negaci na atributu se chovám jinak - otestuji rovnost a pak převrátím výsledek (kvůli správné interpretaci alternativních hodnot - např. dotaz tag!=N*|A*)
		relation = RELATION_EQ;
	}
	//fprintf(stderr,"\ndotser.c: metaAttribMatch: the relation is: %d, the int value is: %d, the first string value is: %s", relation, value, d->Value);
	while (dtl) { // zkouším to přes všechny alternativní hodnoty meta atributu specifikované v dotazu
		if (metaValuesMatch (cely_strom_dotazu, aktualni_vrchol_dotazu, relation, real_relation, dtl, value, resolve_references, query_TVSList, actual_logical_expression)) {
				if (real_relation == RELATION_NEQ) return FALSE; // převracím výsledek, protože jsem na začátku převrátil nerovnítko na rovnítko
			return TRUE;
		}
		dtl = dtl -> next;
	}
	if (real_relation == RELATION_NEQ) return TRUE; // převracím výsledek, protože jsem na začátku převrátil nerovnítko na rovnítko
	return FALSE;
} // metaAttribMatch

int metaAttribMatchString(TVS *cely_strom_dotazu, TVS *aktualni_vrchol_dotazu, TAHLine * dtl, char *value, int poradi_gh, const int resolve_references, TVSList *query_TVSList, char *actual_logical_expression) { // vrátí TRUE/FALSE podle toho, zda metaatribut matchuje s danou hodnotou

	if (dtl == NULL) return FALSE;
	int relation, real_relation;
	relation = real_relation = dtl->relation; // relaci beru pro jistotu (a prozatim) z prvni hodnoty atributu
	if (relation == RELATION_NEQ) { // k této negaci na atributu se chovám jinak - otestuji rovnost a pak převrátím výsledek (kvůli správné interpretaci alternativních hodnot - např. dotaz tag!=N*|A*)
		relation = RELATION_EQ;
	}
	//fprintf(stderr,"\ndotser.c: metaAttribMatch: the relation is: %d, the int value is: %d, the first string value is: %s", relation, value, d->Value);
	while (dtl) { // zkouším to přes všechny alternativní hodnoty meta atributu specifikované v dotazu
		if (metaValuesMatchString (cely_strom_dotazu, aktualni_vrchol_dotazu, relation, real_relation, dtl, value, poradi_gh, resolve_references, query_TVSList, actual_logical_expression)) {
				if (real_relation == RELATION_NEQ) return FALSE; // převracím výsledek, protože jsem na začátku převrátil nerovnítko na rovnítko
			return TRUE;
		}
		dtl = dtl -> next;
	}
	if (real_relation == RELATION_NEQ) return TRUE; // převracím výsledek, protože jsem na začátku převrátil nerovnítko na rovnítko
	return FALSE;
} // metaAttribMatchString

int sady_match(TVS *cely_strom_dotazu, TVS *aktualni_vrchol_dotazu, TValue * d, TValue * s, int * zobrazeni, int delka, TNode *node, int resolve_references, TVSList *query_TVSList, char *actual_logical_expression) { // porovna dve sady atributu (uzlu dotazu a prohl. stromu), zda matchuji
	// resolve_references = TRUE/FALSE urcuje, zda vyhodnocovat referencni odkazy
	TAHLine * thl = d -> AHTable; // zacatek teto sady atributu v dotazu

	for (int i = 0; i < delka; i++) {  // cyklus po atributech sady dotazu

		if (!(thl[i].value[0] || thl[i].long_value))  // neni def. v dotazu
			continue;

		if (zobrazeni[i] == -1) { // atr. neni v s
			#ifdef DEBUG_SADY_MATCH
				fprintf(stderr,"\ndotser.c: sady_match: The attribute is not in the searched tree! Result: 0");
			#endif
			return FALSE;
		}

		if (zobrazeni[i] == META_ATTRIBUTE) { // jedná se o meta atribut
			#ifdef DEBUG_SADY_MATCH
				fprintf(stderr,"\ndotser.c: sady_match: The attribute seems to be a meta attribute.");
			#endif
			if (i == meta_number_of_sons_position_gh) { // jde o meta atribut určující počet (bezprostředních) synů vrcholu
				if (! metaAttribMatch (cely_strom_dotazu, aktualni_vrchol_dotazu, thl + i, node->number_of_sons, resolve_references, query_TVSList, actual_logical_expression)) { // pokud nesmatchováno
					#ifdef DEBUG_SADY_MATCH
						fprintf(stderr,"\ndotser.c: sady_match: (meta attribute _#sons) result: 0");
					#endif
					return FALSE;
				}
			}
			else {
				if (i == meta_number_of_hidden_sons_position_gh) { // jde o meta atribut určující počet (bezprostředních) skrytých synů vrcholu
					if (! metaAttribMatch (cely_strom_dotazu, aktualni_vrchol_dotazu, thl + i, node->number_of_hidden_sons, resolve_references, query_TVSList, actual_logical_expression)) { // pokud nesmatchováno
						#ifdef DEBUG_SADY_MATCH
							fprintf(stderr,"\ndotser.c: sady_match: (meta attribute _#hsons) result: 0");
						#endif
						return FALSE;
					}
				}
				else {
					if (i == meta_depth_from_root_position_gh) { // jde o meta atribut určující vzdálenost vrcholu od kořene stromu
						if (! metaAttribMatch (cely_strom_dotazu, aktualni_vrchol_dotazu, thl + i, node->depth_from_root, resolve_references, query_TVSList, actual_logical_expression)) { // pokud nesmatchováno
							#ifdef DEBUG_SADY_MATCH
								fprintf(stderr,"\ndotser.c: sady_match: (meta attribute _depth) result: 0");
							#endif
							return FALSE;
						}
					}
					else {
						if (i == meta_number_of_descendants_position_gh) { // jde o meta atribut určující počet všech potomků vrcholu
							if (! metaAttribMatch (cely_strom_dotazu, aktualni_vrchol_dotazu, thl + i, node->nodes_in_subtree - 1, resolve_references, query_TVSList, actual_logical_expression)) { // pokud nesmatchováno
								#ifdef DEBUG_SADY_MATCH
									fprintf(stderr,"\ndotser.c: sady_match: (meta attribute _#descendants) result: 0");
								#endif
								return FALSE;
							}
						}
						else {
							if (i == meta_number_of_left_brothers_position_gh) { // jde o meta atribut určující počet levých bratrů vrcholu
								int number_of_left_brothers = getNumberOfBrothers(node, -1); // chci počet levých bratrů uzlu node
								if (! metaAttribMatch (cely_strom_dotazu, aktualni_vrchol_dotazu, thl + i, number_of_left_brothers, resolve_references, query_TVSList, actual_logical_expression)) { // pokud nesmatchováno
									#ifdef DEBUG_SADY_MATCH
										fprintf(stderr,"\ndotser.c: sady_match: (meta attribute _#lbrothers) result: 0");
									#endif
									return FALSE;
								}
							}
							else {
								if (i == meta_number_of_right_brothers_position_gh) { // jde o meta atribut určující počet pravých bratrů vrcholu
									int number_of_right_brothers = getNumberOfBrothers(node, 1); // chci počet pravých bratrů uzlu node
									if (! metaAttribMatch (cely_strom_dotazu, aktualni_vrchol_dotazu, thl + i, number_of_right_brothers, resolve_references, query_TVSList, actual_logical_expression)) { // pokud nesmatchováno
										#ifdef DEBUG_SADY_MATCH
											fprintf(stderr,"\ndotser.c: sady_match: (meta attribute _#rbrothers) result: 0");
										#endif
										return FALSE;
									}
								}
								else {
									if (i == meta_sentence_position_gh) { // jde o meta atribut obsahující větu
											if (attr_V_position == -1) { // pokud pozice tohoto atributu v hlavičce nebyla ještě určena pro tento načtený soubor stromů
												attr_V_position = getPositionOfFunctionalAttribute(actualFileOfTrees, ATTR_VAL); // chci pozici atributu obsahujícího slova v hlavičce
												#ifdef DEBUG_SADY_MATCH
													fprintf(stderr,"\ndotser.c: sady_match: Pozice atributu se slovy věty v hlavičce je %d.",attr_V_position);
												#endif
											}
											if (attr_W_position == -1) { // pokud pozice tohoto atributu v hlavičce nebyla ještě určena pro tento načtený soubor stromů
												attr_W_position = getPositionOfFunctionalAttribute(actualFileOfTrees, ATTR_WNUMTEST); // chci pozici atributu určujícího pořadí slov věty v hlavičce
												if (attr_W_position == -1) { // v hlavičce není určen, vezme se pořadí uzlů ve větě
													if (attr_N_position == -1) { // pokud ještě pozice tohoto atributu nebyla určena
														attr_N_position = getPositionOfFunctionalAttribute(actualFileOfTrees, ATTR_NUMTEST); // chci pozici atributu určujícího pořadí uzlů stromu v hlavičce
													}
													attr_W_position = attr_N_position;
												}
												#ifdef DEBUG_SADY_MATCH
													fprintf(stderr,"\ndotser.c: sady_match: Pozice atributu s pořadím slov věty v hlavičce je %d.",attr_W_position);
												#endif
											}
											char *sentence = getSentence(actual_tree, attr_V_position, attr_W_position); // chci tu větu; pokud ještě nebyla sestavena, sestaví se
											if (! metaAttribMatchString (cely_strom_dotazu, aktualni_vrchol_dotazu, thl + i, sentence, meta_sentence_position_gh, resolve_references, query_TVSList, actual_logical_expression)) { // pokud nesmatchováno
												#ifdef DEBUG_SADY_MATCH
													fprintf(stderr,"\ndotser.c: sady_match: (meta attribute _sentence) result: 0");
												#endif
												return FALSE;
											}
									}
								}
							}
						}
					}
				}
			}
			// ostatní meta atributy se nesnažím smatchovat
			continue;
		} // if metaatribut

		else { // nešlo o metaatribut
      if (i != hidden_position_gh) { // pokud nejde o atribut určující skrytost vrcholu (ten se řeší v createMatchingLists)
        if (! attrib_match (cely_strom_dotazu, aktualni_vrchol_dotazu, thl + i, (s -> AHTable) + zobrazeni[i], i, resolve_references, query_TVSList, actual_logical_expression)) {
          #ifdef DEBUG_SADY_MATCH
            fprintf(stderr,"\ndotser.c: sady_match: result: 0");
          #endif
          return FALSE;
        }
      }
		}
	} // for přes atributy sady dotazu
	#ifdef DEBUG_SADY_MATCH
		fprintf(stderr,"\ndotser.c: sady_match: result: 1");
	#endif
	return TRUE;	// vsechny atrib. prosly
} // sady_match

int sada_vrchol_match(TVS *cely_strom_dotazu, TVS *aktualni_vrchol_dotazu, TValue *values, TNode *s, int *zobrazeni, int pocet_atributu, int resolve_references, TVSList *query_TVSList, char *actual_logical_expression) { // porovna sadu a vrchol, zda matchuji
	// resolve_references = TRUE/FALSE urcuje, zda vyhodnocovat referencni odkazy
	TValue * pom2;
	pom2 = s -> Values;
	while (pom2) {	// cyklus po sadach s
	// test sad
	if (sady_match (cely_strom_dotazu, aktualni_vrchol_dotazu, values, pom2, zobrazeni, pocet_atributu, s, resolve_references, query_TVSList, actual_logical_expression)) {
		#ifdef DEBUG_SADA_VRCHOL_MATCH
			fprintf(stderr,"\ndotser.c: sada_vrchol_match: result: 1");
		#endif
		return TRUE; // sady odpovidaji
	}
		pom2 = pom2 -> Next;
	}
	#ifdef DEBUG_SADA_VRCHOL_MATCH
		fprintf(stderr,"\ndotser.c: sada_vrchol_match: result: 0");
	#endif
	return FALSE;	// nepodarilo se
} // sada_vrchol_match

int clearSpecialAttributesPositions() { // nastaví výchozí "nedefinované" pozice speciálních atributů hlavičky (N, V, W)
	attr_N_position = -1; // pro nový soubor není pozice numerického atributu ještě určena
	attr_V_position = -1; // ani atributu se slovy věty
	attr_W_position = -1; // ani atributu určujícího pořadí slov věty
}
