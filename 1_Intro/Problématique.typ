Comme l'essentiel des outils de sciences de données sont basées sur des langage de programmation dynamiques et souvent faiblement typé, nous rencontrons les problèmes qu'ils génèrent. Le premier problème vient de la maintenance. De par leur nature dynamique. Ces langages ont tendance à faire des "arrangement" en arrière plan et ne permettent pas d'assurer une lecture fidèle à l'execution du code. Cela rend difficile la création de librairies, modules ou packages. Heureusement la plus part de ces langages utilisent un système de type mais (sauf dans le cas de mojo) reste assez laxiste dans l'évaluation du code et une grande partie de la gestion des erreurs et laissé au temps d'exécution. C'est pourquoi cette tâche est laissée à des langages plus performants et mieux typés comme C++ pour créer des librairies. Le problème de ces dernier est qu'on ne trouve pas vraiment de système de type pour la gestion de tableaux multidimensionnels, ce qui est l'un des points les plus essentiels des sciences de données.

Des langages comme haskell combinés à des types dépendants (TODO références) a permis le typage et la vérification correcte de quelques concepts du domaines des tableaux multidimensionnels et de leur lien avec l'algèbre linéaire. Le soucis de ces langages vient du fait qu'ils sont trop "abstrait" et difficilement abordables pour l'ingénieur moyen.

Il n'y a donc pas de moyen raisonablement accessible qui améliore la productivité lors de la construction de librairies pour les sciences de données. C'est là le but de ce projet.

// TODO: parler des autres problèmes courants dans le developpement des sciences de données
