#include "class_notes.hpp"

// alternate constructor
ClassNotes::ClassNotes(double val,double val2)
    : m_const_member{val}, m_member{val2}
{}

// example of a static function
    // does not see the this pointer
    // cannot see non-static members
const std::string& ClassNotes::static_function()
{
    return m_static_member;
}

// example of using friend keyword
    // friends can see private members of a class and do not require :: scope resolution
void friendly_printer(ClassNotes& obj)
{
    std::cout << obj.m_member << std::endl;
}

// example getter function - return by value or const reference
double ClassNotes::member() const { return m_member;}

// example setter function
void ClassNotes::set_member(double val) {m_member = val;}

// chainable function
    // chainable because it returns a non-const reference
ClassNotes& ClassNotes::chainable_func() {return *this;}