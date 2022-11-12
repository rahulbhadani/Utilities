#!/bin/bash

read -p "Enter the folder where you want to generate the Python package: " folder_name
read -p "Enter the package name: " package
read -p "Enter the author's name: " author
read -p "Enter the maintainer's email: " email
read -p "Enter the organization's name: " org
read -p "Enter your github username/org username: " github
dt=$(date +%Y-%m-%d)

# Check if the package folder to be created exists or not

if [ -d $folder_name/$package ]
then
    echo "Directory $folder_name/$package exists. Not creating ..."
else
    mkdir -p $folder_name/$package/$package
fi

touch $folder_name/$package/LICENSE
echo -e "License: MIT License (c) Copyright $author, $org . Initial Date: $dt
Permission is hereby granted, free of charge, to any person obtaining a copy of this
software and associated documentation files (the 'Software'), to deal in the Software
without restriction, including without limitation the rights to use, copy, modify,
merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to the following
conditions: The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS, COPYRIGHT HOLDERS OR $org BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT
OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE." >> $folder_name/$package/LICENSE



# Creating __init__.py
if [ -f $folder_name/$package/$package/__init__.py ]; then
    echo "init in $package exists. Not creating."
else
    touch $folder_name/$package/$package/__init__.py
fi

read -p "Enter the class name in the module $package: " class
if [ -f $folder_name/$package/$package/$class.py ]; then
    echo "class $class exists. Not creating."
else
    touch $folder_name/$package/$package/$class.py
    echo -e "#!/usr/bin/env python\n# coding: utf-8\n# Author : $author\n# Initial Date: $dt\n__author__ = '$author'\n__email__  = '$email'\n# For System and OS level task\nimport sys, getopt\n\nclass $class:\n\tdef __init__(self,  *args, **kwargs):\n\t\tpass">>$folder_name/$package/$package/$class.py
fi

echo -e "from .$class import $class" >> $folder_name/$package/$package/__init__.py

# Create a version file
if [ -f $folder_name/$package/$package/version ]; then
    echo "version exists. Not creating."
else
    touch $folder_name/$package/$package/version
    echo -e "0.0.1" >>  $folder_name/$package/$package/version
fi

# Create a README
if [ -f $folder_name/$package/README.md ]; then
    echo "README exists. Not creating."
else
    touch $folder_name/$package/README.md
    echo -e "# $package\n\n(c) Copyright $author" >>  $folder_name/$package/README.md
fi

# Create a CHANGELOG
if [ -f $folder_name/$package/CHANGELOG.rst ]; then
    echo "Changelog exists. Not creating."
else
    touch $folder_name/$package/CHANGELOG.rst
    echo -e "# CHANGELOG\n## $dt \n- Package $package created." >>  $folder_name/$package/CHANGELOG.rst
fi

# Create MANIFEST
if [ -f $folder_name/$package/MANIFEST.in ]; then
    echo "MANIFEST exists. Not creating."
else
    touch $folder_name/$package/MANIFEST.in
    echo -e "include README.md" >>  $folder_name/$package/MANIFEST.in
fi

# Create requirements.txt
if [ -f $folder_name/$package/requirements.txt ]; then
    echo "requirements.txt exists. Not creating."
else
    touch $folder_name/$package/requirements.txt
    echo -e "setuptools" >>  $folder_name/$package/requirements.txt
fi


# Create Setup.py
if [ -f $folder_name/$package/setup.py ]; then
    echo "setup.py exists. Not creating."
else
    touch $folder_name/$package/setup.py
    echo -e "import setuptools
from distutils.dir_util import copy_tree
from pathlib import Path
PACKAGE_NAME='$package'
MODULE_NAME='$package'
import shutil, os
os.makedirs(os.path.dirname(PACKAGE_NAME + '/README.md'), exist_ok=True)
shutil.copy('README.md', PACKAGE_NAME + '/README.md')
def readme():
    with open('README.md', 'r') as fh:
        long_description = fh.read()
        return long_description

v = Path(MODULE_NAME + '/version').open(encoding = 'utf-8').read().splitlines()
setuptools.setup(
    name='$package',
    version=v[0].strip(),
    author='$author',
    author_email='$email',
    description='A package $package.',
    long_description=readme(),
    long_description_content_type='text/markdown',
    url='https://github.com/$github/$package',
    packages=setuptools.find_packages(),
    install_requires=[
        l.strip() for l in Path('requirements.txt').open(encoding = 'utf-8').read().splitlines()
        ],
    classifiers=[
        'Programming Language :: Python :: 3',
        'Framework :: AsyncIO',
        'Topic :: Communications',
        'Topic :: Scientific/Engineering :: Visualization',
        'License :: OSI Approved :: MIT License',
        ],
    keywords='python',
    include_package_data=True,
    package_data={'$package': ['README.md','version']},
    zip_safe=False
        )

os.remove('$package/README.md')
" >>  $folder_name/$package/setup.py
fi

# Create a script to package and upload to pip
if [ -f $folder_name/$package/pack_and_upload.sh ]; then
    echo "pack_and_upload.sh exists. Not creating."
else
    touch $folder_name/$package/pack_and_upload.sh
    echo -e "#!/bin/bash
rm -rf build/ dist/ *.egg-info*/
python setup.py bdist_wheel --universal
twine upload dist/*
" >>  $folder_name/$package/pack_and_upload.sh
    chmod +x  $folder_name/$package/pack_and_upload.sh
fi


read -p "Upload to pypi? (yes/no): " bool_pypi
if [ "$bool_pypi" = "yes" ] ; then
    cd $folder_name/$package/ && ./pack_and_upload.sh
    cd -
fi

if [ -f $folder_name/$package/.gitignore ]; then
    echo ".gitingore exists. Not creating."
else
    touch $folder_name/$package/.gitignore
    echo -e "build/
dist/
*.egg-info*/
" >>  $folder_name/$package/.gitignore
fi


echo "Make sure to first create an empty https://github.com/$github/$package before proceeding".

read -p "Create a github repo for this? (yes/no): " bool_git
if [ "$bool_git" = "yes" ] ; then
    #curl -u rahulbhadani https://api.github.com/$github/$package -d "{'name':'$package','private':false}"
    cd $folder_name/$package/ && git init
    cd $folder_name/$package/ && git add .
    cd $folder_name/$package/ && git commit -m "first commit"
    cd $folder_name/$package/ && git remote add origin https://github.com/$github/$package.git
    cd $folder_name/$package/ && git branch -M main
    cd $folder_name/$package/ && git push -u origin main
fi

read -p "Create documentation? (yes/no): " bool_doc

if [ "$bool_doc" = "yes" ] ; then
    if [ -f $folder_name/$package/.nojekyll ]; then
        echo ".nojekyll exists. Not creating."
    else
        touch $folder_name/$package/.nojekyll
        cd $folder_name/$package && git add .nojekyll
    fi
    
    # Create docs folder
    if [ -d $folder_name/$package/docs ]; then
        echo "docs exists. Not creating."
    else
        mkdir -p $folder_name/$package/docs
        cd $folder_name/$package/docs && sphinx-quickstart
        cd $folder_name/$package && git add docs

    fi
    cd $folder_name/$package && git commit -m "Created docs folder" && git push
fi
