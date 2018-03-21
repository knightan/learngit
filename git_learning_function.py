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

a = product(2,3)
print(a)