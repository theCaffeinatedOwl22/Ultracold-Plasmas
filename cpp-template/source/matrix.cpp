#include <matrix.hpp>

Matrix::Matrix(size_t rows,size_t cols,cx val):
    m_rows{rows}, m_cols{cols}
{
    m_mat.resize(rows);
    for (auto& row : m_mat) row.resize(cols,val);
}

Matrix Matrix::zero(size_t rows,size_t cols) { return Matrix(rows,cols,0.0); }

void Matrix::transpose()
{
    Matrix new_mat(m_rows,m_cols);
    #pragma omp parallel for
    for (int i=0; i<m_rows; i++){
        for (int j=0; j<m_cols; j++){
            new_mat(i,j) = (*this)(j,i);
        }
    }
}

void Matrix::conjugate()
{
    Matrix new_mat(m_rows,m_cols);
    #pragma omp parallel for
    for (int i=0; i<m_rows; i++){
        for (int j=0; j<m_cols; j++){
            new_mat(i,j) = conj((*this)(j,i));
        }
    }
}

Matrix::cx& Matrix::operator()(size_t row, size_t col)
{
    return m_mat[row][col];
}

Matrix::cx Matrix::operator()(size_t row, size_t col) const
{
    return m_mat[row][col];
}