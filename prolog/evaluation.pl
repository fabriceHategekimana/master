:- use_module(context).
:- use_module(substitution).

% type place holder
tph.

 % FUNC as value
evaluation(
	Context, 
	func(Generics, Parameters, Type, E), 
	func(Generics, Parameters, Type, E2)) :-
	substitution(Context, E, E2).
 
% boolean as values
evaluation(Context, true, true).
evaluation(Context, false, false).

% NUM
evaluation(
	Context, X, X) 
	:- number(X).

% PLUS
evaluation(
	Context,
	plus(A, B),
	Res) :- 
		evaluation(Context, A, Ap),
		evaluation(Context, B, Bp),
		Res is Ap + Bp.

% TIMES
evaluation(
	Context, 
	time(A, B), 
	Res) :-
		evaluation(Context, A, Ap),
		evaluation(Context, B, Bp),
		Res is Ap * Bp.
 
% EQ
evaluation(
	Context, 
	eq(X, Y),
	true) :-
		evaluation(Context, X, Z),
		evaluation(Context, Y, Z).

evaluation(Context, eq(X, Y), false).
		

% GRT
evaluation(
	Context, 
	grt(X, Y),
	true) :-
		evaluation(Context, X, Xp),
		evaluation(Context, Y, Yp),
		Xp > Yp.

evaluation(Context, grt(X, Y), false).


% LOW
evaluation(
	Context, 
	low(X, Y),
	true) :-
		evaluation(Context, X, Xp),
		evaluation(Context, Y, Yp),
		Xp < Yp.

evaluation(Context, low(X, Y), false).


% GRT-EQ
evaluation(
	Context, 
	gte(X, Y),
	true) :-
		evaluation(Context, X, Xp),
		evaluation(Context, Y, Yp),
		Xp >= Yp.

evaluation(Context, gte(X, Y), false).

% LOW-EQ
% evaluation(
% Context, 
% lwe(X, Y),
% true) :-
% evaluation(Context, X, Xp),
% evaluation(Context, Y, Yp),
% Xp <= Yp.

evaluation(Context, lwe(X, Y), false).

% AND
evaluation(Context, and(A, B), true) :-
	evaluation(Context, A, true),
	evaluation(Context, B, true).

evaluation(Context, and(A, B), false).
 
% OR
evaluation(Context, or(A, B), bool) :-
	evaluation(Context, A, false),
	evaluation(Context, B, false).

evaluation(Context, or(A, B), true).
 
% IF-T
evaluation(Context, if(true, E2, E3), E2).
evaluation(Context, if(false, E2, E3), E3).

% VAR
evaluation(
	Context,
	var(X),
	Res) :-
		context_in_context(var(X), Context),
		context_get_value(var(X), Context, Res).

evaluation(
	Context,
	var(X),
	var(X)).
 
% FUNC-APP
evaluation(
	Context,
	app(Exp, Generics, Values),
	Res) :-
		evaluation(Context, Exp, func(Generics2, Parameters, Type, Exp2)),
		context_from(Parameters, Values, Context2),
		append(Context, Context2, Context3),
		evaluation(Context3, Exp2, Res).

evaluation(
	Context,
	let(var(X), T, E, E2),
	Res) :-
		evaluation(Context, E, E3),
		append(Context, [[var(X), E3]], Context2),
		evaluation(Context2, E2, Res).

evaluation(
	Context,
	array([H | T]),
	array([Hp | Tp])) :-
		evaluation(Context, H, Hp),
		evaluation(Context, array(T), array(Tp)).

evaluation(
	Context,
	array([]),
	array([])).

evaluation(
	Context,
	concat(array(A1), array(A2)),
	array(A3)) :-
		concat(A1, A2, A3).

% FIRST
evaluation(Context, first(array([H | T])), H).

% REST
evaluation(Context, rest(array([H | T])), array(T)).

% NUM
evaluation(
	Context,
	X,
	Res) :-
	  number(X),
	  Res = X.

:- begin_tests(test_evaluation).
	 test(t2) :- evaluation([], and(true, false), false).
	 test(t3) :- evaluation([], or(true, false), true).
	 test(t4) :- evaluation([], if(true, 7, 9), 7).
	 test(t5) :- evaluation([], func([], [], tph, 7), func([], [], tph, 7)).
	 test(t6) :- evaluation([], 
		 func([], [[var(a), tph], [var(b), tph]], tph, plus(var(a), var(b))),
		 func([], [[var(a), tph], [var(b), tph]], tph, plus(var(a), var(b)))).
	 test(t7) :- evaluation([], 8, 8).
	 test(t8) :- evaluation([], false, false).
	 test(t9) :- \+ evaluation([], tpc, false).
	 test(t10) :- evaluation([], false, false).
	 test(t11) :- evaluation([], 
		 app(
			 func([], [[var(a), tph], [var(b), tph]], tph, plus(var(a), var(b))),
			 [],
			 [3, 4]
			 ),
		 7).
	 test(t12) :- evaluation([[var(x), 3]], var(x), 3).
	 test(t13) :- evaluation([], let(var(x), tph, 7, var(x)), 7).
	 test(t14) :- evaluation([], array([]), array([])).
	 test(t15) :- evaluation([], array([1, plus(2, 3), 3]), array([1, 5, 3])). 
	 test(t16) :- evaluation([], concat(array([1, 2]), array([3, 4])), array([1, 2, 3, 4])).
	 test(t17) :- evaluation([], first(array([1, 2, 3])), 1).
	 test(t18) :- evaluation([], rest(array([1, 2, 3])), array([2, 3])).
	 test(t19) :- evaluation([], array([array([1, 2]), array([1, 3])]), array([array([1, 2]), array([1, 3])])).
	 test(t20) :- evaluation([], 
		 app(
			func([gen(t)], [[var(a), get(t)]], gen(t), var(a)),
			[int],
			[7]
		 ),
		 7
	 ).
:- end_tests(test_evaluation).
