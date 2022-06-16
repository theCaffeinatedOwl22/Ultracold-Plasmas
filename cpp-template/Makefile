# Based on http:\\make.mad-scientist.net\papers\advanced-auto-dependency-generation

# detect operating system and update path fixing variable 
ifeq ($(OS),Windows_NT)
define path
$(subst /,\,$1)
endef
endif
# input argument 
MAINFILE ?= main
FLAG ?= -g
# set up source, object, and dependent directories
SRCDIR := source
OBJDIR := objects
DEPDIR := $(OBJDIR)/.deps
SRCS := $(wildcard $(SRCDIR)/*.cpp) $(MAINFILE).cpp
OBJS := $(SRCS:%.cpp=$(OBJDIR)/%.o)
EXEC = $(OBJDIR)/$(MAINFILE).exe
# define flags for compilation
CXX = g++
CXXFLAGS = -fopenmp -std=c++20 $(FLAG)
CPPFLAGS = -I source
LNKFLAGS = -lm -larmadillo -lstdc++fs
DEPFLAGS = -MT $@ -MMD -MP -MF $(DEPDIR)/$*.d

# set the default goal by making the target of the first rule $(EXEC)
run : $(OBJS)
	$(CXX) $(CXXFLAGS) $(OBJS) -o $(EXEC) $(LNKFLAGS)

# option to clean directories at the end
clean :
	if exist $(OBJDIR) rmdir /s /q $(OBJDIR)

$(DEPDIR) : ; @mkdir $@

# rule for making object files
$(OBJDIR)/%.o : %.cpp $(DEPDIR)/%.d | $(DEPDIR)
	@if not exist $(dir $@) @mkdir $(call path,$(dir $@))
	$(CXX) $(DEPFLAGS) $(CXXFLAGS) $(CPPFLAGS) -c -o $@ $<

DEPFILES := $(SRCS:%.cpp=$(DEPDIR)/%.d)
$(DEPFILES):
	@if not exist $(dir $@) @mkdir $(call path,$(dir $@))

include $(wildcard $(DEPFILES))
