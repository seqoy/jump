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
#import "JPLog4JLogger.h"

@implementation JPLog4JLogger

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
