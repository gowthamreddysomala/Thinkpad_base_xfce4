# Thinkpad_base_xfce4
its about my thinkpad t14 trackpad issues and driver work arounds in archlinux , auto run scripts etc
plece this folder in .config folder in home diretory and install libinput and uninstall synaptics one , also enable max performance in BIOS .. :) 


<h1> this thing works after freaking 3 Days of Research and multiple different OS testings </h1>

problem lies within the psmouse module in kernel 

Kernel Module psmouse Reloading on Startup (if Step 1-3 Fail to Stabilize)
If the issue is still intermittent, and you notice that sudo modprobe -r psmouse && sudo modprobe psmouse temporarily fixes it, then we need to address psmouse's initialization at boot.

Action: Edit /etc/mkinitcpio.conf:
Bash

sudo nano /etc/mkinitcpio.conf
Find the MODULES= line and ensure psmouse is listed there:
MODULES=(... psmouse) # e.g., MODULES=(i915 amdgpu vmwgfx psmouse)
Adding it here ensures it's loaded very early in the boot process.
Regenerate the initramfs:
Bash

sudo mkinitcpio -P
Reboot and Test.
