#ifndef BAZ_H
#define BAZ_H

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
