#include "settings.hpp"
#include "utility.hpp"
#include "matrix.hpp"
#include "class_notes.hpp"
#include "Timer.hpp"

#include <iostream>
#include <filesystem>

int main(int argc, char *argv[])
{   
    Timer timer;
    ClassNotes test;
    std::cout << "Test complete." << std::endl;
    timer.print_elapsed();
    return 0;
}