#!/bin/sh
ENVIRONMENT="production"
WORKING_DIR="/home/ubuntu"
APP="auth-service-$ENVIRONMENT-all.jar"
APP_NAME="awantunai-auth-service"
APP_JAR="$WORKING_DIR/$APP_NAME/$APP"
LOG_DIR="/mnt/nfs/logs/auth-service"

echo "APP_JAR : $APP_JAR"

JVM_DEBUG="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005"
JVM_ARGS="-javaagent:$WORKING_DIR/newrelic/newrelic.jar -Dlogback.configurationFile=$WORKING_DIR/$APP_NAME/config/logback.xml -DconfigPath=$WORKING_DIR/$APP_NAME -server -Xms1g -Xmx1g -XX:MaxMetaspaceSize=256m -Xmn256m -XX:SurvivorRatio=8 -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:+UseCMSInitiatingOccupancyOnly -XX:CMSInitiatingOccupancyFraction=70 -XX:+ScavengeBeforeFullGC -XX:+CMSScavengeBeforeRemark -XX:+PrintGCDateStamps -verbose:gc -XX:+PrintGCDetails -Xloggc:"$LOG_DIR/auth-service-gc" -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=10 -XX:GCLogFileSize=100M -Dsun.net.inetaddr.ttl=60 -XX:+HeapDumpOnOutOfMemoryError"
JMX_ARGS=" -Dcom.sun.management.jmxremote.port=19999 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false"
APP_ARGS=""

if [ "$1" ]; then
        if [ "$1" = "start" ]; then
                echo $$ > $WORKING_DIR/$APP_NAME/auth-service.pid;
                exec /usr/bin/java $JVM_ARGS -jar $APP_JAR
        fi
        if [ "$1" = "stop" ]; then
                echo "stopping $APP_NAME.."
                sudo kill $(cat $WORKING_DIR/$APP_NAME/auth-service.pid);
                sudo rm $WORKING_DIR/$APP_NAME/auth-service.pid
                echo "$APP_NAME successfully stopped."
        fi
        if [ "$1" = "debug" ]; then
                echo "debugging with arguments $JVM_DEBUG"
                echo $$ > $WORKING_DIR/$APP_NAME/auth-service.pid;
                exec /usr/bin/java $JVM_DEBUG $JVM_ARGS -jar $APP_JAR
        fi
else
        echo "please give argument 'start' or 'stop'.."
fi
