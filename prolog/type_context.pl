:- module(type_context, [in_context/2, get_types/2, get_type/3]).

in_context(var(X), [[var(X), Type] | T]).
in_context(var(X), [[var(Y), V] | T]) :-
	in_context(var(X), T).


get_type(var(X), [[var(X), Type] | T], Type).
get_type(var(X), [[var(Y), V] | T], Res) :-
	get_type(var(X), T, Res).

get_type(var(X), [], any).


% prend une liste de paramètre [nom, type] puis retourne le nom seulement
get_types([[V, T] | R], Res) :-
	get_types(R, Res1), Res = [T | Res1].
get_types([], []).

