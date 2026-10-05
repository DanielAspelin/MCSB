# Storage Decomposition

## Initial witness

NVMe is the first concrete storage realization because its queues, commands, namespaces, DMA buffers, doorbells and completions expose a useful machine-visible decomposition.

## Path

instruction -> memory/buffer -> descriptor/command -> queue -> controller interaction -> transfer -> persistent/nonvolatile medium -> completion -> observed state

Later witnesses include ATA/SATA, SCSI and SD-family storage where specifications and licensing permit.

Storage-specific notions are not promoted to MCSP primitives until cross-domain evidence supports them.
