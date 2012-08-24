
==============
QuantLib-cmake
==============

QuantLib-cmake is a cmake build system for QuantLib (1.2). This describes 
how to use the build system to build QuantLib.


--------------
1. PREPARATION
--------------

First, you need first to put the files in the archive into a clean QuantLib source tree:

# say you clone/unpack this archive in the folder /path/to/QuantLib-cmake
# copy its contents into your fresh & clean QuantLib folder:
cd /to/your/QuantLib-1.2 ; cp -r /path/to/QuantLib-cmake/* .


--------------------
2. CONFIGURE & BUILD
--------------------

In the configure step, cmake will look for dependencies (eg, Boost), and process the given options to determine settings.

2.1 Instructions for a console (out of source) build:

# go to the build directory in your QuantLib-1.2. This is the folder where CMake will put the resulting makefiles/project files.
cd /to/your/QuantLib-1.2/build
# configure cmake, giving the path (in this case, ..) to the main CMakeLists.txt
cmake ..
# now compile
make

If you want to see the compiler command lines, then the make command should be 'make VERBOSE=1'.

It is also possible to generate project files for standard IDEs using the command line. Type 'cmake --help' for instructions. There are several QuantLib options, listed below, which can be given in this step.


2.2 Instructions for a GUI build

2.2.1 Open cmake-gui. 
2.2.2 Select the QuantLib-1.2 folder in the "Browse Source" button. This is the folder where the main CMakeLists.txt is located.
2.2.3 Select the QuantLib-1.2/build folder in the "Browse Build" button. This is the folder where CMake will put the generated project files.
2.2.4 Hit the Configure button.
2.2.5 Choose a compiler/generator/IDE and press Finish. You can also choose standard Makefiles.
2.2.6 The resulting setup will be summarized in the main widget. Edit options as you see fit.
2.2.7 Hit Configure until no more new changes (highlighted in red) appear.
2.2.8 Hit Generate to generate the project files.
2.2.9 Using your chosen IDE, open the generated project files and build them.



----------
3. INSTALL
----------

2.1 Console

In the console, simply type:

make install

This will install QuantLib into the default directory (eg, /usr/local/QuantLib-1.2). 
If you want to install to a different folder, you will have to instruct cmake to do so. This is done in the configuration step, which now becomes (just as above, note the .. path at the end):

cmake -DCMAKE_INSTALL_PREFIX=/your/install/folders ..


2.2 When using an IDE, simply build the INSTALL target.


------------------------
4. CONFIGURATION OPTIONS
------------------------

This section describes the available QuantLib configuration options, 
as well as other relevant options.

The options for QuantLib in cmake have been setup so that defaults are
the same as in autotools. Further, to simplify editing the options in 
cmake-gui and its curses counterpart ccmake, the prefix QuantLib_ has 
been used in any QuantLib specific options.

To set the value of the options in the GUI, just click on its right field.
These widgets are specialized, so for example when choosing a path, cmake
will open up a path chooser dialog. To set the value of the options in the
 command line, simply pass the flag -D<OPTION>=<VALUE>, eg:

cmake -DQuantLib_ENABLE_MSG_ERROR_LINES=ON ..


Configuration options:
----------------------

CMAKE_INSTALL_PREFIX - Path where QuantLib should be installed.


QuantLib options:
-----------------

QuantLib_BUILD_STATIC               - Build a static library. Default=ON.
QuantLib_BUILD_SHARED               - Build a shared library. Default=OFF.

QuantLib_ENABLE_MSG_ERROR_LINES     - Whether to print file and line info
                                      in error messages. Default=OFF.
QuantLib_ENABLE_MSG_FUNCTIONS       - Whether to print function names
                                      in error messages. Default=OFF.
QuantLib_ENABLE_MSG_TRACING         - Whether to print traces in error 
                                      messages. Degrades performance. Default=OFF.

QuantLib_ENABLE_INDEXED_COUPONS     - Use indexed coupons in a floating rate leg. 
                                      Use par coupons otherwise. Default=OFF.
QuantLib_ENABLE_NEGATIVE_RATES      - Allow negative yield rates in a few places 
                                      where they are currently forbidden. It is 
                                      still not clear whether this is safe. 
                                      Default=OFF.
QuantLib_ENABLE_EXTRA_SAFETY_CHECKS - Add extra runtime checks to a few functions. 
                                      This can prevent their inlining and degrade 
                                      performance. Default=OFF.
QuantLib_ENABLE_DEPRECATED_CODE     - Include deprecated code in the library. 
                                      Default=ON.
QuantLib_ENABLE_SESSIONS            - If enabled, singletons will return different
                                      instances for different sessions. Default=. 
                                      You will have to provide and link with the 
                                      library a sessionId() function in namespace 
                                      QuantLib, returning a different session id 
                                      for each session. Default=OFF.

QuantLib_WITH_EXAMPLES              - Whether to build and install examples. 
                                      Default=OFF.
QuantLib_WITH_EXAMPLES_IN_SHARE     - Whether the examples binaries and respective
                                      sources shall be put in the install share folder. 
                                      When OFF, the binaries go to bin and the source
                                      is not copied. Default=OFF.

QuantLib_WITH_BENCHMARK             - Whether to build and install benchmarks. When 
                                      ON will require linking with 
                                      boost::unit_test_framework, which is handled 
                                      automatically by cmake. Default=OFF.
QuantLib_Boost_USES_MULTITHREADED   - Use the multithreaded Boost libraries. 
                                      Default=OFF.
QuantLib_Boost_USES_STATIC_LIBS     - Use the static Boost libraries. Default=OFF.
QuantLib_Boost_USES_STATIC_RUNTIME  - Searches for Boost libraries linked against a 
                                      static C++ standard library (ABI tag s). 
                                      Default=OFF.

Compiler options:
-----------------

CMAKE_CXX_FLAGS  - Flags to pass the compiler.

CMAKE_BUILD_TYPE - None: no flags are added (except of course, CMAKE_CXX_FLAGS)
                   Debug: debug flags are added by cmake
                   Release: optimization flags -O2
                   MinSizeRel: min size release
                   ReleaseWithDebInfo: release with debug info

Boost options:
--------------

Boost_DEBUG - Debug the handling of cmake's search for the Boost libraries.


--------
5. NOTES
--------


There are currently two places which raise issues of compatibility
of cmake with autotools (which I hope you'll help me fix):

- Eventual special compilation flags issued by autotools are not dealt with.

- The obtaining of ql/config.hpp . Currently I've added ql/config.hpp.cmake
which is processed into config.hpp . This is done from the file config.cmake. 
As it stands, this is not actually incompatible, but it will always
require sync between changes to any input config.hpp.

- In the test suite, autotools creates automatically a main.cpp. It was not
easy for me to see the reason for this, so I've put it statically in the
test folder.

It is because of these caveats that I started above by advising use of a
clean QuantLib tree. Nevertheless, I was able to have a tree with both build
systems working.


-----------------------------
6. USING WITH THE ECLIPSE IDE
-----------------------------

When CMake generates a project for an IDE (or any project, for that matter),
the project file is generated in the build dir (the dir from where cmake is
called) rather than the source dir (the dir where the main CMakeLists.txt
is located. When the build dir is a subdir of the source dir, this creates
a problem with Eclipse, which does not allow CVS/SVN to work when the .project
is not in the CVS/SVN root directory.

To deal with this, CMake recommends to use a build dir which is a sibling
of the source directory. This effectively solves the problem. This, however
requires the user to have two QuantLib dirs side by side, which may not be desired.

To address this, there is a CMake switch to create the .project in the
 source dir: CMAKE_ECLIPSE_GENERATE_SOURCE_PROJECT. For example, when the
command line, the command to generate the Eclipse project becomes:

cmake -G "Eclipse CDT4 - Unix Makefiles" -DCMAKE_ECLIPSE_GENERATE_SOURCE_PROJECT=ON ..




