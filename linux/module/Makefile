obj-m += mcsp_probe.o
mcsp_probe-y := mcsp_module_adapter.o mcsp_kernel_object.o

quiet_cmd_mcsp_nasm = NASM    $@
      cmd_mcsp_nasm = nasm -f elf64 $< -o $@; printf '%s: %s\n' '$@' '$<' > $(dot-target).cmd

$(obj)/mcsp_kernel_object.o: $(src)/../../assembly/x86_64/nasm/mcsp_kernel_object.asm FORCE
	$(call if_changed,mcsp_nasm)

targets += mcsp_kernel_object.o
