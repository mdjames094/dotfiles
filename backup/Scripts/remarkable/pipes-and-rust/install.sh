#!/usr/bin/env sh

# Set hostname or ip address of your reMarkable
host="rmk"
port="400"


echo "Creating /opt/ directory, if it doesn't exist, yet.."
ssh "$host" "mkdir -p /opt/" || exit 1
echo "Done"

echo "Stopping previous version, if it exists..."
ssh "$host" "systemctl stop pipes-and-rust.service"
ssh "$host" "killall pipes-and-rust"
echo "Done"

echo "Copying files to device..."
scp "./pipes-and-rust" "$host:/opt/pipes-and-rust" || exit 1
cp ./pipes-and-rust.service ./pipes-and-rust.service_new
sed "s/PORT=80/PORT=${port}/" -i "./pipes-and-rust.service_new"
scp "./pipes-and-rust.service_new" "$host:/lib/systemd/system/pipes-and-rust.service" || exit 1
rm ./pipes-and-rust.service_new
echo "Done"

echo "Installing service..."
ssh "$host" "systemctl daemon-reload" || exit 1
ssh "$host" "systemctl enable pipes-and-rust.service" || exit 1
ssh "$host" "systemctl start pipes-and-rust.service" || exit 1
echo "Done"

echo
echo "pipes-and-rust has been successfully installed on your device!"
echo "opening browser using port ${port}"
