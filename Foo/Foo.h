#ifndef __FOO_H__
#define __FOO_H__

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
