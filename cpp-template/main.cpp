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

    for (int i=0; i<pms.array_size(); i++){
        pms.choose_array(i);
        int set_num = i/pms.runs();
        fs::path set_path = "set_"+num2str(set_num);
        fs::path run_path = "run_"+num2str(pms.getvar("runs"));
        fs::create_directories(save_path/set_path/run_path);
        pms.write_array_params(save_path/set_path/run_path);
    } 

    return 0;
}