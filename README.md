# INFO
`docker-compose` per l'esecuzione dell'ambiente locale di *SOS*.  
Lo stack comprende un container `web`, contenente `php7.2` ed `nginx`, e un `db`.

# Istruzioni
- `cp .env.template .env` (ed eventuale modifica delle variabili d'ambiente)
- nel file `docker-compose.yml` montare come volumi le cartelle del/dei componente/i da testare in `/home/<nome-componente>`
- copiare il file script.template.php dentro alla root del/dei componente/i (`cp script.template.php ./src/script.php`), inserire il nome del componente al posto
di COMPONENT_NAME (es. `class com_helloworldInstallerScript`) e inserire `	<scriptfile>script.php</scriptfile>` nel manifest del componente.
- avviare l'ambiente di sviluppo con `docker-compose up` 