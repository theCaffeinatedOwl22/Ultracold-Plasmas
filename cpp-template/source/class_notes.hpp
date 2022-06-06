#ifndef CLASS_NOTES_HPP
#define CLASS_NOTES_HPP

#include <iostream>
#include <vector>

class ClassNotes
{
    public: // for usage: constructors, getter/setter, other class functionality
        
        // *** Constructors - have no return type, not even void

            ClassNotes(double val,double val2); // alternate constructor
            ClassNotes(); // using a default constructor to delegate to an alternate
            // ClassNotes() = default; // designate an empty default constructor when one does not exist

        // *** Member Functions
            double member() const;
            void set_member(double val);
            ClassNotes& chainable_func();

        // *** Static Examples
            static const inline std::string m_static_member {"test static..."}; // static means property of class, not class object
                // only integral types can be defined inline without the inline keyword
                // need to learn difference between const and constexpr
            static const inline std::vector<int> m_lambda_ex {
                []{
                    std::vector<int> temp(4);
                    for (int i=0; i<temp.size(); i++) temp[i]=i;
                    return temp;
                }() // evaluate lambda right away
            }; // example of using lambda for initialization
            static const std::string& static_function();

        // *** Friends
            // these are not member functions, so require passing of class into function
            // can access private members of class they are friend to
            friend void friendly_printer(ClassNotes& obj); 

    private:// all members and non-end-user functions
            // all  members are initialized in the order they are declared

    // *** Class Members

        double m_member {}; // use brace initialization to avoid undefined behavior
        const double m_const_member {}; // must be initialized in constructor because const
        

    // *** Private Functions

};

#endif