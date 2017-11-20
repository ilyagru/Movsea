################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../src/lib/LibraryManager.cpp \
../src/lib/macroses.cpp \
../src/lib/pathManager.cpp 

OBJS += \
./src/lib/LibraryManager.o \
./src/lib/macroses.o \
./src/lib/pathManager.o 

CPP_DEPS += \
./src/lib/LibraryManager.d \
./src/lib/macroses.d \
./src/lib/pathManager.d 


# Each subdirectory must supply rules for building sources it contributes
src/lib/%.o: ../src/lib/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	g++ -std=c++0x -I"/home/victor/git/MOVSEA2/src" -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


