#include "settings.hpp"
#include "utility.hpp"
#include "matrix.hpp"
#include "class_notes.hpp"
#include "Overloading.hpp"
#include "Timer.hpp"

#include <iostream>
#include <filesystem>

int main(int argc, char *argv[])
{   
    Overloading t1,t2,t3;
    t1.set_num(2);
    t2.set_num(3);
    t3 = t1+t2+3;
    std::cout << t3 << std::endl;

    std::cout << "testing" << std::endl;
    return 0;
}