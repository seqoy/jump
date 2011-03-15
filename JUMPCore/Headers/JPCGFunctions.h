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
#import <Foundation/Foundation.h>

/**
 * \file JPCGFunctions.h 
 * Utility functions to process Core Graphics components.
 */

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Rectangle Functions. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 

/**
 * \def CGRectMove( rectangle, horizontal, vertical )
 * Move an <b>CGRect</b> rectangle specified pixels on some direction.
 * @param rectangle An CGRect to perform the operation.
 * @param horizontal An Float value to move horizontally. 
 * @param vertical An Float value to move vertically.
 */
#define CGRectMove( rectangle, horizontal, vertical )\
\
\CGRectMake( rectangle.origin.x + horizontal, rectangle.origin.y + vertical, rectangle.size.width + horizontal, rectangle.size.height + vertical )
