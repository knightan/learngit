#!/usr/bin/env python3
# -*- coding: utf-8 -*-

' a test module '

__author__ = 'Arthur Wang'

#__slots__
#class Student(object):
#    __slots__ = ('name', 'age') # 用tuple定义允许绑定的属性名称
#
#s = Student()
#s.name = 'Arthur'
#s.age = 25
##s.score = 99
#
#class GraduateStudent(Student):
#    pass
#
#g = GraduateStudent()
#g.score = 99
#
#print(g.score)

#使用@property
#class Screen(object):
#
#    @property
#    def width(self):
#        return self._width
#
#    @width.setter
#    def width(self, value):
#        self._width = value
#        
#    @property
#    def height(self):
#        return self._height
#
#    @height.setter
#    def height(self, value):
#        self._height = value
#        
#    @property
#    def resolution(self):
#        return self._width*self._height
#    
## 测试:
#s = Screen()
#s.width = 1024
#s.height = 768
#print('resolution =', s.resolution)
#if s.resolution == 786432:
#    print('测试通过!')
#else:
#    print('测试失败!')

#定制类

#__str__
#class Student(object):
#    def __init__(self, name):
#         self.name = name
#    def __str__(self):
#         return 'Student object (name: %s)' % self.name
#    __repr__ = __str__
#    
#print(Student('Michael'))
#__iter__
#class Fib(object):
#    def __init__(self):
#        self.a, self.b = 0, 1 # 初始化两个计数器a，b
#
#    def __iter__(self):
#        return self # 实例本身就是迭代对象，故返回自己
#
#    def __next__(self):
#        self.a, self.b = self.b, self.a + self.b # 计算下一个值
#        if self.a > 100000: # 退出循环的条件
#            raise StopIteration()
#        return self.a # 返回下一个值
#
#for n in Fib():
#    print(n)

#__getitem__
print(range(100))

