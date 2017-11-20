################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../src/lib/base/Settings.cpp \
../src/lib/base/baseAlg.cpp \
../src/lib/base/baseClasses.cpp \
../src/lib/base/ffmpegUtil.cpp 

OBJS += \
./src/lib/base/Settings.o \
./src/lib/base/baseAlg.o \
./src/lib/base/baseClasses.o \
./src/lib/base/ffmpegUtil.o 

CPP_DEPS += \
./src/lib/base/Settings.d \
./src/lib/base/baseAlg.d \
./src/lib/base/baseClasses.d \
./src/lib/base/ffmpegUtil.d 


# Each subdirectory must supply rules for building sources it contributes
src/lib/base/%.o: ../src/lib/base/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	g++ -std=c++0x -I"/home/victor/git/MOVSEA2/src" -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


