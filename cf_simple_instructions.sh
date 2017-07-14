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
# Please note that in a shared domain environment, developers have to avoid creating the same URIs for
# their Apps and Services. For example, users assigned to ORG A and ORG B are capable of pushing the 
# cities-hello app with the following URI https://cities-hello.apps.nwhackathon.com, so whoever 
# executes the cf push command first gets to keep that URI.
# In order to avoid clashes, we recommend that you add your initials to the App & Service Names in the
# script below

# The comment above applies to the deletion of Apps and Services as well
# 07-13-2017: I'm updating this script to use unique names where I'm adding a fictious developer's initials
# to the names of Apps and Services. The initials will be "xyz", so you can easily find and replace them
# with your own initials

cf delete xyz-cities-hello -f -r
cf delete xyz-cities-service -f -r
cf delete xyz-cities-ui -f -r
cf delete-service xyz-cities-service-db -f
cf delete-service xyz-cities-ws -f

cd /work/nwhackathon-cities
gradle assemble

cd /work/nwhackathon-cities/cities-hello
cf push xyz-cities-hello -f manifest.yml
# please note that the file manifest.yml also contains the xyz initials in some of its lines
# You can test http://xyz-cities-hello.apps.nwhackathon.com

cf create-service p-mysql 100mb xyz-cities-service-db
cd ../cities-service/
cf push xyz-cities-service -f manifest.yml
# please note that the file manifest.yml also contains the xyz initials in some of its lines
# http://cities-service.apps.nwhackathon.com/cities
# http://cities-service.apps.nwhackathon.com/cities/search/nameContains/?q=DE&page=1&size=100

cf create-user-provided-service xyz-cities-ws -p '{ "citiesuri": "http://xyz-cities-service.apps.nwhackathon.com" }'
# Alternative (interactive) syntax
# cf create-user-provided-service xyz-cities-ws -p "xyz-citiesuri"
# citiesuri> http://xyz-cities-service.apps.nwhackathon.com
cf s

cd ../cities-ui
cf push -f manifest.yml
# please note that the file manifest.yml also contains the xyz initials in some of its lines
# http://xyz-cities-ui.apps.nwhackathon.com

