#include <iostream>
#include <filesystem>

int main(int argc, char *argv[])
{
    std::filesystem::path path = "test";
    std::filesystem::create_directories(path);
    return 0;
}