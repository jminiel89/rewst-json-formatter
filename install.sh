#!/usr/bin/env bash
set -e

REPO="https://github.com/jminiel89/rewst-json-formatter"
INSTALL_DIR="$HOME/rewst-json-formatter"

echo "Rewst JSON Formatter — Installer"
echo "---------------------------------"

# Check Python 3
if ! command -v python3 &>/dev/null; then
  echo "Error: python3 not found."
  echo "Install it with your package manager:"
  echo "  Ubuntu/Debian: sudo apt install python3"
  echo "  macOS:         brew install python3"
  exit 1
fi

PYTHON_VERSION=$(python3 --version 2>&1)
echo "Found: $PYTHON_VERSION"

# Clone or update
if [ -d "$INSTALL_DIR/.git" ]; then
  echo "Existing install found — updating..."
  git -C "$INSTALL_DIR" pull --ff-only
elif command -v git &>/dev/null; then
  echo "Cloning repo..."
  git clone "$REPO.git" "$INSTALL_DIR"
else
  echo "git not found — downloading files directly..."
  mkdir -p "$INSTALL_DIR"
  for FILE in index.html rewst-http-template.json start.sh; do
    echo "  Downloading $FILE..."
    curl -fsSL "$REPO/raw/main/$FILE" -o "$INSTALL_DIR/$FILE"
  done
fi

chmod +x "$INSTALL_DIR/start.sh"

echo ""
echo "Done. Installed to: $INSTALL_DIR"
echo ""
echo "To run:"
echo "  bash $INSTALL_DIR/start.sh"
echo ""
echo "Then open: http://localhost:8080"
