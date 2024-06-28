#!/usr/bin/env bash

function prepare_environment() {
    echo "Preparing environment..."

    local tag="$CI_COMMIT_TAG"

    # If tag doesn't contain a dash or tag end with "-prod", it's a production build
    if [[ "$tag" != *"-"* ]] || [[ "$tag" == *"-prod" ]]; then
        cp $ENV_FILE_PROD .env
        echo "env file for production copied"
        . ./utils/transform_dotenv_to_xcconfig.sh
        echo "Updated environment to production"
        return
    fi

    cp $ENV_FILE_STAGING .env
    echo "env file for staging copied"
    echo -e "\n============================ENV FILE============================\n"
    cat .env
    echo -e "\n============================ENV FILE============================\n"
    . ./utils/transform_dotenv_to_xcconfig.sh
    mv lib/firebase_options_dev.dart lib/firebase_options.dart
    mv ios/firebase_app_id_file_dev.json ios/firebase_app_id_file.json
    mv ios/Runner/GoogleService-Info_dev.plist ios/Runner/GoogleService-Info.plist

    echo 'Updated environment to staging.'
}

prepare_environment

