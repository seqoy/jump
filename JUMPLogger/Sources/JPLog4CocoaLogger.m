/*
 * Copyright (c) 2011 - SEQOY.org and Paulo Oliveira ( http://www.seqoy.org )
 *
 * Licensed under the Apache License, Version 2.0 (the "License") {  };
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
#import "JPLog4CocoaLogger.h"

@implementation JPLog4CocoaLogger

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
+(void)setLevel:(JPLoggerLevels)desiredLevel {
	// Level.
	L4Level *anLevel;
	
	switch (desiredLevel) {
		case JPLoggerAllLevel:
			anLevel = [L4Level all];
			break;
		case JPLoggerInfoLevel:
			anLevel = [L4Level info];
			break;
		case JPLoggerDebugLevel:
			anLevel = [L4Level debug];
			break;
		case JPLoggerWarnLevel:
			anLevel = [L4Level warn];
			break;
		case JPLoggerErrorLevel:
			anLevel = [L4Level error];
			break;
		case JPLoggerFatalLevel:
			anLevel = [L4Level fatal];
			break;
		default:
			anLevel = [L4Level off];
			break;
	}
	
	[[L4Logger rootLogger] setLevel:anLevel];
}
-(void)setLevel:(JPLoggerLevels)anLevel {
	[JPLog4CocoaLogger setLevel:anLevel];
}

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
+(JPLoggerLevels)currentLevel {
	// Current level.
	L4Level *anLevel = [[L4Logger rootLogger] level];
	
	// Convert.
	if      ( anLevel == [L4Level all] ) return JPLoggerAllLevel;
	else if ( anLevel == [L4Level info] ) return JPLoggerInfoLevel;
	else if ( anLevel == [L4Level debug] ) return JPLoggerDebugLevel;
	else if ( anLevel == [L4Level warn] ) return JPLoggerWarnLevel;
	else if ( anLevel == [L4Level error] ) return JPLoggerErrorLevel;
	else if ( anLevel == [L4Level fatal] ) return JPLoggerFatalLevel;
	else if ( anLevel == [L4Level off] ) return JPLoggerOffLevel;
	
	// Nothing, return off.
	return JPLoggerOffLevel;
}
-(JPLoggerLevels)currentLevel {
	return [JPLog4CocoaLogger currentLevel];
}

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
+(void)debug:(id)variableList, ... { 
    // Simply redirect parameters.
    va_list args;
    log4Debug( variableList, args );
};

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
+(void)info:(id)variableList, ...  { 
    // Simply redirect parameters.
    va_list args;
    log4Info( variableList, args );
}; 

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
+(void)warn:(id)variableList, ...  { 
    // Simply redirect parameters.
    va_list args;
    log4Warn( variableList, args );
}; 

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
+(void)error:(id)variableList, ...  { 
    // Simply redirect parameters.
    va_list args;
    log4Error( variableList, args );
}; 

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
+(void)fatal:(id)variableList, ...  {  
    // Simply redirect parameters.
    va_list args;
    log4Fatal( variableList, args );
};

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
+(void)debugWithException:(NSException*)anException andMessage:(id)variableList, ...   { 
    // Simply redirect parameters.
    va_list args;
    log4DebugWithException( variableList, anException, args );
};

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
+(void)infoWithException:(NSException*)anException andMessage:(id)variableList, ...   { 
    // Simply redirect parameters.
    va_list args;
    log4InfoWithException( variableList, anException, args );
};

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
+(void)warnWithException:(NSException*)anException andMessage:(id)variableList, ...   {  
    // Simply redirect parameters.
    va_list args;
    log4WarnWithException( variableList, anException, args );
};

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
+(void)errorWithException:(NSException*)anException andMessage:(id)variableList, ...   {  
    // Simply redirect parameters.
    va_list args;
    log4ErrorWithException( variableList, anException, args );
};

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
+(void)fatalWithException:(NSException*)anException andMessage:(id)variableList, ...   {  
    // Simply redirect parameters.
    va_list args;
    log4FatalWithException( variableList, anException, args );
};


@end
