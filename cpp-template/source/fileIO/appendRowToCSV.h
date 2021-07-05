#ifndef appendRowToCSV_h
#define appendRowToCSV_h

#include <fileIO.h>

namespace fs = std::filesystem;
using namespace std;

template <typename T>
void appendRowToCSV(fs::path filePath, vector<T> data)
// filePath: full path to .csv file specified as type std::filesystem::path
// data: a std::vector of fundamental data type (i.e., string, double, int, etc)
{
    // open output stream to file depending on whether file exists or not
    ofstream fileStream;
    if (!fs::exists(filePath)){ // if file does not exist
        fileStream.open(filePath); // open stream to file
    }
    else if (fs::exists(filePath)){ // if file does exist
        fileStream.open(filePath,ofstream::app);
    }

    // append 'data' to file
    string delim{","};
    for (int i = 0; i < data.size() - 1; i++){
        fileStream << data[i] << delim;
    }
    fileStream << data.back() << endl;
}

#endif