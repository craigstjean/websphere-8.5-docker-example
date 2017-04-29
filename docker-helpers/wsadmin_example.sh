#!/bin/bash

set -e

PROFILE_NAME=${PROFILE_NAME:-"AppSrv01"}
SERVER_NAME=${SERVER_NAME:-"server1"}

# Set soap.client.props to our username/password so we can use wsadmin against a started server
sed -i 's/^com\.ibm\.SOAP\.loginUserid.*$/com\.ibm\.SOAP\.loginUserid='\''wsadmin'\''/I' /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/properties/soap.client.props
sed -i 's/^com\.ibm\.SOAP\.loginPassword.*$/com\.ibm\.SOAP\.loginPassword='\''wsadmin1'\''/I' /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/properties/soap.client.props

# Start the server
echo "Starting server ..................."
/opt/IBM/WebSphere/AppServer/profiles/$PROFILE_NAME/bin/startServer.sh $SERVER_NAME

# Run some jython script against it
/opt/IBM/WebSphere/AppServer/bin/wsadmin.sh -lang jython -f /work/dosomething.py -profileName AppSrv01 -conntype SOAP

# Stop the server
echo "Stopping server ..................."
PID=$(ps -C java -o pid= | tr -d " ")
kill -s INT $PID

