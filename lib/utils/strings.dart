
class Strings {
  static const String type = 'Tipus';
  static const String typesss = 'Serveis Sociosanitaris';
  static const String typeFamilia = 'Atenció i suport a les families';
  static const String typeEducacio = 'Educació i lleure';
  static const String typeEsport = 'Esport';
  static const String typeBasic = 'Atenció a les necessitats bàsiques';
  static const String typeInter = 'Voluntariat Internacional';
  static const String typeMedi = 'Defensa del mediambient';
  static const String typeJove = 'Joventut';
  static const String typeGran = 'Gent Gran';
  static const String typeAnimal = 'Protecció dels animals';
  static const String typeCult = 'Cultura';

  static const String modeTot = "Totes les activitats";
  static const String modeVirtual = "Virtual";
  static const String modeVirtualNomes = "Només Virtual";
  static const String modePresencial = "Presencial";
  static const String modePresencialNomes = "Només Presencial";
  static const String modeSemi = "Semipresencial";

  static const String carouselDestacatsTitol = "Activitats Destacades:";
  static const String carouselNovetatsTitol = "Novetats:";

  static const String homeInici = "Inici";
  static const String homeActivitats = "Activitats";
  static const String homeEntitats = "Entitats";
  static const String homeInfo = "Info";
  static const String homeAdmin = "Zona Administrador";
  static const String hometTancar = "Tancar";
  static const String homefeedback = "Dona el teu feedback";

  static const String entityActivities = "Activitats de l'entitat:";
  static const String entityNoActivities = "Aquesta entitat encara no té activitats programades.";
  static const String entityImageErase = "Vols esborrar la imatge de l'entitat?";
  static const String entityImageEraseWarn = "Aquesta acció serà irreversible";
  static const String entityEraseWarn1 = "Estas segur?";
  static const String entityEraseWarn2 = "Aquesta operació podria afectar altres dades de l'aplicacio";
  static const String entityEraseWarn3 = "No es pot esborrar l'entitat ja que té activitats assignades";
  static const String entityEraseWarn4 = "Desassigna les activitats d'aquesta entitat o esborra les activitats de l'entitat";

  static const String textCerca = "Cerca";
  static const String textCancelar = "Cancelar";
  static const String textEsborrar = "Esborrar";
  static const String textAcceptar = "Acceptar";
  static const String textEntrar = "Entrar";
  static const String textEnviar = "Enviar";

  static const String signTitle = "Inicia sessió Admin";
  static const String signHintCorreu = "correu electrònic";
  static const String signEnterCorreu = 'Introdueix un correu electrònic';
  static const String signHintContra = "contrasenya";
  static const String signEnterContra = 'La contasenya ha de tenir mes de 6 caracters';
  static const String signError = 'No s\' ha pogut iniciar sessio';

  static const String activityImageErase = "Vols esborrar la imatge de l'activitat?";
  static const String activityImageEraseWarn = "Aquesta acció serà irreversible";
  static const String activityEraseWarn1 = "Estas segur?";
  static const String activityEraseWarn2 = "Aquesta operació podria afectar altres dades de l'aplicacio";

  static const String activityDesc = "Descripció";
  static const String activityEnt = "Entitats";
  static const String activityDates = "Dates";
  static const String activityDataInici = "Data d\'inici";
  static const String activityDataFinal = "Data final";
  static const String activityInfoPerm = "Aquesta és una activitat permanent.";
  static const String activityLloc = "Lloc";
  static const String activityHorari ="Horari";
  static const String activityContacte = "Contacte";
  static const String activityDestacat = "Destacat";
  static const String activityWarnVisible = 'L\'activitat ara es visible per tothom';
  static const String activityWarnNoVisible = 'L\'activitat ja no es visible';
  static const String activityUrgent = "Es necessiten voluntaris urgentment:";
  static const String activityUrgentWarn = "Les activitats destacades tenen un megàfon.";

  static const String formActivityWarnUnaEntitat = "L'activitat ha de tenir al menys una entitat.";
  static const String formActivityWarnTipus = "L'activitat ha de tenir un tipus.";
  static const String formActivitySelectType = 'Selecciona si es presencial, virtual o semipresencial';
  static const String formActivityWarnMode = "L'activitat ha de ser presencial, virtual o semipresencial.";
  static const String formActivityTextTitol = "Titol";
  static const String formActivityTextTitolWarn = "L'activitat ha de tenir un titol.";
  static const String formActivityTextDescWarn = "L'activitat ha de tenir una descripció.";
  static const String formActivityTextEntitats = 'Entitat/s';
  static const String formActivityTextTipologia = 'Tipologia';
  static const String formActivityTextSelType = 'Selecciona un tipus';
  static const String formActivityTextDatesExplicacio = 'Si hi ha una diferencia de més de 10 anys entre la data de començament i la de final, l\'activitat serà permanent';
  static const String formActivityTextDataVisible = 'Data fins la que l\'activitat serà visible';
  static const String formActivityTextDataVisibleWarn = "L'activitat ha de tenir una data de caducitat";
  static const String formActivityTextDataLaunch = 'Data de llançament';
  static const String formActivityTextDataLaunchWarn = "L'activitat ha de tenir una data de llantçament";
  static const String formActivityTextDiesLaunch = 'Dies que l\'activitat serà novetat';
  static const String formActivityTextLlocWarn = "L'activitat ha de tenir un lloc.";
  static const String formActivityTextHorariWarn ="L'activitat ha de tenir un horari.";
  static const String formActivityTextContacteWarn ="L'activitat ha de tenir un contacte.";
  static const String formActivityTextVisibilitat ="Visibilitat";
  static const String formActivityTextVisibilitatWarn ='Vols que l\'activitat sigui visible?';
  static const String formActivityTextDestacatWarn ='Vols que l\'activitat sigui destacada?';

  static const String formEntityNom ='Nom';
  static const String formEntityNomWarn ="L'entitat ha de tenir un nom.";
  static const String formEntityDesc='Descripció';
  static const String formEntityDescWarn="L'entitat ha de tenir una descripció.";
  static const String formEntityYT="Video de Youtube";
  static const String formEntityTwitter='Pàgina de twitter';
  static const String formEntityFacebook='Pàgina de facebook';
  static const String formEntitySocialHint ="Introdueix el link o deixa el camp en blanc";
  static const String formEntityInstagram='Pàgina de instagram';
  static const String formEntityWeb='Pàgina web';
  static const String formEntityMaps='Lloc a Google Maps';
  static const String formEntityColorHint='Escolleix el color';
}


