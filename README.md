![Movsea: recognizing movies](https://raw.githubusercontent.com/ilyagru/Movsea/master/Movsea.png)

![languages](https://img.shields.io/badge/languages-4-green.svg)
![server platform](https://img.shields.io/badge/server%20platform-windows%20%7C%20linux-lightgrey.svg)
![client platform](https://img.shields.io/badge/client%20platform-ios-lightgrey.svg)
![test coverage](https://img.shields.io/badge/test%20coverage-no%20tests-red.svg)
[![MIT license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/ilyagru/Movsea/blob/master/LICENSE)

# Movsea – Project for Recognizing Movies by Video [![Tweet](https://img.shields.io/twitter/url/http/shields.io.svg?style=social)](https://twitter.com/intent/tweet?text=Project%20for%20recognizing%20movies%20by%20video&url=https://github.com/ilyagru/Movsea&hashtags=recognition,movies,computervision,developers)

- [Description](#description)
	- [Process](#process)
- [Features](#features)
- [Component Libraries](#component-libraries)
- [Requirements](#requirements)
- [Communication](#communication)
- [Installation](#installation)
	- [Installation of Delphi version](#clean-installation-of-delphi-version)
	- [Clean installation of C++ version](#clean-installation-of-cpp-version)
	- [Building iOS app](#building-ios-app)
- [Usage](#usage)
	- [Usage of Delphi version](#usage-of-delphi-version)
	- [Usage of C++ version](#usage-of-cpp-version)
- [Important Notes](#important-notes)
- [FAQ](#faq)
- [Credits](#credits)
- [Donations](#donations)
- [License](#license)



## Description
The main function of the project is to recognize to which of the videos loaded into the database most likely this segment corresponds to by recording a short segment of the video (about 10 seconds).

![The main idea](https://raw.githubusercontent.com/ilyagru/Movsea/master/Movsea.gif)

### Process

- Receive video from the app on your phone or another device
- Collect video parameters (brightness, blur, etc.)
- Attempt to improve its quality on the basis of parameters (clarification, stabilization, binarization, noise reduction, etc.)
- Split video into keyframes
- Analysis of frames and forming a set of "significant points"
- Comparison of significant points and their relative locations (2 methods, long and fast but requiring a lot of memory)
- Based on frames that are similar in the desired and compared segment and their locations (a series of similar frames), the similarity of the compared video and the desired is calculated
- Send evaluation result back



## Features

- [x] Interact with mobile devices
- [x] Functions for improving video quality
- [x] Video comparison based on frame data
- [x] Ability to work in multiple threads (Delphi version)
- [x] Ability to work on Linux and Windows (C++ version, requires a different setup of POCO)



## Component Libraries

С++ version was written with the [Eclipse IDE](https://www.eclipse.org/)

The following libraries were used:

### Delphi

- [Indy (Internet Direct)](http://www.indyproject.org/index.en.aspx) - for working with the Internet (receiving recognition tasks)

### C++

- [POCO](https://pocoproject.org) - for working with the Internet

Both versions use [ffmpeg](https://www.ffmpeg.org) for video processing (for working requires only ffmpeg.exe)



## Requirements

- Windows 7+ (Delphi)
- Ubuntu, Linux Mint (С++)
- Exlipse IDE (Neon+)
- С++ 11
- Delphi IDE
- INDY 9+
- POCO
- ffmpeg
- Xcode 9+
- Swift 4
- iOS 9+



## Communication

- If you **need help**, open an issue.
- If you'd like to **ask a general question**, open an issue.
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.



## Installation

### Clean installation of Delphi version

1) Install the IDE
2) Install Indy (often shipped with the IDE)
	- Download [sources](http://www.indyproject.org/Sockets/Download/Files/Indy10.EN.aspx) from the official website (10 version)
	- Unarchive and move all files to a directory convenient for you
	- Specify the paths to the sources in the IDE (In the project settings)
	- Compile INDY packages (you can use this [article](http://www.ehome96.ru/index.php?option=com_content&view=article&id=16:ustanovka-indy-10-v-delphi&catid=13&Itemid=107) [RU] - example for Delphi 7, but it comes with packages for several versions of the Delphi. The correct one should be chosen based on your version.)
5) Install ffmpeg
	- Download archive from [ffmpeg](http://ffmpeg.zeranoe.com/builds/)
	- Unarchive and put the file `ffmpeg.exe` (located in the bin folder) in the project folder (by default in the Data folder)
6) Change the connection settings you need
7) Change the path to the folder with the data and with ffmpeg

### Clean installation of CPP version

1) Install Eclipse (tested on the NEON version)
	- Install dialect C++ 11 (С ++ Compiler Options -> Dialects)
2) Install POCO
	- Download sources from the [official website](https://pocoproject.org/download/)
	- Compile the library following [the instructions](https://pocoproject.org/docs/00200-GettingStarted.html)
	- Specify the paths to the sources in the IDE in the compiler settings
	- Specify the paths for the linker to the folders with the libraries and the libraries themselves (for example, `-lPocoFoundation` `-lPocoNet` `-lPocoNetSSL` `-lPocoUtil` `-lPocoXML`)

		Linux example:
		- Download archive with POCO [source code](https://pocoproject.org/download/)
		- Run in the console
		(example for v1.8.1, instead of `make` it is possible to use `gmake` depending on the installed one on your system)
			```shell
			gunzip poco-1.8.0.1.tar.gz
			tar -xf poco-1.8.0.1.tar
			cd poco-1.8.0.1
			./configure
			make -s
			sudo make -s install
			```
		- Write in Eclipse in the project settings the necessary libraries (Linker options) (required: `PocoFoundation`, `PocoNet`, `PocoUtil`)
		- Rebuild the index if the IDE did not do it automatically
3) Install ffmpeg
	- Windows
		- Download archive from [ffmpeg](http://ffmpeg.zeranoe.com/builds/)
		- Unarchive and put the file `ffmpeg.exe` (in the bin folder) in the project folder
	- Linux
		- install ffmpeg using the terminal and the installed package manager (e.g. `sudo apt-get ffmpeg`)
4) Change the connection settings you need in the code
5) The path to ffmpegg can be written in the file `ffmpegUtil.cpp` (except for Windows)

### Building iOS app

1) `cd IOS-APP`
2) run `pod install`
3) To launch on a real device you need to sign the app in the Signing settings in Xcode (You need to have access to a camera)
4) To be able to send a video and receive a result change `Server URL` in iPhone settings in Movsea to your network URL. Port 8080 is used by default.

For local testing of sending a video and getting a result:
1) Run `python python/server.py`
2) In iPhone settings in Movsea change `Server URL` to your network URL.



## Usage

### Usage of Delphi version

#### Start

- Launch a project build
- In the `Library` tab, specify the path to the folder with the library (`Library File Path`)
- Click `Load Index` (a list of hashes is formed)
- Select the required with the help of checkmarks (in the lines of relative paths)
- Click `Load Hashs` (loading **hashes** into memory and preparing for comparison)
- On the `Serv` tab, click `Start listen` (the port listening will start)
- On the same tab the text field will display logs about what the server is doing

#### Creating and editing a library:

Library files
- `Jsons` - stores the description of the segments that will be sent to the requesting fragment search
- `LibraryIndex` - stores a list of paths to folders with hashes
- `MovXX/Hash.txt` - stores the **hash** of the file for comparison

To create from the interface
- In the `Library` tab in `VideoSource`, write the path to the video file
- Specify the folder for temporary storage of frames
(Frames can be changed and added to this folder. You can use frames obtained by another way or cut unnecessary
or combine multiple sets)
- Write into the last text field where the result will be written (analogue `movXX/Hash.txt`)
- In the combo box you can specify a filter (not always works)
- In a multi-line text field on the right the technical information will be displayed

### Usage of CPP version

In the C++ version there is no visual interface. All actions are performed via web requests (for example, using a browser). To test all the functionality you need a program that allows you to do POST requests with data, (e.g. [Postman](getpostman.com)). Next, all paths are described relatively to the address of the computer with the application running (e.g. `127.0.0.1/console` will be written simply `/console`).

All the protocols (commands) are in the `Console` and `Protocols` folders.

The main entry point to the application logic is `RequesHandler.cpp/hpp`

To start the program, you must build and run it.

#### Start

- Send a GET request to `/console--OpenIndexFile:<path_to_file_with_index_of_segments>`
- In contrast to the Delphi version, the download of the **hashes** will happen immediately
- As a response there will be a message that the file is downloaded
- Send POST request in the data of which there is only 1 video file for checking on `/`

#### Creating and editing a library:

- Send a GET request to `/console--OpenIndexFile:<path_to_file_with_index_of_segments>`
- ... to `/console--HashNSaveHash:<path_to_video>||<path_to_file_to_save_cache_file>`
- ... to `/console--AddFileToIndex:<path_to_file_where_hash_was_saved>`
- ... to `/console--SaveIndexFile:<path_to_file_where_to_save_new_index>`



## Important Notes

- **The project is not actively maintained.**
- **The project is not ready for production.**



## FAQ

### Why multiple languages?

We initially did not take into account the amount of necessary resources for this task. Because of this, the most optimal language was chosen according to the speed of development and the simplicity of writing algorithms (Python). But just as soon as we moved to the processing of the arrays of frames, the mistake became immediately clear. At that time, we needed a very stable development and the possibility of visual analysis of frames, so the choice fell on Delphi on which the most complete version of the program was created later. But because of problems with commercial use and the need for a multi-platform server part, in the end, the C++ language was chosen which met all the criteria except complexity.

### Which algorithms were used?

Initially, we looked at many algorithms, some of them use search engines and various programs. Many of them were invented in 90s. But all of them had the disadvantage that they were designed to search for fragments of one frame in another or to compare entirely. They are good for finding the same images in the base but in the realities of shooting from the phone were not strong enough. Therefore, we had to follow the path of writing our own algorithm which saw contrast points on the contour.

### What additional improvements may be taken and what mistakes can be avoided?

- Pick algorithms for improving image quality (We tried the matrix filtering)
- Image stabilization - when comparing frames from 2 arrays of images even small shifts of frames matter
- Do not pursue a higher resolution and the number of attributes - real problems are limited in resources
- Do not think like a human - your algorithm may seem logical but do not believe it, just test a few thousand frames and then draw conclusions (We had a separate tester program)
- Do not reject ideas - you can have 2 algorithms, the second one is 20% better than the first one but you will not improve the second one after a month of work for some reasons, and the first one probably when applying filters which you did not have at the time of testing will win the second one
- Immediately determine the final platform and users: a web service - immediately plan an external api and do not start making the interface of the application, which only you see as a result, apps for using within the same organization - on the contrary, make a good client app
- Do not be afraid of using third-party libraries - a lot of them invented a long time ago (We lost a lot without using the materials from the OpenCV or other libraries, for example)

---



## Credits

Movsea is created by the Movsea team: [**Ilya Gruzhevski**](mailto:ilya.gruzhevski@gmail.com) (CEO, Frontend, iOS), [**Pavel Piskunov**](mailto:pa.piskunov@gmail.com) (CTO, Backend), [**Alexander Horlach**](mailto:horlach.aliaksandr@gmail.com) (CFO, Legal). You can contact us directly.



## Donations

If you find Movsea useful to you do not be afraid of saying thank you and making some donations. For these questions please contact us.



## License

Movsea is released under the MIT license. [See LICENSE](https://github.com/ilyagru/Movsea/blob/master/LICENSE) for details.
