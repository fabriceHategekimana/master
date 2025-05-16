#import "../src/theorem.typ" : *

== Réseaux de neurones (forward propagation)

Nous pouvons facilement constater qu'une couche d'un réseau de neuronnes ainsi que la fonction d'activation peuvent être représentés comme des fonctions sur des vecteurs (de deux dimensions). Un réseaux de neuronnes n'est seulement qu'une suite d'application de fonctions. Par exemple le passage d'un vecteur sur un réseaux de 3 couches serait représenté comme ceci:

#Exemple()[Combinaison de fonction à l'aide de système C3PO
```typescript
let couche1: type = ... in
let activation1: type = ... in
let couche2: type = ... in
let activation2: type = ... in
let couche3: type = ... in
let activation3: type = ... in
  activation3(couche3(activation2(couche2(activation1(couche1(v))))))
```
]

Heureusement, il existe plusieurs solution syntaxique qui nous permettent de facilité la lecture d'un tel réseau. Ces solutions ne font pas directement partie du noyaux du projet mais permettrait une implémentation plus concrète du typage de réseaux. La notion d'appel de fonction uniforme qui nous permet d'avoir une représentation plus lisible à l'oeil humain à l'aide d'un outil de composition de fonction appelé le tyau représenté par ce symbole "|>":

#Exemple()[Combinaison de fonction à l'aide de tuyaux
```typescript
v 
  |> couche1
  |> activation1
  |> couche2
  |> activation2
  |> couche3
  |> activation3
```
]

Pour les personnes plus adepte du passage par message:

#Exemple()[combinaison de fonction à l'aide de passage de message
```typescript
v
.couche1()
.activation1()
.couche2()
.activation2()
.couche3()
.activation3()
```
]

Ces deux exemples seront transformé pour donné le premier exemple durant la compilation. Cela nous permet plus de flexibilité dans la notation. Non seulement nous sommes capable de représenter les réseaux de neuronnes de façon plus simplifié, mais nous avons aussi la garanti de contrôl au niveau de la compatibilité d'application de ces fonctions. Si la sortie d'une de ces fonction ne correspond pas à la sortie de la suivant, le compilateur sera en mesure de détecter ce problème. Cela permet donc de cérer des réseaus de neuronnes de plus grande envergure de façon plus sûre.
