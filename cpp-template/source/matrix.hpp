#ifndef MATRIX_HPP
#define MATRIX_HPP

#include <vector>
#include <complex>

// sparse matrix features
// matrix multiplication
// use lambdas to define component wise operations
// component-wise operations are operations where you iterate over the entire matrix and do some operation on each element
    // add constant value to entire matrix
    // multiply each value by something
    // get the min, max of the matrix

class Matrix
{
public: 
    // *** Construction
    using cx = std::complex<double>;
    using matrix = std::vector<std::vector<cx>>;
    Matrix(size_t rows,size_t cols,cx val = 0);
    static Matrix zero(size_t rows,size_t cols);

    // *** Usage
    void transpose();
    void conjugate();

    // *** Operators
    cx& operator()(size_t row, size_t col);
    cx operator()(size_t row, size_t col) const;
private:
    size_t m_rows{};
    size_t m_cols{};
    matrix m_mat{};
};

#endif