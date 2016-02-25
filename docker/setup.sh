#!/bin/bash

docker_dir="$(dirname ${BASH_SOURCE[0]})"
if [[ "$docker_dir" != "./docker" ]]; then
    echo "Please run this script from the repository directory as './docker/setup.sh'."
    exit 1
fi

if [[ -f docker-compose.yml ]]; then
    echo "Stopping existing services..."
    docker-compose down
else
    echo "No docker-compose.yml found; initializing..."
    cat >docker-compose.yml <<EOF
version: "2"

services:
  gollum:
    image: pjeby/gollum-portable
    restart: unless-stopped
    ports:
      - "4567:4567"
    volumes:
      - ".:/data/wiki"
    env_file: ./gollum-settings.env
EOF
fi

default_username="Anonymous"
default_email="anon@anon.com"
default_timezone="${TZ-UTC}"
default_options="--h1-title --allow-uploads --live-preview"


if [[ -f gollum-settings.env ]]; then
    echo "Reading gollum-settings.env"
    source gollum-settings.env
else
    echo "No gollum-settings.env found; creating..."
fi

get_opt() {
    read -p "$1 [$2]: " -ei "$3" result
    [[ -n "$result" ]] || result="$2"
    echo -n $result
}

echo ""
echo "--- Commit Log Settings ---"
GOLLUM_AUTHOR_USERNAME="$(get_opt "Your name" "$default_username" "$GOLLUM_AUTHOR_USERNAME")"
GOLLUM_AUTHOR_EMAIL="$(get_opt "Your email" "$default_email" "$GOLLUM_AUTHOR_EMAIL")"
TZ="$(get_opt "Your timezone" "$default_timezone" "$TZ" )"

echo ""
echo "--- Wiki Settings ---"
GOLLUM_OPTIONS="$(get_opt "Gollum options" "$default_options" "$GOLLUM_OPTIONS")"

cat >gollum-settings.env <<EOF
# Do not add extra settings to this file; they will be erased
# if you rerun setup.sh!
#
GOLLUM_AUTHOR_USERNAME=${GOLLUM_AUTHOR_USERNAME-$default_username}
GOLLUM_AUTHOR_EMAIL=${GOLLUM_AUTHOR_EMAIL-$default_email}
GOLLUM_OPTIONS=${GOLLUM_OPTIONS-$default_options}
TZ=${TZ-$default_timezone}
EOF

cat <<EOF

Settings saved to gollum-settings.env.  Use 'docker-compose up -d' to start,
or edit docker-compose.yml to customize other settings first.

EOF

