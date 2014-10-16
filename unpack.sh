#sony kernel
echo "Unpacking kernel.elef ..."
7z e kernel.elf

mv 0 kernel.elf-zImage
mv 1 kernel.elf-ramdisk.gz
mv 2 kernel.elf-cmdline
mv 3 kernel.elf-cert

file -b kernel.elf-ramdisk.gz

gzip -d kernel.elf-ramdisk.gz

mkdir ramdisk
mv kernel.elf-ramdisk ramdisk
cd ramdisk
cpio -i < kernel.elf-ramdisk
rm kernel.elf-ramdisk
echo "Done!"
