# Info
`docker-compose` per l'esecuzione dell'ambiente locale di *SOS*.
Lo stack comprende un container `web`, contenente `php7.2` ed `nginx`, e un `db` mysql.
# Istruzioni
- `cp .env.template .env` (ed eventuale modifica delle variabili d'ambiente)
- nel file `docker-compose.yml` montare come volumi le cartelle del/dei componente/i da testare in `/home/<nome-componente>` (vedere ad esempio `- ./src/component:/home/components/helloworld` o `- ./src/template:/home/components/joomlapure`)
- avviare l'ambiente di sviluppo con `docker-compose up`

# Note
Le credenziali di amministratore dell'ambiente locale sono:
- user: `admin`
- password: `admin`
