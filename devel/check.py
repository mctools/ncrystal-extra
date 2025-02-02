#!/usr/bin/env python

import pathlib
import fnmatch

def check_identical_files( f1, f2 ):
    for f in (f1,f2):
        if not f.is_file():
            raise SystemExit(f'Missing file: {f}')
    assert f1.name == f2.name
    if f1.read_bytes() != f2.read_bytes():
        raise SystemExit(f'Files not identical: \n{f1} \n{f2}')
    print(f'  Checked similar content in copies of: {f1.name}')

def check_identical_files_in_dirs( d1, d2, pattern ):
    def get_files(d):
        return set([ f for f in d1.iterdir()
                     if ( f.is_file() and
                          ( pattern is None or fnmatch.fnmatch(f,pattern) )
                         )
                    ])

    files1 = get_files(d1)
    files2 = get_files(d2)
    if files1-files2:
        raise SystemExit(f'Missing in {d2}: {files1-files2}')
    if files2-files1:
        raise SystemExit(f'Missing in {d1}: {files2-files1}')
    for f in files1:
        check_identical_files( f, d2.joinpath(f.name) )

def check_copies():
    reporoot = pathlib.Path(__file__).parent.parent
    plugdatadir_waterdata = reporoot.joinpath('pypkgs',
                                              'ncrystal-plugin-WaterData',
                                              'src',
                                              'ncrystal_plugin_WaterData',
                                              'data')
    check_identical_files_in_dirs( reporoot.joinpath('data','validated'),
                                   plugdatadir_waterdata,
                                   pattern = '*Water*.ncmat')
    check_identical_files( reporoot.joinpath('LICENSE'),
                           reporoot.joinpath('pypkgs',
                                             'ncrystal-plugin-WaterData',
                                             'LICENSE' ) )


def main():
    check_copies()

if __name__ == '__main__':
    main()
