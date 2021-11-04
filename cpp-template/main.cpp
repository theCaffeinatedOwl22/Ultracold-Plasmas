#include <string>
#include <vector>
#include <filesystem>

int main(int argc, char *argv[])
{
    std::string ind;
    int found;
    std::filesystem::path path {"/home/grant/git-hub/plasma-mdqt-simulation/MDQT-Functionalized/sims/equilCond"};
    std::vector<std::string> files; files.reserve(100);
    int ind1, ind2, ind3, ind4;
    double n, Ge, Ti;
    for (const auto & entry : std::filesystem::directory_iterator(path))
    {
        ind = entry.path();
        found = ind.find(path.string());
        if (found != std::string::npos){
            files.push_back(ind.substr(path.string().size()+1));
            ind1 = files.back().find("Ti");
            ind2 = files.back().find("_n");
            ind3 = files.back().find("_Ge");
            ind4 = files.back().find("_N");
            Ti = stod(files.back().substr(ind1+2,ind2-1));
            n = stod(files.back().substr(ind2+2,ind3-1));
            Ge = stod(files.back().substr(ind3+3,ind4-1));
        }

        

    }
    return 0;
}