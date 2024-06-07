
## PATH
ROOT_PATH = $(shell pwd)
SYS = $(shell uname -s)
ARCH = $(shell uname -m)
COMMIT_ID := $(shell git rev-parse HEAD)


######################################
# objects
######################################
OBJS  := $(patsubst %.c,%.o,$(patsubst %.cpp,%.o,$(SOURCE_FILES-y)))
TARGET_OBJS := $(foreach x,$(OBJS),$(addprefix $(DIST_PATH)/,$(notdir $(x))))


######################################
# compilers
######################################
CC      := $(CROSS_COMPILE)$(CC)
AR      := $(CROSS_COMPILE)$(AR)
CXX     := $(CROSS_COMPILE)$(CXX)

# TARGET
ifeq ($(SYS), Linux)
CFLAGS  += -fPIC
CFLAGS  += -Werror
TARGET   = $(TARGET_SHARED_LIB) $(TARGET_STATIC_LIB)
RPATH    = -Wl,-rpath=$(DIST_PATH)
else
TARGET   = $(TARGET_STATIC_LIB)
endif

ifeq ($(RELEASE), RELEASE)
CFLAGS += -DSAKURA_RELEASE
else
CFLAGS += $(DEBUG_FLAG)
endif

# add pthread lib
ifeq ($(SYS), Linux)
LDFLAGS += -pthread
endif


# support gcovr or notdir
ifneq ($(GCOVR), )
ifeq ($(SYS), Linux)
LDFLAGS += -lgcov
endif
CFLAGS  += -fprofile-arcs -ftest-coverage
# remove exceptions flag for test case exceptions
CFLAGS += -DSAKURA_TEST_NO_EXCEPTIONS --coverage -fno-exceptions
endif

# support gcovr or notdir
ifneq ($(GCOVR), )
ifeq ($(SYS), Linux)
LDFLAGS += -lgcov
TEST_LDFLAGS += -lgcov
endif
CFLAGS  += -fprofile-arcs -ftest-coverage
endif

CFLAGS  += $(EXTRA_CFLAGS)
LDFLAGS += $(EXTRA_LDFLAGS)

# To prevent the nuptial
LDFLAGS += -Wl,-Bsymbolic

CFLAGS += -D'MQTT_SDK_COMMIT_ID="$(COMMIT_ID)"'

####### export for compiling app #######
export CC AR CFLAGS LDFLAGS ARFLAGS
########################################

#i think you should do anything here
.PHONY: objs clean check_path $(TARGET_SHARED_LIB) lib

all: demo

%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $(DIST_PATH)/$(notdir $@)

objs: $(OBJS)

clean:
	rm -rf demo

demo: demo.c
	$(CC) $< -o $@ $(CFLAGS) -L $(DIST_PATH) $(LDFLAGS) $(RPATH) $(LDFLAGS) -g -Wall