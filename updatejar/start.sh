BASE_PATH=$(cd `dirname $0`; pwd)
PID_DIR="$BASE_PATH/pid"

if [ ! -d "$PID_DIR" ]; then
    mkdir "$PID_DIR"
fi

PID_FILE="$PID_DIR/pid.log"

if [ ! -f "$PID_FILE" ]; then
    touch "$PID_FILE"
else
    echo "" > "$PID_FILE"
fi

#JAVA_OPTS="-Dspring.profiles.active=prod"
JAVA_OPTS="-Dspring.profiles.active=prod -Dspring.config.location=file:./config/application-prod.properties"
JAVA_OPTS="$JAVA_OPTS -javaagent:/opt/pinpoint-agent/pinpoint-bootstrap-1.7.1.jar"

API_AGENTID="cusc-rnr-api-$1"
SERVICE_AGENTID="cusc-rnr-service-$1"
PORTAL_AGENTID="cusc-rnr-portal-$1"
H5_AGENTID="cusc-rnr-h5-$1"
NOTIFIER_AGENTID="cusc-rnr-notifier-$1"
TASK_AGENTID="cusc-rnr-task-$1"
ADMIN_AGENTID="cusc-rnr-admin-$1"
REPORT_AGENTID="cusc-rnr-report-$1"

PIDS=""
nohup java $JAVA_OPTS  -Dpinpoint.agentId=$API_AGENTID -Dpinpoint.applicationName=cusc-rnr-api  -Xms8G -Xmx8G -jar cusc-rnr-api-1.0.jar >/dev/null 2>&1 &
PID=$!
echo "cusc-rnr-api is start ok, pid: $PID"
PIDS="$PID"

nohup java $JAVA_OPTS -Dpinpoint.agentId=$SERVICE_AGENTID -Dpinpoint.applicationName=cusc-rnr-service -Xms8G -Xmx8G -jar cusc-rnr-service-1.0.jar >/dev/null 2>&1 &
PID=$!
echo "cusc-rnr-service is start ok, pid: $PID"
PIDS="$PIDS $PID"

nohup java $JAVA_OPTS -Dpinpoint.agentId=$PORTAL_AGENTID -Dpinpoint.applicationName=cusc-rnr-portal -Xms8G -Xmx8G  -jar cusc-rnr-portal-1.0.jar >/dev/null 2>&1 &
PID=$!
echo "cusc-rnr-portal is start ok, pid: $PID"
PIDS="$PIDS $PID"

nohup java $JAVA_OPTS -Dpinpoint.agentId=$H5_AGENTID -Dpinpoint.applicationName=cusc-rnr-h5 -Xms8G -Xmx8G  -jar cusc-rnr-h5-1.0.jar >/dev/null 2>&1 &
PID=$!
echo "cusc-rnr-h5 is start ok, pid: $PID"
PIDS="$PIDS $PID"

nohup java $JAVA_OPTS -Dpinpoint.agentId=$NOTIFIER_AGENTID -Dpinpoint.applicationName=cusc-rnr-notifier -Xms8G -Xmx8G  -jar cusc-rnr-notifier-1.0.jar >/dev/null 2>&1 &
PID=$!
echo "cusc-rnr-notifier is start ok, pid: $PID"
PIDS="$PIDS $PID"

nohup java $JAVA_OPTS -Dpinpoint.agentId=$ADMIN_AGENTID -Dpinpoint.applicationName=cusc-rnr-admin -Xms4G -Xmx4G -jar cusc-rnr-admin-1.0.jar >/dev/null 2>&1 &
PID=$!
echo "cusc-rnr-admin is start ok, pid: $PID"
PIDS="$PIDS $PID"

nohup java $JAVA_OPTS -Dpinpoint.agentId=$TASK_AGENTID -Dpinpoint.applicationName=cusc-rnr-task  -Xms4G -Xmx4G  -jar cusc-rnr-task-1.0.jar >/dev/null 2>&1 &
PID=$!
echo "cusc-rnr-task is start ok, pid: $PID"
PIDS="$PIDS $PID"

nohup java $JAVA_OPTS -Dpinpoint.agentId=$REPORT_AGENTID -Dpinpoint.applicationName=cusc-rnr-report -Xms2G -Xmx2G -jar cusc-rnr-report-1.0.jar >/dev/null 2>&1 &
PID=$!
echo "cusc-rnr-report is start ok, pid: $PID"
PIDS="$PIDS $PID"

echo "$PIDS" > "$PID_FILE"
