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
#include <string.h>

#include "messages.h"
#include "mutual.h"

char error_type; // typ chybové hlášky klientovi
char error_message_1[MAX_ERROR_MESSAGE_LENGTH + 1]; // pro chybovou hlášku klientovi
char error_message_2[MAX_ERROR_MESSAGE_LENGTH + 1]; // pro chybovou hlášku klientovi
char error_message_3[MAX_ERROR_MESSAGE_LENGTH + 1]; // pro chybovou hlášku klientovi

// dve pomocne funkce pro plneni chybovych zprav pro klienta:
void fillErrorMessageInt(char *dst, int value) {
  snprintf(dst, MAX_ERROR_MESSAGE_LENGTH, "%d", value);
  dst[MAX_ERROR_MESSAGE_LENGTH] = '\0';
}

void fillErrorMessageString(char *dst, const char *message) {
  int length;
  length = strlen(message);
  if (length > MAX_ERROR_MESSAGE_LENGTH) {
    length = MAX_ERROR_MESSAGE_LENGTH;
  }
  strncpy(dst, message, length);
  dst[length] = '\0';
}

int fillErrorMessagesToOdp(char *odp, int error_type) {
  int length = 0;
  switch (error_type) {
    case ERROR_REGEXP_COMPILATION:
      strcpy(odp + length, error_message_1); // regularni vyraz, ve kterem doslo k chybe kompilace
      length += strlen(error_message_1);
      *(odp + length++) = EOL; // konec řetězce nahradím EOL
      strcpy(odp + length, error_message_2);
      length += strlen(error_message_2); // offset chyby v regularnim vyrazu
      *(odp + length++) = EOL; // konec řetězce nahradím EOL
      strcpy(odp + length, error_message_3);
      length += strlen(error_message_3); // popis chyby
      *(odp + length++) = EOL; // konec řetězce nahradím EOL
    break;
    default:
      strcpy(odp + length, "an unknown error");
      length += strlen("an unknown error");
      *(odp + length++) = EOL; // konec řetězce nahradím EOL
    break;
  }
  return length;
}
