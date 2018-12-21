#!/usr/bin/env python
import sys
import os
import shutil
import subprocess
import glob
import collections

PACKAGES = collections.OrderedDict([('boost', []),
                                    ('tbb', []),
                                    ('ilmbase', []),
                                    ('pyilmbase', ['boost', 'ilmbase']),
                                    ('openexr', ['ilmbase'])])
PACKAGES['all'] = PACKAGES.keys()

PACKAGE_FILES = {}

def main(args):
    curdir = os.path.abspath(os.curdir)
    workspace = os.path.dirname(os.path.dirname(curdir))

    print('Building all in workspace %s'%workspace)
    os.environ['WORKSPACE'] = workspace
    
    print('Downloading...')
    for pkg in PACKAGES.keys():
        subprocess.check_call('%s/download.sh'%pkg)

    for pkg, deps in PACKAGES.iteritems():
        print('Building %s...'%pkg)
        for dep in deps:
            dst = os.path.join(pkg, os.path.basename(PACKAGE_FILES[dep]))
            if not os.path.exists(dst):
                print('Copying {} -> {}'.format(PACKAGE_FILES[dep], dst))
                shutil.copyfile(PACKAGE_FILES[dep], dst)
        cwd = os.path.join(curdir, pkg)
        subprocess.check_call('docker build -t {pkg}-builder .'.format(pkg=pkg), cwd=cwd, shell=True)
        subprocess.check_call('docker run --name {pkg}-builder --rm -v {cwd}:/mnt/dist {pkg}-builder'.format(pkg=pkg, cwd=cwd), cwd=cwd, shell=True)
        pkgFile = glob.glob('%s/%s*vfx-2018.tar.bz2'%(pkg, pkg))[0]
        print('Built artifact: {}'.format(pkgFile))
        PACKAGE_FILES[pkg] = pkgFile

if __name__ == '__main__':
    sys.exit(main(sys.argv))
