#!/bin/bash
# -----------------------------------------------------------------------------
# start.sh — Local development server for Rewst JSON Formatter
#
# Starts Python's built-in HTTP server from the directory this script lives in.
# Binds to 127.0.0.1 (localhost only) for security — the tool is intended for
# local use only, not exposed to the network by default.
#
# Usage:
#   bash start.sh
#
# Then open: http://localhost:8080
# Press Ctrl+C to stop the server.
# -----------------------------------------------------------------------------

# Change to the directory where this script is located so the server
# can find index.html and rewst-http-template.json regardless of where
# the script is called from.
cd "$(dirname "$0")"

python3 -m http.server 8080 --bind 127.0.0.1
