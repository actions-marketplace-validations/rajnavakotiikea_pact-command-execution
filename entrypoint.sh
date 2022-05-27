#!/usr/bin/env bash
set -e

PACT_CLI="docker run --rm pactfoundation/pact-cli:latest ";
EXECUTOR="broker "
COMMAND='create-webhook'


testing() {
  echo ""
  echo "This is to test the docker build"
  echo "$PACT_CLI + $EXECUTOR + $COMMAND"
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

testing

#create_pact_webhook

# org name
# repo name
# github access token
# provider name
# consumer name
# description
# broker url
# broker pwd