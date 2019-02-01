# Pull the latest changes
echo ">> pulling lateset changes"
git pull

# Update any tools
echo ">> updating tools"
asdf install

# Build the application
echo ">> building application"
shards build bingo_web

# Build assets
echo ">> compiling assets"
(cd assets && yarn && yarn build)
