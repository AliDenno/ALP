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