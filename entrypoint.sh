#!/bin/sh

set -e

echo "Action: $1"

/actions/$1

# Output the filename
# filename=`ls *.tar.gz | grep -v -- -dbgsym`
filename=`ls __output/* | grep -v -- -dbgsym`
echo ::set-output name=filename::$filename
