#include "bar.h"
#include "foo.h"
#include "util.h"

class MyBazTop {
public:
    MyBazTop(int a) {
        A = a;
    }
    ~MyBazTop() {
        A -= 2;
        print("Cleanup BazTop");
    }
    int A;
};

class MyBazBottom {
public:
    MyBazBottom(int a) {
        A = a;
    }
    ~MyBazBottom() {
        A -= 2;
        print("Cleanup BazBottom");
    }
    int A;
};

int baz_top(int a) {
    MyBazTop c(a);
    int b = foo(a);
    return b - 2;
}

int baz_bottom(int a) {
    MyBazBottom c(a);
    int b = bar(a);
    return b * 3;
}