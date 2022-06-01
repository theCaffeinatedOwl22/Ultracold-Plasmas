#ifndef SETTINGS_HPP
#define SETTINGS_HPP

#include <iostream> // std::cerr, std::endl, std::cout
#include <filesystem> // std::filesystem
#include <algorithm> // std::remove, std::find, std::distance
#include <vector> // std::vector
#include <string> // std::string, std::getline
#include <fstream> // std::ofstream, std::ifstream
#include <sstream> // std::istringstream
#include <cassert>

namespace fs = std::filesystem;

class Settings
{
public: 
    // *** Constructor
    Settings(fs::path settings_path,std::string unit = "cgs");

    // *** Initialization
    void load_settings(const fs::path& settings_path);
    void check_units() const;
    void process_runs();
    void choose_array(const int& array);
    
    // *** Getters
    std::string task_array_range() const;
    std::vector<int> task_array() const;
    int array_size() const;
    int runs() const;
    double getvar(const std::string& name) const; 
    std::string getopt(const std::string& name) const;
    
    // *** File I/O
    fs::path output_path() const;
    void write_array_params(const fs::path& path, bool overwrite = false) const;
    void write_all(const fs::path& path, bool overwrite = false);
    template<typename T> static std::string num2str(T num,int prec = 9)
    {
            std::stringstream ss;
            ss.precision(prec);
            ss << num;
            return ss.str();
    };
private:
    const std::string m_unit_str;

    std::vector<std::string> m_names, m_units;
    std::vector<std::vector<std::string>> m_vals;
    std::vector<std::vector<std::string>> m_unique;

    bool m_runs_found; // indicates whether <runs> was given in the .settings 
    int m_runs; // number of runs for each unique set of conditions

    bool m_array_chosen{false}; // must be set to true by <choose_array> before calling <getvar> or <getopt>
    int m_array;
    std::vector<std::string> m_array_vals; // m_array_vals[i] holds the values for the chosen array correponding to m_names[i] and m_units[i]

    std::vector<std::vector<std::string>> unique_comb(const std::vector<std::vector<std::string>>& mat_in,const std::vector<std::string>& vec_2) const;
    std::vector<std::vector<std::string>> unique_comb(const std::vector<std::string>& vec_in,const std::vector<std::string>& vec_2) const;
    std::vector<std::vector<std::string>> read_file(fs::path filePath);    
};

#endif