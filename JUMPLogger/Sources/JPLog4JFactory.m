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
#import "JPLog4JFactory.h"

////////// ////////// ////////// ////////// 
@implementation JPLog4JFactory 

// Static Logger Class.
static Class loggerClass;

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
+(void)setLoggerClass:(Class<JPLoggerInterface>)anLoggerClass {
    // Implicit Class.
    loggerClass = [JPLog4JLogger class];
}

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
+(Class)loggerClass {
    return loggerClass;
}

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
// Get an configured instance of the logger. 
+(id)getLogger {
	[self configureLogger];

    // Return it.
    return [L4Logger rootLogger];
}

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
// Default configuration for the logger.
+(BOOL)configureLogger {
	// Try to configure from file first.
    BOOL success = [self configureWithFile:@"JPLogger.properties"];
    
    // If can't, configure locally, using Default values.
    if ( !success) {
		[[L4Logger rootLogger] setLevel:[L4Level debug]];
		[[L4Logger rootLogger] addAppender:[[L4ConsoleAppender alloc] initTarget:YES
																	  withLayout:[L4Layout simpleLayout]]];
	}
    
    // Everything ok.
    return YES;
}

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
// If the Logging Framework that you're using support load configuration from a file. You should
+(BOOL)configureWithFile:(NSString*)anFileName {
	// Format file path.
	NSString *filename = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] bundlePath], anFileName];

	// If doesn't exist the file, return false.
	if ( ! [[NSFileManager defaultManager] fileExistsAtPath:filename] ) {
		return NO;
    }
	
	// If exist, configure with this file.
	L4PropertyConfigurator *configurator = [[L4PropertyConfigurator alloc] initWithFileName:filename];
	[configurator configure];
	
	// Everything ok.
    return YES;
}

@end

