=== Le type embedding

Une notion intéressante que j'ai découvert dans le langage de programmation de Go est l'intégration de (type embedding). C'est un concept qui favorise la composition par rapport à l'héritage. 

L'héritage est un concept de la programmation orientée objet où une classe (dite sous-classe) hérite des propriétés et des méthodes d'une autre classe (dite super-classe). Cela permet de réutiliser le code existant et de créer des relations hiérarchiques entre les classes.

Dans le cadre du sous-typage, l'héritage permet à une sous-classe de se comporter comme une super-classe. Cela signifie qu'un objet de la sous-classe peut être utilisé partout où un objet de la super-classe est attendu. Le sous-typage garantit que la sous-classe respecte le contrat de la super-classe, c'est-à-dire qu'elle implémente ou redéfinit ses méthodes de manière compatible.

Bien que très utile pour la réutilisation de code, l'héritage présentes quelques fragilités qui rendent la maintenance du code difficile. L'héritage apporte un fort couplage entre les classes et leur sous-classes et peut "casser" ces dernières si les super-classes subissent des changements. 

La composition est plus flexible et permet un faible couplage, augmentant ainsi la maintenabilité du code. En revanche, on perd le gain de temps assuré par la réusabilité du code promu par l'héritage. C'est là où l'intégration de type intervient.

L'intégration de type permet la réusabilité du code en utilisant la composition. On peut "intégrer" un type en faisant une référence sur celui-ci depuis le type d'accueil. À partir de là, le type intégrant "hérite" des méthode de la classe intégrée. En réalité, le type parent prend les méthodes du même nom qui font appel aux méthodes du type intégré.

Malgré tout, cette propriété ne peut pas être représentée par le système de type de mon language puisqu'il relève plus de la métaprogrammation que de l'inférence de type. En effet, comparé à l'héritage, l'inclusion de type ne provoque pas de sous-typage. Dans le langage Go, il faut passer par les interface pour avoir cette notion de substitution. A ma déception, cette fonctionnalité n'a aucune propriétés intéressantes pour le typage. Cependant il va quand même dans l'idéologie de la simplicité qui a fait de Go un langage prisé par les développeur débutants.

Je profiterai de parler plus loin des autres fonctionnalités intéressantes qui rendrait le langage plus convivial et simple d'emploi pour les utilisateurs de R, mais qui ne présentent aussi très peu d'intérêt au niveau du typage
