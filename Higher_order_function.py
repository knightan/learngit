# -*- coding: utf-8 -*-
"""
Created on Wed Mar 28 18:05:37 2018

@author: wasun
"""
#def add(x, y, f):
#    return f(x) + f(y)
#
##print(add(-5, -6, abs))
##map&reduce
#def f2(x):
#    return x*x
#
#l = [1, 2, 3, 4, 5, 6]
#r = map(f2, l)
#a = list(r)
##print(a)
#
#def add2(x, y):
#    return x + y
#
#from functools import reduce
#
#b = reduce(add2, l)
##print(b)
##nomalize
#def normalize(name):
#    return name.capitalize()
#
#L1 = ['adam', 'LISA', 'barT']
#L2 = list(map(normalize, L1))
#
##prod
#def prod0(x, y):
#    return x*y
#def prod(L):
#    return reduce(prod0, L)

#print('3 * 5 * 7 * 9 =', prod([3, 5, 7, 9]))
#if prod([3, 5, 7, 9]) == 945:
#    print('测试成功!')
#else:
#    print('测试失败!')

#str2float
#DIGITS = {'0': 0, '1': 1, '2': 2, '3': 3, '4': 4, '5': 5, '6': 6, '7': 7, '8': 8, '9': 9, '.':10}
#str1 = '123.456'
#s = list(str1)
#def char2num(s):
#    return DIGITS[s]
#def f(x, y):
#    return x * 10 + y
#
#def str2float(s):
#    a = str1.index(".")
#    str2 = s.remove('.')
#    n = reduce(f, map(int, str2))
#    m = len(str1) - a - 1
#    return n/pow(10, m)
#
#print('str2float(\'123.456\') =', str2float('123.456'))
#if abs(str2float('123.456') - 123.456) < 0.00001:
#    print('测试成功!')
#else:
#    print('测试失败!')

# anonymous function
#def is_odd(n):
#    return n % 2 == 1
#
#L = list(filter(is_odd, range(1, 20)))

#L = list(filter(lambda x: x % 2 == 1, range(1, 20)))
#print(L)

#decorator
#
#def log(func):
#    def wrapper(*args, **kw):
#        print('call %s():' % func.__name__)
#        return func(*args, **kw)
#    return wrapper
#
#@log
#def now():
#    print('2015-3-25')
#print(now.__name__)

#partial function


import functools
int2 = functools.partial(int, base=2)
print(int2('1000000'))