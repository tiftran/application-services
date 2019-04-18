#!/usr/bin/env bash

set -euvx

FRAMEWORK_NAME="${1:-MozillaAppServices.framework.zip}"

# Help out iOS folks who might want to run this but haven't
# updated rust recently.
rustup update stable

carthage update --platform iOS --cache-builds swift-protobuf
## When https://github.com/Carthage/Carthage/issues/2623 is fixed,
## carthage build --archive should work to produce a zip

carthage build --no-skip-current --platform iOS --verbose

# Exclude SwiftProtobuf.
rm -rf Carthage/Build/iOS/SwiftProtobuf.framework*
zip -r ${FRAMEWORK_NAME} Carthage/Build/iOS
