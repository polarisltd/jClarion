#!/bin/bash
for i in target/*.clw target/*.CLW target/*.INC 
do
	F=${i#target/*}
	diff -q --strip-trailing-cr target/$F ~/personal/c8/java/clarion/c9/src/main/clarion/main/$F >/dev/null
	if [ $? -ne 0 ]
	then
		echo diff --strip-trailing-cr target/$F ~/personal/c8/java/clarion/c9/src/main/clarion/main/$F 
	fi
done
