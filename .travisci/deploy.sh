#!/bin/bash
docker push pistonsh/sfclassic:$TRAVIS_BUILD_NUMBER
docker push pistonsh/sfclassic:latest
