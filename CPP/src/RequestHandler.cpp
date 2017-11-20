#include <iostream>
#include <fstream>
#include <string>

#include "PocoImport.hpp"
#include "RequestHandler.hpp"


#include "mainPipeline.hpp"
#include "taskManager.hpp"
#include "lib/protocols/Protocols.hpp"

using namespace Poco::Net;


//PROTOCOLS todo move to protocols files
mainPipelineProtocol pipelineProtocol;
ConsoleProtocol consoleProtocol;
//

class CMyRequestHandler : public HTTPRequestHandler
{
public:
	void handleRequest(HTTPServerRequest &req, HTTPServerResponse &resp)
	{
		std::string answer;

		// Check request
		URI uri(req.getURI());
		cout << "\n GET A NEW CONNECTION : ";
		cout << uri.toString();
		cout << "\n";

		if (uri.toString() == "/")
		{
			answer = pipelineProtocol.resolve(req);
		}

		if (uri.toString().find("/console") != std::string::npos)
		{
			answer = consoleProtocol.resolve(req, uri);
		}

		//Response
		resp.setStatus(HTTPResponse::HTTP_OK);
		resp.setContentType("text/html");
		ostream& out = resp.send();
		out << answer;//"{\"id\" : \"1\", \"title\" : \"Rom diary 1\", \"productionCountry\" : \"USA\", \"year\" : \"2016\", \"director\" : \"Some director\", \"stars\" : \"Some Stars\", \"description\" : \"Test description\", \"poster\" : \"https://www.stihi.ru/pics/2011/08/22/7332.jpg\", \"rating\" : 2.4, \"trailer\" : \"https://m.youtu.be/dQw4w9WgXcQ\", \"buyMovie\" : \"https://rutracker.org\" }";
		out.flush();

	}
};

class MyRequestHandlerFactory : public HTTPRequestHandlerFactory
{
public:
	virtual HTTPRequestHandler* createRequestHandler(const HTTPServerRequest &)
	{
		return new CMyRequestHandler;
	}
};


int MyServerApp::main(const vector<string> &)
{
	HTTPServer s(new MyRequestHandlerFactory, ServerSocket(8080), new HTTPServerParams);
	s.start();
	for(;;)
	{
		sleep(1);
	}
	s.stop();
	return Application::EXIT_OK;
}
