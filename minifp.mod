module minifp.
accumulate lists.

value (num I).
value tt.
value ff.
value (lam X).

eval M M :- value M.
eval (S plus T) (num L) :- eval S (num N), eval T (num M), L is (N + M).
eval (S minus T) (num L) :- eval S (num N), eval T (num M), L is (N - M).
eval (S times T) (num L) :- eval S (num N), eval T (num M), L is (N * M).
eval (S eq T) tt :- eval S (num N), eval T (num M), N is M, !.
eval (S eq T) ff :- eval S (num N), eval T (num M).
eval (S eq T) tt :- eval S tt, eval T tt.
eval (S eq T) tt :- eval S ff, eval T ff.
eval (S eq T) ff :- eval S tt, eval T ff.
eval (S eq T) ff :- eval S ff, eval T ff.
eval (S >> T) tt :- eval S (num M), eval T (num N), M > N, !.
eval (S >> T) ff :- eval S (num M), eval T (num N), M <= N.
eval (ifte B S T) V :- eval B tt, eval S V.
eval (ifte B S T) V :- eval B ff, eval T V.
eval (bnot S) tt :- eval S ff.
eval (bnot S) ff :- eval S tt.
eval (S and T) tt :- eval S tt, eval T tt.
eval (S and T) ff :- eval S ff, eval T tt.
eval (S and T) ff :- eval S tt, eval T ff.
eval (S and T) ff :- eval S ff, eval T ff.
eval (S @ T)   U  :- eval S (lam F), eval T V, eval (F V) U.
eval (fix B)   V  :- eval (B (fix B)) V.

typeof tt       bool.
typeof ff       bool.
typeof (num N)  integer.
typeof (S eq T) bool :- typeof S bool, typeof T bool.
typeof (S eq T) bool :- typeof S integer, typeof T integer.
typeof (S >> T) bool :- typeof S integer, typeof T integer.
typeof (S plus T) integer :- typeof S integer, typeof T integer.
typeof (S times T) integer :- typeof S integer, typeof T integer.
typeof (S minus T) integer :- typeof S integer, typeof T integer.
typeof (S and T) bool :- typeof S bool, typeof T bool.
typeof (S or T) bool :- typeof S bool, typeof T bool.
typeof (bnot T) bool :- typeof S bool.
typeof (ifte P L R) T :- typeof P bool, typeof L T, typeof R T.
typeof (lam M) (A --> B) :-
  pi x\ (typeof x A => typeof (M x) B).
typeof (fix B) A :-
  pi f\ typeof f A => typeof (B f) A.
typeof (S @ T) A :-
  typeof S (B --> A), typeof T B', B' <! B.

prog "fact" (fix fact\ lam n\
  ifte (n >> num 0)
       (n times (fact @ (n minus num 1)))
       (num 1)
  ).

prog "tail-fact" (fix fact\ lam n\ lam i\
  (ifte (n eq num 0)
        i
        (fact @ (n minus num 1) @ (i times n)))
  ).

tprog S F :- prog S F, sigma T\ typeof F T.

local trec (trm -> trm) -> o.

trec (f\ f).
trec (f\ M).
trec (f\ lam (M f)) :- pi x\ trec (f\ M f x).
trec (f\ (M f) @ N) :- trec M.
trec (f\ ifte B (P f) (Q f)) :- trec P, trec Q.

tailrec (fix F) :- trec F.


typeof u unit.
value u.
eval u u.
eval (S then T) U :-
  eval S S', eval T T', eval ((lam V\ T') @ S') U.

typeof (S then T) V :- typeof S unit, typeof T V.

eval (S as T) S' :- eval S S', !.

eval (S ** T) (S' ** T') :- eval S S', eval T T'.
eval (fst T) X :- eval T (X ** Y).
eval (snd T) Y :- eval T (X ** Y).

value (S ** T) :- value S, value T.

typeof (S ** T) (pair A B) :- typeof S A, typeof T B.
typeof (fst P)  A :- typeof P (pair A B).
typeof (snd P)  B :- typeof P (pair A B).
typeof (E as T) T :- typeof E T', T' <! T.

local typeoffld fld -> fldTy -> o.
typeoffld (X != E) (X ~= T) :- typeof E T.

local lookTy    string -> list fldTy -> typ -> o.
lookTy Var Ts Y :- findMap (X\ Z\ X = (Var ~= Z)) Ts Y.

local lookFld   string -> list fld   -> trm -> o.
lookFld Var Ts Y :- findMap (X\ Z\ X = (Var != Z)) Ts Y.

eval (mk Fs) (mk Fs).

eval (L of S) T :-
  eval S (mk Fs), lookFld L Fs T.

typeof (mk Fs) (rec Ts) :-
  mapped typeoffld Fs Ts.
typeof (L of S) T :-
  typeof S (rec Fs), lookTy L Fs T.

value (mk Fs) :- all (X\ sigma L\ sigma Y\ X =  (L != Y), value Y) Fs.
eval (let T B) S :- eval (B T) S.
typeof (let A B) S :- typeof (B A) S.

eval (inl T) (inl T') :- eval T T'.
eval (inr S) (inr S') :- eval S S'.

eval (either L R T) S :- eval T (inl X), eval (L X) S.
eval (either L R T) S :- eval T (inr Y), eval (R Y) S.

typeof (inl A) (union T S) :- typeof A T.
typeof (inr B) (union T S) :- typeof B S.
typeof (either L R E) C :-
  typeof E (union A B),
  (pi x\ typeof x A => typeof (L x) C),
  (pi y\ typeof y B => typeof (R y) C).

value (inl A) :- value A.
value (inr B) :- value B.

eval (match T Cs) S :-
  eval T (L ?= E),
  findMap (X\ Y\ X = (when L Y)) Cs B,
  eval (B E) S.

eval (L ?= E) (L ?= E') :- eval E E'.

typeof (L ?= E) (var Ts) :-
  typeof E T,
  any (X\ X = (L ~= T)) Ts.
value (L ?= E) :- value E.

local elm A -> list A -> o.
elm X (X :: _).
elm X (Y :: Xs) :- elm X Xs.

local checkClause  list case -> typ -> fldTy -> o.
checkClause Cs S (L ~= T) :-
  findMap (X\Y\ X = (when L Y)) Cs E,
  pi x\ typeof x T => typeof (E x) S.

typeof (match E Cs) S :-
  typeof E (var LTs),
  all (checkClause Cs S) LTs.

typename "dir" (var ["left" ~= unit, "right" ~= unit]).

value (null T).
value (X <# Xs) :- value X, value Xs.

eval (X <# Xs) (Y <# Ys) :- eval X Y, eval Xs Ys.
eval (isNil E) tt :- eval E (null _).
eval (isNil E) ff :- eval E (_ <# _).
eval (hd E)    X  :- eval E (X <# _).
eval (tl E)    Xs :- eval E (_ <# Xs).

typeof (null T)  (lst T).
typeof (X <# Xs) (lst T)  :- typeof X T, typeof Xs (lst T).
typeof (isNil Xs) bool    :- typeof Xs (lst T).
typeof (hd Xs)    T       :- typeof Xs (lst T).
typeof (tl Xs)    (lst T) :- typeof Xs (lst T).

prog "prod" (
  fix prod\
  lam Xs\
    (ifte (isNil Xs)
      (num 1)
      (hd Xs times (prod @ (tl Xs))))
  ).

% eval (error @ E) error.
% eval (V @ error) error :- value V.
% typeof error T.

% typeof (&? E)   (ref T) :- typeof E T.
% typeof (&> E)   T       :- typeof E (ref T).
% typeof (R &= E) unit    :- typeof R (ref T), typeof E T.

eval (throw E @ T) (throw E') :- eval E E', !.
eval (V @ throw E) (throw E') :- value V, eval E E'.
eval (throw (throw E)) (throw V) :- eval E V.
eval (throw E) (throw V) :- eval E V.
eval (try E H) T :- eval E (throw V), eval (H V) T.
eval (try E H) V :- eval E V, value V, !.
eval (error S) (error S).
eval (E plus F) (throw V) :- eval E (throw V), !.
eval (F plus E) (throw V) :- eval E (throw V).
eval (F minus E) (throw V) :- eval E (throw V), !.
eval (E minus F) (throw V) :- eval E (throw V).
eval (F times E) (throw V) :- eval E (throw V), !.
eval (E times F) (throw V) :- eval E (throw V).
eval (F times E) (throw V) :- eval E (throw V), !.
eval (E times F) (throw V) :- eval E (throw V).
eval (E eq F)    (throw V) :- eval E (throw V), !.
eval (E eq F)    (throw V) :- eval F (throw V).
eval (E >> F)    (throw V) :- eval E (throw V), !.
eval (E >> F)    (throw V) :- eval F (throw V).
eval (E and F)    (throw V) :- eval E (throw V), !.
eval (E and F)    (throw V) :- eval F (throw V).
eval (E or F)    (throw V) :- eval E (throw V), !.
eval (E or F)    (throw V) :- eval F (throw V).
eval (bnot E)    (throw V) :- eval E (throw V).
eval (fst  E)    (throw V) :- eval E (throw V).
eval (snd  E)    (throw V) :- eval E (throw V).
eval (L of E)    (throw V) :- eval E (throw V).
eval (either L R E)    (throw V) :- eval E (throw V).
eval (hd  E)    (throw V) :- eval E (throw V).
eval (tl  E)    (throw V) :- eval E (throw V).

typeof (error S) exn.
typeof (throw E) T :- typeof E exn.
typeof (try E H) T :-
  typeof E T,
  pi x\ typeof x exn => typeof (H x) T.

prog "safe-hd" (
  lam Xs\
    ifte (isNil Xs)
         (throw (error "Head for Nil"))
         (hd Xs)
 ).

typeof (call/cc B) T :-
  pi x\ typeof x (cont T) => typeof (B x) T.
typeof (E @@ F) T :-
  typeof E (cont S), typeof F S.
typeof mkcont (cont T).

local mkcont trm.

eval (call/cc E) F :-
  eval (E mkcont) (mkcont @@ F), !.
eval (call/cc E) V :- eval (E mkcont) V.
eval (E @@ T)        (E @@ V) :- eval T V.
eval (S @@ (Q @@ E)) (Q @@ V) :- eval E V, !.
eval ((S @@ E) @ T)  (S @@ V) :- eval E V, !.
eval (V @ (S @@ E))  (S @@ U) :- eval E U.

eval (E plus F)     (S @@ V) :- eval E (S @@ Q), !, eval Q V.
eval (F plus E)     (S @@ V) :- eval E (S @@ Q), eval Q V.
eval (E minus F)    (S @@ V) :- eval E (S @@ Q), !, eval Q V.
eval (F minus E)    (S @@ V) :- eval E (S @@ Q), eval Q V.
eval (E times F)    (S @@ V) :- eval E (S @@ Q), !, eval Q V.
eval (F times E)    (S @@ V) :- eval E (S @@ Q), eval Q V.
eval (E and F)      (S @@ V) :- eval E (S @@ Q), !, eval Q V.
eval (F and E)      (S @@ V) :- eval E (S @@ Q), eval Q V.
eval (E or F)       (S @@ V) :- eval E (S @@ Q), !, eval Q V.
eval (F or E)       (S @@ V) :- eval E (S @@ Q), eval Q V.
eval (E eq F)       (S @@ V) :- eval E (S @@ Q), !, eval Q V.
eval (F eq E)       (S @@ V) :- eval E (S @@ Q), eval Q V.
eval (E >> F)       (S @@ V) :- eval E (S @@ Q), !, eval Q V.
eval (F >> E)       (S @@ V) :- eval E (S @@ Q), eval Q V.
eval (bnot E)       (S @@ V) :- eval E (S @@ Q), eval Q V.
eval (fst  E)       (S @@ V) :- eval E (S @@ Q), eval Q V.
eval (snd  E)       (S @@ V) :- eval E (S @@ Q), eval Q V.
eval (L of E)       (S @@ V) :- eval E (S @@ Q), eval Q V.
eval (either L R E) (S @@ V) :- eval E (S @@ Q), eval Q V.
eval (hd  E)        (S @@ V) :- eval E (S @@ Q), eval Q V.
eval (tl  E)        (S @@ V) :- eval E (S @@ Q), eval Q V.

local subtypesIn (list fldTy -> fldTy -> o).
subtypesIn Fs (L ~= T) :- lookTy L Fs S, S <! T.

S <! top.
(S --> S') <! (T --> T') :- T <! S, S' <! T'.
lst A  <! lst B :- A <! B.
rec Fs <! rec Ts :- all (subtypesIn Fs) Ts.
integer <! integer.
bool    <! bool.

% join top      T        top :- !.
% join T        top      top :- !.
% join integer  bool     top.
% join bool     integer  top.
% join (rec Ts) (rec Cs) (rec Xs) :-
  



% typeof E T :- S <! T, typeof E S.
