sig fol.
kind form type.
kind term type.

type const string -> term.

type  atom  string -> (list term) -> form.
type  and   form   -> form -> form.
type  or    form   -> form -> form.
type  -->   form   -> form -> form.
type  all   (term -> form) -> form.
type  some  (term -> form) -> form.

infixr and 130.
infixr or  120.
infixr -->  100.

type pnf form -> form -> o.