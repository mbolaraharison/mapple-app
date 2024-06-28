#!/usr/bin/env bash

function transform_dotenv_to_xcconfig() {
    echo "Transform .env file into .xcconfig ..."

    local env_file=".env"
    local xcconfig_file="ios/Flutter/Env.xcconfig"

    if [ -f "$env_file" ]; then
        cp "$env_file" "$xcconfig_file"
        echo "Transformed .env file into .xcconfig"
    else
        echo "No .env file found"
    fi
}

transform_dotenv_to_xcconfig