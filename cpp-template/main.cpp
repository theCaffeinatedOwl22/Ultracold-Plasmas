#include "fileIO.h"
#include "test.h"
#include "test2.h"

#include <vector>

int main(int argc, char *argv[])
{
    size_t elements = 2;
    std::vector<double> test(elements);
    appendRowToCSV<double>(test);
    
    return 0;
}