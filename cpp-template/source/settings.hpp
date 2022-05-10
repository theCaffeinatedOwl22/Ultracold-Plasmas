#ifndef SETTINGS_HPP
#define SETTINGS_HPP

#include "utility.hpp"

#include <filesystem> // std::filesystem
#include <iostream> // std::cerr, std::endl, std::cout
#include <algorithm> // std::remove, std::find, std::distance
#include <vector> // std::vector
#include <string> // std::string, std::getline
#include <fstream> // std::ofstream, std::ifstream
#include <sstream> // std::istringstream

namespace fs = std::filesystem;

class Settings
{
public: 
    Settings(fs::path settings_path);
    
    void load_settings(const fs::path& settings_path);
    void check_units(void) const;
    void choose_array(const int& array);
    
    std::vector<int> get_valid_arrays() const;
    double getvar(const std::string& name) const; 
    std::string getopt(const std::string& name) const;
    
    void write_array_params(const fs::path& path) const;

private:
    std::vector<std::vector<std::string>> m_mat; 
    std::vector<std::string> m_names, m_units, m_vals;
    bool m_array_chosen{false}; // must be set to true by <choose_array> before calling <getvar> or <getopt>

    std::vector<std::vector<std::string>> unique_comb(const std::vector<std::vector<std::string>>& mat_in,const std::vector<std::string>& vec_2) const;
    std::vector<std::vector<std::string>> unique_comb(const std::vector<std::string>& vec_in,const std::vector<std::string>& vec_2) const;
};

#endif