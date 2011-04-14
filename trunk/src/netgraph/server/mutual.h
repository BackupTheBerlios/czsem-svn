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

// mutual.h - soubor společný pro dotser.c a netser.c

#ifndef _MUTUAL_H
#define _MUTUAL_H

#define _LINUX_VERSION
//#define _WINDOWS_VERSION

#ifdef _LINUX_VERSION
	#define THIS_SERVER_VERSION "1.91 L (12.11.2007)" // verze serveru
#endif
#ifdef _WINDOWS_VERSION
	#define THIS_SERVER_VERSION "1.91 W (12.11.2007)" // verze serveru
#endif

#define MAXLENMES 250000 // max delka zpravy mezi klientem a serverem
#define EOM 0 // ukoncovaci znak zprav mezi klientem a serverem
#define CONFIG_FILE "config.txt"   // jmeno konfiguracniho souboru

#define TRUE 1
#define FALSE 0


//////// Jména parametrů v konfiguračním souboru ////////

#define PARAM_NAME_INITIAL_PATH "dir"
#define PARAM_NAME_MAX_CLIENTS "max_clients"
#define PARAM_NAME_NEVER_ACCEPT "never_accept"
#define PARAM_NAME_ALWAYS_ACCEPT "always_accept"
#define PARAM_NAME_DO_NOT_RECORD "do_not_record"
#define PARAM_NAME_CORPUS_IDENTIFIER "corpus_identifier"
#define PARAM_NAME_PRESET_HEAD "preset_head"
#define PARAM_PRESET_HEAD_VALUE_FIRST "FIRST"


//////// Druhy zprav ////////

// velkymi pismeny hlavni rozlisovac zpravy, malymi pismeny podrozdelovace zprav

#define PWD 'A'
#define GETDIRS 'B'
#define GETFILES 'C'
#define CD 'D'
#define END_OF_SEARCHING 'E' // konec prohledávání
#define END_OF_SEARCHING_NO_NEXT_TREE 'n' // konec prohledávání kvůli dosažení konce prohledávaných souborů
#define END_OF_SEARCHING_MAX_NUMBER_REACHED 'b' // prohledávání ukončeno kvůli dosažení maximálního povoleného počtu stromů
#define END_OF_SEARCHING_USER_INTERRUPTION 'u' // prohledávání předčasně ukončil uživatel
#define END_OF_SEARCHING_NOT_YET 'y' // prohledávání nebylo dosud ukončeno
#define SETFILES 'F'
#define FILE_BOUNDARY_REACHED 'G' // při žádosti o kontext vpřed či vzad bylo dosaženo hranice souboru
#define PART_ONLY 'o'
#define PART_FIRST 'f'
#define PART_MIDDLE 'm'
#define PART_LAST 'l'
#define GET_INIT_INFO 'I'
#define REMOVE_OCCURRENCE 'K'  // žádost klienta serveru o odstranění aktuálního výskytu dotazu ze seznamu výsledných stromů
#define LOGIN 'L'  // autentikační procesy - autentikace, změna hesla
#define LOGIN_AUTHENTIZE 'a'  // autentikace - ověření login name a hesla
#define LOGIN_CHANGE_PASSWORD 'c'  // změna hesla
#define MAXIMUM_CLIENTS 'M' // tohle používá jen netser
#define GETN 'N'
#define NEXT_OR_PREV_OCCURRENCE 'o'  // upřesnění GETN a GETP (další/předchozí výskyt dotazu)
#define NEXT_OR_PREV_TREE 't'  // upřesnění GETN a GETP (první výskyt dotazu v dalším/předchozím stromě)
#define NEXT_OR_PREV_CONTEXT 'c' // upřesnění GETN a GETP (následující/předchozí kontext (tj. bezprostředně následující/předchozí strom v souborech))
#define OK 'O'
#define OK_PREV 'P' // při odstranění posledního stromu z výsledku pošlu předchozí strom, a ne následující; takto na to klienta upozorním
#define GETP 'P' // klient serveru: žádost o předchozí strom
#define PREV_FIRST_OCCURRENCE 'f'  // upřesnění GETP (první výskyt dotazu)
#define QUERY 'Q'
#define ABOVE_RESULT 'r' // dotaz dle kritéria výběru nad výsledkem minulého dotazu
#define ABOVE_FILES 'f' // dotaz dle kritéria výběru nad vybranými soubory
#define ALL_TREES 'a' // dotaz na všechny stromy (z vybraných souborů)
#define REPEAT 'R' // výzva klientovi k pozdějšímu opakování žádosti (např. minulý dotaz ještě neskončil)
#define STOP 'S' // zastaví právě prováděné prohledávání, pokud nějaké běží
#define TEST 'T'
#define UNKNOWN 'U' // server přijal zprávu s neznámým rozlišovačem
#define GETVERSION 'V'
#define SERVER_VERSION 's'
#define CLIENT_REQUIRED_VERSION 'c'
#define CLIENT_RECOMMENDED_VERSION 'r'
#define ERROR 'X'
#define ERROR_UNKNOWN 'u'
#define ERROR_REGEXP_COMPILATION 'r'
#define GET_STATISTICS 'Y' // dotaz na statistiky o prohledávání
#define CLIENT_EXITED 'Z' // klient ukončuje spojení

// zbaví se bílých znaků na konci řetězce
void getRidOfTrailingWhites(char *dst);

// cteni z konfiguracniho souboru:
int readConfigFile(char *dst, char *param_name, int int_wanted=FALSE, int error_value=-1, int nondef_value=-2, int ok_value=0);
// pokud int_wanted==TRUE, pak funkce vrací načtenou hodnotu jako integer
// error_value je vrácena při chybě čtení
// nondef_value je vrácena, pokud parametr není v konfiguračním souboru
// ok_value se vrací v případě, že int_wanted==FALSE a vše proběhne v pořádku, tedy
//  hodnota parametru je vrácena v řetězci dst

// cteni z konfiguracniho souboru:
int checkInConfigFile(char *buff, char *param_name, char *param_value);
	// vrátí TRUE, pokud daný parametr má v konf. souboru danou hodnotu; jinak FALSE
	// vrátí -1 při chybě

#endif
