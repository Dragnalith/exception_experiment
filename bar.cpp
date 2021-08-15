#include "bar.h"

int bar(int a) {
    if (a < 0) {
        throw -1;
    }
    return a + 2;
}