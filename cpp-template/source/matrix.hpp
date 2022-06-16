#ifndef MATRIX_HPP
#define MATRIX_HPP

#include <iostream>
#include <vector>
#include <string>
#include <complex>
#include <functional>
#include <cassert>

class Matrix
{
public: 
    // *** Type Alias
    using type = double;
    using matrix = std::vector<type>;
    // *** Construction
    Matrix(int rows=1,int cols=1,type val = 0);
    static Matrix zeros(int rows, int cols) {return Matrix(rows,cols,0.0);}
    static Matrix ones(int rows, int cols) {return Matrix(rows,cols,1.0);}
    static Matrix identity(int size);
    // *** Return Operators
    type& operator()(size_t row, size_t col);
    type operator()(size_t row, size_t col) const;
    type& operator()(size_t el);
    type operator()(size_t el) const;
    // *** In Place Operators
    void operator+=(const Matrix& mat);
    void operator+=(const type& val);
    void operator-=(const Matrix& mat);
    void operator-=(const type& val);
    void operator*=(const Matrix& mat);
    void operator*=(const type& val);
    void operator/=(const Matrix& mat);
    void operator/=(const type& val);
    // *** Componentwise Scalar Operators
    friend Matrix operator+(const Matrix& mat, const type& val);
    friend Matrix operator+(const type& val, const Matrix& mat);
    friend Matrix operator-(const Matrix& mat, const type& val);
    friend Matrix operator-(const type& val, const Matrix& mat);
    friend Matrix operator*(const Matrix& mat, const type& val);
    friend Matrix operator*(const type& val, const Matrix& mat);
    friend Matrix operator/(const Matrix& mat, const type& val);
    friend Matrix operator/(const type& val, const Matrix& mat);
    // *** Componentwise Matrix Operators
    friend Matrix operator+(const Matrix& mat1, const Matrix& mat2);
    friend Matrix operator-(const Matrix& mat1, const Matrix& mat2);
    friend Matrix operator%(const Matrix& mat1, const Matrix& mat2);
    friend Matrix operator/(const Matrix& mat1, const Matrix& mat2);
    // *** Matrix Multiplication
    friend Matrix operator*(const Matrix& mat1, const Matrix& mat2);
    // *** Other Operations
    Matrix t();
    // *** Getters
    int rows() const {return m_rows;}
    int cols() const {return m_cols;}
    int size() const {return m_size;}

private:
    // *** Members
    int m_rows{};
    int m_cols{};
    int m_size{};
    matrix m_mat{};
    // *** Operations
    friend Matrix ComponentWiseOp(const Matrix& mat,const type& val,const std::function<type(type,type)>& fun);
    friend Matrix ComponentWiseOp(const type& val,const Matrix& mat,const std::function<type(type,type)>& fun);
    friend Matrix ComponentWiseOp(const Matrix& mat1,const Matrix& mat2,const std::function<type(type,type)>& fun);
    void InPlaceComponentWiseOp(const Matrix& mat, const std::function<void(type&,type)>& fun);
    void InPlaceComponentWiseOp(const type& val, const std::function<void(type&,type)>& fun);

};

#endif