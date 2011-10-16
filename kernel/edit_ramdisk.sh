#!/sbin/sh
rm -r /tmp/rd
mkdir /tmp/rd
cd /tmp/rd
/tmp/busybox_arch gzip -d -c /tmp/boot.img-ramdisk.gz | /tmp/busybox_arch cpio -i
if [ ! -f /tmp/rd/main_init ];
then
    mv /tmp/rd/init /tmp/rd/main_init
fi
cp -r -p /tmp/ramdisk/* /tmp/rd/
rm /tmp/new_rd.cpio
rm /tmp/new_rd.cpio.gz
chmod 750 /tmp/rd/init
find . | /tmp/busybox_arch cpio -o -H newc | /tmp/busybox_arch gzip > ../new_rd.cpio.gz
return 0