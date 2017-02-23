#ifndef __QUX_H__
#define __QUX_H__

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
