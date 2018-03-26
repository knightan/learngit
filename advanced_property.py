# -*- coding: utf-8 -*-
"""
Created on Thu Mar 22 21:56:05 2018

@author: wasun
"""

##slice
#L = ['Michael', 'Sarah', 'Tracy', 'Bob', 'Jack']
#a = L[-2:-1]
#s = ' abc '
#
#def trim(str):
#    while(str[:1] != ' '):
#        str = str[1:]
#    while(str[-1:] != ' '):
#        str = str[:-2]
#    return str
#
#a = trim(s)
##print(a)
#
##iteration
#d = {'a': 1, 'b': 2, 'c': 3}
#for key in d:
#    print(key)
#
#for value in d.values():
#    print(value)
#
#for k, v in d.items():
#    print(k, v)
##    str
#for ch in 'ABC':
#    print(ch)
#
#from collections import Iterable
#a = isinstance(123,Iterable)
#print(a)
#
#for i, v in enumerate(L):
#    print(i, v)
#    
#for x, y in [(1, 1), (2, 4), (3, 9)]:
#    print(x,y)
#def findMinAndMax(L):
#    if L == []:
#        return None,None
#    else:
#        L1 = L[:]
#        L1.sort()
#        return (L1[0],L1[-1])
#
#L1 = [4, 6, 0, 2, 9]
#
#if findMinAndMax([]) != (None, None):
#    print('测试失败!')
#elif findMinAndMax([7]) != (7, 7):
#    print('测试失败!')
#elif findMinAndMax([7, 1]) != (1, 7):
#    print('测试失败!')
#elif findMinAndMax([7, 1, 3, 9, 5]) != (1, 9):
#    print('测试失败!')
#else:
#    print('测试成功!')
#
##print(findMinAndMax(L1))
#    
##List Comprehensions
#L1 = ['Hello', 'World', 18, 'Apple', None]    
#L2 = [s.lower() for s in L1 if isinstance(s, str)]
#print(L2)
#if L2 == ['hello', 'world', 'apple']:
#    print('测试通过!')
#else:
#    print('测试失败!')
    
#generator
def fib(max):
    n, a, b = 0, 0, 1
    while n < max:
        print(b)
        a, b = b, a + b
        n = n + 1
    return 'done'
n, a, b = 0, 0, 1
a, b = b, a + b

def triangles():
    L = [1]
    n = 0
    while n < 10:
        yield L
        L1 = []
        tmp = L[0]
        for i in L[1:]:
            L1.append(tmp + i)
            tmp = i
        L = [1] + L1 + [1]
        n = n + 1     

L = [1]
print(L[1:])
# 期待输出:
# [1]
# [1, 1]
# [1, 2, 1]
# [1, 3, 3, 1]
# [1, 4, 6, 4, 1]
# [1, 5, 10, 10, 5, 1]
# [1, 6, 15, 20, 15, 6, 1]
# [1, 7, 21, 35, 35, 21, 7, 1]
# [1, 8, 28, 56, 70, 56, 28, 8, 1]
# [1, 9, 36, 84, 126, 126, 84, 36, 9, 1]
#n = 0
#results = []
#for t in triangles():
#    print(t)
#    results.append(t)
#    n = n + 1
#    if n == 10:
#        break
#if results == [
#    [1],
#    [1, 1],
#    [1, 2, 1],
#    [1, 3, 3, 1],
#    [1, 4, 6, 4, 1],
#    [1, 5, 10, 10, 5, 1],
#    [1, 6, 15, 20, 15, 6, 1],
#    [1, 7, 21, 35, 35, 21, 7, 1],
#    [1, 8, 28, 56, 70, 56, 28, 8, 1],
#    [1, 9, 36, 84, 126, 126, 84, 36, 9, 1]
#]:
#    print('测试通过!')
#else:
#    print('测试失败!')