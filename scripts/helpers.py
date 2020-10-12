#!/usr/bin/env python3
import os
import sys


def checkCwd():
    if 'KBHOME' in os.environ.keys():
        os.chdir(os.environ['KBHOME'])
        return

    # check if we are in the knowledgebase root folder
    cwd = os.getcwd()
    if cwd.rstrip('/').endswith('scripts'):
        # we are inside the script folder, change up
        os.chdir('..')

    if 'scripts' not in os.listdir():
        print('Please run this script from the knowledgebase root folder or set the KBHOME environment variable')
        sys.exit(1)


def createFileList(tags=False):
    # create a list of all markdown files, ignoring files and folders in the ignorefile
    ignoreFileList = []
    ignoreFolderList = []

    # read ignore file
    # every file in here should be ignored
    # every line ending with / is a directory and should also be ignored
    # lines starting with # are comments
    # one file/folder/comment per line
    for line in [x.strip() for x in open('scripts/ignorefile').readlines()]:
        if line.startswith('#') or len(line) == 0:
            continue
        if line.endswith('/'):
            ignoreFolderList.append(line.rstrip('/'))
        else:
            ignoreFileList.append(line)

    filelist = []

    if tags is True:
        path = os.path.join(os.getcwd(), '.tags')
    else:
        path = os.getcwd()
    for root, dirs, files in os.walk(path):
        ignoreFolder = False
        for folder in ignoreFolderList:
            if folder in root and not (tags is True and folder == '.tags'):
                ignoreFolder = True
                break

        if ignoreFolder:
            continue

        for f in files:
            if f.lower().endswith('.md') and f not in ignoreFileList:
                filelist.append(os.path.join(root, f))
    return filelist
