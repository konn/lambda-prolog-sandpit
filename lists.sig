sig lists.

type deleteAll  A -> list A -> list A -> o.
type deleteOne  A -> list A -> list A -> o.
type uniq       list A -> list A -> o.
type all, any   (A -> o) -> list A -> o.
type ldiff      list A -> list A -> list A -> o.
type subsetOf   list A -> list A -> o.
type sameset    list A -> list A -> o.
type findMap    (A -> B -> o) -> list A -> B -> o.
type mapped     (A -> B -> o) -> list A -> list B -> o.
type map        (A -> B)      -> list A -> list B -> o.
type mapred     (A -> B -> o) -> list A -> list B -> o.
type in         A -> list A -> o.
type unzip      (A -> B -> C -> o) -> list A -> list B -> list C -> o.
type allZip     (A -> B -> o) -> list A -> list B -> o.
type append     list A -> list A -> list A -> o.
type foldedr    (A -> B -> B -> o) -> B -> list A -> B -> o.
type concat     list (list A) -> list A -> o.
type reverse    list A -> list A -> o.
infix in 9.
