#!/sbin/sh
rm -r /tmp/rd
mkdir /tmp/rd
cd /tmp/rd
/tmp/busybox_arch gzip -d -c /tmp/boot.img-ramdisk.gz | /tmp/busybox_arch cpio -i
if [ ! -f /tmp/rd/main_init ];
then
    mv /tmp/rd/init /tmp/rd/main_init
fi

# Remove old version images
rm /tmp/rd/init_0.rle
rm /tmp/rd/init_1.rle
rm /tmp/rd/bmgr_imgs/init_0_sel.rle
rm /tmp/rd/bmgr_imgs/init_1_sel.rle
rm /tmp/rd/bmgr_imgs/init_rbt.rle
rm /tmp/rd/bmgr_imgs/init_0.rle
rm /tmp/rd/bmgr_imgs/init_1.rle

cp -r -p /tmp/ramdisk/* /tmp/rd/
rm /tmp/new_rd.cpio
rm /tmp/new_rd.cpio.gz
chmod 750 /tmp/rd/init
find . | /tmp/busybox_arch cpio -o -H newc | /tmp/busybox_arch gzip > ../new_rd.cpio.gz
busybox mount -t auto /dev/block/mmcblk0p2 /sd-ext
mkdir -p /sd-ext/multirom
busybox umount /sd-ext

# Create multirom config file
if [ ! -f /sdcard/multirom.txt ];
then
    echo "timezone = 0" > /sdcard/multirom.txt
    echo "timeout = 3" >> /sdcard/multirom.txt
    echo "show_seconds = 0" >> /sdcard/multirom.txt
    echo "touch_ui = 1" >> /sdcard/multirom.txt
    echo "tetris_max_score = 0" >> /sdcard/multirom.txt
    echo "brightness = 100" >> /sdcard/multirom.txt
    echo "default_boot = 0" >> /sdcard/multirom.txt
    echo "default_boot_sd = \"\"" >> /sdcard/multirom.txt
    echo "charger_settings = 3" >> /sdcard/multirom.txt
fi

return 0