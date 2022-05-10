#include "settings.hpp"

// class constructor
Settings::Settings(fs::path settings_path)
{
    load_settings(settings_path);
    check_units();
}

// load .settings file that defines plasma characteristics for MHD simulation
void Settings::load_settings(const fs::path& settings_path)
{
    // mat_in[i] contains [name unit val1 val2 ... valx]
    std::vector<std::vector<std::string>> mat_in = readCSV(settings_path);

    // extract information from mat_in
    std::vector<std::vector<std::string>> vals(mat_in.size());
    m_names.resize(mat_in.size());  // name for each row
    m_units.resize(mat_in.size());  // unit for each row
    for (int i = 0; i < mat_in.size(); i++){
        assert(mat_in[i].size() >= 3 && "Each row must contain a variable name, unit, and one or more comma-separated values.");
        m_names[i] = mat_in[i][0];
        m_units[i] = mat_in[i][1];
        for (int j = 2; j < mat_in[i].size(); j++){
            vals[i].push_back(mat_in[i][j]);
        }
    }    


    
    // get unique combination of values for each variable and store in m_mat
    // m_mat[i][j] contains the values for the jth variable for the ith unique combination of parameters
    m_mat = unique_comb(vals[0],vals[1]);
    for (int i = 2; i < vals.size(); i++) m_mat = unique_comb(m_mat,vals[i]);
}

// verify that all variable units are specified correctly: either <cgs>, <opt>, or another variable name
void Settings::check_units(void) const{
    // possible_units are "cgs" or a variable name
    std::vector<std::string> possible_units;
    possible_units.reserve(m_names.size()+2);
    possible_units.push_back("cgs");
    possible_units.push_back("opt");
    for (auto& i : m_names) possible_units.push_back(i);

    // check that specified units are possible
    for (auto& i : m_units){
        bool unit_check = std::find(possible_units.begin(),possible_units.end(),i) != possible_units.end();
        assert(unit_check && "Units for each variable must either be <cgs> or another variable name.");
    } 

    // for varialbes with non-cgs units, check that their dependencies are in cgs
    for (int i = 0; i < m_units.size(); i++){ // for each unit
        if (m_units[i]!="cgs" && m_units[i]!="opt"){ // if unit is not "cgs"
            int dependent;
            for (int j = 0; j < m_names.size(); j++){
                if (m_names[j]==m_units[i]){
                    dependent = j;
                    break;
                }
            }
            if (m_units[dependent]!="cgs") error("Error in check_units: variable <" + m_names[i] + "> is specified in terms of <" + m_names[dependent] + ">, which is not specified in <cgs> units.");
        }
    }
    
}

// choose which set of unique conditions to use
void Settings::choose_array(const int& array)
{
    assert(array>=0 && array<m_mat.size() && "<array> is out of bounds for <m_mat>");
    m_vals = m_mat[array];
    m_array_chosen = true;
}

// return valid array values
std::vector<int> Settings::get_valid_arrays() const
{
    std::vector<int> arrays(m_mat.size());
    for (int i=0; i<m_mat.size(); i++){
        arrays[i] = i;
    }
    return arrays;
}

// return numeric variable with cgs units
double Settings::getvar(const std::string& name) const
{
    assert(m_array_chosen && "Set <m_array> using <choose_array> before calling variables with <getvar>.");

    // ensure given name corresponds to variable name and that variable is not type "opt"
    auto it = std::find(m_names.begin(),m_names.end(),name);
    if (it == m_names.end()) error("Error in Settings::getvar: requested variable <" + name + "> name was not found in .settings file.");
    size_t loc = std::distance(m_names.begin(),it);

    // get value of variable corresponding to <name>
    if (m_units[loc]=="opt") error("Error in Settings::getvar: requested variable <"+m_names[loc]+"> is type opt, so use <getopt> function instead.");
    double val = stod(m_vals[loc]);

    // if not in cgs units, convert <val> to cgs units
    if (m_units[loc]!="cgs"){ // if variable units are not "cgs" (i.e., expressed in terms of another variable)
        auto it = std::find(m_names.begin(),m_names.end(),m_units[loc]);
        if (it==m_names.end()) error("Error in Settings::getvar: <"+m_units[loc]+"> does not match a variable name.");
        size_t loc2 = std::distance(m_names.begin(),it);
        if (m_units[loc2]!="cgs") error("A variable was expressed in terms of <"+m_names[loc2]+">, but its units are not <cgs>.");
        val *= stod(m_vals[loc2]);
    }

    return val;
}

// return option variable as a string
std::string Settings::getopt(const std::string& name) const
{
    // ensure given name has units "opt"
    bool found{false};
    int iter;
    for (int i{0}; i<m_names.size(); i++){
        if (m_names[i]==name){
            found = true;
            iter = i;
            break;
        }
    }
    
    if (!found) error("Error in Settings::getvar: user input <" + name + "> does not match a variable name.");
    if (m_units[iter]!="opt") error("Error in Settings::getvar: requested variable <" + name + "> is not of type <opt>.");
    return m_vals[iter];
}

// write plasma settings for specified m_vals value (i.e., the corresponding row of m_mat)
void Settings::write_array_params(const fs::path& path) const
{
    if (!fs::exists(path)) fs::create_directory(path);
    fs::path file_path{path/"plasma.settings"};
    std::ofstream out_file(file_path);
    for (int i=0; i<m_names.size(); i++){
        out_file << m_names[i] << " = " << m_units[i] << " = " << m_vals[i];
        if (i!=m_names.size()-1) out_file << std::endl;
    }
}

// get unique combinations of each row of mat_in and each element of vec_2
std::vector<std::vector<std::string>> Settings::unique_comb(const std::vector<std::vector<std::string>>& mat_in,const std::vector<std::string>& vec_2) const
{
    std::vector<std::vector<std::string>> mat_out(mat_in.size()*vec_2.size());
    int row = 0;
    for (int i = 0; i < mat_in.size(); i++){
        for (int j = 0; j < vec_2.size(); j++){
            mat_out[row].reserve(mat_in[i].size()+1);
            for (int k = 0; k < mat_in[i].size(); k++) mat_out[row].push_back(mat_in[i][k]);
            mat_out[row].push_back(vec_2[j]);
            row++;
        }
    }

    return mat_out;
}

// get unique combinations of the elements in the two input vectors
std::vector<std::vector<std::string>> Settings::unique_comb(const std::vector<std::string>& vec_in,const std::vector<std::string>& vec_2) const
{
    std::vector<std::vector<std::string>> mat_out(vec_in.size()*vec_2.size());
    int row = 0;
    for (int i = 0; i < vec_in.size(); i++){
        for (int j = 0; j < vec_2.size(); j++){
            mat_out[row].push_back(vec_in[i]);
            mat_out[row].push_back(vec_2[j]);
            row++;
        }
    }

    return mat_out;
}