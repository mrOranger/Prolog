/* Defining the module set, the predicates that can be exported and their ariety */
:- module(set, [find/2, remove/3, max_value/2, max_value/3, swi_max_value/2, swi_max_value/3, merge_set/3, intersect/3]).

/*# From this moment, the predicates will be preceded by a description, in Declarative Language, of their working */


/* find predicate verifies if an element (Element) belongs to or not in a given set (Set).
    1. If the set has just one element, and the element is the given one, then the predicate is true, and cut the tree. 
    2. If the element is not empty and is not the first element, then find it in the rest of the set. 
*/
find([H | _], H) :- !.
find([_ | T], Element) :- find(T, Element).

/* remove predicate removes an element (Element) from a given set (Set).
    1. If the set is empty, then the resulting set is an empty set.
    2. If the list is composed of just one element, and the element is the selected one, then the result will be the empty list. 
    2. If the head if the set is the element to remove, then the resulting set is the tail of the first.
    3. If the element is not the head, then the set will not modified.
*/
remove([], _, []).
remove([X], X, []).
remove([H | T], H, T).
remove([H_1 | T_1], Element, [H_1 | Set_3]) :- remove(T_1, Element, Set_3), !.

/* max_value predicates returns the highest value in a set of numbers. In this implementation we are going to use two predicates
    with the same name but different ariety. In the first case we just split the set and call the next predicate, setting the
    current highest value with the head.
    The predicate is implemented by using the "red" cuts, which changes the procedural and declarative interpretation of the predicate as:
    predicate :- condition, !, true_case.
    predicate :- false_case. 
    Interpreting the predicate as: if (condition) then true_case else false_case.
*/
max_value([H | T], Max) :- max_value([H | T], H, Max).

max_value([], Curr, Curr).
max_value([H | T], Curr, Max) :- greater(H, Curr), !, max_value(T, H, Max).
max_value([_ | T], Curr, Max) :- max_value(T, Curr, Max).

/* By using SWIPL, we can write the predicate in a more compact way:
    predicate :- condition -> true_case ; false_case.
*/
swi_max_value([H | T], Max) :- max_value([H | T], H, Max).

swi_max_value([], Curr, Curr).
swi_max_value([H | T], Curr, Max) :- greater(H, Curr) -> max_value(T, H, Max) ; max_value(T, Curr, Max).

/* Union predicate merges two sets (Set_1, Set_2), in a new one (Set_3).
    1. If the two sets are empty, then the merge is an empty set.
    2. If one set is empty and the other one not, then the merge is the non-empty set.
    3. If the sets are not empty, then the merge is the result.
    N.B.: the name of the predicate is not union due the conflict with the union built-in predicate.
*/
merge_set([], [], []) :- !.
merge_set([], Set_2, Set_2).
merge_set([H_1 | T_1], Set_2, [H_1 | Set_3]) :- merge_set(T_1, Set_2, Set_3).

/* intersect predicate performs the intersection between two sets (Set_1, Set_2) in a new one (Set_3).
    1. If the two sets are empty, then the intersection will be the empty set.
    2. If one of the two sets is empty, then the intersection will be the non-empty set.
    3. If the sets are not empty, and the head of the first set doesn't appear in the second set,
    then the intersection will be the head plus the rest of the second set.
    N.B.: in this first implementation, the sets must have different values. 
*/
intersect([], [], []) :- !.
intersect([], Set_2, Set_2).
intersect([H_1 | T_1], Set_2, [H_1 | Set_3]) :- not(find(Set_2, H_1)), intersect(T_1, Set_2, Set_3).



/* Some useful predicates */
greater(X, Y) :- X >= Y.