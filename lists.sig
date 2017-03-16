sig lists.

exportdef deleteAll  A -> list A -> list A -> o.
exportdef deleteOne  A -> list A -> list A -> o.
exportdef uniq       list A -> list A -> o.
exportdef all, any   (A -> o) -> list A -> o.
exportdef ldiff      list A -> list A -> list A -> o.
exportdef subsetOf   list A -> list A -> o.
exportdef sameset    list A -> list A -> o.
exportdef findMap    (A -> B -> o) -> list A -> B -> o.
exportdef mapped     (A -> B -> o) -> list A -> list B -> o.
exportdef map        (A -> B)      -> list A -> list B -> o.
exportdef mapred     (A -> B -> o) -> list A -> list B -> o.
exportdef in         A -> list A -> o.
exportdef unzip      (A -> B -> C -> o) -> list A -> list B -> list C -> o.
exportdef allZip     (A -> B -> o) -> list A -> list B -> o.
exportdef append     list A -> list A -> list A -> o.
exportdef foldedr    (A -> B -> B -> o) -> B -> list A -> B -> o.
exportdef concat     list (list A) -> list A -> o.
infix in 9.
