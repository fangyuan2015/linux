BASE_PATH=$(cd `dirname $0`; pwd)
PID_DIR="$BASE_PATH/pid"

if [ ! -d "$PID_DIR" ]; then
    echo ""
    echo "PID_DIR not exist."
    echo ""
    exit 1
fi

PID_FILE="$PID_DIR/pid.log"

if [ ! -f "$PID_FILE" ]; then
    echo ""
    echo "PID_FILE not exist."
    echo ""
    exit 1
fi

PID=`cat $PID_FILE`
IFS=" "
PIDS=($PID)

for p in ${PIDS[@]}
do
    kill -9 $p
done

echo "" > "$PID_FILE"
echo "processes $PID are killed"

