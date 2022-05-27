#!/usr/bin/env bash
set -e

PACT_CLI="docker run --rm pactfoundation/pact-cli:latest ";
EXECUTOR="broker "
COMMAND='create-webhook'


testing() {
  echo ""
  echo "This is to test the docker build"
  echo "$PACT_CLI $EXECUTOR $COMMAND"
  echo "$INPUT_ACTION"
  echo "$INPUT_WEBHOOK_TYPE"
}

create_pact_webhook() {
 docker run --rm pactfoundation/pact-cli:latest broker create-webhook 'https://api.github.com/repos/rajnavakotiikea/example-provider/dispatches' \
                    --header 'Content-Type: application/json' 'Accept: application/vnd.github.everest-preview+json' \
                    "'Authorization: Bearer ${INPUT_GITHUB_TOKEN}'" \
                    --request POST \
                    --data '{ "event_type": "pact_changed", "client_payload": { "pact_url": "${pactbroker.pactUrl}" } }' \
                    --provider pactflow-example-provider \
                    --contract-content-changed \
                    --description "Pact content changed for pactflow-example-provider" \
                    --broker-base-url https://sampleautoamtiontestraj.pactflow.io \
                    --broker-token GglUlzHa8Egn_fpkhzZQLw
}

broker_details() {
  broker_authentication=""
  echo "provided token: $INPUT_BROKER_TOKEN"
  if [ -z "$INPUT_BROKER_TOKEN" ]
  then
    echo "broker token not provided. checking for broker username and password details"
    if [ -z "$INPUT_BROKER_USERNAME" ] || [ -z "$INPUT_BROKER_PASSWORD" ]
    then
      echo "either token or username + password has to be provided"
    else
      echo "broker username and password provided for authentication"
      broker_authentication="--broker-username $INPUT_BROKER_USERNAME --broker-password $INPUT_BROKER_PASSWORD"
    fi
  else
    echo "broker token provided for authentication"
    broker_authentication="--broker-token $INPUT_BROKER_TOKEN"
  fi
  echo "$broker_authentication"
}

testing
broker_auth="$(broker_details)"
echo "$broker_auth"



#create_pact_webhook

# org name
# repo name
# github access token
# provider name
# consumer name
# description
# broker url
# broker pwd