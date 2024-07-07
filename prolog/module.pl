:- module(module, [concat/3, unification/3]).

% concatenation de tableau
concat([], L, L).
concat([H | T], L, [H | R]) :-
	concat(T, L, R).


% prend deux listes et retourne une liste de couple d'éléement
unification([H1 | T1], [H2 | T2], Res) :-
	unification(T1, T2, Res1),
	Res = [[H1, H2] | Res1].

unification([], [], []).


:- begin_tests(my_test).
	test(t2) :- unification([1, 2, 3], [a, b, c], [[1, a], [2, b], [3, c]]).
:- end_tests(my_test).
