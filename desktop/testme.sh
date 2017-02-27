#!/usr/bin/env bash


echo -n 'New password. If ready, type yes > '
read YESGATE

while [ ${YESGATE} != 'yes' ]
do
echo "You didn't type yes."
echo
echo -n 'New password. If ready, type yes > '
read YESGATE
done


if [ ${YESGATE} == 'yes' ]
    then
    echo 'woot'
fi



echo 'type hi'
read HI
echo ${HI}
echo 'this is $HI'
