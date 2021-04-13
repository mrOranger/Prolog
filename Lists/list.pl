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