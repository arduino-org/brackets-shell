#!/bin/bash

# grunt-contrib-copy doesn't preserve permissions
# https://github.com/gruntjs/grunt/issues/615
chmod 755 debian/package-root/opt/arduinostudio/arduinostudio
chmod 755 debian/package-root/opt/arduinostudio/ArduinoStudio
chmod 755 debian/package-root/opt/arduinostudio/ArduinoStudio-node
chmod 755 debian/package-root/opt/arduinostudio/www/LiveDevelopment/MultiBrowserImpl/launchers/node/node_modules/open/vendor/xdg-open

# set permissions on subdirectories
find debian -type d -exec chmod 755 {} \;

# delete old package
rm -f arduinostudio.tar.gz

# Move everything we'll be using to a temporary directory for easy clean-up
mkdir -p archive/out
cp -r debian/package-root/opt/arduinostudio archive/out

# Add arduinostudio.svg
cp debian/package-root/usr/share/icons/hicolor/scalable/apps/arduinostudio.svg archive/out/arduinostudio

# Add the modified arduinostudio.desktop file (call arduinostudio instead of /opt/arduinostudio/arduinostudio)
cp archive/arduinostudio.desktop archive/out/arduinostudio

# Add the install.sh and uninstall.sh files.
cp archive/install.sh archive/out/arduinostudio
cp archive/uninstall.sh archive/out/arduinostudio
# README.md too.
cp archive/README.md archive/out/arduinostudio

tar -cf arduinostudio.tar -C archive/out arduinostudio/

gzip arduinostudio.tar

# Clean-up after ourselves once the tarball has been generated.
rm -rf archive/out
