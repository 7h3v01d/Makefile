CC=gcc
CXX=g++
CPPFLAGS=
CFLAGS=-Wall -Wextra -Wpedantic $(INCLUDEDIRS)
CXXFLAGS=-Wall -Wextra -Wpedantic $(INCLUDEDIRS)
LDLIBS=
LDFLAGS=
TARGET=quuz

SOURCES=Main.cpp \
	Foo/Foo.cpp \
	Bar.c \
	Baz.cpp \
	Qux/Qux.cpp

INCLUDES=Qux \
	Quux

BUILDDIR=.build
DEPDIR=$(BUILDDIR)/dep
OBJDIR=$(BUILDDIR)/obj
BINDIR=$(BUILDDIR)/bin

$(shell mkdir -p $(BUILDDIR))
$(shell mkdir -p $(DEPDIR))
$(shell mkdir -p $(OBJDIR))
$(shell mkdir -p $(BINDIR))

SUBTOOBJ=$(subst /,_0x2F_,$(1))
SUBTOSRC=$(subst _0x2F_,/,$(notdir $(1)))
SUBINCDIR=$(addprefix -I,$(1))

DEPFLAGS=-MT $@ -MMD -MP -MF $(DEPDIR)/$*.Td
COMPILE.c=$(CC) $(DEPFLAGS) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c
COMPILE.cpp=$(CXX) $(DEPFLAGS) $(CXXFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c
POSTCOMPILE=mv -f $(DEPDIR)/$*.Td $(DEPDIR)/$*.d
LINK.o=$(CXX) $(LDFLAGS) $(TARGET_ARCH)

INCLUDEDIRS=$(call SUBINCDIR,$(INCLUDES))

OBJECTS=$(filter %.c %.cpp,$(SOURCES))
OBJECTS:=$(basename $(OBJECTS))
OBJECTS:=$(addsuffix .o,$(OBJECTS))
OBJECTS:=$(call SUBTOOBJ,$(OBJECTS))
OBJECTS:=$(addprefix $(OBJDIR)/,$(OBJECTS))

DEPENDENCIES=$(filter %.c %.cpp,$(SOURCES))
DEPENDENCIES:=$(basename $(DEPENDENCIES))
DEPENDENCIES:=$(addsuffix .d,$(DEPENDENCIES))
DEPENDENCIES:=$(call SUBTOOBJ,$(DEPENDENCIES))
DEPENDENCIES:=$(addprefix $(DEPDIR)/,$(DEPENDENCIES))
DEPENDENCIES:=$(wildcard $(DEPENDENCIES))

.SECONDEXPANSION:
$(OBJDIR)/%.o: $$(call SUBTOSRC,%.c) $(DEPDIR)/%.d
	$(COMPILE.c) $(OUTPUT_OPTION) $<
	@$(POSTCOMPILE)

.SECONDEXPANSION:
$(OBJDIR)/%.o: $$(call SUBTOSRC,%.cpp) $(DEPDIR)/%.d
	$(COMPILE.cpp) $(OUTPUT_OPTION) $<
	@$(POSTCOMPILE)

$(DEPDIR)/%.d: ;
.PRECIOUS: $(DEPDIR)/%.d

$(BINDIR)/$(TARGET): $(OBJECTS)
	$(LINK.o) $^ $(LOADLIBES) $(LDLIBS) $(OUTPUT_OPTION)

.PHONY: all
all: $(BINDIR)/$(TARGET)

.PHONY: clean
clean:
	$(RM) $(DEPDIR)/*.Td
	$(RM) $(DEPDIR)/*.d
	$(RM) $(OBJDIR)/*.o
	$(RM) $(BINDIR)/$(TARGET)

include $(DEPENDENCIES)
