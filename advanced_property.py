# -*- coding: utf-8 -*-
"""
Created on Thu Mar 22 21:56:05 2018

@author: wasun
"""

#slice
L = ['Michael', 'Sarah', 'Tracy', 'Bob', 'Jack']
a = L[-2:-1]
s = ' abc '

def trim(str):
    while(str[:1] != ' '):
        str = str[1:]
    while(str[-1:] != ' '):
        str = str[:-2]
    return str

a = trim(s)
#print(a)

#iteration
d = {'a': 1, 'b': 2, 'c': 3}
for key in d:
    print(key)

for value in d.values():
    print(value)

for k, v in d.items():
    print(k, v)
#    str
for ch in 'ABC':
    print(ch)

from collections import Iterable
a = isinstance(123,Iterable)
print(a)

for i, v in enumerate(L):
    print(i, v)
    
for x, y in [(1, 1), (2, 4), (3, 9)]:
    print(x,y)
def findMinAndMax(L):
    if L == []:
        return None,None
    else:
        L1 = L[:]
        L1.sort()
        return (L1[0],L1[-1])

L1 = [4, 6, 0, 2, 9]

if findMinAndMax([]) != (None, None):
    print('测试失败!')
elif findMinAndMax([7]) != (7, 7):
    print('测试失败!')
elif findMinAndMax([7, 1]) != (1, 7):
    print('测试失败!')
elif findMinAndMax([7, 1, 3, 9, 5]) != (1, 9):
    print('测试失败!')
else:
    print('测试成功!')

#print(findMinAndMax(L1))