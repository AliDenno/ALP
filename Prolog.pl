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
