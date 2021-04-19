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

/* Get the n-th element of a list (starting by 0 index), get_nth([Head | List], Index, Counter, Element).
Index is the index of the element to return.
Counter starts from 0 and goes until Index.
Element will the element to return.*/
get_nth([H | _], Index, Index, H).
get_nth([_ | L], Index, Counter, E) :- Counter_1 is Counter + 1, get_nth(L, Index, Counter_1, E).

/* Checks if two lists are equal, removing one element at time and comparing them. */
equals([], []).
equals([H_1 | T_1], [H_2 | T_2]) :- H_1 == H_2, equals(T_1, T_2).

/* Sum all the elements in a list */
sum([], 0).
sum([H | T], Sum_2) :- sum(T, Sum_1), Sum_2 is Sum_1 + H.

/* Replace an element of a list with another. Let's consider the basic case:
    - Replace an element of an empty list means that the results will be an empty list.
   The other cases are:
    - If the element to replace is the head of a list, then the new list will be the same,
      but with the head modified. 
    - If the element is inside the list, consider the remaining elements, and the new list is the same.
*/
replace([], _, _, []).
replace([H | T], H, Y, [Y | T]).
replace([H | T], X, Y, [H | L]) :- replace(T, X, Y, L).

/* Increase the element of a list with an inpute value. */
increase([], _, []).
increase([H | T], X, [Y | L]) :- increase(T, X, L), Y is H + X.

/* Remove duplicates from a list. */
remove_duplicate([], []).
remove_duplicate([H | T], L) :- member(H, T), remove_duplicate(T, L).
remove_duplicate([H | T], [H | L]) :- not(member(H, T)), remove_duplicate(T, L).

/* Push an element in the list */
push_elem(X, [], [X]).
push_elem(X, L, [X | L]).

/* Insert an element in the list in all possible positions */
list_insert(X, L, R) :- delete_item(R, X, L).

/* Reverse the elements of a given list.
   - If the list is empty, the result will be an empty list. */
reverse_list([], []).
reverse_list([H | T], R) :- reverse_list(T, L), concat_list(L, [H], R).

