################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../src/RequestHandler.cpp \
../src/main.cpp \
../src/mainPipeline.cpp 

OBJS += \
./src/RequestHandler.o \
./src/main.o \
./src/mainPipeline.o 

CPP_DEPS += \
./src/RequestHandler.d \
./src/main.d \
./src/mainPipeline.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	g++ -std=c++0x -I"/home/victor/git/MOVSEA2/src" -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


