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