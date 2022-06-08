#ifndef CX_MATRIX_HPP
#define CX_MATRIX_HPP

#include <Matrix.hpp>

class CxMatrix
{
public: 
    CxMatrix(int rows,int cols)
    : m_real(rows,cols),m_imag(rows,cols) {}
private:
    Matrix m_real;
    Matrix m_imag;
};

#endif