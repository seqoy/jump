/*
 * Copyright (c) 2011 - SEQOY.org and Paulo Oliveira ( http://www.seqoy.org )
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/**
 * \mainpage JUMP Common Library
 <b>JUMP Common Library</b> is a collection of classes in Objective-C to perform a series of tasks 
 on iOS or Mac OS applications. From Network libraries until User Interface libraries. 
 The library have classes to accomplish day by day taks until very complex applications.
 <p>
 <h1>JUMP Common Library Modules</h1>
 <b>JUMP Common Library</b> is divided on different <i>weakly coupled</i> modules. You can import all 
 modules or only the modules that you want to use on your project.
 <p>
 These are the main Modules:
	- <a href="../../JUMPDatabase/html/index.html">Database Module</a>
	- <a href="../../JUMPNetwork/html/index.html">Network Module</a>
	- <a href="../../JUMPData/html/index.html">Data Module</a>
	- <a href="../../JUMPUserInterface/html/index.html">User Interface Module</a>
  
 <h3>Installing and Importing</h3>
 Check \ref installing and \ref importing_project to see how to install and use JUMP on your projects.
 <br>
 */

////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// //////
#pragma mark Installing JUMP

/*! \page installing Installing JUMP
 
 Install JUMP is very ease, let's see some tutorial steps to see how we do that.
 
 <h3>Clone the JUMP Library from GIT repository.</h3>
 
 One good idea is to maintain JUMP on a common folder, so if you have many projects that use this library
 you doesn't have to maintain one individual copy for each project.
 <p>
 So, here's how you clone the repository:
 \code
 git clone git@github.com:seqoy/jump.git
 \endcode
 
 <h3>Configuring</h3>
 
 The next time is to configure it. JUMP comes with a configure script, basically what it does is 
 create one 'Header' folder and <a href="http://en.wikipedia.org/wiki/Symbolic_link">create an symbolic link</a>
 of all JUMP headers inside of that. This is very useful and we'll se why later.
 
 To configure, execute this script inside the JUMP folder that you just cloned.
 \code
 ./JUMPConfig.sh -configure
 \endcode
 
 <i>Execute <tt>./JUMPConfig.sh</tt> without parameters to see all the options.</i>
 <p>
 That's it. Is installed, now see \ref importing_project.

 */


////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark Importing JUMP Library on your XCode project

/*! \page importing_project Importing JUMP Library on your XCode project
 
 <b>JUMP</b> is divided on several modules, so you doesn't have to import all modules at the same time, only
 those that you needed it. Also some modules already depends of each other, so sometimes when you import one
 module you're importing all the dependecies. 
 <p>
 Check \ref modules_dependecies first, so you'll known what 
 you're importing and don't import the same module twice.
 
 <h3>Let's see how to import the <b>JUMP Logger</b> module:</h3>
 
 - Open your XCode project, is a good practice to create an <tt>Dependecies</tt> folder inside the project.
 
 - Now go to the <tt>JUMP/JUMPLogger</tt> folder, locate the <tt>JUMPLogger.xcodeproj</tt> file and drag this
 file inside your XCode project.

 \image html importing_1.jpg
 
 - Select the project you just imported. On XCode Main Menu select <i> View > Zoom Editor Out</i>. Now check the <i>
 Target Icon Checkbox</i> next to the <tt>libJUMPDatabase.a</tt>. This will automatically associate the library 
 to your <b>Target</b> under the <b>Link Binary With Libraries</b> section.
 
 \image html importing_2.jpg
 
 The next step is to inform the XCode where to find the library <b>Headers</b>. If you remeber, 
 when we \link installing configure\endlink the library one <tt>Headers</tt> folder was created. 
 There is where the XCode will look for all <b>JUMP Headers</b>, let's do this:
 
 - Open your <b>XCode Target Info</b> and go to the <b>Build</b> tab.
 
 \image html importing_3.jpg
 
 - Under the <b>Build</b> tab look for the <b>Header Search Pahts</b> section. Double-click and 
 create a new entry. Now paste the <tt>JUMP/Headers</tt> <b>full</b> path there.
 
 \image html importing_4.jpg
 
 - Also in the <b>Build</b> tab look for the <b>Other Linker Flags</b> section. Set the <tt><b>-all_load</b></tt>
 flag if isn't already setted.
 
  \image html importing_5.jpg
 
 - Now under the <b>General</b> tab we need to create a new <b>Direct Dependency</b> for our library. 
 Click on the <b>+</b> button and select the JUMPLogger that have the <i>Static Library Icon</i>.
 Add to the target.
 
 \image html importing_6.jpg
 <br> 
 <br> 
 That's it, try to compile your project and everything should work fine. You can repeat this steps for 
 every JUMP Module that you need to use on your project.
 */


////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark JUMP Module Dependecies

/*! \page modules_dependecies JUMP Module Dependecies
 
 */




