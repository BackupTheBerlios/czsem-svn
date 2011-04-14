// seznam vrcholu stromu

struct TVSList; // for cross-reference

struct TVS {
	TNode * vrchol;
	int hloubka;
	TVS * rodic;
	TVS * nalepeny;
	int skipped_optional_node; // signalizuje, zda tento uzel (v případě, že je označen jako optional) byl přeskočen
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

//struct TTree;           // pro křížovou referenci

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
  int number_of_hidden_sons;     // počet bezprostředních skrytých synů vrcholu; počítáno v dotser.c: preprocessTree
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

struct TTree              // strom
{
  TNode *Root;            // ukazatel na kořen
  int AHNum;              // počet atributů, definovaných v původním souboru - nenulové pouze pro strom ve schránce
  TDefsLine *DefsTable;   // ukazatel na vlastní kopii tabulky atributů souboru - nenulové pouze pro strom ve schránce
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
