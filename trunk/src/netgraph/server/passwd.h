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

// passwd.h 1.52 (30.5.2002)

#ifndef _PASSWD_H
#define _PASSWD_H

#define LOGIN_NAME_MAX_LENGTH 20
#define ENCODED_PASSWORD_MAX_LENGTH 33
#define ACCOUNT_STATE_MAX_LENGTH 10
#define ACCOUNT_TYPE_MAX_LENGTH 10
#define ROOT_DIRECTORY_MAX_LENGTH 256
#define E_MAIL_MAX_LENGTH 50
#define USER_NAME_MAX_LENGTH 40
#define USER_INFO_MAX_LENGTH 100

#define ERROR_OK 0
#define ERROR_CANNOT_READ_FILE -1
#define ERROR_CANNOT_WRITE_FILE -2
#define ERROR_USER_DOES_NOT_EXIST -3
#define ERROR_ACCOUNT_DISABLED -4
#define ERROR_WRONG_PASSWORD -5
#define ERROR_WRONG_OLD_PASSWORD -6
#define ERROR_NO_CHANGE_PASSWORD_PERMISSION -7
#define ERROR_CANNOT_ALLOCATE_MEMORY -8
#define ERROR_ANOTHER_ERROR -9

struct account {
   char login_name[LOGIN_NAME_MAX_LENGTH + 1];
   char encoded_password[ENCODED_PASSWORD_MAX_LENGTH + 1];
   char account_state[ACCOUNT_STATE_MAX_LENGTH + 1]; // enabled/disabled
   char account_type[ACCOUNT_TYPE_MAX_LENGTH + 1]; // anonymous/user
   char root_directory[ROOT_DIRECTORY_MAX_LENGTH + 1]; // default/(directory)
   long int max_number_of_trees; // (number, 0 = unlimited)
   int client_save_trees_permission; // 1/0 = yes/no
   int change_password_permission; // 1/0 = yes/no
   char e_mail[E_MAIL_MAX_LENGTH + 1];
   char user_name[USER_NAME_MAX_LENGTH + 1];
   char user_info[USER_INFO_MAX_LENGTH + 1];
};

int authentizeUser(char *login_name, char *password, struct account *str_account);
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

int changePassword(char *login_name, char *old_password, char *new_password);
// this function changes a password in the file PASSWORD_FILE (default value, defined in passwd.c, is passwd.txt)
// the function doesn't solve the problem of multiple access at once!
// it returns ERROR_OK if succesfull,
// ERROR_USER_DOES_NOT_EXIST if the login_name does not exist,
// ERROR_ACCOUNT_DISABLED if the account is disabled
// ERROR_WRONG_OLD_PASSWORD if the old_password is wrong,
// ERROR_NO_CHANGE_PASSWORD_PERMISSION if the user has not permission to change his password
// ERROR_CANNOT_READ_FILE if the reading from the file with passwords failed
// ERROR_CANNOT_WRITE_FILE if the writing to the file with passwords failed
// ERROR_CANNOT_ALLOCATE_MEMORY if an error while allocating memory occurred
// ERROR_ANOTHER_ERROR if some other error occurred

int writeAuthorizationToChars(char *dst, struct account *str_account);
// this function writes part of the authorization information from str_account to dst
// each part on a separate line, a label of a field in front of each part
// it returns number of written characters

void setDefaultValues(struct account *str_account);
// it sets default values to the struct

#endif
