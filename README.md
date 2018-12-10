# INFO
Sito joomla funzionante con installazione automatizzata in fase di build del container Docker.  
Lo stack comprende anche un container mySQL e memcached, che vengono utilizzati da joomla.

#DIPENDENZE
Per eseguire la soluzione è necessario avere Docker e docker-compose installati.

#VARIABILI D'AMBIENTE
Il file .env.template contiene le variabili d'ambiente con i propri valori di default.

`MYSQL_ROOT_PASSWORD` Specifica la password dell'utente root del database mySQL  
`MEMCACHED_CACHE_SIZE` Specifica la dimensione della cache di memcached (in megabyte)

# TEST
- `cp .env.template .env` e modificare eventualmente le variabili d'ambiente
- `docker-compose up`  