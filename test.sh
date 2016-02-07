RUNNING=$(docker inspect --format="{{ .State.Running }}" "minecraft-run")

echo ">>$RUNNING<<"

if [ "${RUNNING}" = "true" ] ; then
   echo "IS RUNNING"
else
  echo "NOT RUNNING"
fi

