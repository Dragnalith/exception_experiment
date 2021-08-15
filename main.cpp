#include <iostream>

#include "foo.h"

int main() {
    try {
        int a = foo(-3);
        std::cout << "Hello World: " << a << "\n";
    }
    catch (int a) {
        std::cout << "Failure!!\n";
    }
    return 0;
}