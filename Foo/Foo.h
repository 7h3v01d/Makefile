#ifndef FOO_H
#define FOO_H

class Foo
{
public:
    Foo();
   ~Foo();

private:
    Foo(const Foo&);
    Foo& operator=(const Foo&);
public:
};

#endif
