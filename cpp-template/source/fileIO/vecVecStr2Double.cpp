#include <fileIO.h>

using namespace std;

vector<vector<double>> vecVecStr2Double(vector<vector<string>> argin)
// argin: vector vector string to be converted to type double
// argout: vector<vector<double>>
{
    vector<vector<double>> argout;              // initialize vector double
    argout.resize(argin.size());                // initialize size of vector to be same as input    
    for(int i = 0; i < argin.size(); i++){      // for each element
        argout[i] = vecStr2Double(argin[i]);    // convert string to double
    }
    return argout;
}