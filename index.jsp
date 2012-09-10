<%--
    Document   : index
    Created on : 25 juin 2012, 17:05:04
    Author     : Galsungen - http://blog.galsungen.net
    SBM111 - Systèmes et applications répartis - 2011-12
--%>

<%@
    page contentType="text/html" pageEncoding="UTF-8"
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Calculatrice</title>
    </head>
    <body>

        <%
            //déclarations de variables
            String resultat = new String("");
            String mesException = new String("");
            boolean error = false;

            //On récupère les variables, si elles sont vides, on initialise à vide
            String chiffre_2 = "";
            String operande = "";
            String chiffre_1 = "";
            chiffre_1 = request.getParameter("chiffre_1");
            chiffre_2 = request.getParameter("chiffre_2");
            operande = request.getParameter("operande");
            if(chiffre_1 == null) {
                chiffre_1 = "0";
            }
             if(chiffre_2 == null) {
                chiffre_2 = "0";
            }
            if(operande == null) {
                operande = "plus";
            }

            /* 
            * On transforme les chaines chiffre_1 et _2 en Double. Si cela échoue cela devrait lever une exception.
            * Nous pourrions mettre une vérification sur le champ pour limiter la saisie, comme un blocage en JavaScript par la suite.
            */
            Double chiffre_a, chiffre_b;
            chiffre_a = 0.;
            chiffre_b = 0.;
            
            if (!chiffre_1.equals("")) {
                try {
                    chiffre_a = Double.valueOf(chiffre_1);
                } catch (Exception e){
                    error = true;
                    mesException = "chiffre_1 n'est pas un nombre !!!";
                }
            } else {
                chiffre_a = new Double(0);
            }
            
            if (!chiffre_2.equals("")) {
                try {
                    chiffre_b = Double.valueOf(chiffre_2);
                } catch (Exception e) {
                    error = true;
                    mesException = "chiffre_2 n'est pas un nombre !!!";
                }
            } else {
                chiffre_b = new Double(0);
            }
            
            //On exécute le calcul à travers un switch suivant l'opérande
            Double rezfin = new Double (0);
            int op; op = 1;

            // On définit une valeur pour chaque operande
            // vu que le switch n'accepte pas de String en operande en 1.6, ce sera pour la 1.7
            //
            if (operande != ""){
                if(operande.equals("plus")){
                    op = 1;
                } else if (operande.equals("moins")){
                    op = 2;
                } else if (operande.equals("divise")){
                    op = 3;
                } else if (operande.equals("multiplie")) {
                    op = 4;
                }

                switch (op) {
                    case 1: rezfin = chiffre_a + chiffre_b;
                            break;
                    case 2: rezfin = chiffre_a - chiffre_b;
                            break;
                    case 3: rezfin = chiffre_a / chiffre_b;
                            break;
                    case 4: rezfin = chiffre_a * chiffre_b;
                            break;
                }
            }

            //On traduit le résultat en une chaine pour afficher
            if(!error){
                resultat = resultat.valueOf(rezfin);
            } else {
                resultat = mesException;
            }

        %>

        <h1>Calculatrice : </h1>

    <%-- Formulaire qui va permettre d'entrer ses paramètres --%>

    <form METHOD="GET" ACTION="index.jsp" ENCTYPE="x-www-form-urlencoded">
        <table border="0" align="center">
            <tr><td>Premier terme : <input  type="text" value="<% out.print(chiffre_1); %>" name="chiffre_1" /></td></tr>
            <tr><td>Op&eacute;rande : </td></tr>
            <tr><td><input  type="radio" value="plus" name="operande" <% if(operande.equals("plus"))out.print("checked=\"checked\""); %> /> + </td></tr>
            <tr><td><input  type="radio" value="moins" name="operande" <% if(operande.equals("moins"))out.print("checked=\"checked\""); %> /> - </td></tr>
            <tr><td><input  type="radio" value="divise" name="operande" <% if(operande.equals("divise"))out.print("checked=\"checked\""); %> /> / </td></tr>
            <tr><td><input  type="radio" value="multiplie" name="operande" <% if(operande.equals("multiplie"))out.print("checked=\"checked\""); %> /> * </td></tr>
            <tr><td>Deuxi&egrave;me terme : <input  type="text" value="<% out.print(chiffre_2); %>" name="chiffre_2" /></td></tr>
            <tr><td><input type="submit" value="Calculer" /></td></tr>
            <tr><td>Résultat : <% out.print(resultat); %></td></tr>
        </table>
    </form>

    </body>
</html>
