module fol.
local merge form -> form -> o.

pnf (atom X L) (atom X L).
pnf (A and B) C :-
  pnf A F, pnf B G, merge (F and G) C.
pnf (A or B) C :-
  pnf A F, pnf B G, merge (F or G) C.
pnf (A --> B) C :-
  pnf A F, pnf B G, merge (F --> G) C.
pnf (some (x\ B x)) (some (x\ T x)) :-
  pi x\ pnf (B x) (T x).
pnf (all (x\ B x)) (all (x\ T x)) :-
  pi x\ pnf (B x) (T x).

merge ((all x\B x) or C) (all D) :-
  pi x\ merge ((B x) or C) (D x).
merge ((some x\B x) or C) (some D) :-
  pi x\ merge ((B x) or C) (D x).
merge ((all x\B x) and C) (all D) :-
  pi x\ merge ((B x) and C) (D x).
merge ((some x\B x) and C) (some D) :-
  pi x\ merge ((B x) and C) (D x).
merge (F --> all x\ C x) (all x\ D x) :-
  pi x\ merge (F --> C x) (D x).
merge ((all x\ B x) --> G) (some x\ D x) :-
  pi x\ merge (B x --> G) (D x).
merge (F --> some x\ C x) (some x\ D x) :-
  pi x\ merge (F --> C x) (D x).
merge ((some x\ B x) --> G) (all x\ D x) :-
  pi x\ merge (B x --> G) (D x).
