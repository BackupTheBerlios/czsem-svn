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

#ifndef _MESSAGES_H
#define _MESSAGES_H

#define EOL 13  // konec radku ve zprave
#define MAX_ERROR_MESSAGE_LENGTH 80  // maximální délka jednotlivých částí chybových hlášek pro klienta
#define REGEXP_START '\"'  // začátek regulárního výrazu v hodnotě atributu; musí být prvním znakem za znamínkem relace
#define REGEXP_END '\"'  // konec regulárního výrazu v hodnotě atributu; musí být posledním znakem v hodnotě atributu

extern char error_type; // typ chybové hlášky klientovi
extern char error_message_1[MAX_ERROR_MESSAGE_LENGTH + 1]; // pro chybovou hlášku klientovi
extern char error_message_2[MAX_ERROR_MESSAGE_LENGTH + 1]; // pro chybovou hlášku klientovi
extern char error_message_3[MAX_ERROR_MESSAGE_LENGTH + 1]; // pro chybovou hlášku klientovi

// dve pomocne funkce pro plneni chybovych zprav pro klienta:
void fillErrorMessageInt(char *dst, int value);

void fillErrorMessageString(char *dst, const char *message);


int fillErrorMessagesToOdp(char *odp, int error_type);

#endif
