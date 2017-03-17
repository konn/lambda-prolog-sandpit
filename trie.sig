sig trie.
accum_sig tuple, tree, strings, maybe, control.

kind trie   (type -> type).
type tnode  (maybe A -> tree int (trie A) -> trie A).

type tsingleton  string -> A -> trie A -> o.
type tlookup     string -> trie A -> A -> o.
type tinsert     string -> A -> trie A -> trie A -> o.
type tinsertBy   (A -> A -> A -> o) -> string -> A -> trie A -> trie A -> o.
type tnull       trie A -> o.
type tmergeBy    (A -> A -> A -> o) -> trie A -> trie A -> trie A -> o.
type tmerge      trie A -> trie A -> trie A -> o.
type tkeys       trie A -> list string -> o.
type tdelete     string -> trie A -> trie A -> o.
type all_trie    (string -> A -> o) -> trie A -> o.
type any_trie    (string -> A -> o) -> trie A -> o.
type mapped_trie (string -> A -> B -> o) -> trie A -> trie B -> o.

type list_to_trie  (list (tuple string A) -> trie A -> o).
type trie_to_list  (trie A -> list (tuple string A) -> o).
