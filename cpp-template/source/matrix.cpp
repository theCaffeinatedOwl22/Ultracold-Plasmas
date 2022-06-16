#include <matrix.hpp>

#define BINARY_LAMBDA(expr) [](const Matrix::type lhs, const Matrix::type rhs){return expr;}
#define UNARY_LAMBDA(expr) [=](Matrix::type val){return expr;}
#define INPLACE_BINARY_LAMBDA(expr) [](Matrix::type& lhs,const Matrix::type rhs){return expr;}

Matrix::Matrix(int rows,int cols,type val): m_rows{rows}, m_cols{cols}, m_size{rows*cols}, m_mat(m_size,val) {}

Matrix Matrix::identity(int size)
{
    Matrix result {Matrix(size,size)};
    for (int i=0; i<size; i++) result(i,i) = 1.;
    return result;
}

Matrix::type& Matrix::operator()(size_t row, size_t col)
{
    assert(row>=0 && row<m_rows && col>=0 && col<m_cols && "Indices out of range.");
    return m_mat[row*m_cols+col];
}
Matrix::type Matrix::operator()(size_t row, size_t col) const
{
    assert(row>=0 && row<m_rows && col>=0 && col<m_cols && "Indices out of range.");
    return m_mat[row*m_cols+col];
}
Matrix::type& Matrix::operator()(size_t el)
{
    assert(el>=0 && el<m_size && "Index out of range.");
    return m_mat[el];
}
Matrix::type Matrix::operator()(size_t el) const
{
    assert(el>=0 && el<m_size && "Index out of range.");
    return m_mat[el];
}

Matrix ComponentWiseOp(const Matrix& mat,const Matrix::type& val,const std::function<Matrix::type(Matrix::type,Matrix::type)>& fun)
{
    Matrix result{Matrix::zeros(mat.rows(),mat.cols())};
    #pragma omp parallel for
    for (int i=0; i<mat.size(); i++) result(i) = fun(mat(i),val);
    return result;
}

Matrix ComponentWiseOp(const Matrix::type& val,const Matrix& mat,const std::function<Matrix::type(Matrix::type,Matrix::type)>& fun)
{
    Matrix result{Matrix::zeros(mat.rows(),mat.cols())};
    #pragma omp parallel for
    for (int i=0; i<mat.size(); i++) result(i) = fun(val,mat(i));
    return result;
}

Matrix ComponentWiseOp(const Matrix& mat1,const Matrix& mat2,const std::function<Matrix::type(Matrix::type,Matrix::type)>& fun)
{
    assert(mat1.rows()==mat2.rows() && mat1.cols()==mat2.cols());
    Matrix result{Matrix::zeros(mat1.rows(),mat1.cols())};
    #pragma omp parallel for
    for (int i=0; i<mat1.size(); i++) result(i) = fun(mat1(i),mat2(i));
    return result;
}

void Matrix::InPlaceComponentWiseOp(const Matrix& mat,const std::function<void(Matrix::type&,Matrix::type)>& fun)
{
    assert(m_rows==mat.rows() && m_cols==mat.cols());
    #pragma omp parallel for
    for (int i=0; i<m_size; i++) fun((*this)(i),mat(i));
}
void Matrix::InPlaceComponentWiseOp(const type& val,const std::function<void(Matrix::type&,Matrix::type)>& fun)
{
    #pragma omp parallel for
    for (int i=0; i<m_size; i++) fun((*this)(i),val);
}

void Matrix::operator+=(const Matrix& mat) {InPlaceComponentWiseOp(mat,INPLACE_BINARY_LAMBDA(lhs += rhs));}
void Matrix::operator+=(const type& val) {InPlaceComponentWiseOp(val,INPLACE_BINARY_LAMBDA(lhs += rhs));}
void Matrix::operator-=(const Matrix& mat) {InPlaceComponentWiseOp(mat,INPLACE_BINARY_LAMBDA(lhs -= rhs));}
void Matrix::operator-=(const type& val) {InPlaceComponentWiseOp(val,INPLACE_BINARY_LAMBDA(lhs -= rhs));}
void Matrix::operator*=(const Matrix& mat) {InPlaceComponentWiseOp(mat,INPLACE_BINARY_LAMBDA(lhs *= rhs));}
void Matrix::operator*=(const type& val) {InPlaceComponentWiseOp(val,INPLACE_BINARY_LAMBDA(lhs *= rhs));}
void Matrix::operator/=(const Matrix& mat) {InPlaceComponentWiseOp(mat,INPLACE_BINARY_LAMBDA(lhs /= rhs));}
void Matrix::operator/=(const type& val) {InPlaceComponentWiseOp(val,INPLACE_BINARY_LAMBDA(lhs /= rhs));}

Matrix operator+(const Matrix& mat, const Matrix::type& val) {return ComponentWiseOp(mat,val,BINARY_LAMBDA(lhs + rhs));}
Matrix operator+(const Matrix::type& val, const Matrix& mat) {return ComponentWiseOp(val,mat,BINARY_LAMBDA(lhs + rhs));}
Matrix operator+(const Matrix& mat1, const Matrix& mat2) {return ComponentWiseOp(mat1,mat2,BINARY_LAMBDA(lhs + rhs));}
Matrix operator-(const Matrix& mat, const Matrix::type& val) {return ComponentWiseOp(mat,val,BINARY_LAMBDA(lhs - rhs));}
Matrix operator-(const Matrix::type& val, const Matrix& mat) {return ComponentWiseOp(val,mat,BINARY_LAMBDA(lhs - rhs));}
Matrix operator-(const Matrix& mat1, const Matrix& mat2) {return ComponentWiseOp(mat1,mat2,BINARY_LAMBDA(lhs - rhs));}
Matrix operator*(const Matrix& mat, const Matrix::type& val) {return ComponentWiseOp(mat,val,BINARY_LAMBDA(lhs * rhs));}
Matrix operator*(const Matrix::type& val, const Matrix& mat) {return ComponentWiseOp(val,mat,BINARY_LAMBDA(lhs * rhs));}
Matrix operator*(const Matrix& mat1, const Matrix& mat2) {return ComponentWiseOp(mat1,mat2,BINARY_LAMBDA(lhs * rhs));}
Matrix operator/(const Matrix& mat, const Matrix::type& val) {return ComponentWiseOp(mat,val,BINARY_LAMBDA(lhs / rhs));}
Matrix operator/(const Matrix::type& val, const Matrix& mat) {return ComponentWiseOp(val,mat,BINARY_LAMBDA(lhs / rhs));}
Matrix operator/(const Matrix& mat1, const Matrix& mat2) {return ComponentWiseOp(mat1,mat2,BINARY_LAMBDA(lhs / rhs));}
Matrix operator%(const Matrix& mat1, const Matrix& mat2)
{
    assert(mat1.cols()==mat2.rows());
    Matrix result {Matrix::zeros(mat1.rows(),mat2.cols())};
    #pragma omp parallel for
    for (int i=0; i<result.rows(); i++){
        for (int j=0; j<result.cols(); j++){
            for (int k=0; k<mat1.cols(); k++) result(i,j) += mat1(i,k)*mat2(k,j);
        }
    }
    return result;
}

// returns the transpose of the matrix
Matrix Matrix::t()
{
    Matrix mat{zeros(m_cols,m_rows)};
    // #pragma omp parallel for
    for (int i=0; i<m_rows; i++){
        for (int j=0; j<m_cols; j++){
            mat(j,i) = (*this)(i,j);
        }
    }
    return mat;
}