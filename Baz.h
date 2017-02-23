#ifndef __BAZ_H__
#define __BAZ_H__

class Baz
{
public:
    Baz();
   ~Baz();

private:
    Baz(const Baz&);
    Baz& operator=(const Baz&);
};

#endif
