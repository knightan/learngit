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
print(a)

