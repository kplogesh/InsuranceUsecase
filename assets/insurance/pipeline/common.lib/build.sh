#!/bin/bash
cd assets/insurance/insurance-usecase-type-apigw-extes/applications/
ls -ltr
docker build -t wm.msr.tn.app:r.$1 -f tradingnetworks/dev/Dockerfile .