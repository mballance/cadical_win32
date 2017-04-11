#!/bin/sh

cd `dirname $0`

die () {
  echo "*** run-api-tests.sh: $*" 1>&2
  exit 1
}

CXX="`grep '^CXX=' ../build/makefile|sed -e 's,CXX=,,'`"

echo "using CXX=$CXX"

run () {
  echo "compiling and executing $1"
  set -x
  $CXX -g api/$1.cpp -o api/$1.exe -L ../build -lcadical || exit 1
  api/$1.exe > api/$1.log 2> api/$1.err || exit 1
  set +x
}

crun () {
  echo "compiling and executing $1"
  set -x
  cc -c -g api/$1.c -o api/$1.o || exit 1
  $CXX -g api/$1.o -o api/$1.exe -L ../build -lcadical || exit 1
  api/$1.exe > api/$1.log 2> api/$1.err || exit 1
  set +x
}


run newdelete
run unit
run morenmore

crun ctest
