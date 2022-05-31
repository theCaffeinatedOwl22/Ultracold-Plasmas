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

int round2int(const double& a);
std::vector<double> bin_vector(const std::vector<double>& vec_in,const std::vector<double>& bins);
double euclidean_norm(const std::vector<double>& vec_in);
std::vector<std::vector<std::string>> read_file(fs::path filePath);
std::string getCommandLineArg(int argc, char* argv[], std::string short_flag, std::string long_flag);

//*** FUNCTION TEMPLATES ***//

// generate linearly spaced values between min and max
template <typename T> std::vector<T> linspace(double min, double max, int num_pts)
{
    std::vector<T> vec_out(num_pts);
    assert(num_pts>1);
    double spacing = (max - min)/(num_pts-1);
    for (int i = 0; i < num_pts; i++) vec_out[i] = min + spacing*i;
    return vec_out;
}

#endif