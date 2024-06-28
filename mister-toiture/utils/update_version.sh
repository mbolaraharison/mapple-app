#!/usr/bin/env bash

function update_version() {
    local tag="$CI_COMMIT_TAG"

    if [[ "$tag" == *"-"* ]]; then
        local name=$( echo "$tag" |cut -d'-' -f1 ) 
        local number=$( echo "$tag" |cut -d'-' -f2 )
        else
        local name="$tag"
        local number="$CI_JOB_ID"
    fi

    local version="$name+$number"

    sed -i '' "s/version: 1.0.0+1/version: $version/" pubspec.yaml

    echo "Updated version to $version"
}

update_version

