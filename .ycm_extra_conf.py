#
# Default YCM config powered with bear (https://github.com/rizsotto/Bear)!
# pylint: disable=invalid-name, missing-docstring, import-error, line-too-long, undefined-variable
#

import os
import ycm_core
from clang_helpers import PrepareClangFlags

def FindCompileCommands():
    path = os.getcwd()
    first = os.path.split(os.path.sep)[0]
    while path is not first and not os.path.isfile(os.path.join(path, 'compile_commands.json')):
        path = os.path.dirname(path)

    if path is first:
        return None

    return path


# Set this to the absolute path to the folder (NOT the file!) containing the
# compile_commands.json file to use that instead of 'flags'. See here for
# more details: http://clang.llvm.org/docs/JSONCompilationDatabase.html
# Most projects will NOT need to set this to anything; you can just change the
# 'flags' list of compilation flags. Notice that YCM itself uses that approach.
compilation_database_folder = FindCompileCommands()

if compilation_database_folder is not None:
    database = ycm_core.CompilationDatabase(compilation_database_folder)
else:
    database = None

def MakeRelativePathsInFlagsAbsolute(flags, working_directory):
    if not working_directory:
        return flags

    new_flags = []
    make_next_absolute = False
    path_flags = ['-isystem', '-I', '-iquote', '--sysroot=']
    for flag in flags:
        new_flag = flag

        if make_next_absolute:
            make_next_absolute = False
            if not flag.startswith('/'):
                new_flag = os.path.join(working_directory, flag)

        for path_flag in path_flags:
            if flag == path_flag:
                make_next_absolute = True
                break

            if flag.startswith(path_flag):
                path = flag[len(path_flag):]
                new_flag = path_flag + os.path.join(working_directory, path)
                break

        if new_flag:
            new_flags.append(new_flag)

    return new_flags

def FlagsForFile(filename):
    if not database:
        return None

    # Bear in mind that compilation_info.compiler_flags_ does NOT return a
    # python list, but a "list-like" StringVec object
    compilation_info = database.GetCompilationInfoForFile(filename)
    final_flags = PrepareClangFlags(MakeRelativePathsInFlagsAbsolute(
        compilation_info.compiler_flags_, compilation_info.compiler_working_dir_), filename)

    return {
        'flags': final_flags,
        'do_cache': True
    }
