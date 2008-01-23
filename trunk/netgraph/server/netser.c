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

// netser 1.77 (5.4.2006)

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <time.h>
#include <netdb.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <signal.h>
#include <errno.h>
#include <pcre.h> // regulární výrazy schopné zvládnout UTF-8; zde pro test, zda knihovna byla kompilována s podporou UTF-8

#include "mutual.h"
#include "passwd.h"

////////////////////////// DEBUG ////////////////////////

//#define DEBUG	// ladici vypisy
//#define DEBUG_SIGNALS  // ladí zasílání signálů mezi procesy

////////////////////////// DEFINE ///////////////////////

#define SERV_TCP_PORT 2000  // defaultni cislo portu
#define MAX_CLIENT_ADDRESS_LENGTH 100 // maximální délka jména (adresy) klienta
#define MAX_DATE_LENGTH 50 // maximální délka datumu a času
#define MAX_CLIENTS 5    // defaultní maximální počet připojených klientů


////////////////////////// GLOBAL ///////////////////////

extern int errno;

char zprava[MAXLENMES];
char *pname;
char client_name[MAX_CLIENT_ADDRESS_LENGTH];
char time_connected[MAX_DATE_LENGTH];

int max_number_of_clients; // maximální povolený počet připojených klientů
int number_of_clients; // aktuální počet připojených klientů

// tyto proměnné obsazuje a využívá až netser (child)
int do_not_record;

int pipe1[2];
int pipe2[2];
int newsockfd;
// ----------


////////////////////////// FUNKCE ///////////////////////

void err_dump (char* message) { // fatal error -> exit
	fprintf(stderr,message);
	fflush(stderr);
	exit(1);
}


void zapis (int fd, char *p, int delka) { // zapise do fd z p delka bajtu

	int nwritten;

	#ifdef DEBUG
		fprintf(stdout,"Chci zapsat : %i", delka);
	 	fflush( stdout );
 	#endif

 	while (delka > 0) {
 		nwritten=write (fd, p, delka);
 	  	if (nwritten <= 0)
 	  		err_dump("\nserver (netser.c): error in writing");

 	  	delka -= nwritten;
 	  	p += nwritten;
 	}
}


int pozice(char * p, int znak) { // vraci pozici znaku znak v retezci p (od nuly)
	char *i = index(p,znak); // ukážu si na ten znak
	if (i == NULL) return -1;
	else return (i-p);
}


void zapis_eom (int fd, char * p, int endznak = EOM) { // zapis s ukonc. znakem (musi byt jiz soucasti retezce)
	zapis (fd, p, pozice (p, endznak) + 1);
}


int cti_eom( int fd, char * p, int endznak = EOM ) { // pro cteni zprav od klienta
// precte z fd do p po znak endznak (vcetne)
// vraci kolik bajtu precetl (vcetne endznaku)

	int nread;
	int index = -1;

	#ifdef DEBUG
		fprintf (stdout,"\nChci cist (netser)");
 		fflush (stdout);
 	#endif

 	do {

 		index++;
 		nread=read(fd, p + index, 1);
 	  	if (nread <= 0)
 	  		err_dump("\nserver (netser.c): error in reading");

 	} while (p[index] != endznak);

 	return index + 1;

} // cti_eom

char *getCurrentTime() { // vrací aktuální systémový čas; pozor, pokaždé na stejném místě v paměti
	struct timeval time;
	struct timezone tz;
	gettimeofday(&time, &tz);
	long int time_sec = time.tv_sec; // čas ve vteřinách
	char *time_str = ctime(&time_sec);
	int length = strlen(time_str);
	if (length > 0) {
		*(time_str + length - 1) = '\0'; // odstraním koncový přechod na nový řádek
	}
	return time_str;
}

// následující funkce je pro netser (parent)
void childExited(int signal) { // spouštěno signálem SIGCHLD, obhospodařuje ukončení netseru pro daného klienta
	#ifdef DEBUG_SIGNALS
		fprintf(stderr, "\nnetser.c (parent): childExited: The process netser (child) has exited.");
	#endif
	number_of_clients --;
	//signal(SIGCHLD,&childExited); // obnovím obsluhu signálu - tahle funkce bude uvědomována o zániku potomka
	close(newsockfd); // zavřu socket
  wait(NULL); // abych se zbavil [netser] <defunct>
	//fprintf(stderr, "\nThe actual number of connected clients is %d", number_of_clients);
} // childExited

//void childExitedSilent(int signal) { // spouštěno signálem SIGCHLD
//	number_of_clients --;
//	signal(SIGCHLD, SIG_IGN); // nechci reagovat na zánik potomka
//} // chiledExitedSilent


// následující funkce je pro netser (child)
void dotserExited(int signal) { // spouštěno signálem SIGCHLD, obhospodařuje ukončení procesu dotser
	#ifdef DEBUG_SIGNALS
		fprintf(stderr, "\nnetser.c (child): dotserExited: The process dotser (parent) has exited.");
	#endif

	char *time_disconnected;
	time_disconnected = getCurrentTime();
	if (do_not_record != TRUE) { // pokud se má tato konexe zaznamenávat do logu
		fprintf(stderr,"\nThe client (connected at %s from %s) disconnected at %s.", time_connected, client_name, time_disconnected);
	}

	#ifdef DEBUG_SIGNALS
		fprintf(stderr, "\nnetser.c (child): dotserExited: Exiting.");
	#endif
  wait(NULL);
	exit(0); // skončím také a uvědomím netser (parent) - spustí se funkce childExited
} // dotserExited


// -------------------------- MAIN ----------------------------------

main (int argc, char *argv[]) {

	int sockfd,
		clilen,
		childpid,
		nleft,
		nwritten,
		portnum; // cislo portu
  int pcre_ret, pcre_res; // pro testování, zda knihovna pcre pro regulární výrazy byla kompilována s podporou UTF-8.

	struct sockaddr_in cli_addr, serv_addr;

	int always_accept, never_accept;

	fprintf (stderr, "\n\nThe Netgraph server version %s", THIS_SERVER_VERSION);

  pcre_ret=pcre_config(PCRE_CONFIG_UTF8, (void *)&pcre_res); // testuje, zda knihovna pcre pro reg. výrazy byla kompilována s podporou UTF-8
  if (pcre_res != 1) {  // v regulárních výrazech není podpora UTF-8!
    fprintf (stderr, "\n\nWarning! The pcre library has been compiled without UTF-8 support! It is bad!");
    fprintf (stderr, "\n         You should exit Netgraph server now and recompile the pcre library");
    fprintf (stderr, "\n         with 'configure' parameter --enable-utf8. Otherwise the server may not");
    fprintf (stderr, "\n         match some regular expressions containing UTF-8 characters correctly.\n");
  }
  //else { // podpora UTF-8 v reg. výrazech je OK
  //  fprintf (stderr, "\n\nThe pcre library has been compiled with UTF-8 support. Good.");
  //}

	max_number_of_clients = MAX_CLIENTS; // tohle je default, později se přečte z config.txt

	if ((sockfd = socket (AF_INET, SOCK_STREAM, 0)) < 0) {
		err_dump("\n\nnetser.c: fatal error: the server cannot open the stream!\nExiting.");
	}

	memset((char *) &serv_addr, 0, sizeof(serv_addr));

	serv_addr.sin_family	= AF_INET;
	serv_addr.sin_addr.s_addr = htonl(INADDR_ANY);

	portnum = SERV_TCP_PORT; // implicitní hodnota portu

	if (argc == 2) {
		sscanf (argv[1], "%d", &portnum); // pokud určen port parametrem, použije se
	}

	serv_addr.sin_port = htons(portnum);

	fprintf (stderr, "\nThe server is trying to bind to the port: %d ...", portnum);

	if (bind(sockfd,(struct sockaddr *) &serv_addr, sizeof(serv_addr)) <0) {
		err_dump("KO!\nnetser.c: fatal error: the server cannot bind to the port.\nExiting.");
	}
	fprintf (stderr, " OK");

	listen(sockfd, 5);
	fprintf (stderr, "\nThe server has started and is waiting for connections.\n");

	number_of_clients = 0; // zatím žádná konexe

	signal(SIGCHLD,&childExited); // tahle funkce bude uvědomována o zániku potomka

	for ( ; ; )  { // pro každou příchozí konexi
		clilen = sizeof(cli_addr); // proč to není před cyklem?

		newsockfd = accept(sockfd, (struct sockaddr *) &cli_addr, (socklen_t*) &clilen);
		if (newsockfd < 0) {
#ifdef _LINUX_VERSION
			fprintf(stderr,"\nnetser.c: fatal error: server accept error!\nExiting.");
#endif
			continue;
		}

		// zjistím adresu (jméno) klienta; použiji již alokované pole zpráva
#ifdef _LINUX_VERSION
		getnameinfo((struct sockaddr *) &cli_addr, sizeof(cli_addr),
					client_name, 99, NULL, 0, NI_NOFQDN); // delší než 99 jméno snad nebude
		// ve windowsech v cygwinu tohle nefunguje
#endif
#ifdef _WINDOWS_VERSION
		//getnameinfo((struct sockaddr *) &cli_addr, sizeof(cli_addr),
		//			client_name, 99, NULL, 0, 4); // delší než 99 jméno snad nebude
#endif
		client_name[99]='\0'; // pro jistotu

		// zjistím čas
		strcpy(time_connected, getCurrentTime());

		always_accept = checkInConfigFile(zprava, PARAM_NAME_ALWAYS_ACCEPT, client_name);
		never_accept = checkInConfigFile(zprava, PARAM_NAME_NEVER_ACCEPT, client_name);
		do_not_record = checkInConfigFile(zprava, PARAM_NAME_DO_NOT_RECORD, client_name);

		if (do_not_record != TRUE) { // pokud se má tato konexe zaznamenávat do logu
			fprintf(stderr, "\nConnection from %s at %s", client_name, time_connected);
		}

		if (never_accept == TRUE) { // pokud tomuto klientovi je zakázán přístup
			fprintf(stderr, "\n - this client is not allowed to connect to the server. The connection is refused!");
			zprava[0] = MAXIMUM_CLIENTS;
			zprava[1] = 0;
			zapis(newsockfd,zprava,2); // pošlu klientovi zprávu (asi nepravdivou), že je příliš mnoho připojených klientů
			shutdown(newsockfd,2); // zruším oba směry socketu (klient to ale dobře nerozpozná!)
			continue;
		}

		// z konfiguračního souboru přečtu maximální povolený počet klientů
		max_number_of_clients = readConfigFile(zprava, PARAM_NAME_MAX_CLIENTS, TRUE);
		if (max_number_of_clients < 0) max_number_of_clients = MAX_CLIENTS;
		// fprintf(stderr,"\nThe maximum number of clients is set to %d", max_number_of_clients);

		// zkontroluji, jestli není připojeno již moc klientů
		if ((number_of_clients < max_number_of_clients) || always_accept) {
			number_of_clients ++;
			if (do_not_record != TRUE) { // pokud se má tato konexe zaznamenávat do logu
				fprintf(stderr, "\nThe actual number of connected clients is %d", number_of_clients);
			}
		}
		else { // klientů je již připojen maximální povolený počet, toto spojení je třeba odmítnout
			if (do_not_record != TRUE) { // pokud se má tato konexe zaznamenávat do logu
				fprintf(stderr, "\n - the maximum allowed number of clients (%d) has already been reached. This connection is refused!", max_number_of_clients);
			}
			zprava[0] = MAXIMUM_CLIENTS;
			zprava[1] = 0;
			zapis(newsockfd,zprava,2); // počlu o tom informaci klientovi
			shutdown(newsockfd,2); // zruším oba směry socketu (klient to ale dobře nerozpozná!)
			continue;
		}


		// ---------------- FORK 1 -----------------
		// vytvořím potomka - netser starajícího se jen o toto jedno spojení
		if ((childpid=fork()) <0) {
			fprintf(stderr, "\nnetser.c: Error in fork - cannot serve the connection!");
			shutdown(newsockfd,2); // zruším oba směry socketu (klient to ale dobře nerozpozná!)
			number_of_clients --;
			continue;
		}
		else {
			if (childpid==0) { // potomek - ten bude obhospodařovat toto jedno spojení s klientem
				close (sockfd);

				int childpid;

				/* vytvoreni rour

				// ziskani retezce s PID
				char pidstr[10];
				sprintf (pidstr, "%d", getpid());

				// vytvoreni jedinecnych jmen pro roury
				strcpy(roura1,"/tmp/rfifo1.");
				strcpy(roura2,"/tmp/rfifo2.");

				strcat (roura1, pidstr);
				strcat (roura2, pidstr);

				#define PERMS 0666

				if ((mknod (roura1, S_IFIFO | PERMS, 0) < 0) && (errno != EEXIST) ) {
					err_dump( "\nnetser.c (child): fatal error: cannot create the pipe roura1! Stopping the connection." );
				}
				if ((mknod (roura2, S_IFIFO | PERMS, 0) < 0) && (errno != EEXIST) ) {
					unlink(roura1);
					err_dump ("nnetser.c (child): fatal error: cannot create the pipe roura2! Stopping the connection.");
				} */

				pipe(pipe1); // vytvořím dvě roury pro komunikaci mezi dotserem a netserem
				pipe(pipe2);
				// ---------------- FORK 2 -----------------
				// nyní vytvořím proces dotser - pro zpracování zpráv od klienta
				if ((childpid = fork()) < 0) {
					err_dump ("\nnetser.c (child): fatal error: cannot create new process dotser! Stopping the connection.");
				}
				else {
					if (childpid > 0) { /* rodic */

						close (pipe1[0]); // zavřu čtení z roury, do které budu zapisovat
						close(1); // zavřu stdout
						dup(pipe1[1]); // a připojím na něj rouru pipe1
						close(pipe1[1]); // ten původní file descriptor zavřu (pro pořádek)
						close (pipe2[1]); // zavřu výstup do roury 2, ze které budu číst
						close(0); // zavřu stdin
						dup(pipe2[0]); // a připojím ho na rouru pipe2
						close(pipe2[0]); // a opět pro pořádek zavřu ten původní file descriptor

						signal(SIGCHLD, &dotserExited); // takto chci reagovat na zánik potomka

/*						if ((writefd = open (roura1, 1)) < 0) {
							err_dump("\nnetser.c (child parent): fatal error: cannot open the pipe roura1! Stopping the connection.");
						}
						if ((readfd = open (roura2, 0)) < 0) {
							err_dump("\nnetser.c (child parent): fatal error: cannot open the pipe roura2! Stopping the connection.");
						}
*/
						/* zde uz bude vlastni prace se schrankami a rourami */

						#ifdef DEBUG
							fprintf(stderr,"Netser je za rourami");
						#endif

						for ( ; ; ) { // pro všechny příchozí zprávy
							cti_eom (newsockfd, zprava); // prečtu zprávu od klienta
							zapis_eom (1, zprava); // pošlu ji dotseru přes rouru
							cti_eom(0, zprava); // od dotseru druhou rourou přečtu odpověd
							zapis_eom (newsockfd, zprava); // a přešlu ji klientovi
						}

					} // konec rodice netser child

					else { // dite netser child vytvori proces dotser
						close (newsockfd);
						//close (writefd);
						//close (readfd);
						close (pipe2[0]); // zavřu čtení z roury, do které budu zapisovat
						close(1); // zavřu stdout
						dup(pipe2[1]); // a připojím na něj rouru pipe2
						close(pipe2[1]); // ten původní file descriptor zavřu (pro pořádek)
						close (pipe1[1]); // zavřu výstup do roury 1, ze které budu číst
						close(0); // zavřu stdin
						dup(pipe1[0]); // a připojím ho na rouru pipe1
						close(pipe1[0]); // a opět pro pořádek zavřu ten původní file descriptor

						execl ("./dotser", "dotser", NULL);
						err_dump ("\nnetser.c (child child): fatal error: cannot start dotser! Stopping the connection.");
					} // fork2 - netser (child child) ~ dotser
				} // fork2
			} // fork1 - netser (child)
		} // fork1
		close(newsockfd);
	} // for
} // main

