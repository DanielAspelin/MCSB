// MCSP 0.54 Linux module adapter.
// Linux/Kbuild boundary only; MCSP semantics remain assembly-owned.
#include <linux/init.h>
#include <linux/module.h>
#include <linux/types.h>

extern unsigned long mcsp_exclusive_u64(unsigned long a, unsigned long b);

static int __init mcsp_probe_init(void)
{
    volatile unsigned long witness = mcsp_exclusive_u64(0x55aa55aa55aa55aaUL,
                                                        0x0f0f0f0f0f0f0f0fUL);
    return witness == 0x5aa55aa55aa55aa5UL ? 0 : -EINVAL;
}

static void __exit mcsp_probe_exit(void)
{
}

module_init(mcsp_probe_init);
module_exit(mcsp_probe_exit);

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("MCSP 0.54 Kbuild integration qualification probe");
MODULE_AUTHOR("MCSP qualification fixture");
