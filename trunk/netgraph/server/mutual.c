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

// mutual.c - soubor společný pro dotser.c a netser.c (23.5.2002)

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "mutual.h"

////////////////////////// DEBUG ////////////////////////

//#define DEBUG_READ_CONFIG_FILE // ladici vypisy funkce pro cteni konfig. souboru
//#define DEBUG_CHECK_CONFIG_FILE // ladici vypisy funkce pro cteni konfig. souboru

void getRidOfTrailingWhites(char *dst) { // zbaví se bílých znaků na konci řetězce
	int length = strlen(dst);
	char c;
	while (length>0) {
		c = dst[length-1]; // poslední znak v řetězci
		if (c != ' ' && c != '\t' && c != '\n' && c != '\r') { // není to bílý znak
			return;
		}
		dst[length-1] = '\0'; // bílý znak odříznu novým koncem řetězce
		length--; // řetězec jsem tím zkrátil
	}
	// řetězec má délku nula, pokud jsem došel až sem
	return;
}

// cteni z konfiguracniho souboru:
int readConfigFile(char *dst, char *param_name, int int_wanted, int error_value, int nondef_value, int ok_value) {
// pokud int_wanted==TRUE, pak funkce vrací načtenou hodnotu jako integer
// error_value je vrácena při chybě čtení
// nondef_value je vrácena, pokud parametr není v konfiguračním souboru
// ok_value se vrací v případě, že int_wanted==FALSE a vše proběhne v pořádku, tedy
//  hodnota parametru je vrácena v řetězci dst

	#ifdef DEBUG_READ_CONFIG_FILE
		fprintf(stderr,"\nparam_name = %s", param_name);
	#endif

	FILE * u_konfig;
	int set = nondef_value; // zatím parametr daného jména nenalezen
	int conversion_succeeded;
	int reading_succeeded;

	if ((u_konfig = fopen (CONFIG_FILE, "r")) == NULL) { // konfigurační soubor nelze otevřít
		set = error_value;
	}
	else {
		while (! feof (u_konfig)) {
			fscanf (u_konfig, "%s", dst);

			if (! strcmp (dst, param_name)) { // parametr nalezen
				#ifdef DEBUG_READ_CONFIG_FILE
					fprintf(stderr,"\nparametr nalezen");
				#endif
				fscanf(u_konfig, "%[ \t]",dst); // precti bile znaky (a vzapeti je na dalsim radku zapomen)
				conversion_succeeded = fscanf (u_konfig, "%[^#\n]", dst); // precte se obsah parametru az do komentare nebo konce radku
				if (conversion_succeeded == 1) {
					getRidOfTrailingWhites(dst); // zbaví se bílých znaků na konci parametru
					set = ok_value;
					#ifdef DEBUG_READ_CONFIG_FILE
						fprintf(stderr,"\nhodnota parametru = '%s'", dst);
					#endif
					if (int_wanted == TRUE) { // parametr se prevede na číslo
  			 			conversion_succeeded = sscanf (dst, "%d", &set); // prevod
						if (conversion_succeeded == 0) { // chyba konverze
							set = error_value;
						}
					}
					break;
				}
				else {
					set = error_value;
				}
			}
			// parametr na teto radce nebyl nalezen jako prvni retezec; preskocim vse do konce radku
			fscanf(u_konfig, "%[^\n]", dst);
		} // while
		fclose (u_konfig);
	}
	return set;

} // readConfigFile

// cteni z konfiguracniho souboru:
int checkInConfigFile(char *buff, char *param_name, char *param_value) {
	// vrátí TRUE, pokud daný parametr má v konf. souboru danou hodnotu; jinak FALSE
	// vrátí -1 při chybě
	#ifdef DEBUG_CHECK_CONFIG_FILE
		fprintf(stderr,"\nlooking for: param_name = %s, param_value = %s", param_name, param_value);
	#endif

	FILE * u_konfig;
	int set = FALSE; // zatím hledaná dvojice nenalezena
	int conversion_succeeded;

	if ((u_konfig = fopen (CONFIG_FILE, "r")) == NULL) { // konfigurační soubor nelze otevřít
		set = -1; // chyba
	}
	else {
		while (! feof (u_konfig)) {
			fscanf (u_konfig, "%s", buff);

			if (! strcmp (buff, param_name)) { // parametr nalezen
				#ifdef DEBUG_CHECK_CONFIG_FILE
					fprintf(stderr,"\nparametr nalezen");
				#endif
				//conversion_succeeded = fscanf (u_konfig, "%s", buff); // precte se obsah parametru
				//if (conversion_succeeded == 1) {
				fscanf(u_konfig, "%[ \t]",buff); // precti bile znaky (a vzapeti na dalsim radku zapomen)
				conversion_succeeded = fscanf (u_konfig, "%[^#\n]", buff); // precte se obsah parametru az do komentare nebo konce radku
				if (conversion_succeeded == 1) {
					getRidOfTrailingWhites(buff); // zbaví se bílých znaků na konci parametru
					#ifdef DEBUG_CHECK_CONFIG_FILE
						fprintf(stderr,"\nhodnota parametru = %s", buff);
					#endif
					if (! strcmp (buff, param_value)) { // hodnota souhlasí
						#ifdef DEBUG_CHECK_CONFIG_FILE
							fprintf(stderr," - hodnota souhlasí");
						#endif
						set = TRUE;
						break; // úspěch
					}
				}
				else {
					set = -1; // chyba, ale budu pokračovat dalším řádkem
				}
			}
			// parametr na teto radce nebyl nalezen jako prvni retezec; preskocim vse do konce radku
			fscanf(u_konfig, "%[^\n]", buff);
		} // while
		fclose (u_konfig);
	}
	#ifdef DEBUG_CHECK_CONFIG_FILE
		fprintf(stderr,"\nreturn value = %d", set);
	#endif

	return set;

} // checkInConfigFile
