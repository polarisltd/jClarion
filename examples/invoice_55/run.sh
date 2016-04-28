# !/bin/bash
set -x
JAR_PATH=/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/compiler/trunk/target
SRC_PATH=/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/examples/invoice_55/src/main/clarion/main/
OUT_PATH=/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/examples/invoice_55/target/generated-sources/clarion/
RUNTIME_PATH=/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/runtime/trunk/target
MAIN_CLASS=org.jclarion.clarion.compile.ClarionCompiler
java -cp  $RUNTIME_PATH/clarion-runtime-1.122-SNAPSHOT.jar:$JAR_PATH/clarion-compile-1.22-SNAPSHOT.jar   $MAIN_CLASS  $SRC_PATH invoice.clw $OUT_PATH