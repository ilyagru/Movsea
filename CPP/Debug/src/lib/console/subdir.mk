################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../src/lib/console/Console.cpp \
../src/lib/console/ConsoleProtocols.cpp 

OBJS += \
./src/lib/console/Console.o \
./src/lib/console/ConsoleProtocols.o 

CPP_DEPS += \
./src/lib/console/Console.d \
./src/lib/console/ConsoleProtocols.d 


# Each subdirectory must supply rules for building sources it contributes
src/lib/console/%.o: ../src/lib/console/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	g++ -std=c++0x -I"/home/victor/git/MOVSEA2/src" -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


