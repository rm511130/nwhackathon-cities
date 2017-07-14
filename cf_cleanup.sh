# In order to avoid URI clashes, where several developers are trying 
# to use, for example, the same https://cities-hello.apps.nwhackathon.com 
# we recommend that you add your initials to the app-names and service-names
# So, when it's time to clean-up and delete apps and services
# please make sure the apps and services you are deleting 
# actually match the apps and services you pushed & created

cf delete cities-hello -f -r
cf delete cities-service -f -r
cf delete cities-ui -f -r
cf delete-service cities-service-db -f
cf delete-service cities-ws -f

