import os
import sys
from setuptools import setup, find_packages
from fnmatch import fnmatchcase
from distutils.util import convert_path

standard_exclude = ('*.pyc', '*~', '.*', '*.bak', '*.swp*')
standard_exclude_directories = ('.*', 'CVS', '_darcs', './build', './dist', 'EGG-INFO', '*.egg-info')

def find_package_data(where='.', package='', exclude=standard_exclude, exclude_directories=standard_exclude_directories):
    out = {}
    stack = [(convert_path(where), '', package)]
    while stack:
        where, prefix, package = stack.pop(0)
        for name in os.listdir(where):
            fn = os.path.join(where, name)
            if os.path.isdir(fn):
                bad_name = False
                for pattern in exclude_directories:
                    if (fnmatchcase(name, pattern)
                        or fn.lower() == pattern.lower()):
                        bad_name = True
                        break
                if bad_name:
                    continue
                if os.path.isfile(os.path.join(fn, '__init__.py')):
                    if not package:
                        new_package = name
                    else:
                        new_package = package + '.' + name
                        stack.append((fn, '', new_package))
                else:
                    stack.append((fn, prefix + name + '/', package))
            else:
                bad_name = False
                for pattern in exclude:
                    if (fnmatchcase(name, pattern)
                        or fn.lower() == pattern.lower()):
                        bad_name = True
                        break
                if bad_name:
                    continue
                out.setdefault(package, []).append(prefix+name)
    return out

setup(name='docassemble.AppearanceEfile',
      version='1.1.0b12',
      description=('Appearance'),
      long_description='# docassemble.AppearanceEfile\r\n\r\nAppearance, with E-filing.\r\n\r\nA complete duplicate of https://github.com/IllinoisLegalAidOnline/docassemble-Appearance,\r\nbut with e-filing added. This is a pilot project, and separated so the original Appearance\r\ncan stay stable as experimental features are added to this e-filing version.\r\n\r\n## Author\r\n\r\nMatt Newsted, mnewsted@illinoislegalaid.org\r\nBryce Willey, bwilley@suffolk.edu\r\n',
      long_description_content_type='text/markdown',
      author='Matt Newsted',
      author_email='66691956+mnewsted@users.noreply.github.com',
      license='The MIT License (MIT)',
      url='https://www.illinoislegalaid.org',
      packages=find_packages(),
      namespace_packages=['docassemble'],
      install_requires=['docassemble.AssemblyLine>=2.26.0', 'docassemble.EFSPIntegration>=1.4.3', 'docassemble.ILAOEfile>=1.0.4'],
      zip_safe=False,
      package_data=find_package_data(where='docassemble/AppearanceEfile/', package='docassemble.AppearanceEfile'),
     )

