# Report

- If `-fno-exceptions` is used to compile a .cpp file with clang the function of the .cpp won't be cleanup in the case a functio
- If no `/EH` is used or `/EHs-` is used to compile a .cpp file with msvc, the function in that .cpp will not be cleanup during stack unwinding.
- If no `/EH` is used or `/EHs-` is used to compile a .cpp file with msvc, exception are still catch but intermediate stack frame are not cleaned up.
- When exception are enabled to compile a .cpp file (i.e `/EHs`- or `-fno-exceptions` is not used), all the function which require some cleanup in case of unwinding will generate some additional code compared with the case when exception are enabled.
- When a function is annotated as `noexcept`, no exception throw inside of the function (or in child function) can be catch above the function marked as `noexcept`.

# ToDo

- [ ] What happen if you throw in a noexcept function??
- [ ] Why calling `std::cout` during unwinding or in a catch block deadlock?