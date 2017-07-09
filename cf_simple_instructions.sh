#!/bin/bash
# Tested on a Mac Computer

# 07-09-2017
#
# This script will delete any pre-existing application instances of the Cities Demo Project
# by deleting the apps: cities-hello, cities-service, and cities-ui
# and by deleteing the services: cities-service-db and cities-ws
# If the above-mentioned Apps and Services do not exist, the script will display messages indicating so
#
# This script will then use 'gradle assemble' to automatically build the Cities Project 
# by following the dependencies defined in build.gradle,
# and by including the various projects listed in 'settings.gradle' 
#
# You can run one Cities Demo Project per PCF Space. More than one will lead to naming collisions
# You can test each step of the way by accessing the individual http addresses shown below in comments
#

cf delete cities-hello -f -r
cf delete cities-service -f -r
cf delete cities-ui -f -r
cf delete-service cities-service-db -f
cf delete-service cities-ws -f

cd /work/nwhackathon-cities
gradle assemble

cd /work/nwhackathon-cities/cities-hello
cf push cities-hello -f manifest.yml
# You can test http://cities-hello.apps.nwhackathon.com

cf create-service p-mysql 100mb cities-service-db
cd ../cities-service/
cf push cities-service -f manifest.yml
# http://cities-service.apps.nwhackathon.com/cities
# http://cities-service.apps.nwhackathon.com/cities/search/nameContains/?q=DE&page=1&size=100

cf create-user-provided-service cities-ws -p '{ "citiesuri": "http://cities-service.apps.nwhackathon.com" }'
# cf create-user-provided-service cities-ws -p "citiesuri"
# citiesuri> http://cities-service.apps.nwhackathon.com
cf s

cd ../cities-ui
cf push -f manifest.yml
# http://cities-ui.apps.nwhackathon.com

