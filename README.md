# metal

This is a (very WIP) compiler for the (very WIP) Metal language.

## Design philosophy
Here is a list of the main design guidelines for both the language and the compiler.

### Close to the **metal**
Give users as much control on the low-level minutiae of their code. Forcefully abstract only the things that the programmer should never care about. However, where possible, provide abstractions for common routines that programmers can use to give decision power to the compiler.

### Verbosity
Readable code states its intent clearly, and programmers should have the right tools for that in the language. If we want e.g. stack-allocated memory, we should ask for stack allocation.

### Communication
Compiler should tell the programmer what it's doing, and why. Same goes for what it's not doing. We should stop treating compilers like black-boxes and treating them like good friends.

## Main feature ideas

- when declaring variables, users should be able to specify how their memory is allocated, e.g. `stack int32 x = 0;`
- ability to mark any part of code as do-not-optimize, more generally than with C's `volatile` and potentially preserving more optimizations
- for any piece of code, compiler should print all considered optimizations and reasons for using/not using them.
