#!/usr/bin/env bash

set -euo pipefail

# -e           :: Exit immediately if any command returns a non-zero status
# -u           :: Treat unset variables as an error
# -o pipefail  :: The script fails if any command in a pipeline fails

# Directory to backup, mutable
DIRECTORY="/var/www" 

BASENAME="$(basename "$DIRECTORY")"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"

OUTPUT="/var/tmp/${BASENAME}_backup_${TIMESTAMP}.tar.gz"

# Create backup directory if it doesn't exist
mkdir -p "$(dirname "$OUTPUT")"

# Ensure the directory exists
if [[ ! -d "$DIRECTORY" ]]; then
    echo "Error: DIRECTORY $DIRECTORY does not exist." >&2
    exit 1
fi

# Perform the backup
tar -czf "$OUTPUT" -C "$(dirname "$DIRECTORY")" "$BASENAME"
