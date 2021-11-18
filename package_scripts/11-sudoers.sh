# grant user sudo privilege to allow adding /dev/video devices in 'sensing_interface/cameras.py
USERNAME=$(logname)

echo "Please run:"
echo "	sudo visudo"
echo "and write a new line"
echo "	$USERNAME ALL=(ALL) NOPASSWD: ALL"

echo "This is the end of package scripts. Restart system."
