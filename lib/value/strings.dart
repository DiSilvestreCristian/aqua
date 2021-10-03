library strings.globals;

import 'package:flutter/material.dart';

/* -- GENERALI -- */

//Nomi inquinanti
const String ostreopsisName = "Ostreopsis cf. ovata";
const String escherichiaName = "Escherichia coli";
const String enterococcusName = "Enterococchi";

//Nome ostreopsis formattato
TextSpan ostreopsisLabel = TextSpan(text: "Ostreopsis ", style: TextStyle(fontStyle: FontStyle.italic),
    children:<TextSpan>[
      TextSpan(text: "cf. ", style: TextStyle(fontStyle: FontStyle.normal)),
      TextSpan(text: "ovata", style: TextStyle(fontStyle: FontStyle.italic)),
    ]
);

//soglie
const String sogliaOstreopsis = "/30000 ";
const String sogliaEscherichia = "/500 ";
const String sogliaEnterococcus = "/200 ";

//unità di misura
const String unitaOstreopsis = "[cell/L]";
const String unitaEscherichia = "[ufc/100ml]";
const String unitaEnterococcus = "[ufc/100ml]";

//Qualità acqua
const String qualityBad = "SCARSA";
const String qualitySufficient = "SUFFICIENTE";
const String qualityGood = "BUONA";
const String qualityExelent = "ECCELLENTE";
const String qualityNotClassified = "NON CLASSIFICATA";

/* -- MAPPA - HOME -- */

//InfoBox
const String infoBoxMarker = "Qualità acqua: ";

//Ricerca
const String searchBarHint = "Cerca...";
const String searchBarIniziaRicerca = "Inizia la ricerca";
const String searchBarNessunRisultato = "Spiaggia non trovata";

/* -- SCREEN NOTIFICHE - SIDEBAR HOME -- */

//Titolo
const String titoloNotifiche = "Notifiche";

//nomi delle notifiche
const String notificaPreferiti = "Notifiche preferiti";
const String notificaPosizione = "Notifiche in base alla posizione";

//descrizioni delle notifiche
const String descrizioneNotificaPreferiti = "Ricevi notifiche se il livello "
    "di inquinamento delle località indicate tra i preferiti supera uno o più "
    "valori di soglia.";
const String descrizioneNotificaPosizione = "Ricevi notifiche se il livello "
    "di inquinamento delle località vicine alla tua posizione supera uno o più "
    "valori di soglia.";

/* -- SCREEN CLASSIFICA -- */

//Titolo
const String addFavourite = "Non hai aggiunto alcuna spiaggia preferita";
/* -- SCREEN CLASSIFICA -- */

//Titolo
const String titoloRank = "Classifica";

/* -- SCREEN DETTAGLI_SPIAGGIA -- */

//Valore non rilevato
const String valoreNonRilevato = "Non rilevato";

//Schede qualità e alga
const String qualitaAcqua = "Qualità dell'acqua:";
const String situazioneAlga = "Situazione alga: ";

//Valori json qualità acqua
const String qualityJSONBad = "0";
const String qualityJSONSufficient = "1";
const String qualityJSONGood = "2";
const String qualityJSONExelent = "3";

//Situazione alga
const String notClassifiedSituation = "NON CLASSIFICATA";
const String regularSituation = "REGOLARE";
const String allertSituation = "ALLERTA";
const String emergencySituation = "EMERGENZA";

/* -- SCREEN DETTAGLI_INQUINANTE -- */

//Schede situazione attuale
const String labelSituazioneAttuale = "Valore attuale";

//Schede medie mensili
const String labelMedieMensili = "Medie mensili";

//Nomi mesi
const List<String> nomiMesi = [
  "Gennaio", "Febbraio", "Marzo", "Aprile", "Maggio", "Giugno",
  "Luglio", "Agosto", "Settembre", "Ottobre", "Novembre", "Dicembre"];
const mesiIniziali = [
  "", "Gen", "Feb", "Mar", "Apr", "Mag", "Giu",
  "Lug", "Ago", "Set", "Ott", "Nov", "Dic"];

//Storico valori
const String labelStoricoValori = "Storico Valori";

//Storico vuoto
TextSpan storicoVuoto = TextSpan(
    text: "Non è presente alcuna rilevazione valida dell'inquinante selezionato per questa spiaggia.",
    style: TextStyle(fontSize: 23.0)
);
TextSpan noOstreopsis = TextSpan(text: "Spiaggia non affetta da presenza dell'alga ", style: TextStyle(fontSize: 23.0),
    children:<TextSpan>[
      TextSpan(text: "Ostreopsis ", style: TextStyle(fontStyle: FontStyle.italic)),
      TextSpan(text: "cf. ", style: TextStyle(fontStyle: FontStyle.normal)),
      TextSpan(text: "ovata.", style: TextStyle(fontStyle: FontStyle.italic)),
    ]
);
/* -- SCREEN INFO-- */

//Titolo
const String titoloInfo = "Info";

//Preview screen info
const String escherichiaPreview ="Escherichia Coli. Che cos’é? Quanti tipi ce ne sono?";
const String enterococcusPreview ="Enterococchi. Perché ci impediscono di fare il bagno?";
TextSpan ostreopsisPreview = TextSpan(text: "Ostreopsis ", style: TextStyle(fontStyle: FontStyle.italic),
    children:<TextSpan>[
      TextSpan(text: "cf. ", style: TextStyle(fontStyle: FontStyle.normal)),
      TextSpan(text: "ovata", style: TextStyle(fontStyle: FontStyle.italic)),
      TextSpan(text: ": tutto quello che devi sapere sull'alga tossica", style: TextStyle(fontStyle: FontStyle.normal)),
    ]
);

/* -- SCREEN INFO_INQUINANTI -- */

//Decrizioni inquinanti
const String escherichiaInfo = " - Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
    "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
    "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi "
    "ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit "
    "in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
    "sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt "
    "mollit anim id est laborum. "
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
    "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
    "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi "
    "ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit "
    "in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
    "sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt "
    "mollit anim id est laborum. "
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
    "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
    "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi "
    "ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit "
    "in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
    "sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt "
    "mollit anim id est laborum. "
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
    "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
    "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi "
    "ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit "
    "in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
    "sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt "
    "mollit anim id est laborum. ";
const String enterococcusInfo = " - Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
    "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
    "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi "
    "ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit "
    "in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
    "sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt "
    "mollit anim id est laborum. "
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
    "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
    "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi "
    "ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit "
    "in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
    "sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt "
    "mollit anim id est laborum. "
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
    "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
    "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi "
    "ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit "
    "in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
    "sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt "
    "mollit anim id est laborum. "
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
    "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
    "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi "
    "ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit "
    "in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
    "sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt "
    "mollit anim id est laborum.";
TextSpan ostreopsisInfo = TextSpan(text: "Ostreopsis ", style: TextStyle(fontStyle: FontStyle.italic),
    children:<TextSpan>[
      TextSpan(text: "cf. ", style: TextStyle(fontStyle: FontStyle.normal)),
      TextSpan(text: "ovata", style: TextStyle(fontStyle: FontStyle.italic)),
      TextSpan(text: " - Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
          "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
          "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi "
          "ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit "
          "in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
          "sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt "
          "mollit anim id est laborum. "
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
          "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
          "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi "
          "ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit "
          "in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
          "sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt "
          "mollit anim id est laborum. "
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
          "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
          "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi "
          "ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit "
          "in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
          "sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt "
          "mollit anim id est laborum. "
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
          "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
          "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi "
          "ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit "
          "in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
          "sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt "
          "mollit anim id est laborum. ", style: TextStyle(fontStyle: FontStyle.normal)),
    ]
);

/* -- SCREEN ERROR ROUTE -- */

//Error message
const String errorMessage = "ERROR";