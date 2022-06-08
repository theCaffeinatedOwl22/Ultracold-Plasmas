#include "settings.hpp"
#include "utility.hpp"
#include "Matrix.hpp"
#include "Timer.hpp"

#include <iostream>
#include <filesystem>


int main(int argc, char *argv[])
{   
    Timer timer;
    Matrix test(1,4,1);
    test(3)=2;
    test = test.t();


    std::cout << "Complete." << std::endl;
    return 0;
}