# Memory Decomposition

## Scope

Address spaces, positions, blocks, pages, regions, reads, writes, mappings, translation, protection, allocation, release, ordering, barriers, atomics, caches, coherency and DMA visibility.

## Governing distinction

A memory write is an operation. Its observable state mutation is a transition. Allocation determines resource placement; mapping/translation determines address relationships; scheduling/order constrains when effects may become observable.

The model must accommodate different host page sizes, memory models, cache structures and translation mechanisms without making any one of them universal semantics.
