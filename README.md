# prog_lab
Progetto per il laboratorio di Architetture Software e Sicurezza Informatica

FUNZIONALITA’ 
Il sito web “Where next” ha come obiettivo offrire un servizio a coloro che vogliono organizzare un’uscita in un locale invitando i propri amici, accontentando le preferenze di ogni partecipante. 
Where next, inoltre, offre ad un proprietario di un locale la possibilità di aggiungere il proprio locale al database del sito e di conseguenza alle possibili scelte dei locali per un’uscita. 
 
RUOLI 
-	Utente registrato come ‘user’: può organizzare un’uscita,visualizzare quelle passate e future e può aggiungere degli amici. Può inoltre selezionare delle categorie per aggiungerle alle sue preferenze. Può visualizzare la lista dei locali ed aggiungere o rimuovere un locale ai preferiti. 
-	Utente registrato come ‘admin’: è l’unico a poter modificare aggiungere o eliminare le categorie ed approvare i locali che sono stati aggiunti dagli owner. Può inoltre bannare gli utenti dal sito. 
-	Utente registrato come ‘owner’: può aggiungere locali al sito e questi rimarranno in attesa di approvazione da parte dell’admin. Può inoltre visualizzare i locali da lui aggiunti, modificarli o eventualmente eliminarli. 
-	Utente non registrato: può vedere la homepage con una breve descrizione del sito, può registrarsi o fare il login 
	-	 
INTERAZIONE CON SERVIZI ESTERNI 
Come servizio esterno abbiamo utilizzato l’API di OpenStreetMap per ottenere longitudine e latitudine della posizione di una via del locale inserito; con Leaflet verrà mostrato il locale su una mappa 
 
AUTENTICAZIONE  
 Sono previste due modalità di accesso al sito:  
•	Locale -> l’utente può registrarsi direttamente sul sito inserendo i propri dati  
•	OAuth -> l’utente può accedere al sito direttamente tramite il proprio account Facebook 


USER STORIES 
https://drive.google.com/file/d/1uJqrTNuNn1bJtIJ-yYr0Wx79WRUG76wE/view?usp=sharing


MOCKUPS
https://drive.google.com/file/d/1ciFfJlpCUgHsp3cDsygXvqy2dDLv7g3h/view?usp=sharing

PIANO DEI TEST: 

  Test di unita':
    1. Modello Location 
    2. Modello Category 
  
  Test funzionali:
    1. Controller Location 
    2. Controller Category 
    3. Controller Gathering
  
  Test di integrazione: 
    1. Accettazione/Rifiuto di un locale (da parte di un Admin) 
    2. Scelta categorie preferite (da parte di uno user)
    3. Aggiungi locale ai preferiti (da parte di uno user)
    4. Matching locations (da parte di uno user)
