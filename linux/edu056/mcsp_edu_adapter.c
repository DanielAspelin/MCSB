// MCSP 0.56 bounded Linux PCI construction adapter.
// Registration only. No MMIO, DMA, IRQ setup, or hardware mutation.
#include <linux/init.h>
#include <linux/module.h>
#include <linux/pci.h>

extern unsigned long mcsp_edu_identity_match(unsigned long vendor,
                                             unsigned long device);

static int mcsp_edu_probe(struct pci_dev *pdev,
                          const struct pci_device_id *id)
{
    return mcsp_edu_identity_match(pdev->vendor, pdev->device) ? 0 : -ENODEV;
}

static void mcsp_edu_remove(struct pci_dev *pdev)
{
    (void)pdev;
}

static const struct pci_device_id mcsp_edu_ids[] = {
    { PCI_DEVICE(0x1234, 0x11e8) },
    { 0, }
};
MODULE_DEVICE_TABLE(pci, mcsp_edu_ids);

static struct pci_driver mcsp_edu_driver = {
    .name = "mcsp_edu_056",
    .id_table = mcsp_edu_ids,
    .probe = mcsp_edu_probe,
    .remove = mcsp_edu_remove,
};

module_pci_driver(mcsp_edu_driver);

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("MCSP 0.56 report-driven QEMU EDU PCI construction fixture");
MODULE_AUTHOR("MCSP qualification fixture");
