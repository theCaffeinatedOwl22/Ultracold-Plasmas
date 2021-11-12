#include <iostream>
#include <filesystem>

int main(int argc, char *argv[])
{
    std::filesystem::create_directories("test");
    
    return 0;
}