// MCSP 0.57 isolated runtime adapter.
// Diagnostic trace is qualification evidence. No MMIO, DMA, IRQ, or device mutation.
#include <linux/init.h>
#include <linux/module.h>
#include <linux/pci.h>

extern unsigned long mcsp_edu_identity_match(unsigned long vendor,
                                             unsigned long device);

static int mcsp_edu_probe(struct pci_dev *pdev,
                          const struct pci_device_id *id)
{
    unsigned long match = mcsp_edu_identity_match(pdev->vendor, pdev->device);
    pr_info("MCSP57_PROBE vendor=%04x device=%04x predicate=%lu\n",
            pdev->vendor, pdev->device, match);
    return match ? 0 : -ENODEV;
}

static void mcsp_edu_remove(struct pci_dev *pdev)
{
    pr_info("MCSP57_REMOVE vendor=%04x device=%04x\n", pdev->vendor, pdev->device);
}

static const struct pci_device_id mcsp_edu_ids[] = {
    { PCI_DEVICE(0x1234, 0x11e8) },
    { 0, }
};
MODULE_DEVICE_TABLE(pci, mcsp_edu_ids);

static struct pci_driver mcsp_edu_driver = {
    .name = "mcsp_edu_057",
    .id_table = mcsp_edu_ids,
    .probe = mcsp_edu_probe,
    .remove = mcsp_edu_remove,
};

module_pci_driver(mcsp_edu_driver);
MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("MCSP 0.57 isolated QEMU EDU runtime qualification fixture");
MODULE_AUTHOR("MCSP qualification fixture");
