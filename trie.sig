sig trie.
accum_sig tuple, lists, tree, strings, maybe.

kind trie   (type -> type).
type tnode  (maybe A -> tree int (trie A) -> trie A).

type tsingleton string -> A -> trie A -> o.
type tlookup    string -> trie A -> A -> o.
type tinsert    string -> A -> trie A -> trie A -> o.
type tinsertBy  (A -> A -> A -> o) -> string -> A -> trie A -> trie A -> o.
type tnull      trie A -> o.
type tmergeBy   (A -> A -> A -> o) -> trie A -> trie A -> trie A -> o.
type tmerge     trie A -> trie A -> trie A -> o.

type list_to_trie  (list (tuple string A) -> trie A -> o).
type trie_to_list  (trie A -> list (tuple string A) -> o).
