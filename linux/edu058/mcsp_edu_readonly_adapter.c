// MCSP 0.58 isolated read-only QEMU EDU interaction adapter.
// Linux supplies mapping/read mechanics. MCSP assembly owns bounded predicates.
#include <linux/init.h>
#include <linux/io.h>
#include <linux/module.h>
#include <linux/pci.h>

extern unsigned long mcsp_edu_identity_match(unsigned long vendor,
                                             unsigned long device);
extern unsigned long mcsp_edu_observation_match(unsigned long value);

static int mcsp_edu_probe(struct pci_dev *pdev,
                          const struct pci_device_id *id)
{
    void __iomem *bar0;
    u32 observed;
    unsigned long identity;
    unsigned long observation;
    int rc;

    identity = mcsp_edu_identity_match(pdev->vendor, pdev->device);
    pr_info("MCSP58_IDENTITY vendor=%04x device=%04x predicate=%lu\n",
            pdev->vendor, pdev->device, identity);
    if (!identity)
        return -ENODEV;

    rc = pci_enable_device(pdev);
    if (rc)
        return rc;

    bar0 = pci_iomap(pdev, 0, 0);
    if (!bar0) {
        pci_disable_device(pdev);
        return -ENOMEM;
    }

    observed = ioread32(bar0);
    observation = mcsp_edu_observation_match(observed);
    pr_info("MCSP58_OBSERVE bar=0 offset=0000 width=32 value=%08x predicate=%lu\n",
            observed, observation);

    pci_iounmap(pdev, bar0);
    pci_disable_device(pdev);

    return observation ? 0 : -ENODEV;
}

static void mcsp_edu_remove(struct pci_dev *pdev)
{
    pr_info("MCSP58_REMOVE vendor=%04x device=%04x\n",
            pdev->vendor, pdev->device);
}

static const struct pci_device_id mcsp_edu_ids[] = {
    { PCI_DEVICE(0x1234, 0x11e8) },
    { 0, }
};
MODULE_DEVICE_TABLE(pci, mcsp_edu_ids);

static struct pci_driver mcsp_edu_driver = {
    .name = "mcsp_edu_058",
    .id_table = mcsp_edu_ids,
    .probe = mcsp_edu_probe,
    .remove = mcsp_edu_remove,
};

module_pci_driver(mcsp_edu_driver);
MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("MCSP 0.58 isolated read-only QEMU EDU MMIO qualification fixture");
MODULE_AUTHOR("MCSP qualification fixture");
