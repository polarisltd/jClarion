set -x
export RT=/home/robertsp/.m2/repository/org/jclarion/clarion-runtime/1.122-SNAPSHOT/
export CLASSPATH=../target/clarion-appgen-1.0-SNAPSHOT.jar:$RT/clarion-runtime-1.122-SNAPSHOT.jar:$CLASSPATH
java org.jclarion.clarion.appgen.dict.TextDictStoreMain src/main/clarion/common/winlats_160305.txd
