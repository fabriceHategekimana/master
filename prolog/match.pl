:- module(match, [match/3]).
:- use_module(module).

% match array of types
match([Gen | Rest1], [Type | Rest2], Res) :-
	match(Rest1, Rest2, Tab),
	match(Gen, Type, Resu),
	append(Resu, Tab, Res).

match([], [], []).

% match generics
match(gen(G), Type, [[gen(G), Type]]).

match(t_array(Gen1, Gen2), t_array(Type1, Type2), Res) :-
	match(Gen1, Type1, Res1),
	match(Gen2, Type2, Res2),
	append(Res1, Res2, Res).

match(t_func(Gens1, Genspar, GenResu), t_func(Gens2, Par, Resu), Res) :-
	match(Genspar, Par, Par1),
	match(GenRes, Resu, Resul),
	append(Par1, Resul, Res).

match(Type1, Type2, []).


:- begin_tests(match_test).
	test(t1) :- match(gen(t), int, [[gen(t), int]]).
	test(t2) :- match(gen(t), bool, [[gen(t), bool]]).
	test(t3) :- match(t_array(gen(n), gen(t)), t_array(7, bool), [[gen(n), 7], [gen(t), bool]]).
	test(t4) :- match(t_array(7, gen(t)), t_array(7, bool), [[gen(t), bool]]).
	test(t5) :- match([gen(t), gen(t)], [bool, int], [[gen(t), bool], [gen(t), int]]).
:- end_tests(match_test)
