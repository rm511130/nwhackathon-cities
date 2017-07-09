cf delete cities-hello -f -r
cf delete cities-service -f -r
cf delete cities-ui -f -r
cf delete-service cities-service-db -f
cf delete-service cities-ws -f

