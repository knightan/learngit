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
class Screen(object):

    @property
    def width(self):
        return self._width

    @width.setter
    def width(self, value):
        self._width = value
        
    @property
    def height(self):
        return self._height

    @height.setter
    def height(self, value):
        self._height = value
        
    @property
    def resolution(self):
        return self._width*self._height
    
# 测试:
s = Screen()
s.width = 1024
s.height = 768
print('resolution =', s.resolution)
if s.resolution == 786432:
    print('测试通过!')
else:
    print('测试失败!')