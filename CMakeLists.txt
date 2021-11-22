
cmake_minimum_required(VERSION 3.11)

project(cadical)

file(GLOB libcadical_SRC 
	src/*.cpp
	src/*.h)
file(GLOB libcadical_H
	src/*.h)
list (REMOVE_ITEM libcadical_SRC ${CMAKE_CURRENT_SOURCE_DIR}/src/cadical.cpp)
list (REMOVE_ITEM libcadical_SRC ${CMAKE_CURRENT_SOURCE_DIR}/src/mobical.cpp)
list (REMOVE_ITEM libcadical_SRC ${CMAKE_CURRENT_SOURCE_DIR}/src/signal.cpp)
#list (REMOVE_ITEM libcadical_SRC ${CMAKE_CURRENT_SOURCE_DIR}/src/resources.cpp)

add_compile_options(-fPIC)
set(CMAKE_CXX_FLAGS_RELEASE "-O3")
set(CMAKE_CXX_FLAGS_DEBUG "-O0 -g")

add_library(cadical ${libcadical_SRC})
#add_executable(cadical src/cadical.cpp)
#add_executable(mobical src/mobical.cpp)

add_definitions(-DNUNLOCKED)

file(WRITE
  ${CMAKE_CURRENT_BINARY_DIR}/build.hpp
  "#define VERSION \"1234\"")

include_directories(
	${CMAKE_CURRENT_SOURCE_DIR}/src
	${CMAKE_CURRENT_BINARY_DIR})

install(TARGETS cadical DESTINATION lib)
install(FILES ${libcadical_H} DESTINATION include)



