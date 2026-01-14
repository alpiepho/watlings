(;
  Memory can grow dynamically at runtime.

  Some options:
    (memory.size) returns the current memory size in 64KB pages
    (memory.grow N) attempts to grow by N pages, returns previous size or -1 on failure
    (memory.fill DEST VALUE SIZE) fills SIZE bytes starting at DEST with VALUE

  Implement $init_and_size which:
    1. Grows memory by 1 page
    2. Fills the first 10 bytes with the value 42
    3. Returns the new memory size
;)

(module
  (memory 1)

  (func $init_and_size (result i32)
    ;; grow by 1 page, compute new size (prev + 1)
    (i32.add (memory.grow (i32.const 1)) (i32.const 1))

    ;; fill first 10 bytes with 42
    (memory.fill (i32.const 0) (i32.const 42) (i32.const 10))
  )

  (export "memory" (memory 0))
  (export "initAndSize" (func $init_and_size))
)
