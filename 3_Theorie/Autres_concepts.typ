= Autres concepts <autre>

Dans le cadre de l'évolution de notre langage de programmation, nous exprimons un fort intérêt pour l'ajout de nouvelles fonctionnalités qui, bien que non discutées en détail ici, méritent une attention particulière. Notre focus principal a été sur les tableaux multidimensionnels et le typage des opérations associées, cependant, d'autres extensions potentiellement bénéfiques pourraient également être envisagées. Ces fonctionnalités supplémentaires s'inscriraient parfaitement dans la vision d'un futur projet de développement d'un système de types inspiré de R, reflétant sa philosophie de flexibilité et de puissance dans la manipulation de données. En intégrant ces nouvelles capacités, nous pourrions offrir une robustesse accrue et une expressivité améliorée à notre langage, alignant ainsi notre outil avec les attentes et les besoins des utilisateurs avancés dans des domaines variés tels que les statistiques, la science des données et l'analyse quantitative.

La communauté R rencontre plusieurs défis dans l'implémentation de la programmation orientée objet (POO), principalement en raison de la diversité des systèmes de POO disponibles. Contrairement à de nombreux langages de programmation qui adoptent un modèle unique et cohérent pour la POO, R offre plusieurs paradigmes distincts : S3, S4, R6 et le récent système basé sur les classes de référence. Cette pluralité de méthodes crée un environnement où les utilisateurs peuvent être confrontés à des choix déroutants, et où les différences entre ces systèmes peuvent conduire à des incompatibilités et à des difficultés d'intégration.

Le système S3, le plus ancien et le plus simple, est apprécié pour sa flexibilité et sa simplicité d'utilisation. Cependant, il manque de rigueur formelle, ce qui peut conduire à des comportements inattendus et à une gestion d'erreurs limitée. En contraste, le système S4 introduit une formalisation stricte des classes et des méthodes, avec une vérification des types plus rigoureuse, ce qui améliore la robustesse et la maintenabilité du code. Malgré ses avantages, S4 est souvent critiqué pour sa complexité et sa courbe d'apprentissage abrupte, ce qui peut dissuader les nouveaux utilisateurs.

Le système R6, introduit pour offrir une approche plus moderne et orientée vers la performance, permet la création de classes avec des champs et des méthodes, similaires aux objets dans des langages comme Python ou Java. Bien que R6 soit plus intuitif pour ceux ayant une expérience avec d'autres langages orientés objet, il n'est pas totalement intégré avec les systèmes S3 et S4, ce qui peut poser des problèmes d'interopérabilité dans des projets complexes qui utilisent plusieurs paradigmes de POO.

Cette multiplicité de systèmes de POO dans R peut non seulement semer la confusion parmi les utilisateurs, mais aussi engendrer des discordes sur la "meilleure" approche à adopter. Les développeurs peuvent avoir des préférences fortes basées sur leur familiarité avec un système particulier, conduisant à des débats au sein de la communauté sur les pratiques optimales. De plus, la documentation et les ressources pédagogiques peuvent être fragmentées, rendant l'apprentissage et la maîtrise de la POO en R plus ardus pour les nouveaux venus.

Ces fonctionnalité pourraient amener une meilleur implémentation de la programmation orientée objet ainsi que plusieurs avantage intéressantes dans la gestion de données.

== L'appel de fonction uniforme

L'appel de fonction uniforme, ou "uniform function call syntax" (UFCS), est un concept en programmation qui permet d'invoquer des fonctions de manière uniforme, indépendamment de leur définition en tant que méthodes d'une classe ou fonctions libres. Cela signifie que les fonctions peuvent être appelées de la même manière, qu'elles soient définies à l'intérieur d'une classe ou en dehors, améliorant ainsi la lisibilité et la flexibilité du code.

Par exemple, en utilisant l'UFCS, une fonction qui agit sur un objet peut être appelée comme une méthode de cet objet, même si elle n'est pas définie à l'intérieur de la classe de cet objet. Supposons qu'on ait une fonction libre `length(x)` et un objet `vec`. Avec l'UFCS, on pourrait appeler `vec.length()`, traitant `length` comme une méthode de `vec`. Cela permet aux développeurs de choisir l'appel le plus naturel ou le plus lisible pour leur contexte, sans se soucier de la localisation de la définition de la fonction.

L'UFCS est particulièrement utile dans les langages de programmation qui favorisent la composition fonctionnelle et la modularité. Par exemple, en C++, D, et Rust, l'UFCS permet d'appeler des fonctions de manière fluide et cohérente, réduisant la confusion entre les fonctions membres et les fonctions non membres. Cela encourage également la réutilisation du code, car les fonctions libres peuvent être facilement intégrées dans des chaînes d'appels de méthodes.

En R, l'adoption de l'UFCS pourrait potentiellement unifier les diverses méthodes de manipulation des objets, rendant le code plus intuitif et cohérent. Actuellement, la pluralité des systèmes de programmation orientée objet (POO) en R (comme S3, S4, et R6) entraîne des différences dans la manière dont les fonctions sont appelées et utilisées. L'introduction de l'UFCS pourrait atténuer certaines de ces divergences en permettant un style d'appel homogène, simplifiant ainsi l'interaction avec les objets et les fonctions.

== Typage nominal/structurel

Le typage nominal et le typage structurel sont deux approches distinctes pour la vérification des types dans les langages de programmation, chacune ayant ses avantages et inconvénients. Le typage nominal repose sur les noms des types pour déterminer la compatibilité entre eux. Deux types sont considérés comme compatibles si et seulement si ils portent le même nom ou si l’un est explicitement déclaré comme étant une sous-classe de l’autre. Ce système est courant dans des langages comme Java et C\#. L'avantage principal du typage nominal est la clarté et la sécurité qu'il procure : les relations de type sont explicites et faciles à comprendre, réduisant les risques d'erreurs de typage accidentelles. Cependant, il peut être rigide, car il nécessite souvent des déclarations répétitives et ne permet pas la compatibilité entre types structurellement similaires mais nominalement différents, limitant ainsi la flexibilité.

En revanche, le typage structurel se base sur la forme ou la structure des types pour vérifier leur compatibilité. Deux types sont compatibles si leurs structures internes (comme les champs et les méthodes) correspondent, indépendamment de leurs noms. Cette approche est utilisée dans des langages comme TypeScript et Go. Le principal avantage du typage structurel est sa flexibilité : il permet de traiter des objets de types différents mais ayant des structures similaires de manière interchangeable, facilitant ainsi la réutilisation du code et l'intégration de composants. Toutefois, le typage structurel peut introduire des ambiguïtés et des erreurs difficiles à diagnostiquer, car des types accidentellement similaires peuvent être considérés comme compatibles, menant potentiellement à des comportements inattendus.

Comme le langage R est un langage conçu pour être flexible, il aura un système de type qui favorisera le typage structurel avec l'usage de types comme les tableaux, les tuples ou les records (qui sont mentionnés après). Il y aura tout de même l'opportunité de passer au typage nominal à l'aide du concept de named tuple.

=== Records

Par défaut, le langage R n'utilise pas de classe, mais émule un système similaire à l'aide de label. Le langage que nous formons n'implémentera pas de classe avec des méthodes mais permettra de créer des types avec des fonctions dédiées. L'un des types les plus proche des classes sont les records. Ils n'ont pas le pouvoir d'héritages comme les classes mais offrent d'autres pouvoir plus intéressants.

Les records et les classes sont des concepts fondamentaux en programmation orientée objet et en gestion de données structurées, chacun ayant des avantages distincts selon le contexte d'utilisation. Les records, ou structures, sont des types de données simples qui regroupent un ensemble de champs ou de valeurs sous un même nom. Ils sont souvent utilisés pour représenter des données immuables et peuvent être comparés par leurs valeurs. Un avantage majeur des records est leur simplicité et leur efficacité pour représenter des données de manière directe et sans comportement associé. Cela les rend particulièrement adaptés pour la représentation de données de configuration, de résultats de calculs ou d'états immuables.

En revanche, les classes sont des structures plus complexes qui combinent à la fois des données (champs) et des comportements (méthodes). Elles permettent de définir des objets avec un état interne modifiable et des opérations spécifiques qui peuvent manipuler cet état. Les classes offrent une encapsulation des données et un haut niveau d'abstraction, facilitant ainsi la modélisation de concepts complexes et la gestion de l'état mutable. Un avantage clé des classes est leur capacité à encapsuler le comportement avec les données, promouvant ainsi la réutilisation du code et la modularité.

Cependant, les classes peuvent aussi introduire de la complexité, notamment en matière d'héritage et de gestion de la hiérarchie des classes. L'héritage multiple, par exemple, peut poser des défis de conception et de maintenance en introduisant des dépendances et des relations complexes entre les classes. De plus, la gestion de l'état mutable peut parfois conduire à des erreurs difficiles à diagnostiquer, telles que les problèmes de concurrence dans les environnements multi-threadés.

En comparaison, les records sont souvent plus simples à utiliser et à raisonner, mais peuvent être limités lorsque des comportements complexes doivent être associés aux données. Le choix entre records et classes dépend donc largement des besoins spécifiques du projet : les records sont souvent préférés pour la représentation de données simples et immuables, tandis que les classes sont utilisées pour modéliser des entités avec un état interne mutable et des comportements associés. En résumé, bien que les records et les classes aient des rôles distincts, ils offrent chacun des avantages significatifs en fonction du contexte d'utilisation et des exigences du projet.

=== Sous-typage

Le sous-typage est une part du polymorphism et a souvent été utilisé en programmation orienté objet à l'aide de l'héritage. Avec notre langage qui a une orientation fonctionnelle comme R, nous laissons ce context au profit d'autres méthodes de sous typage.

On peut mentionner l'usage d'interfaces qui permettrons à toutes les types les implémentant d'être considérés de "sous-type" car ils respectent les contrats imposés par par les dits interfaces. Ici les interfaces ne seront pas aussi puissant que dans le langage Rust mais permettrons d'implémenter des fonctions par défaut. Ils ne se baseront pas sur des génériques mais pourront être combinés pour créer de plus grandes interfaces. Nous aurons ainsi un peu plus de puissance et de flexibilité sans apporter trop de complexité.

Dans le contexte du sous-typage, un record peut aussi être considéré comme un sous-type d'un autre s'il possède tous les champs de ce dernier, éventuellement avec quelques champs supplémentaires. Par exemple, si nous avons un record `Person` avec des champs `name` et `age`, et un record `Employee` qui ajoute un champ `id` à ceux de `Person`, alors `Employee` est un sous-type de `Person`.

Le polymorphisme de ligne, quant à lui, permet de définir des types en termes de lignes de champs plutôt qu'en termes de noms de types fixes. Cela offre une flexibilité significative dans la définition et l'utilisation des types de données, car les types peuvent être étendus dynamiquement avec de nouveaux champs sans nécessiter de redéfinition explicite du type. Par exemple, un type polymorphe pourrait être défini comme ayant au moins certains champs spécifiques, mais la présence d'autres champs est autorisée et traitée de manière flexible.

L'interaction entre le sous-typage et le polymorphisme de ligne permet donc de créer des structures de données qui peuvent être étendues tout en maintenant les relations de sous-typage. Cela signifie qu'un code qui s'attend à manipuler un type plus général peut également interagir avec des instances de types plus spécifiques qui ajoutent des champs supplémentaires. Cette approche favorise la réutilisation du code et la gestion dynamique des données, car elle permet de traiter les types de manière plus générique tout en prenant en charge des variations spécifiques au sein de ces types, améliorant ainsi la flexibilité et l'expressivité du système de types.

=== Dataframe

Les dataframes sont des structures de données cruciales en sciences des données, particulièrement dans le langage de programmation R, en raison de plusieurs caractéristiques et fonctionnalités qui répondent aux besoins spécifiques de l'analyse de données.

Tout d'abord, les dataframes permettent de stocker et d'organiser des données tabulaires sous forme de lignes et de colonnes, où chaque colonne peut représenter une variable différente et chaque ligne correspond à une observation ou un enregistrement unique. Cette organisation est essentielle pour traiter et manipuler des ensembles de données complexes et hétérogènes provenant de diverses sources, comme des fichiers CSV, des bases de données ou des résultats d'expérimentations.

Ensuite, R est spécialement conçu pour le traitement statistique et graphique des données. Les dataframes offrent une structure de données optimisée pour les opérations statistiques courantes telles que le calcul de moyennes, de médianes, de corrélations, et la création de graphiques. Ils facilitent également la manipulation des données grâce à une large gamme de fonctions intégrées et de packages spécialisés dédiés à la manipulation, à la transformation et à l'analyse de dataframes.

De plus, les dataframes en R sont conçus pour être compatibles avec les autres outils et méthodes statistiques de la langue. Ils s'intègrent parfaitement aux fonctions de modélisation statistique, aux tests d'hypothèses, à l'analyse de variance, à la régression linéaire et non linéaire, ainsi qu'à la visualisation de données avancées. Cette intégration transparente permet aux scientifiques des données et aux analystes de travailler efficacement avec des données volumineuses tout en conservant la capacité d'appliquer des techniques statistiques sophistiquées.

Enfin, les dataframes facilitent la collaboration et le partage de données au sein d'une équipe de travail. Leur structure tabulaire standardisée et leur manipulation aisée permettent à différents analystes et chercheurs de travailler sur les mêmes données, en utilisant des méthodes cohérentes et reproductibles. Cela contribue à la transparence des analyses et à la vérifiabilité des résultats, des aspects essentiels dans le domaine scientifique et académique.

Si nous représentons les dataframes sous la forme de record de tableau (à 1 dimension) alors nous ouvrons la porte à une nouvelle façon de définir les opérations sur ces éléments. À l'aide du polymorphisme de rang discuté plus tôt, nous somme en mesure de developper des fonctions agissantes sur des dataframes aillants des colonnes spécifique et d'un type spécifique, facilitant la création de package sécurisés.

== Gestion d'erreur

La gestion des erreurs est un aspect crucial de la programmation moderne, essentiel pour assurer la fiabilité, la sécurité et la robustesse des applications logicielles. Les erreurs peuvent survenir pour diverses raisons : des données d'entrée invalides, des opérations non valides, des erreurs réseau, ou encore des bugs logiciels. Traiter ces erreurs de manière efficace est nécessaire pour garantir que l'application continue de fonctionner de manière prévisible et stable, même face à des conditions imprévues.

Les sum types (ou types somme) et les union types sont des concepts fondamentaux en programmation qui permettent de représenter des valeurs qui peuvent être de différents types. Ils offrent une façon élégante et expressive de modéliser des situations où une valeur peut prendre plusieurs formes possibles. Par exemple, un type union peut représenter une valeur numérique valide ou une valeur NaN pour indiquer un calcul incorrect.

Dans le contexte de la gestion des erreurs, les union types offrent une flexibilité particulière en permettant de représenter explicitement les cas où une opération peut échouer ou retourner un résultat indéterminé comme NaN. Cela permet aux développeurs de définir des fonctions et des structures de données capables de traiter ces situations de manière cohérente et prévisible. Par exemple, au lieu de retourner une valeur incorrecte ou de provoquer une exception non contrôlée, une fonction peut retourner un type union qui indique clairement si le calcul a réussi ou a produit une valeur non valide.

Cette approche renforce également la documentation du code et l'interopérabilité avec d'autres systèmes, car elle clarifie les attentes quant aux résultats des fonctions et aux données manipulées. En outre, les union types permettent de gérer de manière efficace les valeurs manquantes ou non valides dans les analyses de données, un aspect crucial dans les applications de science des données où des données manquantes ou incorrectes sont fréquentes et doivent être gérées avec soin pour éviter des résultats incorrects ou biaisés.