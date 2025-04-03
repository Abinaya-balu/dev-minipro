#!/bin/bash
    echo hi123
    chmod 777 build.sh
    echo build
    docker build -t test .
    docker login -u abinayabalusamy -p dckr_pat_JHYzC2wC8xUc2iq4-QSMIwHHkNs
    docker tag test abinayabalusamy/mern-app
    docker push abinayabalusamy/mern-app  
