#include <fileIO.h>

namespace fs = std::filesystem;
using namespace std;

int main(int argc, char *argv[])
{
    // test appendToCSV function
    fs::path path{"/home/grant/git-hub/ultracold-plasmas/cpp-template/testFile.csv"};
    vector<vector<string>> data = readCSV(path);
    
    for(auto i: data){
        for(auto j : i){
            cout << j << ' ';
        }
        cout << endl;
    }
    vector<vector<double>> test = vecVecStr2Double(data);

    return 0;
}