/* Definition of facts */
parent(piero, mario).
parent(giovanna, mario).
parent(camillo, maria).
parent(maria_laura, maria).
parent(mario, luca).
parent(maria, luca).
parent(mario, anna).
parent(maria, anna).
parent(nicola, giacomo).
parent(silva, giacomo).
parent(erica, edoardo).
parent(luca, edoardo).
parent(erica, andrea).
parent(luca, andrea).
parent(erica, libero).
parent(luca, libero).
parent(anna, elisabetta).
parent(giacomo, elisabetta).

male(piero).
male(mario).
male(camillo).
male(nicola).
male(giacomo).
male(luca).
male(edoardo).
male(andrea).
male(libero).

female(giovanna).
female(maria).
female(maria_laura).
female(silvia).
female(anna).
female(erica).
female(elisabetta).

/* Definition of rules */

/* Father rule. X is the father of Y if X is male and X and Y are parent. */
father(X, Y) :- parent(X, Y), male(X).
father(X)    :- father(X, _).

/* Mother rule. X is the mother of Y if X is female and X and Y are parent. */
mother(X, Y)  :- parent(X, Y), female(X).
mother(X)     :- mother(X, _).

/* Son rule. X is the son of Y if X male and X and Y are parent. */
son(X, Y) :- parent(Y, X), male(X).
son(X)    :- son(X, _).

/* Daughter rule. X is the son of Y if X female and X and Y are parent. */
daughter(X, Y) :- parent(Y, X), female(X).
daughter(X)    :- daugher(X, _).

/* Married rule. X is married with Y if the X is the parent of Z and Y is the parent of Z */
married(X, Y) :- parent(X, Z), parent(Y, Z), X \== Y.
married(X)    :- married(X, _).

/* Brother rule. X is the brother of Y, if X is male and the father of X is the father of Y */
brother(X, Y) :- male(X), father(Z, X), father(Z, Y), X \== Y.
brother(X) :- brother(X, _).

/* Sister rule. X is the sister of Y, if X is female and the father of X is the father of Y */
sister(X, Y) :- female(X), father(Z, X), father(Z, Y), X \== Y.
sister(X) :- sister(X, _).

/* Grandmother rule. X is the grandmother of Y, if X is the mother of the father of Y or the mother of the mother of Y. */
grandmother(X, Y) :- father(Z, Y), mother(X, Z).
grandmother(X, Y) :- mother(Z, Y), mother(X, Z).
grandmother(X)    :- grandmother(X, _).

/* Grandfatherrule. X is the grandfather of Y, if X is the father of the father of Y or the father of the mother of Y. */
grandfather(X, Y) :- father(Z, Y), father(X, Z).
grandfather(X, Y) :- mother(Z, Y), father(X, Z).
grandfather(X)    :- grandmother(X, _).

/* Autn rule. X is the aunt of Y, if is the sister of the father of Y, or is the sister of the mother of Y. */
aunt(X, Y) :- father(Z, Y), sister(X, Z).
aunt(X, Y) :- mother(Z, Y), sister(X, Z).
aunt(X)    :- aunt(X, _).

/* Uncle rule. X is the uncle of Y, if is the brother of the father of Y, or is the brother of the mother of Y. */
uncle(X, Y) :- father(Z, Y), brother(X, Z).
uncle(X, Y) :- mother(Z, Y), brother(X, Z).
uncle(X)    :- uncle(X, _).

/* Cousin rule. X is the cousin of if the father or X is the brother of the fater of Y,
or if the father of X is the brother of the mother of Y, 
or if the mother of X is the sister of the mother of Y,
or if the mother of Y is the sister of the father of Y. */
cousin(X, Y) :- father(Z, X), father(W, Y), brother(Z, W).
cousin(X, Y) :- father(Z, X), mother(W, Y), brother(Z, W).
cousin(X, Y) :- mother(Z, X), father(W, Y), sister(Z, W).
cousin(X, Y) :- mother(Z, X), mother(W, Y), sister(Z, W).
cousin(X)    :- cousin(X, _).

/* Mother in law relationship. X is the mother in law of Y, if X and Z are married and Y is the mother of Z */
mother_in_law(X, Y) :- married(Y, Z), mother(X, Z).
mother_in_law(X)    :- mother_in_law(X, _).

/* Father in law relationsip. X is the father in law of Y, if X and Z are married and Y is the father of Z */
father_in_law(X, Y) :- married(Y, Z), father(X, Z).
father_in_law(X)    :- father_in_law(X, _).

/* Sister in law relationship. X is the sister in law of Y, if X and Z are married and Y is the sister of Z */
sister_in_law(X, Y) :- married(Y, Z), sister(X, Z).
sister_in_law(X)    :- sister_in_law(X, _).

/* Brother in law relationship. X is the brother in law of Y, if X and Z are married and Y is the brother of Z */
brother_in_law(X, Y) :- married(Y, Z), brother(X, Z).
brother_in_law(X)    :- brother_in_law(X, _).

/* Ancestor relationship. X is the ancestor of Y, if is X is the partent of Y, 
or Z is the parent of X and Z is the ancestor of Y. */
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).
ancestor(X, Y) :- parent(X, Y).

/* Descendant relationship. X is the descendant of Y, if Y is the ancestor of Y */
descendant(X, Y) :- ancestor(Y, X).