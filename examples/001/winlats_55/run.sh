# !/bin/bash
set -x
JAR_PATH=/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/compiler/trunk/target
SRC_PATH=/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/examples/winlats_55/src/main/clarion/main/
OUT_PATH=/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/examples/winlats_55/target/generated-sources/clarion
RUNTIME_PATH=/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/runtime/trunk/target
MAIN_CLASS=org.jclarion.clarion.compile.ClarionCompiler
TARGET_PATH=/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/examples/winlats_55.j/
EXEC_DIR=/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/examples/execute.jar/

#java -cp  $RUNTIME_PATH/clarion-runtime-1.122-SNAPSHOT.jar:$JAR_PATH/clarion-compile-1.22-SNAPSHOT.jar   $MAIN_CLASS  $SRC_PATH winlats.clw $OUT_PATH

mvn clean install

if [ $? -eq 0 ]
then
  echo "Successfully compiled"
  cp target/winlats55-1.0.jar $EXEC_DIR
  #  install java project as well to be used under eclipse
#  cp -r $OUT_PATH/clarion $TARGET_PATH/src/main/java/
#  (cd $TARGET_PATH; mvn install)
fi

