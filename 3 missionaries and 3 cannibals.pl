
%one of missionaries
move([[M1,C1],[M2,C2],P],[[M3,C1],[M4,C2],P1]):-
    P=0,
    M1>0,
    M3 is M1-1,
    M4 is M2+1,
    P1=1.

move([[M1,C1],[M2,C2],P],[[M3,C1],[M4,C2],P1]):- %2
    P=1,
    M2>0,
    M3 is M1+1,
    M4 is M2-1,
    P1=0.


%one of cannibals
move([[M1,C1],[M2,C2],P],[[M1,C3],[M2,C4],P1]):-
    P=0,
    C1>0,
    C3 is C1-1,
    C4 is C2+1,
    P1=1.
move([[M1,C1],[M2,C2],P],[[M1,C3],[M2,C4],P1]):- %4 %8 %10
    P=1,
    C2>0,
    C3 is C1+1,
    C4 is C2-1,
    P1=0.

%two of missionaries
move([[M1,C1],[M2,C2],P],[[M3,C1],[M4,C2],P1]):- %5 %7
    P=0,
    not(M1<2),
    M3 is M1-2,
    M4 is M2+2,
    P1=1.
move([[M1,C1],[M2,C2],P],[[M3,C1],[M4,C2],P1]):-
    P=1,
    not(M2<2),
    M3 is M1+2,
    M4 is M2-2,
    P1=0.


%two of cannibals
move([[M1,C1],[M2,C2],P],[[M1,C3],[M2,C4],P1]):- %3 %9 %11
    P=0,
    not(C1<2),
    C3 is C1-2,
    C4 is C2+2,
    P1=1.
move([[M1,C1],[M2,C2],P],[[M1,C3],[M2,C4],P1]):-
    P=1,
    not(C2<2),
    C3 is C1+2,
    C4 is C2-2,
    P1=0.

%one of cannibals and one of  missionaries
move([[M1,C1],[M2,C2],P],[[M3,C3],[M4,C4],P1]):- %1
    P=0,
    C1>0,
    M1>0,
    C3 is C1-1,
    C4 is C2+1,
    M3 is M1-1,
    M4 is M2+1,
    P1=1.

move([[M1,C1],[M2,C2],P],[[M3,C3],[M4,C4],P1]):- %6
    P=1,
    C2>0,
    M2>0,
    C3 is C1+1,
    C4 is C2-1,
    M3 is M1+1,
    M4 is M2-1,
    P1=0.


save([[M1,C1],[M2,C2],_]):-
    (
        M1>C1;M1=C1;M1=0
    ),
    (
        M2>C2;M2=C2;M2=0
    ),!.


savepath([[0,0],[3,3],1], R,R).

savepath(Current,Visited,R):-
    move(Current,Next),
    save(Next),
    not(member(Next,Visited)),
    savepath(Next,[Next|Visited],R).


game(R):-
    X =[[3,3],[0,0],0],
    savepath(X,[X],R),
    printres(R).


printres([]).
printres([H|T]):-
    write(H),
    write("\n"),
    printres(T).


