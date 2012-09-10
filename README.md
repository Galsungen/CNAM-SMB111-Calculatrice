# Calculatrice (JSP) #

## Matière / UE ##

 * SMB111 : Systèmes et applictaions répartis
 * Centre FOD Interrégional de la Réunion
 * Année de réalisation : 2012

## Avertissement ##

Je met à disposition ces sources et ce sujet pour accompagner de nouveaux auditeurs dans les matières concernées. En aucun cas il ne s'agit de "la" solution au sujet, mais simplement de ma solution. Ne recopiez jamais le code d'un autre sans le comprendre, et surtout pas pour le rendre au formateur. Et même en le comprenant d'ailleurs dans le cadre du CNAM ... Ecrivez votre propre code, votre propre solution, vous verrez que vous en apprendrez bien plus. Ma démarche est juste de vous aider en vous donnant une réprésentation possible d'une solution. Je sais que moi cela m'aide comme démarche, et que j'écris ensuite toujours ma solution, avec ma vision.

Bon courage à tous si vous êtes dans le cursus du CNAM (Conservatoire National des Arts et Métiers).

## Sujet ##

Implémenter un serveur de calcul qui permettra d’effectuer à distance des opérations d’addition, de soustraction, de multiplication et de division.

## Technologies à utiliser ##

Utiliser au choix .NET, JSP, Servlet ou Java RMI. La technologie devant changer à chaque exercice, j'ai choisi d'utiliser ici les JSP.

## Comment exécuter le code ##

Afin de pouvoir l’exécuter il faut avoir un serveur implémentant la lecture des fichiers JSP comme Apache Tomcat, par exemple ( http://tomcat.apache.org/ ). Il faut ensuite un simple navigateur Web pour pouvoir se rendre sur la page et l’exécuter.

Pour installer un serveur Tomcat, que ce soit sous Windows ou Linux, le plus simple est de se rendre sur le site (lien ci-dessus) et de cliquer sur la gauche sur le lien « Tomcat 7.0 » dans la rubrique Download. Sur la page où on arrive, télécharger le fichier zip dans la partie « Binary Distributions ». Dézipper le fichier. Dans le dossier obtenu nous allons nous intéresser à deux dossiers pour commencer, « bin » qui contient les exécutables binaires, et « conf » qui contient les fichiers nécessaires à la configuration. Si vous n’avez pas de serveur Web qui tourne par défaut sur votre machine, vous ne devriez pas avoir besoin de modifier les ports par défaut, sinon il faut éditer le fichier « server.xml » dans le dossier « conf ». Avant de lancer le serveur, il vaut mieux aussi définir les identifiants et mots de passe nécessaires à sa bonne exécution. Pour cela éditer le fichier « tomcat-users.xml ». Voici un exemple de ce que j’ai dans le mien :

```xml
<?xml version='1.0' encoding='utf-8'?>
<role rolename="manager"/>
<role rolename="manager-gui"/>
<role rolename="admin"/>
<role rolename="manager-script"/>
<user username="tomcat" password="tomcat" roles="admin,manager,manager-gui,manager-script"/>
</tomcat-users>
```

Tous ces rôles ne sont pas obligatoires, le « manager-gui » suffit pour tester l’exécution du code donné, mais si vous voulez tester depuis un IDE comme Netbeans, le « manager-script » sera nécessaire, par exemple. Pour plus d’informations la dessus, reportez-vous à la documentation fournie sur le site de Apache Tomcat.
Pour démarrer le serveur, se rendre ensuite dans le dossier « bin » et procéder à son lancement avec l’exécutable approprié :
 * Windows : startup.bat
 * Linux : startup.sh<br />
Des exécutables sont aussi présents pour stopper les services à l’issue.

Dans l’architecture de dossiers propres au serveur Tomcat, se rendre dans le dossier « webapps », y créer un dossier « Calculatrice » et y placer le fichier « index.jsp ».
Dans votre navigateur, se rendre à l’URL : http://localhost:8080/Calculatrice/index.jspp. Vous pouvez remplacer « localhost » par une autre IP si votre serveur est distant, et le port (ici 8080) par le port sur lequel écoute votre serveur Tomcat.

Le fonctionnement de l’application est très simple, on inscrit les nombres que l’on souhaite dans les champs textes « Premier terme » et « Deuxième terme », on choisit l’opérande correspondant à l’opération souhaitée et on clique sur « Calculer ».
Le résultat, si il est correct et calculable apparaitra dans le champ en face de « Résultat ».
Les calculs se font que l’on soumette un entier ou un double. Normalement tous les réels sont acceptés, avec en retour un double.
Le passage des paramètres est effectué par la méthode GET, c'est-à-dire par la barre d’adresse du navigateur.
L’insertion de texte, ou la demande d’une opération « impossible » comme une division par zéro, sont prises en compte par la levée d’exceptions.

## Limitations et évolutions ##

L’application est ici très légère avec une seule page de 130 lignes pour l’affichage et les calculs. Etant présentée sous la forme d’une simple page Web, il est possible de l’appeler plusieurs fois en même temps depuis la même machine ou depuis plusieurs machines distinctes. Chaque machine fonctionnera avec son « instance » de l’application et cette dernière sera partagée mais avec des mémoires indépendantes pour la réalisation des calculs.

La gestion des erreurs et des exceptions est limitée à son minimum ici. Une première évolution pourrait être une meilleure prise en compte de ces dernières avec plus de détails, de précisions. Comme nous réalisons de la saisie, nous pourrions bloquer l’envoi du formulaire si les champs ne sont pas correctement remplis. Ce point pourrait-être réalisé en JavaScript.

Une autre évolution serait de remplacer la méthode GET par la méthode POST afin d’éviter le passage de paramètres par la barre d’adresse du navigateur. Même si le passage de mauvais paramètres est ignoré, ce serait plus propre.

Nous pourrions aussi remplacer l’interface simpliste par une autre plus proche des calculatrices actuelles avec boutons pour les chiffres, fonctions mathématiques plus avancées (cos, tan, sin, …) et ainsi de suite.

Enfin nous pourrions modifier l’application pour qu’elle épouse mieux le modèle MVC. Pour ce faire nous pourrions coupler JSP pour l’affichage, avec une Servlet pour les calculs. Cela permettrait une meilleure séparation des rôles (ici un seul fichier) mais aussi la possibilité d’ouvrir le fonctionnement de l’application. En effet les clients pourraient aussi bien interroger le serveur de calcul depuis l’interface en JSP que depuis un autre accès type API, sur la Servlet. Nous aurions en revanche plus de fichiers à gérer.
