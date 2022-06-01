#include "settings.hpp"
#include "utility.hpp"

#include <iostream>
#include <filesystem>

int main(int argc, char *argv[])
{   
    // process command line arguments
    std::string settings_path = getCommandLineArg(argc,argv,"-s","--settings");
    std::string save_path = getCommandLineArg(argc,argv,"-p","--path");
    std::string task_array_str = getCommandLineArg(argc,argv,"-a","--array");
    if (!fs::exists(save_path)) fs::create_directories(save_path);
    int task_array{0};
    if (!task_array_str.empty()) task_array = stoi(task_array_str);

    Settings pms(settings_path);
    std::cout << pms.task_array_range() << std::endl;
    pms.write_all(save_path);

    return 0;
}