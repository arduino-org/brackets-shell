#!/bin/bash
echo 'uninstalling arduinostudio from your ~/.local directory'
echo 'run with -c to remove ~/.config/ArduinoStudio'

removeConfig=false

while getopts c opt; do
  case $opt in
    c)
      removeConfig=true
      ;;
  esac
done

shift $((OPTIND - 1))

if [ "$removeConfig" = true ]; then
    echo 'deleting ~/.config/ArduinoStudio'
    rm -rf ~/.config/ArduinoStudio
fi

# Safety first: only uninstall files we know about.

rm -f ~/.local/bin/arduinostudio
rm -f ~/.local/share/applications/arduinostudio.desktop

echo 'finished uninstall arduinostudio from your ~/.local directory'
