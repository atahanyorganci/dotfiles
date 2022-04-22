#!/usr/bin/env fish

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# Symlink `kitty` executable to a dir in `PATH`
ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/

# Copy over terminal icon for .desktop entry
set -x ICON_PATH "$XDG_DATA_HOME/icons/terminal.png"
mkdir -p (dirname $ICON_PATH)
cp "$INSTALLER_DIR/kitty/terminal.png" $ICON_PATH

# Create .desktop files
set -l APPLICATIONS_DIR "$XDG_DATA_HOME/applications"
mkdir -p $APPLICATIONS_DIR
cat "$INSTALLER_DIR/kitty/kitty.desktop" | envsubst >$APPLICATIONS_DIR/kitty.desktop
cat "$INSTALLER_DIR/kitty/kitty-open.desktop" | envsubst >$APPLICATIONS_DIR/kitty-open.desktop
