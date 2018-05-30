##!/usr/bin/env python3
## -*- coding: utf-8 -*-
#
#' a test module '
#
#__author__ = 'Arthur Wang'
#
##class Student(object):
##
##    def __init__(self, name, score):
##        self.name = name
##        self.score = score
##
##    def print_score(self):
##        print('%s: %s' % (self.name, self.score))
##
##    def get_grade(self):
##        if self.score >= 90:
##            return 'A'
##        elif self.score >= 60:
##            return 'B'
##        else:
##            return 'C'
##        
##lisa = Student('Lisa', 99)
##print(lisa.name, lisa.get_grade())
##lisa.print_score()
#
##访问限制
#
#class Student(object):
#
#    def __init__(self, name, score):
#        self.__name = name
#        self.__score = score
#
#    def print_score(self):
#        print('%s: %s' % (self.__name, self.__score))
#
#    def get_name(self):
#        return self.__name
#    
#    def set_name(self, name):
#        self.__name = name
#        
#bart = Student('Bart Simpson', 59)
#bart.set_name('Bart')
#
#bart.__name = 'new name'
#print(bart.__name)
#print(bart.get_name())
#

#继承和多态
class Animal(object):
    def run(self):
        print('Animal is running...')

class Dog(Animal):

    def run(self):
        print('Dog is running...')

    def eat(self):
        print('Eating meat...')
        
class Cat(Animal):

    def run(self):
        print('Cat is running...')
        
def run_twice(animal):
    animal.run()
    animal.run()
        
dog = Dog()
cat = Cat()


cat.run()
dog.run()
dog.eat()
print(isinstance(dog,Cat))
run_twice(Dog())
