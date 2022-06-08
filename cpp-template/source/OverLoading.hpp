#ifndef OVERLOADING_HPP
#define OVERLOADING_HPP

#include <iostream>
#include <vector>
#include <cassert>
#include <functional>

class Overloading
{
    public:
        using number = int;
        Overloading(int inp = 0,size_t size = 1): m_num(inp), m_vec{std::vector(size,0.0)} {};
        number get_num() const { return m_num; };
        void set_num(double inp) { m_num = inp; };

        // *** Unary Operators
            // these operators modify the object on the LHS
            // always return *this so you can chain uses of unary operators

            Overloading& operator+=(const Overloading& b);
            Overloading& operator+=(int b);

        // *** Binary Operators
            // should generally be friends because they do not modify the objects in the operation
            // return either an object of the class or a value that can instantiate the class
            // below I return a <number> because it can be used in the Overloading constructor

            friend Overloading operator+(const Overloading& a,const Overloading& b);
            friend Overloading operator+(const Overloading& a,double b);
            friend std::ostream& operator<<(std::ostream& out, const Overloading& inp);
            

    private:
        number m_num{};
        std::vector<double> m_vec{};
};

std::vector<double> ComponentWiseOperation(const std::vector<double>& a,const std::vector<double>& b, const std::function<double(double,double)>& fun);
std::vector<double> ScalarOperation(const std::vector<double>& a,double b, const std::function<double(double,double)>& fun);
std::vector<double> operator+(const std::vector<double>& a,const std::vector<double>& b);
std::vector<double> operator+(const std::vector<double>& a,double b);


#endif