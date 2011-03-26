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
 * \file JPLogger.h
 * JPLogger main header. You only need to import this header to implement JPLogger on your project.
 */
#import "JPLoggerShortcuts.h"
#import "JUMPLoggerConfig.h"

// Factories.
#import "JPLog4CocoaFactory.h"

/**
 * \mainpage JPLogger Module Programming Guide
 <b>JPLogger Module</b> isn't an Logger framework actualy. It only provide interfaces that you should to implement
 to use your favorite Logging Framework on top. It allows you to log all modules of JUMP Framework using your own
 logger or another third-part library. 
 <p>
 JUMP Logger comes with this great Logging Frameworks embedded: <a href="https://github.com/fpillet/NSLogger">Florent Pillet NSLogger</a>
 and <a href="http://code.google.com/p/cocoalumberjack/">Cocoa Lumberjack</a>. They are integrated and delivers an very powerfull set 
 of logging facilities. Of course, you can use this default logging or implement your own.
*/