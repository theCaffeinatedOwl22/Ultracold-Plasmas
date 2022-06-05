#include "settings.hpp"
#include "utility.hpp"
#include "matrix.hpp"
#include "class_notes.hpp"

#include <iostream>
#include <filesystem>

int main(int argc, char *argv[])
{   
    ClassNotes::static_function();
    ClassNotes test{2,2};
    int x {5};
    int* xptr {&x};
    int& xref {*xptr};
    std::cout << "testing" << std::endl;
    return 0;
}