module lists.
accumulate control.

deleteAll X [] [].
deleteAll X (X :: Xs) Ys :- !, deleteAll X Xs Ys.
deleteAll X (Y :: Xs) (Y :: Ys) :- deleteAll X Xs Ys.

deleteOne X [] [].
deleteOne X (X :: Ys) Ys :- !.
deleteOne X (Y :: Xs) (Y :: Ys) :- deleteOne X Xs Ys.

uniq [] [].
uniq (X :: Xs) (X :: Ys) :- uniq Xs Zs, deleteAll X Zs Ys.

all P [].
all P (X :: Xs) :- P X, all P Xs.

any P (X :: Xs) :- P X, !.
any P (_ :: Xs) :- any P Xs.

ldiff L [] L.
ldiff L (X :: Xs) M :- deleteAll X L N, ldiff N Xs M.

subsetOf L M :- ldiff L M [].

sameset L M :-
  uniq L L',
  uniq M M',
  subsetOf L' M', subsetOf M' L'.

findMap P (X :: Xs) Y :- P X Y, !.
findMap P (_ :: Xs) Y :- findMap P Xs Y.

mapped P [] [].
mapped P (X :: Xs) (Y :: Ys) :- P X Y, mapped P Xs Ys.

mapred P [] [].
mapred P (X :: Xs) (Y :: Ys) :- P X Y, !, mapred P Xs Ys.
mapred P (X :: Xs) Ys :- mapred P Xs Ys.

map F [] [].
map F (X :: Xs) (X' :: Ys) :- X' is F X, map F Xs Ys.

X in (X :: Xs).
X in (Y :: Xs) :- X in Xs.

unzip R [] [] [].
unzip R (X :: Xs) (Y :: Ys) (Z :: Zs) :-
  R X Y Z, unzip R Xs Ys Zs.

allZip P [] [].
allZip P (X :: Xs) (Y :: Ys) :- P X Y, allZip P Xs Ys.

append []        Ys Ys.
append (X :: Xs) Ys (X :: Zs) :- append Xs Ys Zs.

foldedr _ Y [] Y.
foldedr P I (X :: Xs) Y :-
  foldedr P I Xs >>> P X @> Y.

concat Xss Xs :- foldedr append [] Xss Xs.

reverse Xs Ys :-
  pi rev\
     (pi A\ pi As\ pi Bs\ rev (A :: As) Bs :- rev As (A :: Bs))
  => rev nil Ys
  => rev Xs nil.
