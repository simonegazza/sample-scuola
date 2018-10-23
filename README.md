# INFO
`docker-compose` per l'esecuzione dell'ambiente locale di *SOS*.  
Lo stack comprende un container `data` per il codice e che si occuperà di montare i volumi necessari per la persistenza,
`db`, `php`, `nginx`, `redis` al momento si spiegano da soli, `localstack` come fallback delle funzionalità di AWS.

# TEST
- `cp .env.template .env` e modificare eventualmente le variabili d'ambiente
- `docker-compose up`  
NB: *WIP* al momento serviamo solo dei file HTML staticamente