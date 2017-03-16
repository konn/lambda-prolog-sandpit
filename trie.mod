module trie.
accumulate strings, tree, maybe.

local singsub list int -> A -> trie A -> o.
singsub []        A (tnode (just A) empty).
singsub (X :: Xs) A (tnode nothing  T) :-
  singsub Xs A S, singleton X S T.

tsingleton S A T :-
  str_to_ints S L,
  singsub L A T.

tnull (tnode nothing empty).

tlookup S T A :- str_to_ints S L, looksub L T A.

local subtrees trie A -> tree int (trie A) -> o.
subtrees (tnode _ Ts) Ts.

local looksub list int -> trie A -> A -> o.
looksub [] (tnode (just A) _) A.
looksub (X :: Xs) Tr A :-
  subtrees Tr T, lookup X T S, looksub Xs S A.

tinsert S A T T' :- tinsertBy (X\ Y\ Z\ Z = Y) S A T T'.

tinsertBy P S A T T' :-
  tsingleton S A N,
  tmergeBy P T N T'.

local ins_sub  (list int -> A -> trie A -> trie A -> o).
% ins_sub [] A (tnode _ Ts) (tnode (just A) Ts).
% ins_sub (X :: Xs) A (tnode M Ts) (tnode M Ts') :-
%   insertBy (ins_sub Xs A

list_to_trie Xs T :-
  foldedr (X\E\Z\ sigma S\ sigma A\ X = (S pair A), tinsert S A E Z)
    (tnode nothing empty) Xs T.

trie_to_list (tnode X Ts) Fs :-
  foldTree (K\ V\ Ps\ Rs\
            trie_to_list V Cs,
            mapped (ttl_prefix K) Cs Qs,
            append Qs Ps Rs
         )  [] Ts Us,
  ttl_unmaybe X Hd,
  append Hd Us Fs.

local ttl_prefix  int -> tuple string A -> tuple string A -> o.
ttl_prefix K (L pair V) (T pair V) :- sigma S\ S is chr K, T is S ^ L.

local ttl_unmaybe  (maybe A -> list (tuple string A) -> o).
ttl_unmaybe X T :- runMaybe (V\ Y\ Y = ["" pair V]) [] X T.

tmerge T S U :- tmergeBy (X\ Y\ Z\ Z = Y) T S U.

tmergeBy P (tnode M Fs) (tnode N Es) (tnode L Ds) :-
  sumMaybe P M N L,
  mergeBy (tmergeBy P) Fs Es Ds.


