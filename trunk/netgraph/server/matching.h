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

#ifndef _MATCHING_H
#define _MATCHING_H

//#include <pcre.h> // regulární výrazy schopné zvládnout UTF-8; zde pro definování struktury uchovávající zpracovaný regulární výraz

#include "trees.h"
#include "searching.h"

#define ESCAPE_CHAR '\\'   // znak pro potlaceni spec. vyzn. v dotazu
#define WILD_CARD_ONE_CHAR '?' // divoká karta pro právě jeden znak v hodnotách atributů v dotazech
#define WILD_CARD_STRING '*' // divoká karta pro posloupnost nula až mnoho znaků v hodnotách atributů v dotazech

#define NODE_REFERENCE_START '{' // začátek referenčního odkazu
#define NODE_REFERENCE_DIVIDER '.' // oddělovač jména vrcholu a jména atributu v referenčních odkazech
#define CHARACTER_ORDER_DIVIDER '.' // oddělovač jména atributu a pořadí požadovaného znaku (může být stejný jako NODE_REFERENCE_DIVIDER)
#define NODE_REFERENCE_END '}' // konec referenčního odkazu - musí být různý od NODE_REFERENCE_DIVIDER a CHARACTER_ORDER_DIVIDER

#define META_ATTRIBUTE -2  // obraz meta atributu z dotazu v hlavičce prohledávaného stromu

extern TFSFile * GlobHlav; // Globalni Hlavicka
extern TFSFile *actualFileOfTrees; // seznam stromů načtených z jednoho souboru

extern TTree *actual_tree; // aktuálně prohledávaný strom

extern int match_lemma_variants; // TRUE/FALSE - mají se matchovat lemmata bez ohledu na varianty?
extern int match_lemma_comments; // TRUE/FALSE - mají se ignorovat poznámky a vysvětlivky při matchování lemmat?
extern int lemma_position_gh; // pozice lemmatu v globální hlavičce (-1, pokud v hlavičce není, ale u PDT je vždycky)
extern int hidden_position_gh; // pozice atributu pro skryté vrcholy v globální hlavičce (-1, pokud v hlavičce není)
extern int hidden_position; // pozice atributu pro skryté vrcholy v prohledávaných stromech (-1, pokud v hlavičce není)

// pro následující pozice meta atributů v glob. hlavičce je -1 defaultní hodnota (tj. pokud atribut není v hlavičce přítomen)
extern int meta_transitive_parent_edge_position_gh; // pozice meta atributu pro transitivní hranu v glob. hlavičce
extern int meta_optional_node_position_gh; // pozice meta atributu pro nepovinný vrchol v glob. hlavičce
extern int meta_number_of_sons_position_gh; // pozice meta atributu pro počet synů v glob. hlavičce
extern int meta_number_of_hidden_sons_position_gh; // pozice meta atributu pro počet skrytých synů v glob. hlavičce
extern int meta_depth_from_root_position_gh; // pozice meta atributu pro počet synů v glob. hlavičce
extern int meta_number_of_descendants_position_gh; // pozice meta atributu pro počet všech potomků v glob. hlavičce
extern int meta_number_of_occurrences_position_gh; // pozice meta atributu pro počet takovych synu predka daneho vrcholu
extern int meta_node_name_position_gh; // pozice meta atributu pro pojmenování vrcholu v glob. hlavičce
extern int meta_number_of_left_brothers_position_gh; // pozice meta atributu pro počet levých bratrů v glob. hlavičce
extern int meta_number_of_right_brothers_position_gh; // pozice meta atributu pro počet pravých bratrů v glob. hlavičce
extern int meta_sentence_position_gh; // pozice meta atributu obsahujícího větu v glob. hlavičce
extern int meta_dependence_position_gh; // pozice meta atributu pro změnu rodičovské hrany na koreferenci v glob. hlavičce

int isMetaAttribute(char *attribute_name); // rozpozná meta atribut podle počátečního podtržítka

void matchHeads( TFSFile * vzor, TFSFile * obraz, int * vysl );
// urci zobrazeni hlavicky vzor (Glob. hlavicka) do hlavicky obraz (hlavicka souboru)
// vysledek zapise do vysl

int scanGlobalHead(TFSFile *tree_file); // prohlédne hlavičku souboru stromů - zapamatuje si pozice význačných atributů a meta atributů; používá se pro globální hlavičku
	// dříve se to provádělo v matchHeads (odtud názvy některých proměnných), ale to se zbytečně dělalo opakovaně při načtení každého nového souboru se stromy; stačí to jednou po vložení dotazu

int scanHead(TFSFile *tree_file); // prohlédne hlavičku souboru stromů - zapamatuje si pozice význačných atributů; používá se pro prohledávané soubory
// v současné době jediný význačný atribut je atribut pro skryté vrcholy

int getHiddenValue(TNode *node, int local_hidden_position); // vrátí 0, pokud je uzel neskrytý,
// 1, pokud je skrytý, 2, pokud oboje (to je možné u dotazu)
// pokud local_hidden_position == -1, vrátí 0

int preprocessRegexpsAtNode(TNode *node, int number_of_attributes);

char * findNodeName(TNode *node); // vrátí jméno vrcholu, pokud je specifikováno metaatributem META_NODE_NAME v první sadě atributů
// jinak vrací NULL
// předpokládám, že již je nastavena proměnná meta_node_name_position_gh (to určitě je)

int preprocessTree(TTree *tree, int check_name, int check_regexps, int local_hidden_position, int number_of_attributes); // projde strom a u vrcholů nastaví pomocné hodnoty
// (tj. depth_from_root, max_depth_to_leaf, nodes_in_subtree, depth_first_order)
// pomocnou hodnotu name nastavuje pouze, pokud je check_name TRUE
// pokud je check_regexps TRUE, zjistuje pritomnost regularnich vyrazu a pripadne je kompiluje
// v local_hidden_position se predava pozice atributu pro skryté vrcholy; -1 znamená nepřítomnost atributu
// vrací 0, pokud vše v pořádku, jinak typ chyby (ERROR_*)

int preprocessTrees(TFSFile *trees, int check_name, int check_regexps, int local_hidden_position); // předzpracuje všechny stromy ze souboru stromů
// pomocnou hodnotu name nastavuje u vrcholu pouze, pokud je check_name TRUE
// pokud je check_regexps TRUE, zjistuje pritomnost regularnich vyrazu a pripadne je kompiluje
// v local_hidden_position se predava pozice atributu pro skryté vrcholy; -1 znamená nepřítomnost atributu
// vrací 0, pokud vše v pořádku, jinak typ chyby (ERROR_*)

int metaAttribMatch(TVS *cely_strom_dotazu, TVS *aktualni_vrchol_dotazu, TAHLine * dtl, const int value, const int resolve_references, TVSList *query_TVSList, char *actual_logical_expression); // vrátí TRUE/FALSE podle toho, zda metaatribut matchuje s danou hodnotou

int sada_vrchol_match(TVS *cely_strom_dotazu, TVS *aktualni_vrchol_dotazu, TValue *values, TNode *s, int *zobrazeni, int pocet_atributu, int resolve_references, TVSList *query_TVSList, char *actual_logical_expression); // porovna sadu a vrchol, zda matchuji
	// resolve_references = TRUE/FALSE urcuje, zda vyhodnocovat referencni odkazy

TSezVrch *getStickedNode(TVS *d_node); // vrátí ukazatel na vrchol nalepený na d_node - položku seznamu matchujících vrcholů daného vrcholu dotazu; NULL, pokud žádný nalepený nenajde

// vlastní porovnání dvou hodnot atributů - hodnoty v dotazu a hodnoty v prohledávaném stromu
int valuesMatch(TVS *cely_strom_dotazu, TVS *aktualni_vrchol_dotazu, int relation, int real_relation, TAHLine *dtl, char *s, int poradi_gh, int resolve_references, TVSList *query_TVSList, char *actual_logical_expression);
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

int clearSpecialAttributesPositions(); // nastaví výchozí "nedefinované" pozice speciálních atributů hlavičky (N, V, W)

#endif
