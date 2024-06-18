#import "../src/module.typ" : *

#pagebreak()

= Introduction


== Context
Aujourd'hui les science des données jouent un rôle capital dans la dynamique de nos sociétés. Avec internet, les réseaux sociaux et même des domaines comme l'IoT, une quantité immense de données sont générées quotidiennement. C'est ce que l'on appel le Big Data. De plus la données est considérée comme le nouveau pétrol: Elle a beaucoup de valeur seulement dans le cas où on est capable de la rafiner. C'est pourquoi on a vu l'essort de plusieurs métiers basés sur la donnée. Nous avons notamment les métier de data analyst, data engineer, ML engineer ou bien même data scientist.

Les sciences des données sont basée sur les mathématiques, l'informatique et l'expertise sur un domaine donné. Les mathématiques principalement utilisées en sciences des données sont l'algèbre, les probabilités, les statistiques ou bien même la théorie de l'information. Ces connaissances sont cruciales pour faire de l'analyse de données, du machine learning ou simplement du nettoyage de données. Il faut noter qu'une grande partie du travail fait sur des données reposent sur les tableaux multidimensionnels.

Les tableaux multidimensionnels jouent un rôle crucial dans les sciences de données en raison de leur capacité à organiser et à manipuler efficacement des ensembles de données complexes. Contrairement aux tableaux unidimensionnels, qui ne permettent que de stocker des données de manière linéaire, les tableaux multidimensionnels permettent de représenter des structures de données plus riches, telles que des matrices, des tenseurs et des cubes de données. Cette capacité est essentielle pour traiter des jeux de données volumineux et hétérogènes provenant de diverses sources, telles que des expérimentations scientifiques, des bases de données transactionnelles et des données collectées en temps réel.

En sciences de données, les tableaux multidimensionnels facilitent la manipulation et l'analyse de données à haute dimensionnalité, souvent nécessaires pour modéliser des phénomènes complexes et interdépendants. Par exemple, dans l'apprentissage automatique, les images peuvent être représentées sous forme de tableaux multidimensionnels où chaque dimension correspond à une caractéristique spécifique de l'image (comme la hauteur, la largeur et les canaux de couleur). De même, dans l'analyse de séries temporelles ou de données spatiales, les tableaux multidimensionnels permettent de capturer des variations complexes dans le temps ou dans l'espace.

De plus, les opérations sur les tableaux multidimensionnels sont optimisées pour les calculs numériques et statistiques, offrant des performances améliorées par rapport aux structures de données plus simples. Les bibliothèques et les frameworks spécialisés, tels que NumPy en Python et les fonctions intégrées de manipulation de données en R, sont conçus pour exploiter efficacement les capacités des tableaux multidimensionnels, permettant ainsi aux scientifiques des données et aux analystes de réaliser des calculs sophistiqués avec une grande efficacité et précision.

Les experts du domaines utilisent le plus souvent des langages de programmation dynamiques tel que Python, R ou Julia. Ils ont l'avantage de permettre un prototypage rapide et un passage a un code de production avec peu de friction. Dans le domaine des sciences des données, Python est le langage le plus populaire car il dispose de la syntaxe la plus facile ainsi qu'une quatité importante de module qui vont bien au dela des applications sur les données.

Malgré sa notoriété, python a été aussi critiqué pour certaines de ses faiblesses. Il est considéré comme l'un des langage les plus lent, ce qui a poussé la communauté à developper des modules comme numpy ou panda ou l'essentiel des calcules sont fait dans des langage de plus bas niveau et plus rapides comme C/C++. De plus l'abscence de définition de type peut rendre du code compliqué à maintenir (pour la création de modèles par exemple). Python propose aussi un paradigme de programmation orienté objet mais qui peut présenter de mauvaise pratique pour la définition de code et la modélisation de principes théoriques.

Python utilise des librairies comme numpy, tensorflow ou pytorch pour créer des modèles pour les sciences des données. Toutes ces librairies ont en commun leur rapidité et la simplicité de leur API. Le problème rencontré vient surtout du système de type de python qui ne permet pas de saisir la forme des tableaux multidimensionnels (ou tenseurs) et de ce fait, ne permet aucune intelligence pour aider le scientifiques des donnée/developpeur construir une librairie solide. En effet, on se rend compte qu'un système de type efficace aide beaucoup lorsqu'on a des projet de plus grande envergure. C'est ce qu'on peut voir lorsqu'on jette un oeil sur les modèles GPT qui présentent une vingtènes de couches qui peuvent donner assez rapidement du code spaghetti si on ne fait pas attention à la justesse de notre programme.

