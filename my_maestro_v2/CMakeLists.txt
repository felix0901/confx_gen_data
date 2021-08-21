cmake_minimum_required (VERSION 2.8.11)
project (MAESTRO)

include_directories(lib/include/)
include_directories(lib/include/DSE/)
include_directories(lib/include/DFA)
include_directories(lib/include/DFSL)
include_directories(lib/include/base)
include_directories(lib/include/AHW-model)
include_directories(lib/include/cost-analysis)
include_directories(lib/include/tools)

find_package(Boost)
IF (Boost_FOUND)
    include_directories(${Boost_INCLUDE_DIR})
endif()


add_executable (cmake_maestro maestro-top.cpp
        lib/src/BS_base-objects.cpp
        lib/src/maestro.cpp
        lib/src/DSE.cpp
        )
