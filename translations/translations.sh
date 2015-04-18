#!/bin/bash

BASE_DIR=`pwd`
OUT_DIR=$1

if [ -z ${OUT_DIR} ]
then
    OUT_DIR=${BASE_DIR}/translations
fi

echo "=== out dir is == ${OUT_DIR}"

if [ ! -d ${OUT_DIR} ]
then
	mkdir ${OUT_DIR}
fi

TRANSLATIONS=\
(\
	"phoenixplayer.ts" \
	"phoenixplayer-zh_CN.ts" \
)
        
TS_FILE=${BASE_DIR}/phoenixplayer.ts

TRANSLATION_SOURCES=\
(\
	"${BASE_DIR}/../qml" \
	"${BASE_DIR}/../src/app" \
)

lupdate -noobsolete ${TRANSLATION_SOURCES[@]} -ts ${TS_FILE} ${TRANSLATIONS[@]}

for i in ${TRANSLATIONS[@]}
do
	cp -fR $i ${OUT_DIR}/${i}
	lrelease -nounfinished  ${OUT_DIR}/${i}
done
