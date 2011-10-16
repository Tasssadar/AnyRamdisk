#!/sbin/sh
mkdir -p /tmp/rd
cd /tmp/rd
/tmp/busybox_arch gzip -d -c /tmp/boot.img-ramdisk.gz | /tmp/busybox_arch cpio -i
mv /tmp/rd/init /tmp/rd/main_init
cp -r -p /tmp/ramdisk/* /tmp/rd/
ls | /tmp/busybox_arch cpio -o -Hnewc > ../new_rd.cpio
/tmp/busybox_arch gzip /tmp/new_rd.cpio
return 0