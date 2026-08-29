#!/usr/bin/env bash
set -euo pipefail

MYSQLOO_VERSION="9.7.6"
MYSQLOO_REPO="FredyH/MySQLOO"

usage() {
	cat <<'EOF'
Usage: scripts/setup-mysqloo.sh [server_root]

Downloads the mysqloo binary module pinned at MYSQLOO_VERSION from
https://github.com/FredyH/MySQLOO and installs it into
<server_root>/garrysmod/lua/bin/.

server_root defaults to the gmod-server checkout that contains this
gamemode, resolved relative to this script's location, or the
METRO_SERVER_ROOT environment variable if set.

Architecture is read from <server_root>/server.env's SRCDS_ARCH (32 or
64), defaulting to 32 if server.env is absent or the value is unset.

Re-running this script when the pinned version is already installed
does nothing.
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
	usage
	exit 0
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_SERVER_ROOT="$(cd "$SCRIPT_DIR/../../../.." && pwd)"
SERVER_ROOT="${1:-${METRO_SERVER_ROOT:-$DEFAULT_SERVER_ROOT}}"

SERVER_ENV_FILE="$SERVER_ROOT/server.env"
LUA_BIN_DIR="$SERVER_ROOT/garrysmod/lua/bin"

ARCH="32"
if [[ -f "$SERVER_ENV_FILE" ]]; then
	ENV_ARCH="$(grep -E '^SRCDS_ARCH=' "$SERVER_ENV_FILE" | head -n1 | cut -d= -f2 | tr -d '"' || true)"
	if [[ -n "$ENV_ARCH" ]]; then
		ARCH="$ENV_ARCH"
	fi
fi

if [[ "$ARCH" == "64" ]]; then
	ASSET_NAME="gmsv_mysqloo_linux64.dll"
else
	ASSET_NAME="gmsv_mysqloo_linux.dll"
fi

TARGET_PATH="$LUA_BIN_DIR/$ASSET_NAME"
VERSION_MARKER="$LUA_BIN_DIR/.gmsv_mysqloo_version"

if [[ -f "$TARGET_PATH" && -f "$VERSION_MARKER" && "$(cat "$VERSION_MARKER")" == "$MYSQLOO_VERSION" ]]; then
	echo "mysqloo $MYSQLOO_VERSION already installed at $TARGET_PATH, nothing to do"
	exit 0
fi

mkdir -p "$LUA_BIN_DIR"

DOWNLOAD_URL="https://github.com/$MYSQLOO_REPO/releases/download/$MYSQLOO_VERSION/$ASSET_NAME"
TMP_FILE="$(mktemp)"
trap 'rm -f "$TMP_FILE"' EXIT

echo "downloading $DOWNLOAD_URL"
curl -fsSL -o "$TMP_FILE" "$DOWNLOAD_URL"

DOWNLOAD_SIZE="$(stat -c%s "$TMP_FILE" 2>/dev/null || stat -f%z "$TMP_FILE")"
if [[ "$DOWNLOAD_SIZE" -lt 1000000 ]]; then
	echo "downloaded file is too small ($DOWNLOAD_SIZE bytes), aborting" >&2
	exit 1
fi

MAGIC="$(head -c4 "$TMP_FILE" | xxd -p)"
if [[ "$MAGIC" != "7f454c46" ]]; then
	echo "downloaded file does not look like an ELF binary module (missing ELF header), aborting" >&2
	exit 1
fi

mv "$TMP_FILE" "$TARGET_PATH"
chmod 644 "$TARGET_PATH"
trap - EXIT
echo "$MYSQLOO_VERSION" > "$VERSION_MARKER"

echo "installed $ASSET_NAME ($MYSQLOO_VERSION) to $TARGET_PATH"
