#import "@preview/bubble:0.1.0": *
#import "@preview/curryst:0.3.0": rule, proof-tree
#import "src/module.typ": *

#show: bubble.with(
  title: "Système de type",
  subtitle: "Pour les sciences des données",
  author: "Fabrice H.",
  affiliation: "Université de Genève",
  date: datetime.today().display(),
  year: "2024",
  class: "Sciences informatiques",
  logo: image("src/logo.png"),
) 

#set par(
  first-line-indent: 1em,
  justify: true,
  linebreaks: "optimized"
)

#pagebreak()

#align(horizon)[

== Abstract

Les sciences des données et les statistiques jouent un rôle de plus en plus important dans nos sociétés. Cependant, les langages de programmation actuels ne sont pas entièrement adaptés à ce nouveau paradigme de développement. L'objectif de cette recherche est de développer un système de type statique permettant de manipuler des tableaux multidimensionnels pour les sciences des données. La méthodologie consiste à créer un mini-langage capable de gérer les tableaux multidimensionnels, en utilisant des génériques et des types dépendants. Nous avons réussi à développer un modèle simple d'un langage capable de réaliser des opérations sur des scalaires, des matrices et des vecteurs, ainsi qu'un module pour les réseaux de neurones. Les résultats montrent qu'il est possible d'assurer un niveau satisfaisant de sécurité avec les types, bien que nous rencontrions des limitations en termes de représentation complète sans rendre l'algorithme de vérification de type indécidable à un certain degré.
]

#pagebreak()

#outline(depth: 2, indent: 8% - 2em)

#include "1_Intro/Context.typ"
#include "1_Intro/Problématique.typ"
#include "1_Intro/Solutions.typ"
#include "2_Etat_de_l_art/R.typ"
#include "2_Etat_de_l_art/Lambda_calculus.typ"
#include "2_Etat_de_l_art/STLC.typ"
#include "2_Etat_de_l_art/Système_F.typ"

#include "3_Theorie/C3PO.typ"
#include "3_Theorie/Syntax.typ"
#include "3_Theorie/Évaluation.typ"
#include "3_Theorie/Typage.typ"
#include "3_Theorie/Soundness.typ"

#include "3_Theorie/Intro.typ"
#include "3_Theorie/Types_de_données_basiques.typ"
#include "3_Theorie/Broadcasting.typ"

#include "5_Implémentation/Prolog.typ"

#include "4_Usecase/Couches.typ"
#include "4_Usecase/Réseaux_de_neurones.typ"

#include "6_Conclusion/Synthèse.typ"
#include "6_Conclusion/Succès.typ"
#include "6_Conclusion/Défauts.typ"
#include "6_Conclusion/Projet_futures.typ"

#pagebreak()

= Remerciements

Je tiens à exprimer ma profonde gratitude à toutes les personnes qui ont contribué à la réalisation de cette thèse. Leur soutien, leurs conseils et leurs encouragements ont été inestimables tout au long de ce parcours.

Tout d'abord, je remercie sincèrement Monsieur Didier Buchs, mon directeur de thèse, pour sa supervision éclairée. Son expertise et sa rigueur scientifique ont grandement enrichi ce travail.

Je suis également reconnaissant envers Dr. Damien Morard et Mr. Aurélien Coet, les membres du laboratoire SMV qui m'ont accompagné dans ce projet. Leur expertise, leur soutien moral et leurs échanges enrichissants on su me donner un cadre stable où évoluer. Leur camaraderie a rendu cette expérience de recherche plus agréable et stimulante.

Un grand merci à Mr. Alexi Turcott et Mr. Jan Vitek, membres de l'université de Northeastern University, pour leur travail de recherche sur le langage R et l'élaboration d'un système de type. Leurs suggestions constructives et leurs encouragements pour ce projet de recherche. 

Je n'oublie pas Mr. John Coene, ainsi que la communauté des utilisateurs de R à Genève pour leur aide précieuse à comprendre les besoin actuels des statisticiens, scientifiques des données et constructeur de librairies. Leur expertise technique et leur feedback ont été d'une grande aide à la réalisation du design du langage.

À tous, je vous exprime ma profonde reconnaissance et mes remerciements les plus sincères.

#bibliography("works.bib")
