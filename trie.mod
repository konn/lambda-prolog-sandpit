module trie.
accumulate tuple, tree, strings, maybe, control.

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

tinsertBy P S A T T' :- tsingleton S A N, tmergeBy P T N T'.

list_to_trie Xs T :-
  foldedr (X\E\Z\ sigma S\ sigma A\ X = (S pair A), tinsert S A E Z)
    (tnode nothing empty) Xs T.

trie_to_list (tnode X Ts) Fs :-
  foldTree (K\ V\ Ls\ Rs\ Result\ sigma Cs\
            trie_to_list V >>> mapped (ttl_prefix K) @> Cs,
            append Ls Rs >>> append Cs @> Result
         )  [] Ts Us,
  ttl_unmaybe X Hd,
  append Hd Us Fs.

local ttl_prefix  int -> tuple string A -> tuple string A -> o.
ttl_prefix K (L pair V) (T pair V) :- S is chr K, T is S ^ L.

local ttl_unmaybe  (maybe A -> list (tuple string A) -> o).
ttl_unmaybe X T :- runMaybe (V\ Y\ Y = ["" pair V]) [] X T.

tmerge T S U :- tmergeBy (X\ Y\ Z\ Z = Y) T S U.

tmergeBy P (tnode M Fs) (tnode N Es) (tnode L Ds) :-
  sumMaybe P M N L,
  mergeBy (tmergeBy P) Fs Es Ds.

tkeys (tnode M Ts) Hs :-
  runMaybe (X\ Y\ Y = [ "" ]) [] M Hd,
  foldTree (K\ V\ Ls\ Rs\ Result\
            sigma C\ sigma Ks\
              C is chr K,
              tkeys V >>> map (X\ C ^ X) @> Ks,
              append Ls Rs >>> append Ks @> Result
           )
            []
            Ts Rs,
  append Hd Rs Hs.

tdelete L S T :-
  str_to_ints L Ns,
  delete_sub Ns S T.

local delete_sub  list int -> trie A -> trie A -> o.
delete_sub [] (tnode _ Ts) T :- !, clean_empty (tnode nothing Ts) T.
delete_sub (X :: Xs) (tnode M Ts) T :-
  lookup X Ts >>> delete_sub Xs @> U, !,
  delete X Ts >>> insert X U @> Ts',
  clean_empty (tnode M Ts') T.
delete_sub _ T T.

local clean_empty  trie A -> trie A -> o.
clean_empty (tnode M Ts)    (tnode M Ts') :-
  filterTree (K\ V\ not (tnull V)) Ts Ts'.

all_trie P T :-
  trie_to_list T L,
  all (X\ sigma L\ sigma R\ X = (L pair R), P L R) L.

any_trie P T :-
  trie_to_list T L,
  any (X\ sigma L\ sigma R\ X = (L pair R), P L R) L.

mapped_trie P T S :- map_sub "" P T S.

local map_sub  (string -> (string -> A -> B -> o) -> trie A -> trie B -> o).

map_sub L P (tnode M Ts) (tnode N Ts') :-
  map_tree (mss L P) Ts Ts',
  map_maybe (P L) M N.

local mss  (string -> (string -> A -> B -> o) -> int -> trie A -> trie B -> o).
mss L P K V R :- L' is L ^ chr K, map_sub L' P V R.
