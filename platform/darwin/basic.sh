#!/bin/bash

set -ex

curl -s "https://get.sdkman.io" | bash
sdk install java 11.0.16.1-tem
