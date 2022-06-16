# Based on http:\\make.mad-scientist.net\papers\advanced-auto-dependency-generation
OBJDIR := objects
SRCS := source\matrix.cpp \
	source\class_notes.cpp \
	source\overloading.cpp \
	source\physics_cgs.cpp \
	source\settings.cpp \
	source\utility.cpp \
	main.cpp

OBJS := $(SRCS:%.cpp=$(OBJDIR)\%.o)
DEPDIR := $(OBJDIR)\.deps
DEPFLAGS = -MT $@ -MMD -MP -MF $(DEPDIR)\$*.d
EXEC = run

CXX = g++
CXXFLAGS = -fopenmp -std=c++20
CPPFLAGS = -I.\source

COMPILE.c = $(CXX) $(DEPFLAGS) $(CXXFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c

run: $(OBJS)
	$(CXX) $(CXXFLAGS) $(OBJS) -o $(EXEC)

clean:
	rm -f $(EXEC)
	rm -rf obj\

$(OBJDIR)\%.o : %.cpp $(DEPDIR)\%.d | $(DEPDIR)
	@mkdir -p $(dir $@)
	$(COMPILE.c) -o $@ $<

$(DEPDIR): ; @mkdir -p $@

DEPFILES := $(SRCS:%.cpp=$(DEPDIR)\%.d)
$(DEPFILES):
	@mkdir -p $(dir $@)

include $(wildcard $(DEPFILES))
