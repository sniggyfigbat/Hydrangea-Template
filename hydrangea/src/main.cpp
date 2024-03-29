#include <string>
#include <iostream>
#include <chrono>

#include "extApi.c"
#include "extApiPlatform.c"

extern "C" {
#include "extApi.h"
}

int main(int argc, char *argv[]) {
	int portNb = 19999;

	/*if (argc >= 5)
	{
		portNb = atoi(argv[1]);
	}
	else
	{
		printf("Indicate following arguments: 'portNumber'!\n");
		extApi_sleepMs(5000);
		return 0;
	}*/

	int clientID = simxStart((simxChar*)"127.0.0.1", portNb, true, true, 2000, 5);
	std::cout << "Client ID: " << clientID << std::endl;

	int leftMotorHandle, rightMotorHandle;
	if (simxGetObjectHandle(clientID, "Pioneer_p3dx_rightMotor", &rightMotorHandle, simx_opmode_blocking) != 0) {
		std::cout << "Could not retreive handle of right motor." << std::endl;
		extApi_sleepMs(5000);
		return 0;
	}

	if (simxGetObjectHandle(clientID, "Pioneer_p3dx_leftMotor", &leftMotorHandle, simx_opmode_blocking) != 0) {
		std::cout << "Could not retreive handle of left motor." << std::endl;
		extApi_sleepMs(5000);
		return 0;
	}

	if (clientID != -1)
	{
		float motorSpeeds[2];
		//std::chrono::high_resolution_clock::time_point timeStart = std::chrono::high_resolution_clock::now();

		motorSpeeds[0] = 3.1415f;
		motorSpeeds[1] = 3.1415f / 2.0f;

		std::cout << "Starting donuts." << std::endl;
		simxSetJointTargetVelocity(clientID, leftMotorHandle, motorSpeeds[0], simx_opmode_oneshot);
		simxSetJointTargetVelocity(clientID, rightMotorHandle, motorSpeeds[1], simx_opmode_oneshot);

		extApi_sleepMs(5000);

		std::cout << "Stopping donuts." << std::endl;

		simxSetJointTargetVelocity(clientID, leftMotorHandle, 0.0f, simx_opmode_oneshot);
		simxSetJointTargetVelocity(clientID, rightMotorHandle, 0.0f, simx_opmode_oneshot);

		extApi_sleepMs(2000);
		simxFinish(clientID);
	}

	return(0);
}