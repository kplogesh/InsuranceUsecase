#!/bin/bash
echo "*************************"
echo "************Build********"
echo "*************************" 
ls -ltr
cd assets/insurance/insurance-usecase-type-apigw/applications/
ls -ltr
docker build -t test-assessments:10.15 -f assessments/Dockerfile .