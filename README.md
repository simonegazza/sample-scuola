# Info
`docker-compose` per l'esecuzione dell'ambiente locale di *SOS*.
Lo stack comprende un container `web`, contenente `php7.2` ed `nginx`, e un `db` mysql.
# Istruzioni
- `cp .env.template .env` (ed eventuale modifica delle variabili d'ambiente)
- nel file `docker-compose.yml` montare come volumi le cartelle del/dei componente/i da testare in `/home/<nome-componente>` (vedere ad esempio nel `docker-compose.yml` le righe `- ./src/component:/home/components/helloworld` o `- ./src/template:/home/components/joomlapure`)
- avviare l'ambiente di sviluppo con `npm run start`

# Note
Il container di sviluppo risponde a `localhost:8000`
Le credenziali di amministratore (`localhost:8000/administrator`) dell'ambiente locale sono:
- user: `admin`
- password: `admin`
