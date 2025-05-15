:- module(type_context, [in_context/2, get_right_elements/2, get_right_element/3, concat_context/3]).

in_context(var(X), [[var(X), Type] | T]).
in_context(var(X), [[var(Y), V] | T]) :-
	in_context(var(X), T).

in_context(gen(X), [[gen(X), Type] | T]).
in_context(gen(X), [[gen(Y), V] | T]) :-
	in_context(gen(X), T).

get_right_element(var(X), [[var(X), Type] | T], Type).
get_right_element(var(X), [[var(Y), V] | T], Res) :-
	get_right_element(var(X), T, Res).

get_right_element(var(X), [], any).


get_right_element(gen(X), [[gen(X), Type] | T], Type).
get_right_element(gen(X), [[gen(Y), V] | T], Res) :-
	get_right_element(gen(X), T, Res).

get_right_element(gen(X), [], any).


% prend une liste de paramètre [nom, type] puis retourne le nom seulement
get_right_elements([[V, T] | R], Res) :-
	get_right_elements(R, Res1), Res = [T | Res1].
get_right_elements([], []).

concat_context(context(Kinds1, Types1), context(Kinds2, Types2), context(Kinds3, Types3)) :-
	concat(Kinds1, Kinds2, Kinds3),
	concat(Types1, Types2, Types3).
	

