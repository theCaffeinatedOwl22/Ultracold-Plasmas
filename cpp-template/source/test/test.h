#ifndef TEST_h
#define TEST_h

#include <vector>

class QT
{
public:
    // const member variables - these must be set using initialization list in constructor
    enum class PosOpt : int {zeros}; // options for position initialization
    enum Axes{ax_x,ax_y,ax_z,ax_num}; // cartesian axes for simulation

    const int N0; // number of particles in simulation
    
    struct Units{double r; double t; double E;};
    const Units units; // natural units for simulation in SI

    // non-const member varialbes - can be set using constructor
    std::vector<std::vector<double>> pos; // pos[i][j] = position of ith particle along jth dimension
    std::vector<std::vector<double>> vel; // vel[i][j] = velocity of ith particle along jth dimension

    // class constructor
    QT(int arg1 = 1): // input arguments for constructor
        N0{arg1},
        units{1., 2.}
    {
        init_pos(PosOpt::zeros); // initialize particle positions
    }

    // add member function forward declarations
    void printVars();
    void init_pos(PosOpt opt = PosOpt::zeros);
};

#endif