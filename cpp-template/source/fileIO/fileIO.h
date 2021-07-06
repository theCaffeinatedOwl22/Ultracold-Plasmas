#ifndef fileIO_h
#define fileIO_h

// include header files
#include <iostream>     // for terminal input/output, using std::cout for example
#include <vector>       // for std::vector
#include <string>       // for std::string
#include <filesystem>   // imports directory interactivity - create directory, read directory contents, etc
#include <fstream>      // imports std::ofstream for file writing
#include <sstream>      // imports std::ifstream for file reading
#include <typeinfo>     // for data type comparison using std::typeid

// template functions
#include <appendRowToCSV.h>

// forward declarations of functions
std::vector<std::vector<std::string>> readCSV(std::filesystem::path filePath);
std::vector<double> vecStr2Double(std::vector<std::string> vecStr);
std::vector<std::vector<double>> vecVecStr2Double(std::vector<std::vector<std::string>> argin);


#endif