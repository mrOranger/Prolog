/* Definition of facts */
parent(carlo, stefano).
parent(anna, stefano).
parent(alfonso, marcella).
parent(iginia, marcella).
parent(francesco, alfonso).
parent(lucia, alfonso).
parent(iginia, carlo).
parent(alfonso, carlo).
parent(pietro, francesco).
parent(giovanni, anna).
parent(immacolata, anna).

male(carlo).
male(stefano).
male(alfonso).
male(francesco).
male(pietro).
male(giovanni).

female(anna).
female(marcella).
female(iginia).
female(lucia).
female(immacolata).

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

/* Brother rule. X is the brother of Y, if X is male and the father of X is the father of Y */
brother(X, Y) :- male(X), father(Z, X), father(Z, Y), X \== Y.
brother(X) :- brother(X, _).

/* Sister rule. X is the sister of Y, if X is female and the father of X is the father of Y */
sister(X, Y) :- female(X), father(Z, X), father(Z, Y), X \== Y.
sister(X) :- sister(X, _).

/* Grandmother rule. X is the grandmother of Y, if X is the mother of the father of Y or the mother of the mother of Y. */
grandmother(X, Y) :- female(X), father(Z, Y), mother(X, Z).
grandmother(X, Y) :- female(X), mother(Z, Y), mother(X, Z).
grandmother(X)    :- grandmother(X, _).

/* Grandfatherrule. X is the grandfather of Y, if X is the father of the father of Y or the father of the mother of Y. */
grandfather(X, Y) :- male(X), father(Z, Y), father(X, Z).
grandfather(X, Y) :- male(X), mother(Z, Y), father(X, Z).
grandfather(X)    :- grandmother(X, _).

/* Autn rule. X is the aunt of Y, if is the sister of the father of Y, or is the sister of the mother of Y. */
aunt(X, Y) :- female(X), father(Z, Y), sister(X, Z).
aunt(X, Y) :- female(X), mother(Z, Y), sister(X, Z).
aunt(X)    :- aunt(X, _).

/* Uncle rule. X is the uncle of Y, if is the brother of the father of Y, or is the brother of the mother of Y. */
uncle(X, Y) :- female(X), father(Z, Y), brother(X, Z).
uncle(X, Y) :- female(X), mother(Z, Y), brother(X, Z).
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