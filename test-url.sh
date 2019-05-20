#!/bin/bash

if [ "$1" == "" ]; then
  echo "Program should specified csv file"
  exit 2
fi

count=0
lst=$(grep '\n' $1 | cut -d, -f1)
for i in $(echo $lst | sed "s/,/ /g")
do
  status_code=$(curl --write-out %{http_code} --silent --output /dev/null $i)

  if [[ "$status_code" -ne 200 ]] ; then
    echo "[$count] [$status_code] [$i] error code from website"
  else
    echo "[$count] [$status_code] [$i] success"
  fi
  count=$(( $count + 1 ))
done

exit 1
