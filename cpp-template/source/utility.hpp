#ifndef UTILITY_HPP
#define UTILITY_HPP

#include <iostream> // std::cout, std::endl
#include <filesystem> // std::filesystem - for file directory interactivity
#include <fstream> // std::ofstream, std::ifstream - file i/o
#include <sstream> // std::istringstream
#include <vector> // std::vector
#include <string> // std::string, std::getline
#include <math.h> // sqrt, pow, etc - basic math functions
#include <algorithm> // std::remove, std::find, std::distance
#include <cassert> // assert

namespace fs = std::filesystem;


//*** GENERAL FUNCTIONS ***//

std::vector<std::vector<std::string>> read_file(fs::path filePath);
std::string getCommandLineArg(int argc, char* argv[], std::string short_flag, std::string long_flag);


#endif