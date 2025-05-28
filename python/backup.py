#!/usr/bin/env python3

import os
import sys
import tarfile
import time
from pathlib import Path

# Strict error handling
def die(message):
    print(f"Error: {message}", file=sys.stderr)
    sys.exit(1)

# Directory to back up
DIRECTORY = "/var/www"

# Ensure the directory exists
if not os.path.isdir(DIRECTORY):
    die(f"DIRECTORY {DIRECTORY} does not exist.")

basename = os.path.basename(DIRECTORY.rstrip('/'))
timestamp = time.strftime('%Y%m%d_%H%M%S')
output = f"/var/tmp/{basename}_backup_{timestamp}.tar.gz"

# Ensure output directory exists
os.makedirs(os.path.dirname(output), exist_ok=True)

# Perform the backup
try:
    with tarfile.open(output, "w:gz") as tar:
        tar.add(DIRECTORY, arcname=basename)
    print(f"Backup created at: {output}")
except Exception as e:
    die(f"Failed to create backup: {e}")
