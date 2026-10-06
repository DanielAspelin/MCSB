obj-m += mcsp_probe.o
mcsp_probe-y := mcsp_module_adapter.o mcsp_kernel_object.o

$(obj)/mcsp_kernel_object.o: $(src)/../../assembly/x86_64/nasm/mcsp_kernel_object.asm
	nasm -f elf64 $< -o $@
