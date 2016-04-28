# !/bin/bash
set -x
JAR_PATH=/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/compiler/trunk/target
SRC_PATH=/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/examples/HelloWorld/src/main/clarion/
OUT_PATH=/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/examples/HelloWorld/target/generated-sources/clarion/
RUNTIME_PATH=/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/runtime/trunk/target
MAIN_CLASS=org.jclarion.clarion.compile.ClarionCompiler
TARGET_PATH=/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/examples/HelloWorld.j/
EXEC_DIR=/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/examples/execute.jar/

java -cp  $RUNTIME_PATH/clarion-runtime-1.122-SNAPSHOT.jar:$JAR_PATH/clarion-compile-1.22-SNAPSHOT.jar   $MAIN_CLASS  $SRC_PATH helloworld.clw $OUT_PATH

if [ $? -eq 0 ]
then
  echo "Successfully compiled"
#  cp -r $OUT_PATH $TARGET_PATH/src/main/java/
#(cd $TARGET_PATH; mvn install)
#  cp $TARGET_PATH/target/helloworld-SNAPSHOT.jar $EXEC_DIR
fi

