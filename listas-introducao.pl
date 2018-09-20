/** tamanho de lista: **/

tam2(L, T) = tam2(L, T, 0).
tam2([], L, T) :- T = A.
tam2([]_R, T, A) :- AA is A+1, tam2(R, T, AA).

/** tamanho de lista com acumulador: **/
 accLen(List,Acc,Length).
 accLen([_|T],A,L) :- Anew  is  A+1,  accLen(T,Anew,L). 
 accLen([],A,A).

/** soma de itens de uma lista: **/

soma([], 0).
soma([X|XS], S) :- soma(XS, SS), S is SS+X.

/** soma([3, 4, 5, 6], 18) verifica se a soma é igual a 18 **/

/** dado n gera lista de 1 a n,  de N a 1 é mais simples: **/

gera(0, []).
gera(N, L) :- NN is N-1, gera(NN, LL), L = [N|LL].

/** Soma dos itens pares de uma lista: **/

somapar([], 0).
somapar([X|XS], S) :- somapar(XS, SS), 0 is mod(X,2), S is SS+X.

/** soma dos elementos nas posições pares da lista: **/

somaacc([], 0, 0).
somaacc([X|XS], A, S) :- 0 is mod(A,2), somaacc(XS,Anew,SS), Anew is A+1, S is SS+X.

/** existe item na lista elem: **/

member(X,[X|T]). 
member(X,[H|T]) :- member(X,T).

/** posição do item na lista: 1 se é o primeiro, falha se nao esta na lista pos(+IT,+LISTA,-POS): **/

pos(1, X, [X|T]).
pos(A, X, [H|T]) :- pos(Anew, X, T), Anew is A+1

/** conta quantas vezes o item aparece na lista (0 se nenhuma) conta(+IT,+LISTA,-CONTA) **/

conta(0, X, []).
conta(A, X, [H|T]) :- member(X, H), conta(Anew, X, T), Anew is A+1

/** maior elemento de uma lista - maior(+LISTA,-MAX) **/

maior(X, [X|T])
maior(X, [H|T]) :- H > X, maior(XS, T),XS is H

/** a lista ja esta ordenada **/

ordenada(X, [X|T])
ordenada(X, [H|T]) :- H >= X, ordenada(XS, T), XS is H
