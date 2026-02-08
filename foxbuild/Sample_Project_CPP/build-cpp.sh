#!/bin/sh
source ./project.env
source ./build.env

$CXX $(find $SRC_DIR $LIB_DIR -type f -iregex ".*\.c\|.*\.cpp") $CXXFLAGS -I./$LIB_DIR -o ./$BUILD_DIR/$PROJECT_NAME-test.elf
