#include "Foo/Foo.h"
#include "Bar.h"
#include "Baz.h"
#include "Qux/Qux.h"

int main(int argc, char** argv)
{
    (void)argc;
    (void)argv;

    Foo foo;
    Bar();
    Baz baz;
    Qux qux;

    return 0;
}
