:- module(substitution, [substitution/3]).

% FUNC as value
substitution(
	Context, 
	func(Generics, Parameters, Type, E1), 
	func(Generics, Parameters, Type, E2)) :-
	substitution(Context, E, E2).
 
% boolean as values
substitution(Context, true, true).
substitution(Context, false, false).

% PLUS
substitution(
	Context,
	plus(A, B),
	plus(Ap, Bp)) :- 
		substitution(Context, A, Ap),
		substitution(Context, B, Bp).
 
% TIME
substitution(
	Context,
	time(A, B),
	time(Ap, Bp)) :- 
		substitution(Context, A, Ap),
		substitution(Context, B, Bp).
 
% AND
substitution(Context, and(E1, E2), and(E1p, E2p)) :-
	substitute(Context, E1, E1p),
	substitute(Context, E2, E2p).
 
% OR
substitution(Context, or(E1, E2), or(E1p, E2p)) :-
	substitute(Context, E1, E1p),
	substitute(Context, E2, E2p).
 
% IF-T
substitution(Context, if(E1, E2, E3), if(E1p, E2p, E3p)) :-
	substitute(Context, E1, E1p),
	substitute(Context, E2, E2p).
	substitute(Context, E3, E3p).

% VAR
substitution(
	Context,
	var(X),
	Res) :-
		context_in_context(var(X), Context),
		context_get_value(var(X), Context, Res).

% VAR
substitution(
	Context,
	var(X),
	var(X)).
 
% FUNC-APP
substitution(
	Context,
	app(Exp, Generics, Values),
	Res) :-
		substitution(Context, Exp, Res).

% LET
substitution(
	Context,
	let(var(X), T, E, E2),
	Res) :-
		substitution(Context, E, E3),
		append(Context, [[X, E3]], Context2),
		substitution(Context2, E2, Res).

% NUM
substitution(Context, X, X).
