#!/usr/bin/python
# Filename: merge_strings.py
# -*- coding: utf-8 -*-

import os
import sys
import re
import codecs

reload(sys)
sys.setdefaultencoding('utf-8')

os.system(r"find ../Classes -name '*.m' | xargs genstrings -o ./")

f_ori_strings = './Localizable.strings'
encoding = 'utf-16'
fp = codecs.open(f_ori_strings, 'r+', encoding)
try:
    content = fp.readlines()
    array = []
    for eachline in content:
        if eachline.find(' = ') != -1:
            endchar = eachline.find('=')
            array.append(eachline[:endchar])
            array.append(' \n')
finally:
    fp.close()

f_chn_strings = '../i18n/zh-Hans.lproj/Localizable.strings'
fp1 = open(f_chn_strings, 'r+')
try:
    content2 = fp1.readlines()
    array2 = []
    for eachline2 in content2:
        if eachline2.find(' = ') != -1:
            array2.append(eachline2)
    array.extend(array2)
finally:
    fp1.close()

fo = open('./tempOutput.txt', 'w+')
try:
    for item in array:
        fo.write(str(item))
finally:
    fo.close()

fname = './tempOutput.txt'
fp = open(fname, 'r+')
try:
    content = fp.readlines()
    dictory = {}
    matcher = re.compile(r'^".*" ')
    for eachline in content:
        m = matcher.match(eachline)
        if m:
            s = m.group()
        else:
            s = '';
            print '!!!!!!!!!!!!!!!!!'
        if not dictory.get(s):
            if eachline.find(' = ') == -1:
                dictory[s] = eachline
        else:
            del dictory[s]
            dictory[s] = eachline
    array = dictory.values()
    array.sort()
    array1 = []
    array2 = []

    for item in array:
        if item.find (' = ') != -1:
            array1.append(item)
        else:
            array2.append(item[:-2] + '= "";\n')
    array1.sort()
    array2.sort()
    array1.append('\n\n----untranslate words----\n\n')
    array1.extend(array2)
finally:
    fp.close()

file_object = open('./output.txt', 'w+')
try:
    for item in array1:
        file_object.write(str(item))
finally:
    file_object.close()

#os.system('subl ./output.txt +10000')
reload(sys)
