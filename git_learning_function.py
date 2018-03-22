# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
import math

def quadratic(a, b, c):
    x1 = (-b + math.sqrt(b^2 - 4*a*c))/(2*a)
    x2 = (-b - math.sqrt(b^2 - 4*a*c))/(2*a)
    return x1, x2

def product(*nums):
    production = 1
    n = 0
    length = len(nums)
    while n < length:
        production = production*nums[n]
        n = n + 1
    return production

def hanoti(n,x1,x2,x3):
    if(n == 1):
        print('move:',x1,'-->',x3)
        return
    hanoti(n-1,x1,x3,x2)
    print('move:',x1,'-->',x3)
    hanoti(n-1,x2,x1,x3)
hanoti(3,'A','B','C')       
a = product(2,3)
print(a)