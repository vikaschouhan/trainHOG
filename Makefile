.DEFAULT_GOAL := all

# Environment
MKDIR=mkdir
CP=cp
GREP=grep
NM=nm
CCADMIN=CCadmin
RANLIB=ranlib
CC=gcc
CCC=g++
CXX=g++
FC=gfortran
AS=as

OBJECTDIR=build
EXEFILE=openhogtrainer

# Object Files
OBJECTFILES= \
	${OBJECTDIR}/main.o \
	${OBJECTDIR}/svm_common.o \
	${OBJECTDIR}/svm_hideo.o \
	${OBJECTDIR}/svm_learn.o


# C Compiler Flags
CFLAGS=

# CC Compiler Flags
CCFLAGS=
CXXFLAGS=`pkg-config --cflags opencv`

# Fortran Compiler Flags
FFLAGS=

# Assembler Flags
ASFLAGS=

# Link Libraries and Options
LDLIBSOPTIONS=-lopencv_calib3d -lopencv_contrib -lopencv_core -lopencv_features2d -lopencv_flann -lopencv_gpu -lopencv_highgui -lopencv_imgproc -lopencv_legacy -lopencv_ml -lopencv_objdetect -lopencv_ts -lopencv_video

${OBJECTDIR}/main.o: main.cpp 
	${CCC} -O2 ${CXXFLAGS} -MMD -MP -MF "$@.d" -c -o ${OBJECTDIR}/main.o main.cpp

${OBJECTDIR}/svm_common.o: svmlight/svm_common.c 
	${CC} -O2 ${CXXFLAGS} -MMD -MP -MF "$@.d" -c -o ${OBJECTDIR}/svm_common.o svmlight/svm_common.c

${OBJECTDIR}/svm_hideo.o: svmlight/svm_hideo.c 
	${CC} -O2 ${CXXFLAGS} -MMD -MP -MF "$@.d" -c -o ${OBJECTDIR}/svm_hideo.o svmlight/svm_hideo.c

${OBJECTDIR}/svm_learn.o: svmlight/svm_learn.c 
	${CC} -O2 ${CXXFLAGS} -MMD -MP -MF "$@.d" -c -o ${OBJECTDIR}/svm_learn.o svmlight/svm_learn.c

${OBJECTDIR}:
	${MKDIR} -p ${OBJECTDIR}

all: ${OBJECTDIR} ${OBJECTFILES}
	${CCC} ${CXXFLAGS} -o ${EXEFILE} ${OBJECTFILES} `pkg-config --libs opencv`

# Clean Targets
clean:
	${RM} -f ${EXEFILE}
	${RM} -r ${OBJECTDIR}
