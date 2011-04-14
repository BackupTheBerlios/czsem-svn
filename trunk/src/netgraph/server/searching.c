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

#include "searching.h"

void deleteTSezVrch(TSezVrch * seznam) { // uvolneni seznamu TSezVrch
	TSezVrch * next;

	while (seznam != NULL) {
		next = seznam->next;
		delete(seznam);
		seznam = next;
	}
} // deleteTSezVrch

void free_all_tsezvrch( TVS * seznam ) // uvolni TsezVrch seznamy od vsech prvku jednoho TVS seznamu seznam
{
	while( seznam )
	{
		deleteTSezVrch( seznam -> match );
		seznam -> match = NULL;
		seznam = seznam -> dalsi;
	}

}

void freeTSezVrchs(TVSList *query_TVSList) { // it deletes all TSezVrchs in all TVSs in this TVSList; makes TVSList ready for creating a new lists of matching nodes
	while (query_TVSList) {
		free_all_tsezvrch(query_TVSList->tvs);
		query_TVSList = query_TVSList->next;
	}
} // freeTSezVrchs

TVS * newTVS() { // it safely allocates a memory for a new TVS
	TVS *tvs;
	tvs = new TVS;
	if (tvs == NULL) {
		fprintf(stderr,"\nsearching.c: newTVS: FATAL ERROR: insufficient memory!\n");
	}
	tvs->vrchol = NULL;
	tvs->hloubka = -1;
	tvs->rodic = NULL;
	tvs->nalepeny = NULL;
	tvs->skipped_optional_node = FALSE;
	tvs->secondary_stick_to_optional_node = FALSE;
	tvs->match = NULL;
	tvs->contains_reference = FALSE;
	tvs->tvs_list = NULL;
	tvs->dalsi = NULL;
	return tvs;
} // newTVS

void deleteTVS(TVS * seznam) { // it frees the memory allocated for TVS and for all TSezVrch lists inside
	TVS *next;

	while (seznam != NULL) {
		deleteTSezVrch(seznam->match);
		next = seznam->dalsi;
		delete seznam;
		seznam = next;
	}
} // deleteTVS

void printTVS(TVS *tvs) {
  fprintf(stderr,"\n  Start of TVS:");
  while (tvs) {
    fprintf(stderr,"\n      node:");
    printTNode(tvs->vrchol);
    fprintf(stderr,"\n    other properties:");
    fprintf(stderr,"\n      hloubka = %d", tvs->hloubka);
    fprintf(stderr,"\n      contains_reference = %d", tvs->contains_reference);
    tvs = tvs->dalsi;
  }
  fprintf(stderr,"\n  End of TVS");
}

TVSList * newTVSList() { // it safely allocates a memory for a new TVSList
	TVSList *list;
	list = new TVSList;
	if (list == NULL) {
		fprintf(stderr,"\nsearching.c: newTVSList: FATAL ERROR: insufficient memory!\n");
	}
	list->tvs = NULL;
	list->nodes_match = TRUE; // FALSE means that it is not necessary to try this tree in finding subtree - therefore it is safer to have TRUE as default
	list->order = 0;
	list->next = NULL;
	return list;
} // newTVSList

void deleteTVSList(TVSList * list) { // it frees the memory allocated for TVSList and for all TVSs inside
	TVSList *next;

	while (list != NULL) {
		deleteTVS(list->tvs);
		next = list->next;
		delete(list);
		list = next;
	}
} // deleteTVSList

void printTVSList(TVSList *tvslist) {
  fprintf(stderr,"\nStart of TVSList:");
  while (tvslist) {
    printTVS(tvslist->tvs);
    tvslist = tvslist->next;
  }
  fprintf(stderr,"\nEnd of TVSList");
}

TVS * zacatek,
    * konec; // pomocne promenne pro vytvareni TVS seznamu

void projdi (TNode *u, int h, TVS *rodic, TVSList *tvslist_start) { // vlastni prochazeni stromu do hloubky a vytvareni TVS seznamu vrcholu
	TNode *pom; TVS *pom2;
	if (u == NULL) return; // ukončovací podmínka rekurze
	// vytvoreni prostoru pro zarazeni vrcholu
	if (zacatek == NULL) zacatek = konec = newTVS();
	else {
		konec -> dalsi = newTVS();
		konec = konec -> dalsi;
	}
	// prostor pro zarazeni pripraven, vrchol se zaradi
	konec -> vrchol = u;
	konec -> hloubka = h;
	konec -> rodic = rodic;
	konec -> nalepeny = NULL;
	konec -> skipped_optional_node = FALSE;
	konec -> secondary_stick_to_optional_node = FALSE;
	konec -> match = NULL;
	konec -> contains_reference = FALSE;
	konec -> tvs_list = tvslist_start;
	konec -> dalsi = NULL;
	// ted se projdou synove
	pom = u -> FirstSon; pom2 = konec;
	while (pom != NULL) { // pres vsechny syny
		projdi (pom, h+1, pom2, tvslist_start);
		pom = pom -> Brother;
	}
}

TVS * treeToTVS(TNode *root, TVSList *tvslist_start) { // it goes through the tree deep-first and creates a TVS list of nodes
	zacatek = konec = NULL;
	projdi (root, 1, NULL, tvslist_start);
	return zacatek;
}

TVSList * treesToTVSList(TTree *tree) { // it goes through the trees deep-first and creates a list of TVSs
	TVSList *list;
	TVSList *start;
	int count = 0;
	if (tree == NULL) {
		return NULL;
	}
	list = start = newTVSList();
	count++;
	list->order = count;
	list->tvs = treeToTVS(tree->Root, start);
	list->tvs->tvs_list = start;
	tree = tree->Next;
	while (tree != NULL) {
		list = list->next = newTVSList();
		count++;
		list->order = count;
		list->tvs = treeToTVS(tree->Root, list);
		tree = tree->Next;
	}
	list->next = NULL; // unnecessary, it has been done in newTVSList; only to be sure
	return start;
} // treesToTVSList

int isInTSezVrch(TVS *node, TSezVrch *list) { // checks if there is the node in the list; returns TRUE/FALSE
	while (list != NULL) {
		if (node == list -> vrchol) {
			return TRUE;
		}
		list = list -> next;
	}
	return FALSE;
}
