echo "packing..."

if [ -e kernel.elf-new ]; then
rm kernel.elf-new;
fi

cd ramdisk
find|cpio -o -H newc|gzip >../kernel.elf-new_ramdisk.gz
cd ..

./mkelf.py -o kernel.elf-new kernel.elf-zImage@0x00008000 kernel.elf-new_ramdisk.gz@0x01000000,ramdisk kernel.elf-cmdline@cmdline

printf "\x04"|dd of=kernel.elf-new bs=1 seek=44 count=1 conv=notrunc 2>/dev/null
dd if=kernel.elf of=kernel.elf-dumped_cert bs=1 skip=148 count=1106 2>/dev/null
cat kernel.elf-cert|dd of=kernel.elf-new bs=1 seek=148 count=1106 conv=notrunc 2>/dev/null

rm kernel.elf-new_ramdisk.gz
rm kernel.elf-dumped_cert

mkdir output
mv kernel.elf-new output/kernel.elf-new
echo "Done!"
