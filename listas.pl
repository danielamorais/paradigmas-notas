conta(_, [], 0).
/** Isso é um IF que se X igual a I, entra no resto da linha.
** Caso contrário, vai para a próxima linha
**/
conta(I, [X|R], N) :- X = I, conta(I,R,NN), N is NN+1. (isso é um if que se X igual I, entra no resto da linha. Caso contrário, vai p a proxima)
conta(I, [X|R], N) :- conta(I,R,NN), N is NN.

/** É equivalente a (sem fazer teste de igualdade diretamente) **/

conta(_, [], 0).
conta(I, [I|R], N) :- conta(I,R,NN), N is NN+1.
conta(I, [X|R], N) :- conta(I,R,NN), N is NN.

conta2(_, [], 0).
conta2(I, [X|R], N) :- conta(I,R,NN), (I=X, N is NN+1) : N = NN.

/** Teste: Maneiras equivalentes de remover a primeira ocorrencia de um elemento numa lista **/
rem(_, [], []).
rem(I, [X|R], L) :- X=I, L=R.
rem(I, [X|R], L) :- rem(I, R, LL), L=[X|LL].

rem2(_,[], []).
rem2(I, [I|R], R).
rem2(I, [X|R], [X|LL]) :- rem2(I,R,LL).

/** Soma de pares. O input é somap([2,3,4,5,6,5,4,4,3,0], N) **/
somap([], 0).
somap([X|R],S) :- X mod 2 =:= 0, somap(R, SS), S is SS+X.
somap([_|R],S) :- somap(R,S).
