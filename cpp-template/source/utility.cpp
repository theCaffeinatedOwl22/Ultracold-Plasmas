#include "utility.hpp"

// read file with comma delimiter - <#> functions as <,> - all white space ignored - all text in line after <%> is ignored
std::vector<std::vector<std::string>> read_file(fs::path filePath)
{
    assert(fs::exists(filePath) && !fs::is_empty(filePath) && "File must exist and not be empty.");

    // initialize data with reasonable buffer size
    std::vector<std::vector<std::string>> data;
    data.reserve(100);

    // open input stream to file
    std::ifstream fileStream;       // initialize empty stream object
    while(!fileStream.is_open()){   // while the file is not open...
        fileStream.open(filePath);  // try to open file
    }
    
    // read data from file line-by-line: % comments out line, read after :, spaces are ignored
    while (fileStream.good()){ // while stream is open and has no errors
        std::string currLine;
        std::getline(fileStream,currLine);
        std::size_t pos = currLine.find("%");
        if (pos == 0) currLine.clear();
        else if (pos != std::string::npos) currLine = currLine.substr(0,pos-1);

        // convert '#' to ','
        while ((pos = currLine.find("=")) != std::string::npos) 
            currLine.replace(pos,1,",");

        // remove spaces from string
        auto new_end = std::remove(currLine.begin(),currLine.end(),' ');
        currLine.erase(new_end,currLine.end());
        
        // parse .csv delimited values one at a time
        std::istringstream ss(currLine);
        std::vector<std::string> currVec; // create container for parsing of current line
        currVec.reserve(100); // initialize container size
        while (ss.good()){ // for each delimited value in currLine
            std::string s;
            std::getline(ss,s,','); // place delimited value in 's'
            currVec.push_back(s); // place that element in currVec

            if(currVec.size() == currVec.capacity()) // ensure that reserved size for currVec is large enough
                currVec.reserve(2.*currVec.capacity()); 
        }
        currVec.shrink_to_fit(); // remove excess space

        // store parsed line into data and ensure the reserved storage is large enough
        if (!currLine.empty()){
            data.push_back(currVec); // store in data
            if (data.size() == data.capacity()) 
                data.reserve(2.*data.capacity()); // double buffer size
        }
    }

    // close file stream and shrink data buffer to actual size
    fileStream.close();
    data.shrink_to_fit();

    return data;
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