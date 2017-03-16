module diff.

%% First attempt:
% Automatic differentiation, easy (i.e. non-composite) case.
% Lambda Prolog supports pattern-matching on lambdas,
% so we can use it to define "deep-embedded" autodiffs:

% We can exploit the higher-order expressiveness of Lambda Prolog
% to express that "F is a constant function".
ediff F (X : real\ 0.0) :-  pi Y\ pi X\ F X = F 0.0, !.
ediff (X\ X)     (X : real\ 1.0) :- !.
ediff (X\ ~ F X) (X\ ~ G X) :- ediff F G, !.
ediff sin cos         :- !.
ediff cos (X\~ sin X) :- !.
ediff (X\ F X + G X) (X\ F' X + G' X) :-
  !, ediff F F', ediff G G'.
ediff (X\ F X - G X) (X\ F' X - G' X) :-
  !, ediff F F', ediff G G'.
ediff (X\ F X * G X) (X\ F' X * G X + F X * G' X) :-
  !, ediff F F', ediff G G'.

ediff sqrt (X\ 1.0 / (2.0 * sqrt X)) :- !.
ediff (X\ F X / G X) (X\ (F' X / G X) - (F X * G' X / (G X * G X))) :-
  !, ediff F F', ediff G G'.

% If we add the following rule, computation explodes.
% ediff (X\F (G X)) (X \ F' (G X) * G' X) :-
%   ediff F F', ediff G G'.

%% Second attempt:
% Automatic differentiation, which supports composition.
% We declare each rule in a composite form to avoid explosion.
adiff (X\ X) (X\ 1.0) :- !.
adiff F (X : real\ 0.0) :-
  pi X\ F X = F 0.0, !.
adiff (X\ A * F X) (X\ A * F' X) :- !, adiff F F'.
adiff (X\ ~ (F X)) (X\ ~ (F' X)) :- !, adiff F F'.
adiff (X\ sin (F X)) (X\ cos (F X) * F' X) :- !, adiff F F'.
adiff (X\ cos (F X)) (X\ ~ sin (F X) * F' X) :- !, adiff F F'.
adiff (X\ F X + G X) (X\ F' X + G' X) :-
  !, adiff F F', adiff G G'.
adiff (X\ F X - G X) (X\ F' X - G' X) :-
  !, adiff F F', adiff G G'.
adiff (X\ F X * G X) (X\ F' X * G X + F X * G' X) :-
  !, adiff F F', adiff G G'.
adiff (X\ F X / G X) (X\ (F' X / G X) - (F X * G' X / (G X * G X))) :-
  !, adiff F F', adiff G G'.
adiff (X\ sqrt (F X)) (X\ F' X / (2.0 * sqrt (F X))) :-
  !, adiff F F'.

ndiff 0 F F.
ndiff N F Fn :-
  N > 0, M is N - 1, ndiff M F F', adiff F' Fn.

simpl (X\ ln (F X))  (X\ (F' X) / (F X)) :-
  !, simpl F F'.
simpl (X\ arctan (F X))  (X\ (F' X) / (1 + (F X) * (F X))) :-
  !, simpl F F'.
simpl (X\ F X + G X) G' :-
  (pi X\ F X = 0.0), !, simpl G G'.
simpl (X\ F X + G X) F' :-
  (pi X\ G X = 0.0), !, simpl F F'.
simpl (X\ F X + G X) E :-
  simpl F F', simpl G (X\ ~ (G' X)), !, simpl (X\ F' X - G' X) E.
simpl (X\ F X + G X) E :-
  simpl F (X\ ~ (F' X)), simpl G G', !, simpl (X\ G' X - F' X) E.
simpl (X\ F X + G X) (X\ F' X + G' X) :-
  !, simpl F F', simpl G G'.
simpl (X\ F X - G X) (X\ 0.0) :-
  simpl F F', simpl G G', (pi X\ (F' X = G' X)), !.
simpl (X\ F X - G X) (X\ F' X - G' X) :-
  simpl F F', simpl G G'.
simpl (X\ F X * G X) (X\ 0.0) :-
  (pi X\ F X = 0.0), !.
simpl (X\ F X * G X) (X\ 0.0) :-
  (pi X\ G X = 0.0), !.
simpl (X\ F X * G X) G' :-
  (pi X\ F X = 1.0), !, simpl G G' .
simpl (X\ F X * G X) F' :-
  (pi X\ G X = 1.0), !, simpl F F' .
simpl (X\ F X * G X) (X\ ~ (G' X)) :-
  (pi X\ F X = ~ 1.0), !, simpl G G' .
simpl (X\ F X * G X) (X\ ~ (F' X)) :-
  (pi X\ G X = ~ 1.0), !, simpl F F' .
simpl (X\ F X * G X) (X\ F' X * G' X) :-
  simpl F F', simpl G G'.
% simpl (X\ F X / G X) F' :-
%   simpl F F', (pi X\ G X = 1.0).
% simpl (X\ F X / G X) (X\ 1.0) :-
%   simpl F F', simpl G G',  (pi X\ F' X = G' X), !.
simpl (X\ F X / G X) (X\ F' X / G' X) :-
  simpl F F', simpl G G', !.
simpl (X\ ~ (F X)) (X\ (F' X)) :- simpl F (X\ ~ (F' X)).
simpl (X\ ~ (F X)) (X\ ~ (F' X)) :- simpl F F'.
simpl F F.



%% Taylor series.
taylor X0 F S :- maclaurin (X\ F (X - X0)) S.

%% Maclaurin series.
maclaurin F S :-
  machelper F S0,
  facts Fs,
  zipped macTerm Fs S0 S.

% local macTerm  int -> real -> real -> o.
macTerm N X Y :- Z is int_to_real N, Y is (X / Z).

% local machelper (real -> real) -> stream real -> o.
machelper F S :-
  adiff F F', Y is F 0.0, scons Y (machelper F') S.

% local facts  stream A -> o.
facts (1 # value S) :- facHelper 1 1 S.

facHelper N K Ns :-
  M is N * K, N' is N + 1, scons M (facHelper N' M) Ns.

%% Helper functions.
scons A P (A # thunk P).

force (value X) X.
force (thunk P) X :- P X.

take 0 _ [] :- !.
take N (X # P) (X :: Xs) :-
  N > 0, force P T, M is N - 1, take M T Xs.

zipped P (X # S) (Y # T) U :-
  P X Y Z,
  force S S', force T T',
  scons Z (zipped P S' T') U.
