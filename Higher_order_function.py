# -*- coding: utf-8 -*-
"""
Created on Wed Mar 28 18:05:37 2018

@author: wasun
"""
def add(x, y, f):
    return f(x) + f(y)

print(add(-5, -6, abs))
