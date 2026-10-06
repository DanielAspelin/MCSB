obj-m += mcsp_edu_056.o
mcsp_edu_056-y := mcsp_edu_adapter.o mcsp_edu_identity.o

quiet_cmd_mcsp_nasm = NASM    $@
      cmd_mcsp_nasm = nasm -f elf64 $< -o $@; printf '%s: %s\n' '$@' '$<' > $(dot-target).cmd

$(obj)/mcsp_edu_identity.o: $(src)/../../assembly/x86_64/nasm/mcsp_edu_identity.asm FORCE
	$(call if_changed,mcsp_nasm)

targets += mcsp_edu_identity.o
