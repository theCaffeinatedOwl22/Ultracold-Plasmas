#include "test.h"
#include <vector>

using namespace std;

void QT::init_pos(PosOpt opt)
{
    if (opt == PosOpt::zeros){
        pos.resize(N0);
        for (int i = 0; i < N0; i++){
            pos[i].resize(ax_num,0.);
        }
    }
}
