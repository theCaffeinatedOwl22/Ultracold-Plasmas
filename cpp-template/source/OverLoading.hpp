#ifndef OVERLOADING_HPP
#define OVERLOADING_HPP

#include <iostream>

class Overloading
{
    public:
        using number = int;
        Overloading(int inp = 0): m_num(inp) {};
        number get_num() const { return m_num; };
        void set_num(double inp) { m_num = inp; };

        // *** Unary Operators
            // these operators modify the object on the LHS
            // always return *this so you can chain uses of unary operators

        Overloading& operator+=(const Overloading& b)
        {  
            this->m_num += b.m_num;
            return *this;
        }

        Overloading& operator+=(int b)
        {  
            this->m_num += b;
            return *this;
        }

        // *** Binary Operators
            // should generally be friends because they do not modify the objects in the operation
            // return either an object of the class or a value that can instantiate the class
            // below I return a <number> because it can be used in the Overloading constructor

        friend Overloading operator+(const Overloading& a,const Overloading& b)
        {
            return a.get_num()+b.get_num();
        }

        friend Overloading operator+(const Overloading& a,double b)
        {
            return a.get_num()+b;
        }

        friend std::ostream& operator<<(std::ostream& out, const Overloading& inp)
        {
            out << "Num is: " << inp.m_num;
            return out;
        }
    private:
        number m_num {};
};

#endif