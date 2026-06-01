✅ Ce que ton code actuel montre
Tu as déjà :

DemandeStatus en DemandeStatus.java
DemandeStatusService en DemandeStatusService.java
DemandeStatusRepository en DemandeStatusRepository.java
DemandeStatusController en DemandeStatusController.java
form_demande_status.jsp en views
Mais il manque :

un contrôleur pour afficher la page d’ajout / liste
un contrôleur pour afficher le formulaire de modification
un formulaire propre avec status, date avec minute, observation, ref demande
une liste des demandes status
une page de modification séparée (ou un formulaire réutilisé proprement)
un status dropdown réel
🧭 To-do list étape par étape
1) Créer/modifier DemandeStatusController.java
Ajoute/implémente :

@GetMapping("/form_demande_status")
charge new DemandeStatus()
charge demandes via demandeService.listerDemandes()
charge la liste des status possibles
éventuellement charge la liste demandeStatus si tu veux lister sur la même page
@GetMapping("/demande_status/liste")
charge demandeStatusService.listerDemandes()
renvoie liste_demande_status
@GetMapping("/demande_status/modifier/{idDemande}/{idStatus}")
charge l’entrée existante via demandeStatusService.getDemande(idDemande, idStatus)
charge les statuses déjà passés pour cette demande
renvoie edit_demande_status
@PostMapping("/demande_status/modifier")
sauvegarde avec demandeStatusService.modifierDemande(...)
redirige vers la liste ou la page de formulaire
Actuellement tu n’as que @PostMapping("/demande_status/ajouter").

2) Modifier/ajouter des méthodes dans DemandeStatusService.java
Ajoute :

List<DemandeStatus> listerDemandesStatus() si tu veux plus clair
List<DemandeStatus> findByDemande(int idDemande) pour récupérer les statuses déjà passés d’une demande
éventuellement int modifierDemandeStatus(DemandeStatus d) (tu as déjà modifierDemande)
3) Modifier DemandeStatusRepository.java
Ajoute une méthode Spring Data JPA pour filtrer par demande :

List<DemandeStatus> findById_Id_demande(int idDemande);
ou
List<DemandeStatus> findByIdDemande(int idDemande);
Cela servira pour :

afficher les statuses déjà passés sur la page de modification
reconstruire le dropdown <select> limité aux statuts déjà passés
4) Corriger form_demande_status.jsp
Ta page actuelle est incomplète :

il y a deux fois le select de la référence
il n’y a pas de champ status
il y a type="date" alors que tu veux la minute
il n’y a pas d’input name="id_demande" lié à l’objet
le select devrait envoyer une valeur lisible ou un id_demande caché
Ce qu’il faut faire :

un seul bloc Référence demande
onblur / onchange sur le champ ref pour charger la demande comme dans devis.jsp
un champ date_status de type datetime-local
un <form:select path="id_status"> pour choisir le status
un champ observation
un bouton Valider
un champ caché form:input path="id_demande" ou input type="hidden" name="id_demande"
5) Ajouter une page de modification edit_demande_status.jsp
Crée un fichier :

src/main/webapp/WEB-INF/views/edit_demande_status.jsp
Il doit contenir :

les mêmes champs que le formulaire d’ajout
la même logique JavaScript de chargement de la demande si besoin
le dropdown status limité aux statuts déjà passés pour la demande
un bouton Valider
6) Ajouter une page de liste liste_demande_status.jsp
Crée un fichier :

src/main/webapp/WEB-INF/views/liste_demande_status.jsp
Il devra afficher :

toutes les lignes de DemandeStatus
ref demande
status
date_status
observation
actions Modifier / Supprimer si tu veux
7) Gérer la liste des statuts
Tu peux utiliser Utils.MapperStatus() pour obtenir les statuts :

passe un Map<String,Integer> ou une liste de paires au modèle
dans JSP, affiche tous les statuts possibles
pour la modification, charge seulement ceux déjà passés par la demande
Exemple :

DC, DA, DR, DEC, DER, DFC, DFR
8) Normaliser les routes et le menu
Modifie ou ajoute :

un lien vers /form_demande_status
un lien vers /demande_status/liste
Par exemple dans ta navbar ou une page d’accueil.

📁 Dossiers/fichiers à créer ou modifier
À modifier
DemandeStatusController.java
DemandeStatusService.java
DemandeStatusRepository.java
form_demande_status.jsp
À créer
src/main/webapp/WEB-INF/views/edit_demande_status.jsp
src/main/webapp/WEB-INF/views/liste_demande_status.jsp
Si tu veux apprendre vite, commence par faire fonctionner l’ajout seul, puis ajoute la liste, puis le formulaire de modification.

💡 Conseil concret
Pour l’onblur comme dans devis.jsp :

utilise <select id="refDemande" onchange="chargerDemande(this.value)">
crée une fonction JS chargerDemande(ref) qui appelle /devis/demande/{ref}
si la demande existe, stocke id_demande dans un champ caché et affiche un message
🧪 Ordre recommandé
Ajouter le GET /form_demande_status et la JSP form_demande_status.jsp
Corriger le formulaire avec id_demande, status, datetime-local, observation
Tester l’ajout avec /demande_status/ajouter
Créer liste_demande_status.jsp + route /demande_status/liste
Ajouter GET /demande_status/modifier/{idDemande}/{idStatus}
Créer edit_demande_status.jsp
Ajouter POST /demande_status/modifier
Tester la modification
Si tu veux, je peux maintenant te donner le code exact pour :

DemandeStatusController
DemandeStatusRepository
form_demande_status.jsp
edit_demande_status.jsp
liste_demande_status.jsp
Je peux aussi te montrer précisément comment faire le onblur avec le champ ref_demande.

Je veux que vous créer une table paramètre dans laquelle il se trouvera les colonnes suivantes (id_status1 ,id_status2 ,durée , couleur ) 
si id status 1 est décalé de id_status 2 , on va sommer les durées entre les status à l'intéérieurs 
Par exemple 1 2 350 rouge ,1 2 220 Jaune ,1 2 50 vert , 
c à dire de 350 et à son au delà , le couleur est rouge , et de 220 à 350 le couleur est  jaune 