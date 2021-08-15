#include <iostream>

#include "baz.h"

int main() {
    bool test = false;
    int a = 0;
    std::cout << "Start\n" << std::endl;
    try {
        a = baz_top(-3);
    }
    catch (int a) {
        test = true;
    }
    if (test) {
        std::cout << "Failure!!\n";
    }
    else {
        std::cout << "Hello World: " << a << "\n";
    }
     return 0;
}