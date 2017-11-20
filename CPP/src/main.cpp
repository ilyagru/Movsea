#define USE_CUSTOM_DEBUG

#include "RequestHandler.hpp"

int main(int argc, char** argv)
{
	MyServerApp app;
	return app.run(argc, argv);
}
