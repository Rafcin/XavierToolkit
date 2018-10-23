# XavierToolkit
Repo created to host scripts that can be used to fix problems on Jetson Xavier Jetpack 4.1 and on.
Also contains instructions on setting up a ROS workspace for Robotics

# Hardware
|[![Jetson Xavier](https://a70ad2d16996820e6285-3c315462976343d903d5b3a03b69072d.ssl.cf2.rackcdn.com/61793ea59a38edb4cfd56b473e3f4e98 "Jetson Xavier")](https://developer.nvidia.com/embedded/buy/jetson-xavier-devkit "Jetson Xavier")|[![TP-Link Wireless-N300 Mini USB Adapter](https://matrixwarehouse.co.za/1702-large_default/tp-link-300mbps-n-mini-usb-adapter.jpg "TP-Link Wireless-N300 Mini USB Adapter")](https://www.tp-link.com/us/products/details/cat-5520_TL-WN823N.html "TP-Link Wireless-N300 Mini USB Adapter")|![XPG SX6000 128GB M.2 PCIe NVMe](https://www.storagereview.com/images/StorageReview-ADATA-XPG.jpg "XPG SX6000 128GB M.2 PCIe NVMe")|
| ------------ | ------------ | ------------ |
|Jetson Xavier with custom software and kernel.|TP-Link Wireless-N300 Mini USB Adapter.|XPG SX6000 128GB M.2 PCIe NVMe.|


|![4 Port USB Hub](https://images-na.ssl-images-amazon.com/images/I/71Iz-G82R0L._SX355_.jpg "4 Port USB Hub")|![HOKUYO UXM-30LX-EW](https://autonomoustuff.com/wp-content/uploads/2016/07/UXM-30LX-EW.-product.png "HOKUYO UXM-30LX-EW")|![Stereolabs Zed Camera](https://www.stereolabs.com/img/developer/jetson/ZED_product_dev.png "Stereolabs Zed Camera")|
| ------------ | ------------ | ------------ |
|Amazon 4 Port USB Hub.|Hokuyo UXM-30LX-EW 2D Lidar.|StereoLabs Zed Camera that uses Cuda to do depth processing.|


### Todo
1. Will create script to compile on device, not recomended but will add just in case.
2. Will improve the flashing script and make loading modules easier.

## USB-WIFI
By default USB-WIFI dongles do not work on the Jetson Xavier. How I fixed it was this way, and I use a 
Penguin Wireless N USB Adapter for GNU / Linux (TPE-N150USB) from https://www.thinkpenguin.com/gnu-linux/penguin-wireless-n-usb-adapter-gnu-linux-tpe-n150usb
but you can use any usb that you can support the drivers for, in this case the penguin uses Atheros ath9k_htc drivers but something like a TP-Link Wifi dongle uses Realtek.

Steps:
1. Install Jetpack
2. Flash Jetson and if you want do the rest of the setup and install Cuda and everything else.
3. Confirm Jetson is working and stable.

4. On the Host PC install https://github.com/jtagxhub/jetpack-agx-build and follow the instructions on his page. 
(Clone the repo as it says by the name 'build', and clone it inside the Jetpack folder, that jt folder is reffered to as $TOP)
5. Follow step 3.1 to 3.10 as they say. (You don't need to flash, and your kernel might give you a build error)
6. Once you do that and you have reflashed your system and make sure it works, open the kconfigmenu and do the following...
Under Networking --> Wireless, enable everything for cfg80211, this is an important step, you can not compile the kernel without it. Make sure you set this to Y not M. (Builds into Kernel) (This will solve the kbuild compiler errror)
7. Under Device Drivers -> Networking -Wireless Lan, install the important driver you need, do note that when you install it, do not set it as a module but instead of M use Y. (Builds into Kernel)
8. Save the config and exit.
9. Run the kbuild command and wait for the kernel to complete, it will say done when it is finished.
it should look like...
```
kernel install...
cp /home/raf/Downloads/out/KERNEL/arch/arm64/boot/Image /home/raf/Downloads/Xavier/Linux_for_Tegra/kernel/
cp /home/raf/Downloads/out/KERNEL/arch/arm64/boot/dts ...
...
Done
```
10. After that simply run flash_kernel, make sure your Jetson is in bootloader mode and you are done.
When it is flashing you should see this:
```
flash_kernel 
sudo ./flash.sh -k kernel jetson-xavier mmcblk0p1
###############################################################################
# Target Board Information:
# Name: jetson-xavier, Board Family: t186ref, SoC: Tegra 194, 
# OpMode: production, Boot Authentication: , 
###############################################################################
copying soft_fuses(/home/raf/Downloads/Xavier/Linux_for_Tegra/bootloader/t186ref/BCT/tegra194-mb1-soft-fuses-l4t.cfg)... done.
./tegraflash.py --chip 0x19 --applet "/home/raf/Downloads/Xavier/Linux_for_Tegra/bootloader/mb1_t194_prod.bin" --skipuid --soft_fuses tegra194-mb1-soft-fuses-l4t.cfg --bins "mb2_applet nvtboot_applet_t194.bin" --cmd "dump eeprom boardinfo cvm.bin;reboot recovery" 
Welcome to Tegra Flash
version 1.0.0
...
```
As a final check, run sudo nmcli and it will display the driver no longer as USB0 but as wlan0.

## Internet Speed Issue
By default packets are being throttled and sent in smaller values so to fix this run:
```
echo "options iwlwifi 11n_disable=8" | sudo tee -a /etc/modprobe.d/iwlwifi.conf
```

## USB Camera Devices
Like above, compile V4L2 as Y.
```
Device Drivers -> Multimedia Support -> Media USB Adapters -> USB Video Class V4L2
```

## Resources
Jetson Flashing
https://github.com/jtagxhub/jetpack-agx-build
Video
https://unix.stackexchange.com/questions/114902/install-kernel-module-v4l2
https://github.com/torvalds/linux/blob/master/drivers/usb/serial/ch341.c
ROS
http://wiki.ros.org/melodic/Installation/Ubuntu
