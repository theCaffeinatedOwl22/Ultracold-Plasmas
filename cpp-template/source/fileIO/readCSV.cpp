#include <fileIO.h>
namespace fs = std::filesystem;
using namespace std;

vector<vector<string>> readCSV(fs::path filePath)
// filePath: full path to .csv file to read from, formatted as std::filesystem::path
{
    // check that file exists and is not empty
    if (!fs::exists(filePath) || fs::is_empty(filePath)){
        cerr << "The specified .csv file is either empty or does not exist." << endl;
    }

    // initialize data with reasonable buffer size
    vector<vector<string>> data;
    data.reserve(100);

    // open input stream to file
    ifstream fileStream;            // initialize empty stream object
    while(!fileStream.is_open()){             // while the file is not open...
        fileStream.open(filePath);  // try to open file
    }
    
    // read data from file line-by-line
    while (fileStream.good()){ // while stream is open and has no errors
        // read in current line from .csv file
        string currLine; // initialize container for current line of .csv file
        getline(fileStream,currLine); // read in current line
        istringstream ss(currLine); // create stream to current line

        // parse .csv delimited values one at a time
        vector<string> currVec; // create container for parsing of current line
        currVec.reserve(100); // initialize container size
        while (ss.good()){ // for each delimited value in currLine
            string s;
            getline(ss,s,','); // place delimited value in 's'
            currVec.push_back(s); // place that element in currVec

            if(currVec.size() == currVec.capacity()){ // ensure that reserved size for currVec is large enough
                currVec.reserve(2.*currVec.capacity()); 
            }
        }
        currVec.shrink_to_fit(); // remove excess space

        // store parsed line into data and ensure the reserved storage is large enough
        data.push_back(currVec); // store in data
        if(data.size() == data.capacity()){ // if actual size has reached buffer size
        data.reserve(2.*data.capacity()); // double buffer size
    }
    }

    // close file stream and shrink data buffer to actual size
    fileStream.close();
    data.shrink_to_fit();

    return data;
}