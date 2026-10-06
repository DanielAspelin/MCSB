# MCSP 0.58 Controlled Device Interaction Qualification Plan

Run only in the disposable QEMU/KVM guest established by 0.57.

PASS requires:
- QEMU EDU enumerates as 1234:11e8;
- 0.57 assembly identity predicate accepts it;
- BAR0 is mapped through Linux PCI APIs;
- exactly one 32-bit read is made from BAR0 offset 0x00;
- assembly observation predicate accepts the documented stable suffix 0x00ed;
- mapping is released and PCI function disabled;
- module insertion occurs only in the guest;
- guest terminates after evidence capture.

Static audit must find no iowrite/writeb/writew/writel, DMA setup, pci_set_master,
request_irq, or IRQ registration in the 0.58 adapter.

The observed version fields are evidence, not new semantic authority.
