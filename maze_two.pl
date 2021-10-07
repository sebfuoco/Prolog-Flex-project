% Facts
link(entry, a).
link(a, b).
link(b, c).
link(b, e).
link(c, d).
link(d, e).
link(e, f).
link(f, c).
link(f, exit).
% Rule 1
route1(X,Y) :- link(X,Y).
route(X,Y) :- link(X,Z), link(Z,Y).
% Recursive Rule
route2(X,Z) :- link(X,Z).
route2(X,Z) :- link(X,Y), route(Y,Z).

check(X,[X|_]). % stop endless loop | (a, [a,b,c]) = true
check(X,[_|T]):-check(X,T).

path(Start,End,Path) :- path(Start,End,[Start], Path). % path(a,f,[])
path(start,end,rpath,path):- reverse(rpath,path). % reverse list

%\+ check(Next,V),
% check if already visted before use. V = visited list.
path(Start,End,V,Path_list):-
	link(Start,Next),
	\+ check(Next,V), % check if next path is in visited rooms
	append(V,[Next],Path),
	\+ check(End,Path), % check if end is in visited rooms
	path(Next,End,Path,Path_list).

% -> Find all possible routes and store in list.
% -> Display list after every iteration(when Exit is reached).
% List Rule
visit(A,B,C) :- append([A],[B],C).
rt(X,Y,Z) :- route1(X,Y), append([X],[Y],Z).
% member([1,2,3], [X]).
