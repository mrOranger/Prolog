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
remove_head([_ | T], T).

/* Delete the tail from a list, requires two conditions.
1. If the list is empty, the result will be the empty list.
2. If the list has one or more elements, scan the list until the tail is reached and append the elements. 
Notice that in this case, the tail refers to the last element!*/
remove_tail([_ | []], []).
remove_tail([H | T], [H | L]) :- remove_tail(T, L).

/* Append one list to another, returns a list composed of two lists. 
1. If I'm passing an element, just return the lists whose head is that element.
2. If I'm passing a list, return the concatenation of the two lists.
*/
append_lists(X, L, [X | L]).

/* Get the last element of a list.
1. If the list is empty the last element is the empty list.
2. If the list is composed of only one element, the last element is the head.
3. If the list has more than one element. the last one must be find in the tail. 
*/
last_element([H | []], H).
last_element([_ | T], L) :- last_element(T, L).

/* Translate a list of numbers in a list of terms. 
First, we need relationships between the numbers and the terms as these */
interm(0, zero).
interm(1, one).
interm(2, two).
interm(3, three).
interm(4, four).
interm(5, five).
interm(6, six).
interm(7, seven).
interm(8, eight).
interm(9, nine).

inwords([H | []], [W]) :- interm(H, W).
inwords([H_1 | T_1], [H_2 | T_2]) :- interm(H_1, H_2), inwords(T_1, T_2).
