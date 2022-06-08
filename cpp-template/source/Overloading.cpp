#include "Overloading.hpp"

#define BINARY_EXPR(expr) [](double this_comp,double that_comp) {return expr;}

Overloading& Overloading::operator+=(const Overloading& b)
{  
    this->m_num += b.m_num;
    return *this;
}

Overloading& Overloading::operator+=(int b)
{  
    this->m_num += b;
    return *this;
}

Overloading operator+(const Overloading& a,const Overloading& b)
{
    return a.get_num()+b.get_num();
}

Overloading operator+(const Overloading& a,double b)
{
    return a.get_num()+b;
}

std::ostream& operator<<(std::ostream& out, const Overloading& inp)
{
    out << "Num is: " << inp.m_num;
    return out;
}

std::vector<double> ComponentWiseOperation(const std::vector<double>& a, const std::vector<double>& b, const std::function<double(double,double)>& fun)
{
    assert(a.size()==b.size() && "Cannot add vectors of different length.");
    std::vector<double> result(a.size(),0.0);
    #pragma omp parallel for
    for (int i=0; i<result.size(); i++) result[i] = fun(a[i],b[i]);
    return result;
}

std::vector<double> ScalarOperation(const std::vector<double>& a,double b, const std::function<double(double,double)>& fun)
{
    std::vector<double> result(a.size(),0.0);
    #pragma omp parallel for
    for (int i=0; i<result.size(); i++) result[i] = fun(a[i],b);
    return result;
}

std::vector<double> operator+(const std::vector<double>& a,const std::vector<double>& b) { return ComponentWiseOperation(a,b,BINARY_EXPR(this_comp + that_comp));}
std::vector<double> operator+(const std::vector<double>& a,double b) { return ScalarOperation(a,b,BINARY_EXPR(this_comp + that_comp)); }
std::vector<double> operator+(double a,const std::vector<double>& b) { return ScalarOperation(b,a,BINARY_EXPR(this_comp + that_comp)); }