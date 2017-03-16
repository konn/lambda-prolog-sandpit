sig minifp.

kind typ type.
kind trm type.

type   integer  typ.
type   bool     typ.
type   -->      typ -> typ -> typ.
infixr -->      90.

type   ifte     trm -> trm   -> trm -> trm.
type   eq       trm -> trm   -> trm.
type   >>       trm -> trm   -> trm.
type   plus     trm -> trm   -> trm.
type   minus    trm -> trm   -> trm.
type   times     trm -> trm   -> trm.
type   lam      (trm -> trm) -> trm.
type   fix      (trm -> trm) -> trm.
type   @        trm -> trm   -> trm.
type   num      int -> trm.
type   tt, ff   trm.
type   and, or  trm -> trm -> trm.
type   bnot     trm -> trm.

infixr and     80.
infixr or      70.
infix  eq, >>  90.
infixl plus    100.
infixl minus   100.
infixl times   110.
infixl @       150.

exportdef value     trm -> o.
exportdef eval      trm -> trm -> o.
exportdef typeof    trm -> typ -> o.
exportdef prog      string -> trm -> o.
exportdef tailrec   trm -> o.
exportdef tprog     string -> trm -> o.
exportdef typename  string -> typ -> o.

type then trm -> trm -> trm.
infixr then 50.

type u    trm.
type unit typ.

type as   trm -> typ -> trm.
infixr as 180.

type **   trm -> trm -> trm.
type pair typ -> typ -> typ.
infixr ** 30.
type fst  trm -> trm.
type snd  trm -> trm.

kind fldTy type.
type   ~= string -> typ -> fldTy.
infixr ~= 10.

kind   fld type.
type   !=  string -> trm -> fld.
infixr != 50.

type rec list fldTy -> typ.

type of  string -> trm -> trm.
type mk  list fld -> trm.
infixr of 20.

type findApply (A -> B -> o) -> list A -> B -> o.

type let trm -> (trm -> trm) -> trm.

type union  typ -> typ -> typ.
type inl    trm -> trm.
type inr    trm -> trm.
type either (trm -> trm) -> (trm -> trm) -> trm -> trm.

type  var list fldTy -> typ.
type  ?=  string -> trm -> trm.
infix ?= 50.

kind case  type.
type when  string -> (trm -> trm) -> case.
type match trm -> list case -> trm. 

type lst   typ -> typ.
type null  typ -> trm.
type <#    trm -> trm -> trm.
type isNil trm -> trm.
type hd    trm -> trm.
type tl    trm -> trm.
infixr <# 90.

% type ref   typ -> typ.
% type &>    trm -> trm.
% type &=    trm -> trm -> trm.
% type &!    trm -> trm.

% infix &= 60.

type throw trm -> trm.
type try   trm -> (trm -> trm) -> trm.
type exn   typ.
type error string -> trm.

type cont    typ -> typ.
type call/cc (trm -> trm) -> trm.
type @@      trm -> trm -> trm.
infixl @@ 150.

typeabbrev location int.
type loc   location -> trm.
type top   typ.
exportdef <!  typ -> typ -> o. % subtyping rel.
infix     <!  120.

exportdef join typ -> typ -> typ -> o.
exportdef meet typ -> typ -> typ -> o.
