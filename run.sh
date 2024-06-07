#!/bin/bash
set -xe


checkExitCode() {
if [ $? -ne 0 ]; then
    echo "Error"
    exit 1;
fi
}

INPUTS_DIR=${_tapisExecSystemInputDir}
OUTPUTS_DIR=${_tapisExecSystemOutputDir}
NAM=$INPUTS_DIR/tmp.nam
BASEDIR=`dirname $0`

BAS6=$(basename $1)
DIS=$(basename $2)
BCF6=$(basename $3)
OC=$(basename $4)
WEL=$(basename $5)
DRN=$(basename $6)
RCH=$(basename $7)
HFB6=$(basename $8)
SIP=$(basename $9)

echo "## MODFLOW-2005 name-file" >> $NAM
echo "LIST    7    LST" >> $NAM
echo "BAS6    1    $BAS6" >> $NAM
echo "DIS    10    $DIS" >> $NAM
echo "BCF6    11   $BCF6" >> $NAM
echo "OC    22    $OC" >> $NAM
echo "WEL    12    $WEL" >> $NAM
echo "DRN    13    $DRN" >> $NAM
echo "RCH    18    $RCH" >> $NAM
echo "HFB6    26    $HFB6" >> $NAM
echo "SIP    19    $SIP" >> $NAM
echo "DATA(BINARY)    50    CBB" >> $NAM
echo "DATA(BINARY)    51    HDS" >> $NAM
echo "DATA(BINARY)    52    DDN" >> $NAM

mf2005 $NAM

mv LST ${OUTPUTS_DIR}/LST
mv CBB ${OUTPUTS_DIR}/CBB
mv HDS ${OUTPUTS_DIR}/HDS
mv DDN ${OUTPUTS_DIR}/DDN
checkExitCode