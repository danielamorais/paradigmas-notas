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
conta2(I, [X|R], N) :- conta(I,R,NN), (I=X, N is NN+1) : N = NN


