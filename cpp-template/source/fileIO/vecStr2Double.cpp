#include <fileIO.h>

using namespace std;

vector<double> vecStr2Double(vector<string> argin)
// vecStr: vector of strings to be converted to vector of doubles
{
    vector<double> vecDouble;                   // initialize vector double
    vecDouble.resize(argin.size());            // initialize size of vector to be same as input    
    for(int i = 0; i < vecDouble.size(); i++){  // for each element
        vecDouble[i] = atof(argin[i].c_str()); // convert string to double
    }
    return vecDouble;
}