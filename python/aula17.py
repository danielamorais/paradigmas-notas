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
