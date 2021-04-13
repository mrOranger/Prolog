/* The length of a list represents the number of elements in that list. */
list_length([], 0).
list_length([_ | B], N) :- list_length(B, M), N is M + 1.

/* The membership relationships, checks whenever an object is a member or not of a list */
is_member(H, [H | _]).
is_member(X, [_ | T]) :- is_member(X, T).

/* Given two lists L_1, L_2, the concatenation operator creates a new list which is the sum of the two lists */
concat_list([], L_2, L_2).
concat_list(L_2, [], L_2).
concat_list([H_1 | T_1], C_1, [H_1 | T_2]) :- concat_list(T_1, C_1, T_2).

/* Delete an item from a list, requires analyse the following cases:
1. If the element to delete is the head of the list, return the tail.
2. If the element to delete is in the tail, find in the tail and append the head. */
delete_item([H | T], H, T).
delete_item([H | T], X, [H | L]) :- delete_item(T, X, L).

/* Delete the head from a list, requires two conditions.
1. If the list is empty, the result will be the empty list.
2. If the list has one or more elements, just return the tail. */
remove_head([], []).
remove_head([_ | T], T).

/* Delete the tail from a list, requires two conditions.
1. If the list is empty, the result will be the empty list.
2. If the list has one or more elements, scan the list until the tail is reached and append the elements. 
Notice that in this case, the tail refers to the last element!*/
remove_tail([], []).
remove_tail([_ | []], []).
remove_tail([H | T], [H | L]) :- remove_tail(T, L).