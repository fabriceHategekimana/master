:- use_module(type_context).
:- use_module(module).

% type place holder
tph.

 % FUNC as value
typing(
	Context, 
	func(Generics, Parameters, Type, E), 
	t_func(Generics, Parameters2, Type)) :-
	get_types(Parameters, Parameters2),
	concat(Context, Parameters, Context2),
	typing(Context2, E, Type).
 
% boolean as values
typing(Context, true, bool).
typing(Context, false, bool).

% NUM
typing( Context, X, int) :- number(X).

% PLUS
typing(
	Context,
	plus(A, B),
	int) :- 
		typing(Context, A, int),
		typing(Context, B, int).

% TIMES
typing(
	Context, 
	time(A, B), 
	int) :-
		typing(Context, A, int),
		typing(Context, B, int).
 
% EQ
typing(
	Context, 
	eq(X, Y),
	bool) :-
		typing(Context, X, Z),
		typing(Context, Y, Z).

% GRT
typing(
	Context, 
	grt(X, Y),
	bool) :-
		typing(Context, X, int),
		typing(Context, Y, int).

% LOW
typing(
	Context, 
	low(X, Y),
	bool) :-
		typing(Context, X, int),
		typing(Context, Y, int).

% GRT-EQ
typing(
	Context, 
	gte(X, Y),
	bool) :-
		typing(Context, X, int),
		typing(Context, Y, int).

% LOW-EQ
typing(
	Context, 
	lwe(X, Y),
	bool) :-
		typing(Context, X, int),
		typing(Context, Y, int).

% AND
typing(Context, and(A, B), bool) :-
	typing(Context, A, bool),
	typing(Context, B, bool).
 
% OR
typing(Context, or(A, B), bool) :-
	typing(Context, A, bool),
	typing(Context, B, bool).
 
% IF-T

typing(Context,
	if(E1, E2, E3),
	T) :-
		typing(Context, E1, bool),
		typing(Context, E2, T),
		typing(Context, E2, T).

% VAR
typing(
	Context,
	var(X),
	T) :-
		% in_context(var(X), Context),
		get_type(var(X), Context, T).


match_gen([gen(X) | T1], [Ty | T2], G) :-
	match_gen(T1, T2, G2),
	G = [[gen(X), Ty] | G2].

match_gen([Ty | T1], [gen(X) | T2], G) :-
	match_gen(T1, T2, G2),
	G = [[gen(X), Ty] | G2].

match_gen([], [], []).

% substitute_with(t_array(gen(n), gen(t)), [[gen(n), 1], [gen(t), bool]], T).

substitute_with(t_array(gen(X), B), [[gen(X), Ty] | T], t_array(Ty, Res)) :-
	substitute_with(B, T, Res).

substitute_with(t_array(t_plus(A, B), gen(Y)), Gens, t_array(Res1, Res2)) :-
	substitute_with(t_plus(A, B), Gens, Res1),
	substitute_with(gen(Y), Gens, Res2).

substitute_with(t_array(A, gen(Y)), [[gen(Y), Ty] | T], t_array(Res, Ty)) :-
	substitute_with(A, T, Res).


substitute_with(t_plus(gen(X), gen(X)), [[gen(X), Ty] | T], t_plus(Ty, Ty)).

substitute_with(t_plus(gen(X), Arg), [[gen(X), Ty] | T], t_plus(Ty, Res)) :-
	substitute_with(Arg, T, Res).

substitute_with(t_plus(Arg, gen(X)), [[gen(X), Ty] | T], t_plus(Res, Ty)) :-
	substitute_with(Arg, T, Res).


substitute_with(gen(X), [[gen(X), Ty] | T], Ty).
substitute_with(gen(X), [[gen(Y), Ty] | T], Ty2) :-
	substitute_with(gen(X), T, Ty2).

% substitute_with(N, Gens, N) :- number(N).
substitute_with(X, Gens, X).
% substitute_with(X, [], X).

% apply_gen(
	% [[gen(n), 1], [gen(t), bool]],
	% [t_array(gen(n), gen(t)), gen(t)],
	% T).

apply_gen([], X, X).

apply_gen(Gen_type, [Z | T2], P) :-
	substitute_with(Z, Gen_type, Zp),
	apply_gen(Gen_type, T2, T3),
	P = [Zp | T3].	

apply_gen(Gen_type, [], []).

% typing([], par([[true], false]), t_par(_63250))
typing(
	Context,
	par([H | T]),
	t_par(Res)) :-
		typing(Context, H, Hp),
		typing(Context, par(T), t_par(Tp)),
		Res = [Hp | Tp].

typing( Context, par([]), t_par([])).

% match_par([t_array(1, bool), bool], [1, bool], T).
%
match_par([Ty | T1], [gen(X) | T2], Res) :-
	match_par(T1, T2, Res2),
	Res = [[gen(X), Ty] | Res2].

match_par([Ty | T1], [Ty | T2], Res) :-
	match_par(T1, T2, Res).

% NEW
match_par([Ty1 | T1], [Ty2 | T2], Res) :-
	match_par(T1, T2, Res).

match_par([], [], []).

% apply_par([], t_array(t_plus(gen(n), 1), gen(t)), t_array(2, bool)).
	

apply_par([], X, X).

apply_par(GenFinal, t_array(N, T), t_array(Np, Tp)) :-
	apply_par(GenFinal, N, Np),
	apply_par(GenFinal, T, Tp).

apply_par(GenFinal, t_func(G, P, T), t_func(G, Pp, Tp)) :-
	apply_par(GenFinal, P, Pp),
	apply_par(GenFinal, T, Tp).

apply_par(GenFinal, [Ty | T], Res) :-
	apply_par(GenFinal, Ty, Typ),
	apply_par(GenFinal, T, Tp),
	Res = [Typ | Tp].


apply_par(GenFinal, [], []).

apply_par([[gen(X), Ty] | T], gen(X), Ty).
apply_par([[gen(X), Ty] | T], gen(Y), Ty2) :-
	apply_par(T, gen(Y), Ty2).

% apply_par final
apply_par([H | T], X, X).

% FUNC-APP
typing(
	Context,
	app(E, G, par(P)),
	T) :-
		typing(Context, E, t_func(G2, P2, T2)),
		typing(Context, par(P), t_par(PTy)),
		match_gen(G, G2, Gens),
		apply_gen(Gens, P2, P2Gen),
		apply_gen(Gens, [T2], [T3]),
		calc(T3, T).
		% match_par(PTy, P2Gen, Final),
		% apply_par(Final, T2, T).

typing(
	Context,
	let(var(X), T, E, E2),
	T) :-
		typing(Context, E, T2),
		append(Context, [[var(X), T]], Context2),
		typing(Context2, E2, T).

match_type(any, any, Ty).
match_type(any, Ty, Ty).
match_type(Ty, any, Ty).
match_type(Ty, Ty, Ty).

index_calc(M, M) :- 
	number(M).

index_calc(gen(X), gen(X)).


index_calc(t_plus(A, B), C) :-
	index_calc(A, Ap),
	index_calc(B, Bp),
	number(Ap),
	number(Bp),
	C is A + B.

index_calc(t_plus(A, B), t_plus(Ap, Ab)) :-
	index_calc(A, Ap),
	index_calc(B, Bp).

calc(t_array(t_plus(A, B), C), t_array(D, C)) :-
	index_calc(t_plus(A, B), D).

calc(X, X).

typing(
	Context,
	array([H | T]),
	t_array(M, Ty3)) :-
		typing(Context, H, Ty),
		typing(Context, array(T), t_array(N, Ty2)),
		match_type(Ty, Ty2, Ty3),
		index_calc(t_plus(N, 1), M).

typing(
	Context,
	array([]),
	t_array(0, any)).

typing(
	Context,
	array(var(X)),
	T) :-
	get_type(var(X), Context, T).

% typing(
% [[var(a), t_array(gen(n), gen(t))], [var(e), gen(t)]],
% concat(var(a), array([var(b)])),
% t_array(t_plus(gen(n), 1), gen(t))
% ).

typing(
	Context,
	concat(A1, A2),
	t_array(O, Ty)) :-
		typing(Context, A1, t_array(M, Ty)),
		typing(Context, A2, t_array(N, Ty)),
		index_calc(M, Mp),
		index_calc(N, Np),
		index_calc(t_plus(Mp, Np), O).
		



% FIRST
typing(Context, first(array(A)), Ty) :-
	typing(Context, array(A), t_array(M, Ty)).

% REST
typing(Context, rest(array(A)), t_array(N, Ty)) :-
	typing(Context, array(A), t_array(M, Ty)),
	N is M - 1.


:- begin_tests(test_typing).
	test(t0) :- typing([], true, bool).
	test(t1) :- typing([], 7, int).
	test(t1) :- typing([], plus(7, 7), int).
	test(t2) :- typing([], time(7, 7), int).
	test(t3) :- typing([], eq(12, time(3, 4)), bool).
	test(t4) :- typing([], grt(19, time(3, 4)), bool).
	test(t5) :- typing([], low(10, time(3, 4)), bool).
	test(t6) :- typing([], gte(12, time(3, 4)), bool).
	test(t8) :- typing([], lwe(12, time(3, 4)), bool).
	test(t9) :- typing([], lwe(10, time(3, 4)), bool).
	test(t10) :- typing([], and(true, false), bool).
	test(t11) :- typing([], or(true, false), bool).
	test(t12) :- typing([], if(true, 7, 9), int).
	test(t13) :- typing([[var(x), bool]], var(x), bool).
	test(t14) :- typing([], func([], [], int, 7), t_func([], [], int)).
	test(t15) :- typing([], 
		func([], [[var(x), int], [var(y), int]], int, plus(var(x), var(y))), 
		t_func([], [int, int], int)).
	test(t16) :- typing([], let(var(x), int, 7, var(x)), int).
	test(t17) :- typing([], array([]), t_array(0, any)).
	test(t18) :- typing([], array([1, plus(2, 3), 3]), t_array(3, int)). 
	test(t19) :- typing([], concat(array([1, 2]), array([3, 4])), t_array(4, int)).
	test(t20) :- typing([], first(array([1, 2, 3])), int).
	test(t21) :- typing([], rest(array([1, 2, 3])), t_array(2, int)).
	test(t22) :- typing([], array([array([1, 2]), array([1, 3])]), t_array(2, t_array(2, int))).
	test(t23) :- typing([], func([], [[var(a), int]], int, var(a)), t_func([], [int], int)).
	test(t24) :- typing([], func([T], [[var(a), T]], T, var(a)), t_func([T], [T], T)).
	test(t25) :- typing([],
		app(
			func([gen(t)], [[var(a), gen(t)]], gen(t), var(a)),
			[int],
			par([7])
		),
		int
		).
	test(t26) :- typing([], 
		app(
			func([], [[var(a), int], [var(b), int]], int, plus(var(a), var(b))),
			[],
			par([3, 4])
			),
		int).
	test(t27) :- typing([],
		func([gen(n), gen(t)], [[var(a), t_array(gen(n), gen(t))], [var(e), gen(t)]], t_array(t_plus(gen(n), 1), gen(t)),
			concat(var(a), array([var(b)]))
			),
			t_func([gen(n), gen(t)], [t_array(gen(n), gen(t)), gen(t)], t_array(t_plus(gen(n), 1), gen(t)))).
	test(t28) :- typing([], 
		app(
		func([gen(n), gen(t)], [[var(a), t_array(gen(n), gen(t))], [var(e), gen(t)]], t_array(t_plus(gen(n), 1), gen(t)),
			concat(var(a), array([var(b)]))
			),
			[1, bool],
			par([array([true]), false])
			),
			t_array(2, bool)
		).
:- end_tests(test_typing).

