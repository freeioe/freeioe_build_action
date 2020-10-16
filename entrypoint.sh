#!/bin/bash

set -e

echo "Action: $1"
echo "WorkDir: $2"

/actions/$1 $2

# Output the filename
# filename=`ls *.tar.gz | grep -v -- -dbgsym`
filename=`ls __output/* | grep -v -- -dbgsym`
echo ::set-output name=filename::$filename
