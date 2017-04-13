#ifndef QUX_H
#define QUX_H

#include "../Baz.h"

class Qux:
    public Baz
{
public:
    Qux();
   ~Qux();

private:
    Qux(const Qux&);
    Qux& operator=(const Qux&);
};

#endif
