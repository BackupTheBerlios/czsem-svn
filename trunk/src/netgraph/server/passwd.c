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

// passwd.c 1.52 (30.5.2002)

// dodelat: writeToPasswdFile

#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#include "passwd.h"

#define PASSWORD_FILE "passwd.txt"  // soubor s přihlašovacími konty
#define PASSWORD_FILE_BACKUP "passwd.txt.bak"  // záložní soubor s přihlašovacími konty
#define PASSWD_FIELDS_DELIMITER ':'  // oddělovač položek v záznamech v souboru kont

#define MAX_ACCOUNT_LENGTH 600  // max length of one record in the file with passwords

// these numbers will represent yes or no in the struct account
#define YES_INT_VALUE 1
#define NO_INT_VALUE 0

#define DEFAULT_LOGIN_NAME "anonymous"
#define DEFAULT_ENCODED_PASSWORD ""
#define DEFAULT_ACCOUNT_STATE "enabled"
#define DEFAULT_ACCOUNT_TYPE "anonymous"
#define DEFAULT_ROOT_DIRECTORY "default"
#define DEFAULT_MAX_NUMBER_OF_TREES 100
#define DEFAULT_CLIENT_SAVE_TREES_PERMISSION NO_INT_VALUE
#define DEFAULT_CHANGE_PASSWORD_PERMISSION NO_INT_VALUE
#define DEFAULT_E_MAIL ""
#define DEFAULT_USER_NAME "anyone"
#define DEFAULT_USER_INFO "anywhere"

// the following definitions match the properties of the account with the client
#define ACCOUNT_TYPE_LABEL "account_type"
#define MAX_NUMBER_OF_TREES_LABEL "max_number_of_trees"
#define ROOT_DIRECTORY_LABEL "root_directory"
#define CLIENT_SAVE_TREES_PERMISSION_LABEL "client_save_trees_permission"
#define CHANGE_PASSWORD_PERMISSION_LABEL "change_password_permission"
#define USER_NAME_LABEL "user_name"
#define ACCOUNT_TYPE_ANONYMOUS_VALUE "anonymous"
#define ACCOUNT_TYPE_USER_VALUE "user"
#define YES_VALUE "yes"
#define NO_VALUE "no"

#define CLIENT_COMMUNICATION_FIELDS_DELIMITER 13 // to je asi '\r', ale v jave '\n' == 13, tak explicitne udavam 13
#define CLIENT_COMMUNICATION_LABEL_DELIMITER ':'

//#define DEBUG_READ_FROM_PASSWD_FILE  // ladění čtení ze souboru kont
//#define DEBUG_READ_PASSWD_FILE  // ladění čtení celého souboru kont
//#define DEBUG_WRITE_TO_PASSWD_FILE  // ladění zápisu do souboru kont
//#define DEBUG_AUTHENTIZE_USER
//#define DEBUG_CHANGE_PASSWORD
//#define DEBUG_READ_STRUCT_FROM_PASSWD_FILE
//#define DEBUG_READ_STRUCT_FROM_STRING
//#define DEBUG_READ_FIELD

// private:
struct password_file { // this structure keeps all the passwd file content
   char account[MAX_ACCOUNT_LENGTH+1]; // one line from the file
   struct password_file *next; // next member of the list
};


// cteni ze souboru kont (private):
int readFromPasswdFile(char *dst, char *login_name) { // přečte řádek ze souboru kont do dst
// vrací ERROR_OK, pokud v pořádku přečteno,
// ERROR_USER_DOES_NOT_EXIST, pokud uživatel daného jména neexistuje,
// ERROR_CANNOT_READ_FILE, pokud se vyskytla chyba při čtení ze souboru

	#ifdef DEBUG_READ_FROM_PASSWD_FILE
		fprintf(stderr,"\nlogin_name = %s", login_name);
	#endif

	FILE * u_passwd;
	int ret_value = ERROR_USER_DOES_NOT_EXIST; // zatím konto s daným jménem nenalezeno

	if ((u_passwd = fopen (PASSWORD_FILE, "r")) == NULL) { // soubor nelze otevřít
		return ERROR_CANNOT_READ_FILE;
	}
	else {

		int login_name_length = strlen(login_name);
    int length;
		while (fgets(dst, MAX_ACCOUNT_LENGTH, u_passwd)) { // čtu celý řádek, využívám cílové dst jako buffer
      length = strlen(dst);
      if (length > 0) { // get rid of newline if present
         if (*(dst+length-1) == '\n') {
            *(dst+length-1) = '\0';
            length--;
         }
      }
			#ifdef DEBUG_READ_FROM_PASSWD_FILE
 				fprintf(stderr,"\nnačten řádek: %s", dst);
  		#endif

			if (! strncmp (dst, login_name, login_name_length)) { // login name možná nalezeno
				if (dst[login_name_length] == PASSWD_FIELDS_DELIMITER) { // login name skutečně nalezeno
          ret_value = ERROR_OK;
  				#ifdef DEBUG_READ_FROM_PASSWD_FILE
	  				fprintf(stderr,"\nuživatelské konto nalezeno: %s", dst);
		  		#endif
          break;
				}
			}
		} // while
		fclose (u_passwd);
	}
   #ifdef DEBUG_READ_FROM_PASSWD_FILE
      fprintf(stderr,"\npasswd.c: readFromPasswdFile: everything seems to be OK.");
   #endif

	return ret_value;


} // readFromPasswdFile

// private:
void freeList(struct password_file *list) { // it frees the whole list
  struct password_file *member = list;
  struct password_file *next;
  while (member != NULL) {
    next = member->next;
    free (member);
    member = next;
  }
}

// čtení celého souboru kont (private):
int readPasswdFile(struct password_file **list) { // it reads the whole file of accounts to the list of structures
// vrací ERROR_OK, pokud v pořádku přečteno,
// ERROR_CANNOT_READ_FILE, pokud se vyskytla chyba při čtení ze souboru
// ERROR_CANNOT_ALLOCATE_MEMORY if an error while allocating memory occurred
// ERROR_ANOTHER_ERROR při jiných chybách
// v (*list) vrací spojový seznam obsahující celý soubor kont, řádek po řádku

	FILE * u_passwd;
  (*list) = NULL;
  struct password_file **list_start = list; // keep the pointer to the pointer to the start point of the list
  struct password_file *list_last; // it keeps a pointer to the last member of the list

	if ((u_passwd = fopen (PASSWORD_FILE, "r")) == NULL) { // soubor nelze otevřít pro čtení
		return ERROR_CANNOT_READ_FILE;
	}
	else {

    char *buf = (char *)malloc(sizeof(char)*(MAX_ACCOUNT_LENGTH+1)); // create a space for one record from file
    if (!buf) return ERROR_CANNOT_ALLOCATE_MEMORY;

    int length;
    while (fgets(buf, MAX_ACCOUNT_LENGTH, u_passwd)) { // čtu do buf celý řádek
      length = strlen(buf);
      if (length > 0) { // get rid of the newline if present
         if (*(buf+length-1) == '\n') {
            *(buf+length-1) = '\0';
            length--;
         }
      }
      #ifdef DEBUG_READ_PASSWD_FILE
         fprintf(stderr,"\npasswd.c: readPasswdFile: načten řádek: %s", buf);
      #endif
      (*list) = (struct password_file *)malloc(sizeof(struct password_file));
      if (!(*list)) {
        free (buf);
        freeList (*list_start);
        return ERROR_CANNOT_ALLOCATE_MEMORY;
      }
      strcpy((*list)->account, buf);
      (*list)->next = NULL;
      list_last = (*list);
      list = & ((*list)->next);
		} // while
    free (buf);
		fclose (u_passwd);
	}
	return ERROR_OK;

} // readPasswdFile

int copyPasswdFile(FILE *dst, FILE *src) { // zkopíruji obsah jednoho souboru do druhého
// téměř totožná funkce je i v dotser.c, jmenuje se tam copyFile!
// vrací ERROR_OK, pokud OK,
// ERROR_CANNOT_WRITE_FILE, pokud problém při zápisu,
// ERROR_ANOTHER_ERROR při jiných chybách
   int error = ERROR_OK;
   if (! dst || ! src) {
      return ERROR_ANOTHER_ERROR;
   }
   rewind (src); // přesunu se na začátky obou souborů
   rewind (dst);
   int c;

   while ((c = fgetc(src)) != EOF) { // přes celý soubor po znacích
      if (fputc(c, dst)<0) {
         error = ERROR_CANNOT_WRITE_FILE;
         break;
      }
   }
   //fputc(EOF,dst);
   return error;
}

// private:
int backupPasswdFile() {
// vrací ERROR_OK, pokud OK,
// ERROR_CANNOT_WRITE_FILE, pokud problém při zápisu,
// ERROR_CANNOT_READ_FILE, pokud se vyskytla chyba při čtení ze souboru,
// ERROR_ANOTHER_ERROR při jiných chybách

   FILE * u_passwd;
   FILE * u_passwd_backup;

   if ((u_passwd = fopen (PASSWORD_FILE, "r")) == NULL) { // soubor nelze otevřít pro čtení
      return ERROR_CANNOT_READ_FILE;
   }
   if ((u_passwd_backup = fopen (PASSWORD_FILE_BACKUP, "w")) == NULL) { // soubor nelze otevřít pro zápis
      return ERROR_CANNOT_WRITE_FILE;
   }

   int i = copyPasswdFile(u_passwd_backup, u_passwd);

   fclose (u_passwd);
   fclose (u_passwd_backup);

   return i;
} // backupPasswdFile

// private:
int recoverPasswdFile() {
// vrací ERROR_OK, pokud OK,
// ERROR_CANNOT_WRITE_FILE, pokud problém při zápisu,
// ERROR_CANNOT_READ_FILE, pokud se vyskytla chyba při čtení ze souboru,
// ERROR_ANOTHER_ERROR při jiných chybách

   FILE * u_passwd;
   FILE * u_passwd_backup;

   if ((u_passwd = fopen (PASSWORD_FILE, "w")) == NULL) { // soubor nelze otevřít pro zápis
      return ERROR_CANNOT_WRITE_FILE;
   }
   if ((u_passwd_backup = fopen (PASSWORD_FILE_BACKUP, "r")) == NULL) { // soubor nelze otevřít pro čtení
      return ERROR_CANNOT_READ_FILE;
   }

   int i = copyPasswdFile(u_passwd, u_passwd_backup);

   fclose (u_passwd);
   fclose (u_passwd_backup);

   return i;
} // recoverPasswdFile

// zápis celého souboru kont (private):
int writePasswdFile(struct password_file *list) { // it writes the whole file of accounts from the list of structures
// it creates a copy of the previous file
// vrací ERROR_OK, pokud v pořádku zapsáno,
// ERROR_CANNOT_WRITE_FILE, pokud se vyskytla chyba při zápisu do souboru,
// ERROR_CANNOT_READ_FILE, pokud se vyskytla chyba při čtení ze souboru,
// ERROR_ANOTHER_ERROR při jiných chybách

   FILE * u_passwd;

   // first, create a backup copy of the actual password file

   int i = backupPasswdFile();
   if (i != ERROR_OK) {
      return i;
   }

   // now truncate the old file and write the new content to it

   if ((u_passwd = fopen (PASSWORD_FILE, "w")) == NULL) { // soubor nelze otevřít pro zápis
      return ERROR_CANNOT_WRITE_FILE;
   }
   else {
      struct password_file *list_act = list; // it keeps a pointer to the actual member of the list
      int first = 1;
      while (list_act) {
         if (list_act->account == NULL) {
            fclose(u_passwd);
            i = recoverPasswdFile();
            if (i != ERROR_OK) { // FATAL ERROR!
               fprintf(stderr, "\npasswd.c: writePasswdFile: Cannot recover the password file - it has been probably damaged!");
               return ERROR_CANNOT_WRITE_FILE;
            }
            return ERROR_ANOTHER_ERROR;
         }
         if (first) {
            first = 0;
         }
         else {
            fprintf(u_passwd,"\n");
         }
         fprintf(u_passwd,"%s",list_act->account);
         list_act = list_act->next;
      }
      fclose (u_passwd);
   }
   return ERROR_OK;

} // writePasswdFile

// private:
int findAccount(struct password_file *str_password_file, char *login_name, char **member) {
// the function goes through the list str_password_file and looks for the login_name
// in (*member) it returns the pointer to the found record (NULL if not found)
// it returns ERROR_OK if succesfull,
// ERROR_USER_DOES_NOT_EXIST if the login_name does not exist
// ERROR_ANOTHER_ERROR při jiné chybě

   (*member) = NULL; // not found yet
   struct password_file *list = str_password_file;
   int login_name_length = strlen(login_name);

   while (list != NULL) { // go through the list
      if (list->account == NULL) {
         return ERROR_ANOTHER_ERROR;
      }
      if (! strncmp (list -> account, login_name, login_name_length)) { // login name možná nalezeno
         if (list->account[login_name_length] == PASSWD_FIELDS_DELIMITER) { // login name skutečně nalezeno
            (*member) = list->account;
            return ERROR_OK;
         }
      }
      list = list->next;
   }
   return ERROR_USER_DOES_NOT_EXIST;
} // findAccount

// zápis do souboru kont (private):
int writeToPasswdFile(char *src, char *login_name) { // zapíše řádek src do souboru kont (případně přepíše uživatele se stejným jménem)
// vrací ERROR_OK, pokud v pořádku přečteno,
// ERROR_CANNOT_WRITE_FILE, pokud se vyskytla chyba při zápisu do souboru,
// ERROR_CANNOT_ALLOCATE_MEMORY if an error while allocating memory occurred
// ERROR_ANOTHER_ERROR při jiné chybě

   // at first, read all the file with accounts to memory
   struct password_file *str_password_file;
   int i = readPasswdFile(& str_password_file);
   if (i != ERROR_OK) { // some error occurred
      freeList(str_password_file);
      return i;
   }
   // now find the right record

   char *member;
   i = findAccount(str_password_file, login_name, & member);
   if (i != ERROR_OK) {
      freeList(str_password_file);
      return i;
   }

   // change it (member points to to the right record)

   strcpy (member, src);

   // save the accounts from memory to the file

   i = writePasswdFile(str_password_file);
   if (i != ERROR_OK) {
      freeList(str_password_file);
      return i;
   }

   freeList(str_password_file);
   return ERROR_OK;
} // writeToPasswdFile

// private:
int addField(char *dst, int position, const char *src) {
   int length = strlen(src);
   strncpy(dst + position, src, MAX_ACCOUNT_LENGTH - position - 1); // in order not to write behing the end of dst
   if (position + length < MAX_ACCOUNT_LENGTH) {
      *(dst + position + length) = PASSWD_FIELDS_DELIMITER; // instead of '\0'
   }
   return length + 1; // counting ':' as well
}

// private:
int readStringFromStruct (char *buf, struct account *str_account) {
// it returns ERROR_OK if OK,
// ERROR_ANOTHER_ERROR if anything wrong happened
   int position = 0; // actual position in buf
   position += addField(buf, position, str_account->login_name);
   position += addField(buf, position, str_account->encoded_password);
   position += addField(buf, position, str_account->account_state);
   position += addField(buf, position, str_account->account_type);
   position += addField(buf, position, str_account->root_directory);
   char number[20]; // hopefully the string representation of max number of trees will not be longer
   sprintf(number, "%d", str_account->max_number_of_trees);
   position += addField(buf, position, number);
   position += addField(buf, position, ((str_account->client_save_trees_permission == NO_INT_VALUE) ? NO_VALUE : YES_VALUE));
   position += addField(buf, position, ((str_account->change_password_permission == NO_INT_VALUE) ? NO_VALUE : YES_VALUE));
   position += addField(buf, position, str_account->e_mail);
   position += addField(buf, position, str_account->user_name);
   position += addField(buf, position, str_account->user_info);
   if (position >= MAX_ACCOUNT_LENGTH) {
      *(buf + MAX_ACCOUNT_LENGTH - 1) = '\0'; // terminate the string
      return ERROR_ANOTHER_ERROR;
   }
   *(buf + position - 1) = '\0'; // terminate the string (overwrite the last PASSWD_FIELD_DELIMITER)
   return ERROR_OK;
} // readStringFromStruct

// private:
int readField (char *dst, char *src, int max_length) {
   #ifdef DEBUG_READ_FIELD
      fprintf(stderr,"\npasswd.c: readField: src = %s", src);
   #endif
   char *next = (char *)memccpy(dst, src, PASSWD_FIELDS_DELIMITER, max_length);
   if (!next) { // the delimiter has not been found, the field is probably too long
      return MAX_ACCOUNT_LENGTH + 1; // error occurred
   }
   *(next - 1) = '\0';
   #ifdef DEBUG_READ_FIELD
      fprintf(stderr,"\npasswd.c: readField: everything seems to be OK.");
   #endif
   return next-dst;

} // readField

// private:
int readStructFromString (struct account *str_account, char *buf) {
// it returns ERROR_OK if OK,
// ERROR_ANOTHER_ERROR if anything wrong happened
   int length = strlen(buf);
   if (length < MAX_ACCOUNT_LENGTH) {
      *(buf + length) = PASSWD_FIELDS_DELIMITER; // I need it after the last field
      *(buf + length + 1) = '\0'; // new termination of the string
   }
   else {
      *(buf + length - 1) = PASSWD_FIELDS_DELIMITER; // I need it after the last field; in this case the last character of the last field is overwritten
      *(buf + length) = '\0'; // new termination of the string
   }
   int position = 0;
   #ifdef DEBUG_READ_STRUCT_FROM_STRING
      fprintf(stderr,"\npasswd.c: readStructFromString: looking for the login name");
   #endif
   position += readField (str_account->login_name, buf + position, LOGIN_NAME_MAX_LENGTH);
   if (position > MAX_ACCOUNT_LENGTH) return ERROR_ANOTHER_ERROR;
   #ifdef DEBUG_READ_STRUCT_FROM_STRING
      fprintf(stderr," - %s", str_account->login_name);
      fprintf(stderr,"\npasswd.c: readStructFromString: looking for the encoded password");
   #endif
   position += readField (str_account->encoded_password, buf + position, ENCODED_PASSWORD_MAX_LENGTH);
   if (position > MAX_ACCOUNT_LENGTH) return ERROR_ANOTHER_ERROR;
   #ifdef DEBUG_READ_STRUCT_FROM_STRING
      fprintf(stderr," - %s", str_account->encoded_password);
      fprintf(stderr,"\npasswd.c: readStructFromString: looking for the account state");
   #endif
   position += readField (str_account->account_state, buf + position, ACCOUNT_STATE_MAX_LENGTH);
   if (position > MAX_ACCOUNT_LENGTH) return ERROR_ANOTHER_ERROR;
   #ifdef DEBUG_READ_STRUCT_FROM_STRING
      fprintf(stderr," - %s", str_account->account_state);
      fprintf(stderr,"\npasswd.c: readStructFromString: looking for the account type");
   #endif
   position += readField (str_account->account_type, buf + position, ACCOUNT_TYPE_MAX_LENGTH);
   if (position > MAX_ACCOUNT_LENGTH) return ERROR_ANOTHER_ERROR;
   #ifdef DEBUG_READ_STRUCT_FROM_STRING
      fprintf(stderr," - %s", str_account->account_type);
      fprintf(stderr,"\npasswd.c: readStructFromString: looking for the root directory");
   #endif
   position += readField (str_account->root_directory, buf + position, ROOT_DIRECTORY_MAX_LENGTH);
   if (position > MAX_ACCOUNT_LENGTH) return ERROR_ANOTHER_ERROR;
   #ifdef DEBUG_READ_STRUCT_FROM_STRING
      fprintf(stderr," - %s", str_account->root_directory);
      fprintf(stderr,"\npasswd.c: readStructFromString: looking for the max number of trees");
   #endif
   char number[20]; // hopefully the string representation of max number of trees will not be longer
   position += readField (number, buf + position, 19);
   if (position > MAX_ACCOUNT_LENGTH) return ERROR_ANOTHER_ERROR;
   str_account->max_number_of_trees = strtol(number, (char **)NULL, 10); // convert the string to a long integer
   #ifdef DEBUG_READ_STRUCT_FROM_STRING
      fprintf(stderr," - %ld", str_account->max_number_of_trees);
      fprintf(stderr,"\npasswd.c: readStructFromString: looking for the save permission");
   #endif
   position += readField (number, buf + position, 19);
   if (position > MAX_ACCOUNT_LENGTH) return ERROR_ANOTHER_ERROR;
   str_account->client_save_trees_permission = (strncmp(number,YES_VALUE,3) ? NO_INT_VALUE : YES_INT_VALUE);
   #ifdef DEBUG_READ_STRUCT_FROM_STRING
      fprintf(stderr," - %d", str_account->client_save_trees_permission);
      fprintf(stderr,"\npasswd.c: readStructFromString: looking for the change password permission");
   #endif
   position += readField (number, buf + position, 19);
   if (position > MAX_ACCOUNT_LENGTH) return ERROR_ANOTHER_ERROR;
   str_account->change_password_permission = (strncmp(number,YES_VALUE,3) ? NO_INT_VALUE : YES_INT_VALUE);
   #ifdef DEBUG_READ_STRUCT_FROM_STRING
      fprintf(stderr," - %d", str_account->change_password_permission);
      fprintf(stderr,"\npasswd.c: readStructFromString: looking for the e-mail");
   #endif
   position += readField (str_account->e_mail, buf + position, E_MAIL_MAX_LENGTH);
   if (position > MAX_ACCOUNT_LENGTH) return -ERROR_ANOTHER_ERROR;
   #ifdef DEBUG_READ_STRUCT_FROM_STRING
      fprintf(stderr," - %s", str_account->e_mail);
      fprintf(stderr,"\npasswd.c: readStructFromString: looking for the user name");
   #endif
   position += readField (str_account->user_name, buf + position, USER_NAME_MAX_LENGTH);
   if (position > MAX_ACCOUNT_LENGTH) return ERROR_ANOTHER_ERROR;
   #ifdef DEBUG_READ_STRUCT_FROM_STRING
      fprintf(stderr," - %s", str_account->user_name);
      fprintf(stderr,"\npasswd.c: readStructFromString: looking for the user info");
   #endif
   position += readField (str_account->user_info, buf + position, USER_INFO_MAX_LENGTH);
   #ifdef DEBUG_READ_STRUCT_FROM_STRING
      fprintf(stderr," - %s", str_account->user_info);
   #endif
   if (position > MAX_ACCOUNT_LENGTH) return ERROR_ANOTHER_ERROR;
   #ifdef DEBUG_READ_STRUCT_FROM_STRING
      fprintf(stderr,"\npasswd.c: readStructFromString: everything seems to be OK.");
   #endif
   return ERROR_OK;
} // readStructFromString

int readStructFromPasswdFile (char *login_name, struct account *str_account) {
// vrací ERROR_OK, pokud v pořádku přečteno,
// ERROR_USER_DOES_NOT_EXIST, pokud uživatel daného jména neexistuje,
// ERROR_CANNOT_READ_FILE, pokud se vyskytla chyba při čtení ze souboru,
// ERROR_CANNOT_ALLOCATE_MEMORY if an error while allocating memory occurred
// ERROR_ANOTHER_ERROR při nějaké jiné chybě

   char *buf = (char *)malloc(sizeof(char)*(MAX_ACCOUNT_LENGTH+1)); // create a space for one record from file
   if (!buf) return ERROR_CANNOT_ALLOCATE_MEMORY;

   #ifdef DEBUG_READ_STRUCT_FROM_PASSWD_FILE
      fprintf(stderr,"\npasswd.c: readStructFromPasswdFile: the memory is allocated, looking into the file for the name %s.", login_name);
   #endif

   int i = readFromPasswdFile (buf, login_name); // read one line with the login name
   if (i == ERROR_USER_DOES_NOT_EXIST) { // the login name does not exist
      free (buf);
      return ERROR_USER_DOES_NOT_EXIST;
   }

   if (i == ERROR_CANNOT_READ_FILE) { // error while reading the file with passwords
      free (buf);
      return ERROR_CANNOT_READ_FILE;
   }

   #ifdef DEBUG_READ_STRUCT_FROM_PASSWD_FILE
      fprintf(stderr,"\npasswd.c: readStructFromPasswdFile: the account has been found, converting it to the struct account.");
   #endif

   i = readStructFromString (str_account, buf);
   if (i != ERROR_OK) { // some error
      free (buf);
      return i;
   }

   #ifdef DEBUG_READ_STRUCT_FROM_PASSWD_FILE
      fprintf(stderr,"\npasswd.c: readStructFromPasswdFile: everything seems to be OK.");
   #endif

   free (buf);
   return ERROR_OK;
} // readStructFromPasswdFile

int writeStructToPasswdFile (struct account *str_account) {
// vrací ERROR_OK, pokud v pořádku zapsáno,
// ERROR_CANNOT_WRITE_FILE, pokud se vyskytla chyba při zápisu do souboru,
// ERROR_CANNOT_READ_FILE, pokud se vyskytla chyba při čtení ze souboru,
// ERROR_CANNOT_ALLOCATE_MEMORY if an error while allocating memory occurred
// ERROR_ANOTHER_ERROR při nějaké jiné chybě

   char *buf = (char *)malloc(sizeof(char)*(MAX_ACCOUNT_LENGTH+1)); // create a space for one record from file
   if (!buf) return ERROR_CANNOT_ALLOCATE_MEMORY;

   int i = readStringFromStruct (buf, str_account);
   if (i != ERROR_OK) { // some error
      free (buf);
      return i;
   }

   i = writeToPasswdFile (buf, str_account->login_name); // write (overwrite) one line with the login name
   if (i != ERROR_OK) { // error while writing to the file with passwords
      free (buf);
      return i;
   }

   free (buf);
   return ERROR_OK;
} // readStructFromPasswdFile

// public:
int authentizeUser(char *login_name, char *password, struct account *str_account) {
// this function checks the login_name and the password in the file PASSWORD_FILE
// (default value, defined in passwd.c, is passwd.txt)
// it gives an authorization information in str_account (it must be allocated before the function is called)
// it returns ERROR_OK if succesfull,
// ERROR_USER_DOES_NOT_EXIST if the login_name does not exist,
// ERROR_ACCOUNT_DISABLED if the account is disabled
// ERROR_WRONG_PASSWORD if the password is wrong,
// ERROR_CANNOT_READ_FILE if the reading from the file with passwords failed,
// ERROR_CANNOT_ALLOCATE_MEMORY if an error while allocating memory occurred
// ERROR_ANOTHER_ERROR if some other error occurred

   int i = readStructFromPasswdFile (login_name, str_account); // read one record from the passwords file with the login name
   if (i == ERROR_USER_DOES_NOT_EXIST) { // the login name does not exist
      return ERROR_USER_DOES_NOT_EXIST;
   }
   if (i == ERROR_CANNOT_READ_FILE) { // error while reading the file with passwords
      return ERROR_CANNOT_READ_FILE;
   }
   if (i == ERROR_CANNOT_ALLOCATE_MEMORY) { // error while allocating memory
      return ERROR_CANNOT_ALLOCATE_MEMORY;
   }
   if (i == ERROR_ANOTHER_ERROR) { // some other error
      return ERROR_ANOTHER_ERROR;
   }

   if (strcmp(str_account->account_state, "enabled")) { // the account is disabled
      return ERROR_ACCOUNT_DISABLED;
   }

   if (strncmp(password, str_account->encoded_password, ENCODED_PASSWORD_MAX_LENGTH)) { // the password is wrong
      return ERROR_WRONG_PASSWORD;
   }
   return ERROR_OK;
} // authentizeUser

// public:
int changePassword(char *login_name, char *old_password, char *new_password) {
// this function changes a password in the file PASSWORD_FILE (default value, defined in passwd.c, is passwd.txt)
// it returns ERROR_OK if succesfull,
// ERROR_USER_DOES_NOT_EXIST if the login_name does not exist,
// ERROR_ACCOUNT_DISABLED if the account is disabled
// ERROR_WRONG_OLD_PASSWORD if the old_password is wrong,
// ERROR_NO_CHANGE_PASSWORD_PERMISSION if the user has not permission to change his password
// ERROR_CANNOT_READ_FILE if the reading from the file with passwords failed
// ERROR_CANNOT_WRITE_FILE if the writing to the file with passwords failed
// ERROR_CANNOT_ALLOCATE_MEMORY if an error while allocating memory occurred
// ERROR_ANOTHER_ERROR if some other error occurred

   struct account *str_account = (struct account *) malloc(sizeof(struct account));

   if (!str_account) return ERROR_CANNOT_ALLOCATE_MEMORY;

   #ifdef DEBUG_CHANGE_PASSWORD
      fprintf(stderr,"\npasswd.c: changePassword: the memory is allocated, looking for the login name %s",login_name);
   #endif

   int i = readStructFromPasswdFile (login_name, str_account); // read one record from the passwords file with the login name
   if (i != ERROR_OK) { // if some error occurred
      free (str_account);
      return i;
   }

   #ifdef DEBUG_CHANGE_PASSWORD
      fprintf(stderr,"\npasswd.c: changePassword: the struct account has been filled with the right account.");
   #endif

   if (strcmp(str_account->account_state, "enabled")) { // the account is disabled
      free (str_account);
      return ERROR_ACCOUNT_DISABLED;
   }

   #ifdef DEBUG_CHANGE_PASSWORD
      fprintf(stderr,"\npasswd.c: changePassword: the account is not disabled.");
   #endif

   if (str_account->change_password_permission == 0) { // the user doesn't have permission to change his password
      free (str_account);
      return ERROR_NO_CHANGE_PASSWORD_PERMISSION;
   }

   #ifdef DEBUG_CHANGE_PASSWORD
      fprintf(stderr,"\npasswd.c: changePassword: the user has permission to change his password.");
   #endif

   if (strncmp(old_password, str_account->encoded_password, ENCODED_PASSWORD_MAX_LENGTH)) { // the old_password is wrong
      free (str_account);
      return ERROR_WRONG_OLD_PASSWORD;
   }

   #ifdef DEBUG_CHANGE_PASSWORD
      fprintf(stderr,"\npasswd.c: changePassword: the old password is OK.");
   #endif

   strncpy(str_account->encoded_password, new_password, ENCODED_PASSWORD_MAX_LENGTH); // copy the new password to the structure
   str_account->encoded_password[ENCODED_PASSWORD_MAX_LENGTH] = '\0'; // null termination in case the new_password has been too long

   i = writeStructToPasswdFile (str_account);
   if (i == ERROR_CANNOT_WRITE_FILE) { // error while writing to the file with passwords
      free (str_account);
      return ERROR_CANNOT_WRITE_FILE;
   }
   if (i == ERROR_CANNOT_ALLOCATE_MEMORY) { // error while allocating memory
      free (str_account);
      return ERROR_CANNOT_ALLOCATE_MEMORY;
   }
   if (i == ERROR_ANOTHER_ERROR) { // some other error
      free (str_account);
      return ERROR_ANOTHER_ERROR;
   }

   #ifdef DEBUG_CHANGE_PASSWORD
      fprintf(stderr,"\npasswd.c: changePassword: everything seems to be OK.");
   #endif

   free (str_account);
   return ERROR_OK;
} // changePassword

// private:
int writeOneLine(char *dst, const char *label, const char *field) {
// this function writes one field of the account to dst, in front of it puts the label
// between the label and the content of the field is CLIENT_COMMUNICATION_LABEL_DELIMITER
// all this is ended by CLIENT_COMMUNICATION_FIELDS_DELIMITER
// it returns number of written charecters
	int pom;
	int length = strlen(label);
	strncpy(dst,label,length);
	*(dst + length++) = CLIENT_COMMUNICATION_LABEL_DELIMITER;
	pom = strlen(field);
	strncpy(dst + length, field, pom);
	length += pom;
	*(dst + length++) = CLIENT_COMMUNICATION_FIELDS_DELIMITER;
	return length;
	
} // writeOneLine

// public:
int writeAuthorizationToChars(char *dst, struct account *str_account) {
// this function writes part of the authorization information from str_account to dst
// each part on a separate line, a label of a field in front of each part
// it returns number of written characters

	int length = 0;
	char number[20]; // hopefully the string representation of max number of trees will not be longer
	length += writeOneLine(dst + length, ACCOUNT_TYPE_LABEL, str_account->account_type);
	length += writeOneLine(dst + length, ROOT_DIRECTORY_LABEL, str_account->root_directory);
	sprintf(number, "%ld", str_account->max_number_of_trees);
	length += writeOneLine(dst + length, MAX_NUMBER_OF_TREES_LABEL, number);
	length += writeOneLine(dst + length, CLIENT_SAVE_TREES_PERMISSION_LABEL, (str_account->client_save_trees_permission == YES_INT_VALUE) ? YES_VALUE : NO_VALUE);
	length += writeOneLine(dst + length, CHANGE_PASSWORD_PERMISSION_LABEL, (str_account->change_password_permission == YES_INT_VALUE) ? YES_VALUE : NO_VALUE);
	length += writeOneLine(dst + length, USER_NAME_LABEL, str_account->user_name);
	*(dst + length++) = CLIENT_COMMUNICATION_FIELDS_DELIMITER; // it signals the end of fields
	return length;

} // writeAuthorizationToChars

// public:
void setDefaultValues(struct account *str_account) {
// it sets default values to the struct
	strcpy(str_account->login_name, DEFAULT_LOGIN_NAME);
	strcpy(str_account->encoded_password, DEFAULT_ENCODED_PASSWORD);
	strcpy(str_account->account_state, DEFAULT_ACCOUNT_STATE);
	strcpy(str_account->account_type, DEFAULT_ACCOUNT_TYPE);
	strcpy(str_account->root_directory, DEFAULT_ROOT_DIRECTORY);
	str_account->max_number_of_trees = DEFAULT_MAX_NUMBER_OF_TREES;
	str_account->client_save_trees_permission = DEFAULT_CLIENT_SAVE_TREES_PERMISSION;
	str_account->change_password_permission = DEFAULT_CHANGE_PASSWORD_PERMISSION;
	strcpy(str_account->e_mail, DEFAULT_E_MAIL);
	strcpy(str_account->user_name, DEFAULT_USER_NAME);
	strcpy(str_account->user_info, DEFAULT_USER_INFO);
} // setDefaultValues
