:- use_module(type_context).
:- use_module(match).
:- use_module(module).

% le contexte est représenter comme un couple Kind, Typage. Donc context(Kind, Typage)
% le contexte Typage va faire un mappage des variable aux types
% le contexte Kind va faire un mappage des génériques aux kinds

% T-FUNC
typing(
	Context, 
	func(Generics, Parameters, Type, E), 
	t_func(Generics, Types, Type)) :-
	get_right_elements(Parameters, Types),
	concat_context(Context, context(Generics, Parameters), Context2),
	typing(Context2, E, Type).
 
% boolean
typing(Context, true, bool).
typing(Context, false, bool).

% NUM
typing(Context, X, int) :- number(X).

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

% VAR with generic
typing(
	context(Kinds, Types),
	var(X),
	gen(T)) :-
		get_right_element(var(X), Types, gen(T))
		get_right_element(gen(T), Y).

% VAR with the rest
typing(
	context(Kinds, Types),
	var(X),
	T) :-
		get_right_element(var(X), Types, T).

typing(
	context(Kinds, Types),
	gen(X),
	T) :-
		get_right_element(gen(X), Kinds, T).

% typing a list of parameters
typing(
	Context,
	par([H | T]),
	t_par(Res)) :-
		typing(Context, H, Hp),
		typing(Context, par(T), t_par(Tp)),
		Res = [Hp | Tp].

typing(Context, par([]), t_par([])).

kind(N, k_type) :- number(N).
kind(T, Type) :- is_type(Type).

kinding([[Type, Kind] | T]) :-
	kind(Type, Kind),
	kinding(T).

kinding([]).

substitute([[gen(X), Ty] | T], gen(X), Ty).
substitute([[gen(X), Ty] | T], gen(Y), Ty2) :-
	substitute(T, gen(Y), Ty2).

substitute(GenFinal, [], []).

substitute(Sub, kinds([[K, Ki] | Rest]), Kps) :-
	substitute(Sub, K, Kp),
	substitute(Sub, kinds(Rest), Ks),
	Kps = [[Kp, Ki] | Ks].

substitute(Sub, kinds([]), []).

substitute([], X, X).

substitute(GenFinal, t_array(N, T), t_array(Np, Tp)) :-
	substitute(GenFinal, N, Np),
	substitute(GenFinal, T, Tp).

substitute(GenFinal, t_func(G, P, T), t_func(G, Pp, Tp)) :-
	substitute(GenFinal, P, Pp),
	substitute(GenFinal, T, Tp).

substitute(GenFinal, [Ty | T], Res) :-
	substitute(GenFinal, Ty, Typ),
	substitute(GenFinal, T, Tp),
	Res = [Typ | Tp].

substitution(Sub, t_func(Ks, Ts, Tp), T) :-
	substitute(Sub, kinds(Ks), Kps),
	kinding(Kps),
	substitute(Sub, Ts, Tps),
	substitute(Tp, T).

% T-APP
typing(
	Context,
	app(E1, Ks, par(E2)),
	T) :-
		typing(Context, E1, t_func(Ks, Ts, Tp)),
		concat_context(Context, context(Ks, []), Context2),
		typing(Context2, par(E2), t_par(E2p)),
		get_right_elements(Ks, Kps),
		match(Ts, E2p, Sub),
		substitution(Sub, t_func(Ks, Ts, Tp), T).
		% perhaps check if all generics the user write exist in the context.


typing(
	context(Kinds, Types),
	let(var(X), T, E, E2),
	T) :-
		typing(Context, E, T2),
		append(Types, [[var(X), T]], Types2),
		typing(context(Kinds, Types2), E2, T).

% TODO pour éviter la création de liste vide
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
	get_right_element(var(X), Context, T).


typing(
	Context,
	concat(E1, E2),
	t_array(O, Ty)) :-
		typing(Context, E1, t_array(M, Ty)),
		typing(Context, E2, t_array(N, Ty)),
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

my_typing(Term, Res) :- typing(context([], []), Term, Res).


:- begin_tests(test_typing).
	test(t0) :- my_typing(true, bool).
	test(t1) :- my_typing(7, int).
	test(t1) :- my_typing(plus(7, 7), int).
	test(t2) :- my_typing(time(7, 7), int).
	test(t3) :- my_typing(eq(12, time(3, 4)), bool).
	test(t4) :- my_typing(grt(19, time(3, 4)), bool).
	test(t5) :- my_typing(low(10, time(3, 4)), bool).
	test(t6) :- my_typing(gte(12, time(3, 4)), bool).
	test(t8) :- my_typing(lwe(12, time(3, 4)), bool).
	test(t9) :- my_typing(lwe(10, time(3, 4)), bool).
	test(t10) :- my_typing(and(true, false), bool).
	test(t11) :- my_typing(or(true, false), bool).
	test(t12) :- my_typing(if(true, 7, 9), int).
	test(t13) :- typing(context([], [[var(x), bool]]), var(x), bool).
	test(t14) :- my_typing(func([], [], int, 7), t_func([], [], int)).
	test(t15) :- my_typing(
		func([], [[var(x), int], [var(y), int]], int, plus(var(x), var(y))), 
		t_func([], [int, int], int)).
	test(t16) :- my_typing(let(var(x), int, 7, var(x)), int).
	test(t17) :- my_typing(array([]), t_array(0, any)).
	test(t18) :- my_typing(array([1, plus(2, 3), 3]), t_array(3, int)). 
	test(t19) :- my_typing(concat(array([1, 2]), array([3, 4])), t_array(4, int)).
	test(t20) :- my_typing(first(array([1, 2, 3])), int).
	test(t21) :- my_typing(rest(array([1, 2, 3])), t_array(2, int)).
	test(t22) :- my_typing(array([array([1, 2]), array([1, 3])]), t_array(2, t_array(2, int))).
	test(t23) :- my_typing(func([], [[var(a), int]], int, var(a)), t_func([], [int], int)).
	test(t24) :- 
		my_typing(func([[gen(t), k_type]], [[var(a), gen(t)]], gen(t), var(a)), t_func([[gen(t), k_type]], [gen(t)], gen(t))).

	test(tt24) :- my_typing(
			func([[gen(t), k_type]], [[var(a), gen(t)]], gen(t), var(a)),
			t_func([[gen(t), k_type]], [gen(t)], gen(t))
		).
	
	test(t25) :- my_typing(
		app(
			func([[gen(t), k_type]], [[var(a), gen(t)]], gen(t), var(a)),
			[[gen(t), k_type]],
			par([7])
			),
		int
		).

	test(t26) :- my_typing(
		app(
			func([[gen(t), k_type]], [[var(a), gen(t)]], gen(t), var(a)),
			[[gen(t), k_type]],
			par([true])
			),
		bool
		).

	test(t27) :- my_typing(
		func([[gen(n), k_dim], [gen(t), k_type]], [[var(a), t_array(gen(n), gen(t))], [var(b), gen(t)]], t_array(t_plus(gen(n), 1), gen(t)), concat(var(a), array([var(b)]))
		),
		t_func([[gen(n), k_dim], [gen(t), k_type]], [t_array(gen(n), gen(t)), gen(t)], t_array(t_plus(gen(n), 1), gen(t)))).


	test(t28) :- my_typing( 
		app(
			func([[gen(n), k_dim], [gen(t), k_type]], [[var(a), t_array(gen(n), gen(t))], [var(b), gen(t)]], t_array(t_plus(gen(n), 1), gen(t)), concat(var(a), array([var(b)]))),
		
			[[gen(n), k_dim], [gen(t), k_type]],
			par([array([true]), false])
			),
		t_array(2, bool)
		).


	test(t29) :- my_typing(let(var(x), t_array(2, bool), array([true, false]), var(x)), t_array(2, bool)).

:- end_tests(test_typing).

