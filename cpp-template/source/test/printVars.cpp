#include "test.h"
#include <iostream>
void QT::printVars()
{
    for (int i = 0; i < N0; i++){
        for (int j = 0; j < ax_num; j++){
            std::cout << pos[i][j] << " ";
        }
        std::cout << std::endl;
    }
}