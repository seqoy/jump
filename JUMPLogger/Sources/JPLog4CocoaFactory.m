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
#import "JPLog4CocoaFactory.h"

////////// ////////// ////////// ////////// 
@implementation JPLog4CocoaFactory 

// Static Logger Class.
static BOOL configured;

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
// Default configuration for the logger.
+(BOOL)configureLogger {
	// If no Class defined, assume default.
	if ( [self loggerClass] == nil ) 
		 [self setLoggerClass:[JPLog4CocoaLogger class]];

	// If already configured, doesn't configure again.
	if ( configured )
		return YES;
	
	// Try to configure from file first.
    BOOL success = [self configureWithFile:@"JPLogger.properties"];
    
    // If can't, configure locally, using Default values.
    if ( !success) {
		[[L4Logger rootLogger] setLevel:[L4Level debug]];
		[[L4Logger rootLogger] addAppender:[[L4ConsoleAppender alloc] initTarget:YES
																	  withLayout:[L4Layout simpleLayout]]];
	}
    
	// Set as configured.
	configured = YES;
	
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

