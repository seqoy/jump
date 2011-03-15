/*
	JPSynthetizeSingleton.h

	SynthesizeSingleton
	CocoaWithLove - http://cocoawithlove.com/

	Created by Matt Gallagher on 20/10/08.
	Copyright 2009 Matt Gallagher. All rights reserved.

	Permission is given to use this source code file without charge in any
	project, commercial or otherwise, entirely at your risk, with the condition
	that any redistribution (in part or whole) of source code must retain
	this copyright and permission notice. Attribution in compiled projects is
	appreciated but not required.
*/

/**
 * \file JPSynthetizeSingleton.h
 * \brief Automatically synthetize all needed methods to implement the Singleton Pattern on some class.
 * \author Matt Gallagher . CocoaWithLove - http://cocoawithlove.com/ | 
 * \copyright Copyright 2009 Matt Gallagher. All rights reserved. 
 */

/** 
 * \def JPSynthetizeSingleton( classname )
 * Automatically synthetize all needed methods to implement the Singleton Pattern on some class.
 * @param classname The class name to sythetize.
 */
#define JPSynthetizeSingleton( classname ) \
\
static classname *sharedInstance = nil; \
\
+ (classname *)sharedInstance \
{ \
@synchronized(self) \
{ \
if (sharedInstance == nil) \
{ \
sharedInstance = [[self alloc] init]; \
} \
} \
\
return sharedInstance; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (sharedInstance == nil) \
{ \
sharedInstance = [super allocWithZone:zone]; \
return sharedInstance; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
} \
\
- (id)retain \
{ \
return self; \
} \
\
- (NSUInteger)retainCount \
{ \
return NSUIntegerMax; \
} \
\
- (void)release \
{ \
} \
\
- (id)autorelease \
{ \
return self; \
}
