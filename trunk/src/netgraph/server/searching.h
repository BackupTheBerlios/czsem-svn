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

#ifndef _SEARCHING_H
#define _SEARCHING_H

#include "trees.h"

struct TSezVrch; // for cross-reference

struct TVSList; // for cross-reference

// seznam vrcholu stromu
struct TVS {
	TNode * vrchol;
	int hloubka;
	TVS * rodic;
	TVS * nalepeny;
	int secondary_stick_to_optional_node; // signalizuje, zda tento uzel je jedním z řetězu uzlů nalepených na optional uzel, ale ne posledním z nich; obsahuje FALSE, když není nalepen na optional_node nebo je nalepený na poslední v řetězu těch uzlů; obsahuje TRUE, pokud je nalepený na optional node a není poslední (tj. nejníž ve stromě)
	int skipped_optional_node; // signalizuje, zda tento uzel dotazu (v případě, že je označen jako optional) byl přeskočen
	TSezVrch * match; // odkaz na seznam vrcholů stromu, které matchují s tímto vrcholem dotazu
	int contains_reference; // informace o tom, zda tento vrchol dotazu obsahuje alespoň jednu referenci (TRUE = ano, FALSE = ne či dosud nezjištěno (ale ve chvíli, kdy se na to budu ptát, už to bude vždy zjištěno))
	TVSList *tvs_list; // ukazuje na TVSList, do ktereho patri (pokud do nejakeho patri - jako u dotazu)
	TVS * dalsi;
};

struct TVSList { // a list of lists of nodes of trees ( = of a potentially multiple-tree query)
	TVS *tvs; // TVS of one tree
	int nodes_match; // TRUE/FALSE - indicates whether all necessary nodes of this query tree match with the nodes in the result tree
	int order; // order of the tvs (tree) in the list of tvss (trees), counted from 1; it identifies the query tree in a query consisting of multiple trees
	TVSList *next; // next member of this list
};

// seznam vrcholu co matchujou
struct TSezVrch {
	TVS * vrchol;
	TSezVrch * next;
	int matching_set; // určuje pořadí sady atributů ve vrcholu dotazu, která matchovala s tímto vrcholem stromu (číslováno od 1)
};

void freeTSezVrchs(TVSList *query_TVSList); // it deletes all TSezVrchs in all TVSs in this TVSList; makes TVSList ready for creating a new lists of matching nodes

TVS * newTVS(); // it safely allocates a memory for a new TVS

void deleteTVS(TVS * seznam); // it frees the memory allocated for TVS and for all TSezVrch lists inside

void printTVS(TVS *tvs); // it prints the TVS structure to stderr

TVSList * newTVSList(); // it safely allocates a memory for a new TVSList

void deleteTVSList(TVSList * list); // it frees the memory allocated for TVSList and for all TVSs inside

void printTVSList(TVSList *tvslist); // it prints the TVSList structure to stderr

TVS * treeToTVS(TNode *root, TVSList *tvslist_start); // it goes through the tree deep-first and creates a TVS list of nodes

TVSList * treesToTVSList(TTree *tree); // it goes through the trees deep-first and creates a list of TVSs

int isInTSezVrch(TVS *node, TSezVrch *list); // checks if there is the node in the list; returns TRUE/FALSE

#endif
