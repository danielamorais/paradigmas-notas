## lista com apenas valores pares de outra lista
l = [2, 3, 4, 5, 6]
[x for x in l if x % 2 == 0]

## lista com apenas posições pares, considerando que começa do 1 
items = [2, 3, 4, 5, 6]
l = []

for index, item in enumerate(items):
    if (index + 1) % 2 == 0:
         l.append(item)

print(l)

## chave associada ao maior valor num dicionario
d = {'a': 1, 'b': 3, 'c': 4, 'd': 5, 'e': 6}

maiorValor = 0
for key, value in d.items():
    if value > maiorValor:
        maiorValor = value

for key, value in d.items():
    if maiorValor == value:
        print(key)

## criar um dicionario com a contagem de cada elemento numa lista
d = {}
l = [2, 2, 3, 2, 2, 6]

for i in l:
    if d.get(i) is None:
        d[i] = 1
    else:
        atual = d.get(i)
        d[i] = atual + 1

for key, value in d.items():
    print(key, value)

## uma lista é sublista de outra?
a = [1, 2, 3, 4, 5, 6]
b = [2, 1, 3, 1, 4]

isSublist = False
if ([x for x in range(len(a)) if a[x:x+len(b)] == b]) != []:
     isSublist = True

print(isSublist)
