#!/bin/sh
source ./project.env
source ./build.env

$CC $(find $SRC_DIR $LIB_DIR -type f -iregex ".*\.c") $CCFLAGS -I./$LIB_DIR -o ./$BUILD_DIR/$PROJECT_NAME-test.elf

