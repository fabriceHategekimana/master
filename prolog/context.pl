:- module(context, [context_from/3, context_in_context/2, context_get_value/3, concat/3]).
:- use_module(module).

% prend une liste de paramètre [nom, type] puis retourne le nom seulement
get_variable([[V, T] | R], Res) :- get_variable(R, Res1), Res = [V | Res1].
get_variable([], []).

context_from(Parameters, Values, Res) :-
	get_variable(Parameters, Variables),
	unification(Variables, Values, Res).

context_in_context(var(X), [[var(X), Val] | T]).
context_in_context(var(X), [[var(Y), V] | T]) :-
	context_in_context(var(X), T).

context_get_value(var(X), [[var(X), Val] | T], Val).
context_get_value(var(X), [[var(Y), V] | T], Res) :-
	context_get_value(var(X), T, Res).


:- begin_tests(context_test).
	test(t1) :- get_variable([[1, a], [2, b], [3, c]], [1, 2, 3]).
	test(t2) :- context_from([[1, a], [2, b], [3, c]], [d, e, f], [[1, d], [2, e], [3, f]]).
	test(t3) :- context_get_value(var(x), [[var(x), 2], [var(y), 3], [var(z), 5]], 2).
	test(t4) :- \+ context_get_value(var(m), [[var(x), 2], [var(y), 3], [var(z), 5]], N).
	test(t5) :- context_in_context(var(y), [[var(x), 2], [var(y), 3], [var(z), 5]]).
	test(t6) :- context_get_value(var(x), [[var(x), 2]], 2).
:- end_tests(context_test).
