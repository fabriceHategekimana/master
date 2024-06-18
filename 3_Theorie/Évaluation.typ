#import "../src/module.typ" : *
#pagebreak()

//TODO: ajout du context d'évaluation

== Sémantique d'Évaluation

L'évaluation est l'une des deux parties de la sémantique du langage qui va nous permettre de voir que les opérations définies font bien ce qu'on leur demande.

Les opérations de base sont simples. Ce sont l'addition et la multiplication pour les nombre entiers (la soustraction et la division nous feraient sortir de cet ensemble si on les prend dans leur sens premier). Nous avons aussi les opérateur and et or pour les booléens (nous somme capable de facilement créer l'opérateur uniaire *not* avec la définition de notre langage).

Les nombres respectent les propriétés des entiers positifs. Il n'y a rien de très spécial si ce n'est le fait d'utiliser les règles arithmétiques de base pour les dérivations d'évaluation.


$ #proof-tree(eval("NUM", $"n" => "n"$)) $
$ #proof-tree(eval("PLUS", $"E1" + "E2" => "E3"$, $"E1" + "E2" => "E3"$)) $
$ #proof-tree(eval("PLUS", $"E1" * "E2" => "E3"$, $"E1" * "E2" => "E3"$)) $


Les booléens se comportent aussi de la même façon que dans les langages de programmations classiques comme python. Ils s'appuient aussi sur l'arithmétique classique.


$ #proof-tree(eval("BOOL-T", $"true" => "true"$)) $
$ #proof-tree(eval("BOOL-F", $"false" => "false"$)) $
$ #proof-tree(eval("AND", $"E1" "and" "E2" => "E3"$, $"E1" sect "E2" => "E3"$)) $
$ #proof-tree(eval("OR", $"E1" "or" "E2" => "E3"$, $"E1" union "E2" => "E3"$)) $


Nous en profitons pour aborder le *if...then...else* dont le premier argument dépend d'un booléen.


$ #proof-tree(eval("IF-T", $"if" "E1" "then" "E2" "else" "E3" => "E2"$, $"E1" => "true"$)) $
$ #proof-tree(eval("IF-F", $"if" "E1" "then" "E2" "else" "E3" => "E3"$, $"E1" => "true"$)) $


Les fonctions sont un point essentiel pour un langage. C'est d'ailleur l'un des éléments les plus sophistiqués de celui-ci. Son execution n'est pas très compliqué si ce n'est l'usage d'une subsitution.


$ #proof-tree(eval("FUNC",$"func"< overline( "a")>( overline( "x":"P")) -> "T" { "E" }$)) $
$ #proof-tree(eval("FUNC-APP", $("E1")< overline( "T")>( overline( "E")) => "E2"$, $"E1" => "func" < overline( "T")>( overline( "x":"P")) -> "T" { "E" }$, $"E"[ overline( "x")/ overline( "E")] => "E2"$)) $


L'une des fonctionnalités cruciales de ce langage se résume dans les tableaux. En effet C'est là où nous aborderons la notion de typage pour des opérations correctes sur ces structures de données. Nous définissions dans l'actualité l'opération de concaténation qui n'est pas une opération commutative. Celle-ci prendra un tableau et y ajoutera un élément. La définition du tableau est syntaxiquement simple. Nous pouvons comprendre qu'un tableau vide est représenté par un "[]". C'est pourquoi il n'y a pas de définition récursive.


$ #proof-tree(eval("ARR", $[overline( "E")] => [overline( "E")]$)) $
$ #proof-tree(eval("CONC", $[overline("E1")]::[overline("E2")] => [overline("E1"), overline("E2")]$)) $


Nous avons aussi les fonctions d'extraction de valeurs. On pourrait utiliser l'indexation, mais le plus simple dans notre situation est de se limiter au minimum est d'émuler la fonction à partir des fondamentaux du langage.


$ #proof-tree(eval("FIRST-ARR", $"first"([ "E1", overline( "E2")])  => "E1"$)) $
$ #proof-tree(eval("REST-ARR", $"rest"([ "E1", overline( "E2")])  => overline("E2")$)) $
