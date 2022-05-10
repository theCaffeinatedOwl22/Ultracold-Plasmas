#ifndef PHYSICS_CGS_HPP
#define PHYSICS_CGS_HPP

#include "constants_cgs.hpp"
#include <math.h>

//*** PHYSICS FORMULAS - all use cgs units ***//

double coulomb_coupling(const double& n,const double& T);
double wigner_seitz_radius(const double& n);
double plasma_freq(const double& n,const double& m);
double einstein_freq(const double& n,const double& m);
double nearest_coulomb_pot(const double& n);
double debye_length(const double& n,const double& T);
double screening_parameter(const double& n, const double& Te);
double dih_temp(const double& n,const double& Te);
double tau_exp(const double& sig,const double& m, const double& Te);

#endif