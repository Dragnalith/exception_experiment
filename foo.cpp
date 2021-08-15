#include "baz.h"
#include "util.h"

class MyFoo {
public:
    MyFoo(int a) {
        A = a;
    }
    ~MyFoo() {
        A -= 2;
        print("Cleanup MyFoo");
    }
    int A;
};

int foo(int a) noexcept {
    MyFoo c(a);
    int b = baz_bottom(a);
    return b * b;
}