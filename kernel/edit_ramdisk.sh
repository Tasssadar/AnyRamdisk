#!/sbin/sh
rm -r /tmp/rd
mkdir /tmp/rd
cd /tmp/rd
/tmp/busybox_arch gzip -d -c /tmp/boot.img-ramdisk.gz | /tmp/busybox_arch cpio -i

#exit if no main_init found
if [ ! -f /tmp/rd/main_init ];
then
    exit 1
fi

# Restore init
rm /tmp/rd/init
mv /tmp/rd/main_init /tmp/rd/init
rm /tmp/rd/preinit.rc

# Remove images
rm /tmp/rd/init_0.rle
rm /tmp/rd/init_1.rle
rm -r /tmp/rd/bmgr_imgs

# Pack ramdisk again
rm /tmp/new_rd.cpio
rm /tmp/new_rd.cpio.gz
chmod 750 /tmp/rd/init
find . | /tmp/busybox_arch cpio -o -H newc | /tmp/busybox_arch gzip > ../new_rd.cpio.gz
return 0