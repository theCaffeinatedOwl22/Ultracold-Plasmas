#include "utility.hpp"

// round double to int
int round2int(const double& a) { return static_cast<int>(a < 0 ? a - 0.5 : a + 0.5); }

// bin <vec_in> into <num_bins> linearly spaced bins between min and max
std::vector<double> bin_vector(const std::vector<double>& vec_in,const std::vector<double>& bins)
{
    std::vector<double> num_in_bin(bins.size(),0.);
    double bin_spacing = bins[1] - bins[0];
    
    #pragma omp parallel for
    for (int i = 0; i < bins.size(); i++){ 
        for (int j = 0; j < vec_in.size(); j++){
            bool cond1, cond2, in_bin;
            cond1 = vec_in[j] < (bins[i] + bin_spacing/2.); 
            cond2 = vec_in[j] > (bins[i] - bin_spacing/2.); 
            in_bin = cond1 && cond2;
            if (in_bin) num_in_bin[i] += 1./vec_in.size();
        }
    }
    return num_in_bin;
}



// compute the norm (i.e., square root of a vectors inner product with itself)
double euclidean_norm(const std::vector<double>& vec_in)
{
    double norm;
    for (auto val : vec_in) norm += pow(val,2.);
    norm = sqrt(norm);
    return norm;
}

// read file with comma delimiter, "=" functions as ",", all text after "%" is ignored
std::vector<std::vector<std::string>> readCSV(fs::path filePath)
// filePath: full path to .csv file to read from, formatted as std::filesystem::path
{
    // check that file exists and is not empty
    if (!fs::exists(filePath) || fs::is_empty(filePath)){
        std::cerr << "The specified .csv file is either empty or does not exist." << std::endl;
    }

    // initialize data with reasonable buffer size
    std::vector<std::vector<std::string>> data;
    data.reserve(100);

    // open input stream to file
    std::ifstream fileStream;            // initialize empty stream object
    while(!fileStream.is_open()){             // while the file is not open...
        fileStream.open(filePath);  // try to open file
    }
    
    // read data from file line-by-line: % comments out line, read after :, spaces are ignored
    while (fileStream.good()){ // while stream is open and has no errors
        // read in current line from .csv file
        std::string currLine; // initialize container for current line of .csv file
        std::getline(fileStream,currLine); // read in current line

        // if first character is "%", line is ignored
        std::size_t pos = currLine.find("%");
        if (pos == 0) currLine.clear();
        else if (pos != std::string::npos) currLine = currLine.substr(0,pos-1);

        // convert '#' to ','
        while ((pos = currLine.find("=")) != std::string::npos) currLine.replace(pos,1,",");

        // remove spaces from string
        auto new_end = std::remove(currLine.begin(),currLine.end(),' ');
        currLine.erase(new_end,currLine.end());
        
        std::istringstream ss(currLine); // create stream to current line

        // parse .csv delimited values one at a time
        std::vector<std::string> currVec; // create container for parsing of current line
        currVec.reserve(100); // initialize container size
        while (ss.good()){ // for each delimited value in currLine
            std::string s;
            std::getline(ss,s,','); // place delimited value in 's'
            currVec.push_back(s); // place that element in currVec

            if(currVec.size() == currVec.capacity()){ // ensure that reserved size for currVec is large enough
                currVec.reserve(2.*currVec.capacity()); 
            }
        }
        currVec.shrink_to_fit(); // remove excess space

        // store parsed line into data and ensure the reserved storage is large enough
        
        if (!currLine.empty()){
            data.push_back(currVec); // store in data
            if(data.size() == data.capacity()){ // if actual size has reached buffer size
            data.reserve(2.*data.capacity()); // double buffer size
        }
        
    }
    }

    // close file stream and shrink data buffer to actual size
    fileStream.close();
    data.shrink_to_fit();

    return data;
}


void error(const std::string& err_msg)
{
    std::cerr << err_msg << std::endl;
    std::abort();
}

std::string getCommandLineArg(int argc, char* argv[], std::string short_flag, std::string long_flag)
{
  std::vector<std::string> arguments(argv+1, argv+argc);
  std::string result;
  int num_args = argc - 1;
  for(int i=0; i<num_args; i++){
    assert(arguments[i][0] == '-' && i+1<num_args && "Error 1: arguments must be given as flag followed by non-flag");
    if(arguments[i] == short_flag || arguments[i] == long_flag){
      assert(result.empty() && "Error 2: command line flags cannot be used more than once");
      result = arguments[i+1];
    }
    i++;
  }
  return result;
}