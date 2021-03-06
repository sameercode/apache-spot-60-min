#!/bin/bash
# start ingest

### send flow data
cd
mkdir -p /collector_path/flow
rm -f /collector_path/flow/*
tar -xvf data/nfcapd_aws_utc_an.tar.gz -C /collector_path/flow

## wait 5 min
echo "waiting 5 min for flow collector and worker to populate data"
sleep 5m

## spot ml
cd
cd incubator-spot/spot-ml
./ml_ops.sh 20160127 flow .1 200

## spot oa
cd
cd incubator-spot/spot-oa/oa
python2.7 start_oa.py -d 20160127 -t flow -l 3000