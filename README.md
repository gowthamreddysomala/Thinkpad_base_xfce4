ThinkPad T14 Trackpad Fixes for Arch Linux (XFCE4)
This repository contains a collection of scripts, configurations, and insights gained from three days of intensive research and multi-OS testing to resolve persistent trackpad issues on the ThinkPad T14 running Arch Linux with XFCE4.

The core problem was identified to lie within the psmouse kernel module. This repository provides a robust workaround to achieve stable and reliable trackpad functionality.

Table of Contents
Problem Description

Solution Overview

Installation and Setup

1. Prerequisites

2. Clone and Place Repository

3. Driver Management

4. BIOS Configuration

5. Kernel Module (psmouse) Stabilization

Troubleshooting and Notes

Contribution

License

Problem Description
Users of the ThinkPad T14 on Arch Linux (especially with XFCE4) may experience intermittent or complete trackpad unresponsiveness. This often manifests as:

Trackpad freezing randomly.

Trackpad gestures not working consistently.

Need for frequent modprobe -r psmouse && modprobe psmouse commands to restore functionality.

After extensive debugging, the root cause was pinpointed to issues with how the psmouse kernel module initializes and interacts with the trackpad hardware.

Solution Overview
This solution involves a multi-pronged approach:

Correct Driver Configuration: Ensuring libinput is used and xf86-input-synaptics is removed.

BIOS Optimization: Enabling maximum performance to potentially improve hardware stability.

Kernel Module Stabilization: Explicitly loading the psmouse module early in the boot process to prevent erratic behavior.

Automated Workarounds: (Future-proofing/Scripts if needed, currently implied by module stabilization)

Installation and Setup
Follow these steps carefully to resolve your ThinkPad T14 trackpad issues.

1. Prerequisites
Ensure you have basic Arch Linux knowledge and access to a terminal.

2. Clone and Place Repository
Clone this repository into your home directory and then move it to your .config folder:

Bash

git clone https://github.com/gowthamreddysomala/Thinkpad_base_xfce4.git 
mv Thinkpad_base_xfce4 ~/.config/
3. Driver Management
It is crucial to use libinput for modern trackpad management and remove any conflicting synaptics drivers.

Bash

sudo pacman -S libinput # Install libinput if not already installed
sudo pacman -Rns xf86-input-synaptics # Uninstall synaptics
4. BIOS Configuration
Reboot your ThinkPad and enter the BIOS settings (usually by pressing F1 or Enter at boot). Navigate to the performance or power management section and enable "Maximum Performance". This can sometimes alleviate hardware-related flakiness. Save and exit the BIOS.

5. Kernel Module (psmouse) Stabilization
The primary workaround involves ensuring the psmouse kernel module is loaded early and consistently during boot. If you find yourself repeatedly running sudo modprobe -r psmouse && sudo modprobe psmouse to fix your trackpad, this step is essential.

Edit /etc/mkinitcpio.conf:
Open the mkinitcpio.conf file with your preferred text editor (e.g., nano):

Bash

sudo nano /etc/mkinitcpio.conf
Add psmouse to MODULES:
Locate the MODULES= line and ensure psmouse is listed within the parentheses. If it's not there, add it.

Example:

Diff

-MODULES=(i915 amdgpu vmwgfx)
+MODULES=(i915 amdgpu vmwgfx psmouse)
Note: Your existing modules may vary. Just ensure psmouse is included.

Regenerate the Initramfs:
After saving the changes to mkinitcpio.conf, regenerate the initramfs to apply the new module configuration:

Bash

sudo mkinitcpio -P
Reboot and Test:
Reboot your system and test your trackpad thoroughly. It should now be stable and responsive.

Bash

sudo reboot
Troubleshooting and Notes
Still experiencing issues? Double-check all the steps, especially the psmouse configuration in mkinitcpio.conf and the regeneration of the initramfs.

Kernel Updates: After a kernel update, it's a good practice to re-verify mkinitcpio.conf and regenerate the initramfs if you notice any trackpad instability, although mkinitcpio -P should typically handle this automatically.

XFCE4 Specifics: While the core fixes are kernel-level, ensure your XFCE4 input device settings (Settings Manager -> Mouse and Touchpad) are configured to your liking, as libinput offers various customization options.

Contribution
If you have further insights, improvements, or alternative solutions, feel free to open an issue or submit a pull request!

License
This project is open-source and available under the MIT License.
