#!/bin/bash
# Wait to ensure X server and device are ready
sleep 2
xinput set-prop "Synaptics TM3471-020" "libinput Tapping Enabled" 1

