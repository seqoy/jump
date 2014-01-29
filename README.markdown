JUMP Framework
==============

JUMP Framework is a collection of classes in Objective-C to perform a series of tasks on iOS or
Mac OS applications. From Network libraries until User Interface libraries. The framework have
classes to accomplish day by day tasks until very complex applications.  

Modules
-------

JUMP Framework is divided on different _weakly coupled_ modules. You can import all modules or only
the modules that you want to use on your project. See [JUMP Framework Start Guide](http://seqoy.github.com/jump) to 
learn more about it.

JUMP Network Module and AFNetworking
------------------------------------
The JUMP Network Module was updated to start to use [AFNetworking](http://afnetworking.com/) instead of [ASIHTTPRequest](http://allseeing-i.com/ASIHTTPRequest/). This update introduce ARC to this module, modern Objective-C code and a more robust
HTTP Request engine.

However, when you update this you should change some minor tricks to your project:
	- You must import the Pods.xcodeproj into your main project. It is located at JUMP/JUMPNetwork/Pods.
	- If you use JUMP_Reachability, you must use Reachability from AFNetworking.
	- If you use any ASIHTTPRequest error constants. You need to update to NSURLErrorDomain error constants.
	
Yes, a little effort. But I'm sure that worths the deal.


Documentation
-------------

JUMP Framework Modules documentation is generated from code using [Doxygen](http://www.stack.nl/~dimitri/doxygen/). 
Access [seqoy.github.com/jump](http://seqoy.github.com/jump) to learn more about it, many **Programming Guides** and **Code Snippets** for the different modules are
provided to help you understand and start to use right away.

