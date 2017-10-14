%------------------------------------------------------------------------------------------------------------------------------%
/**GK
* The predicate length(List, Int) suceeds iff Arg2 is
* the number of elements in the list Arg1.
*/
/**AD
* We are traversing the list by calling the tail recursively until we reach an empty list, then The N is getting incremented with each step
* Out of the stack and passing the value back, So N -> N1 -> N11 -> N111 -> N111=0 then 
* N111 -> N11 0+1 -> N1 1+1 -> N 2+1 
*/
myLength([],0).
myLength([X|Xs],N):- myLength(Xs,N1), N is N1+1. 

/* Accumulators */
length_acc(L,N):-len_acc(L,0,N).
len_acc([H|T],A,N):- A1 is A+1, len_acc(T,A1,N).
len_acc([],A,A).
%------------------------------------------------------------------------------------------------------------------------------%
/**AD
* A basic predicate that would only copy a list into another, but it is good to check the way the head is copied to the second list 
* each time a recursive call is breaking out. 
*/
copy([],[]).
copy([H|T], [H|X]):- copy(T, X).

/**AD
* A basic predicate that would only copy a list into another incremented by 1
*/
Increment([],[]).
Increment([H|T], [H1|X]):- H1 is H+1, Increment(T, X).
%------------------------------------------------------------------------------------------------------------------------------% 
/**AD
* The predicate take a list and then return it in a reversed form, it keeps exhausting all the values of the list and when breaking the 
* recursive call it appends the head to the reversed tail as a result list. 
*/
myReverse([],[]).
myReverse([H|T],RList):- myReverse(T,RTail),append(RTail,[H],RList).

/* Accumulators */
reverse(L,RL):-reverse(L,[],RL).
reverse([],RL,RL).
reverse([Head|Tail],PreviousRL,RL):-reverse(Tail,[Head|PreviousRL],RL).
%------------------------------------------------------------------------------------------------------------------------------% 
/**AD
* Succeeds iff Arg2 is Arg1 ‘shifted rotationally’ by one element to the left 
* So Simply just add the head to the end of the list and fill them in the result. 
*/
shift([],[]).
shift([A|T],Result):- append(T,[A],Result).
%------------------------------------------------------------------------------------------------------------------------------%
/**AD
* A predicate that removes the first occurrence of Element in a List
* So there are two conditions, when the head is not equal to the element, then we just append the head to the result, otherwise and if the head is equal to the element
* We just go to the first clause, return the tail as the remaining result to append to previous heads and then simply return true and terminate. 
*/
removeFirst([H|T], H, T).
removeFirst([H|T], E, [H|P]) :- E \= H,
removeFirst(T, E, P).
%------------------------------------------------------------------------------------------------------------------------------%
/**AD
* A predicate that traverse the family tree, basically the first part of the body rule in the second clause is the pivot point,
* where it’s trying the combinations of all parents and then trying to relate them together. 	
*/
ancestor(Anc,Desc):- parent(Anc,Desc).
ancestor(Anc,Desc):- parent(Anc,X), ancestor(X,Desc).
%------------------------------------------------------------------------------------------------------------------------------%
/**GK
* The predicate append(L1, L2, L12) suceeds iff Arg3 is the list that results from concatenating Arg2 and Arg1.
*/
/**AD
* So the key Idea is that Every TL is decomposed into H|TL, so querying append([a,b],[c,d],L) at first the third argument L will be a|TL1 and this particular TL1
* will get the value of [b|TL2] after its called recursively, in a same manner thi TL2 will be assigned the value of the termination clause [c,d] as L is passed to L 
* which is traversed back.
* in other words : H|'TL' ---> 'H|"TL1"' ----> "H|"'TL11'""  , so you can see how each TL is decomposed.
*/
append([],L,L).
append([H|T],L,[H|TL]):-append(T,L,TL).
%------------------------------------------------------------------------------------------------------------------------------%
/**GK
* The predicate member(Elem, List) suceeds iff Arg1 is an element of the list arg2 or unifiable with an element of Arg2. 
*/
member(E,[E|_]).
member(E,[_|T]):-member(E,T).
%------------------------------------------------------------------------------------------------------------------------------%
/** Acessing List Elements
* Acessing elements at different positions
*/
/* First */
first([X|_],X).
/* Last */
last([X],X).
last([_|Xs],X):-last(Xs,X).
/* Position N */
nth(1,[X|_],X).
nth(N,[_|Xs],X):-N1 is N-1, nth(N1,Xs, X).
%------------------------------------------------------------------------------------------------------------------------------%
/**GK
* The split/4 predicate succeeds if Arg3 is a list that contains all elements of Arg2 that are smaller than Arg1 
* and Arg4 is a list that contains all elements of Arg2 that are bigger or equal to Arg1 
*/
split(_, [], [], []).
split(E,[H|T],[H|S],B):-H < E, split(E,T,S,B).
split(E,[H|T],S,[H|B]):-H >= E, split(E,T,S,B).
%------------------------------------------------------------------------------------------------------------------------------%
/**AD
* Predicate that returns the sum of list element. 
*/
sum([],0).
sum([H|T],S):- sum(T, ST), S is ST+H.
%------------------------------------------------------------------------------------------------------------------------------%
/**AD
* Check if there is a path between two rooms, while remembering the visited element. 
*/
connected(X,Y):-door(X,Y).
connected(X,Y):-door(Y,X).

path(X,Y):-path(X,Y,[X]).
path(X,Y,Visited):-connected(X,Y).
path(X,Y,Visited):-connected(X,Z),not(member(Z,Visited)),path(Z,Y,[Z|Visited]).

/* Improve it so no more linear time testing the list => constant time but we need clean up */
connected(X,Y):-door(X,Y).
connected(X,Y):-door(Y,X).

path(X,Y):- retractall(visited(_)), assert(visited(X)), path_(X,Y).
path_(X,Y):-connected(X,Y).
path_(X,Y):-connected(X,Z), not(visited(Z)), assert(visited(Z)), path_(Z,Y).
%------------------------------------------------------------------------------------------------------------------------------%
/**Puzzle:
1. Tick, Trick and Track are friends.
2. One friend is 15, one 17, and one 18 years but we do not know who has which age.
3. One friend’s last name is Chang.
4. Miss Yang is three years older than Tick.
5. The person whose last name is Thatcher is 17 years old.
*/
task_2_puzzle(FRIENDS):-
FRIENDS = [ person(tick,_,_,female),
person(trick,_,_,male),
person(track,_,_,female)
],
member(person(_,_,15,_), FRIENDS),
member(person(_,_,17,_), FRIENDS),
member(person(_,_,18,_), FRIENDS),
member(person(_,thatcher,17,_), FRIENDS),
member(person(_,chang,_,_), FRIENDS),
member(person(_,yang,A,female), FRIENDS),
member(person(tick,_,B,_), FRIENDS),
A is B+3.
%------------------------------------------------------------------------------------------------------------------------------%
/* Fails because the list [b|H] cannot be unified to the constant b. */
[a,[b|H]|C]=[a,b,c,d]

/* Fails because the list [b|H] cannot be unified to the constant b. */
[a,[b,H|C]]=[a,b,c,d].

/* {C <- [c,d] , B <- [b|H]} */
[a,[b|H]|C]=[a,B,c,d].

/* {A <- [X,Y] , B <- e , C <- y , D <- z} */
[[X,Y],e|[y,z]]=[A,B,C,D]

/* tail is larger than arguments on the right hand */
[[X,Y],e|[y,z,q]]=[A,B,C,D].

/* {C = 1, H = [2, 3, 4]} */
[C|H]=[1,2,3,4].

/* {C = 2, H = []} */
[1,C|H]=[1,2].

/* H = [c, d], C = []. */
[[b|H]|C]=[[b,c,d]] 

/* list with constant */
[[b|H]|C]=[b,c,d].

/* H = [c], C = a. */
[a,[b|H],C]=[a,[b,c],a].

/* again 2 is not a list  */
[1,[C|H]]=[1,2,3].

%------------------------------------------------------------------------------------------------------------------------------%
/*  check if the input is a list or not */
is_list([]).
is_list([_|T]) :- is_list(T).
%------------------------------------------------------------------------------------------------------------------------------%
linear([],[]).
linear([H|T], [H|TFlatt]):-
			not(is_list(H)),
			linear(T,TFlatt).
linear([H|T], Flatt):-
			linear(H, Hflatt),
			linear(T, Tflatt),
			append(Hflatt, Tflatt, Flatt).
%------------------------------------------------------------------------------------------------------------------------------%
do_list(N, L) :- do_list1(N, [], L).

do_list1(0, L, L) :- !.
do_list1(N, R, L) :- N > 0, N1 is N-1, do_list1(N1, [N|R], L).
%------------------------------------------------------------------------------------------------------------------------------%
/*  Fundamentals */
?- a = X.
X = a 
yes

?- X = Y.
X = H3
Y = H3 
yes

?- a == a.
yes

?- a == X.
no

?- X == Y.
no

?- X == X.
X = H3 
yes

?- not(not(a = X)).
X = H4 
yes

?- not(not(X = Y)).
X = H3
Y = H4 
yes

?- 1+1==1+1+0.
false.

?- 1+1=1+1+0.
false.

?- 1+1=:=1+1+0.
true.

?- 1+0 @< 1+0.
false.

?- 1+0+1 @< 1+0.
false.

?- 1 @< 1+0.
true
%------------------------------------------------------------------------------------------------------------------------------%

replace([],_,_,[]).
replace([Eold|Rest],Eold,Enew,[Enew|NewRest]) :- % Replace
					replace(Rest,Eold,Enew,NewRest).
replace([X|Rest],Eold,Enew,[X|NewRest]) :- % Keep head
					not(X==Eold),
					replace(Rest,Eold,Enew,NewRest).
%------------------------------------------------------------------------------------------------------------------------------%
% Interface predicate
sum_square(L, Sum, Square) :-
sum_square(L, 0, Sum, 0, Square). % Initialize accumulators to 0.
% Implementation using accumulators.
sum_square([], ASum, ASum, ASquare, ASquare) . % Terminal case
sum_square([H|T], ASum, Sum, ASquare, Square) :- % Recursive case
						NextASum is H+ASum,
						NextASquare is H*H + ASquare,
						sum_square(T, NextASum, Sum, NextASquare, Square).
%------------------------------------------------------------------------------------------------------------------------------%
%% nested_loop(?Outer,?Inner) is nondet
%
% Succeeds if Inner and outer are IDs of loops
% and Inner is nested within Outer.
nested_loop(Outer,Inner) :-
loop(Inner, _, _),
ast_ancestor(Inner,Outer),
loop(Outer, _, _).
%------------------------------------------------------------------------------------------------------------------------------%
%% replace(+OldList, +OldElem, +NewElem, ?NewList).
% 
% Succeed whenever NewList is the list that can be obtained from OldList by           % replacing EACH occurrence of OldElem by NewElem. 

replace([],_,_,[]).

replace([Eold|Rest],Eold,Enew,[Enew|NewRest]) :-    % Replace
   replace(Rest,Eold,Enew,NewRest).

replace([X|Rest],Eold,Enew,[X|NewRest]) :-          % Keep head
   not(X==Eold),
   replace(Rest,Eold,Enew,NewRest).
%------------------------------------------------------------------------------------------------------------------------------%


