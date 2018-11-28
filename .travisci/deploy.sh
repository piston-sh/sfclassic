#!/bin/bash
docker push sourceforts/server:$TRAVIS_BUILD_NUMBER
docker push sourceforts/server:latest