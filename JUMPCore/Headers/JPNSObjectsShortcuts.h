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
 * \file JPNSObjectsShortcuts.h
 * \nosubgrouping 
 * Collection of convenient Macro-Functions that are shortcut to <b>NSObjects</b> initiators.
 */

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ///
/** @name Retained initiators.
 */
///@{ 

/**
 * Shortcut to initiate an retained NSNumber.
 * @param __anValue__ an <b>int</b> number
 * @return An retained NSNumber object.
 */
#define NSInt( __anValue__ ) (  [[NSNumber alloc] initWithInt:__anValue__ ]  )

/**
 * Shortcut to initiate an retained NSDouble.
 * @param __anValue__ an <b>double</b> number
 * @return An retained NSDouble object.
 */
#define NSDouble( __anValue__ ) (  [[NSNumber alloc] initWithDouble:__anValue__ ]  )

/**
 * Shortcut to initiate an retained NSDecimal.
 * @param __anValue__ an <b>float</b> number
 * @return An retained NSDecimal object.
 */
#define NSDecimal( __anValue__ ) ( [[NSDecimalNumber alloc] initWithFloat:__anValue__] )

/**
 * Shortcut to initiate an retained NSNumber.
 * @param __anValue__ an <b>float</b> number
 * @return An retained NSNumber object.
 */
#define NSFloat( __anValue__ ) ( [[NSNumber alloc] initWithFloat:__anValue__ ] )

/**
 * Shortcut to initiate an retained NSNumber boolean representation.
 * @param __anValue__ an <b>BOOL</b> value.
 * @return An retained NSNumber object.
 */
#define NSBOOL( __anValue__ ) ( [[NSNumber alloc] initWithBool:__anValue__ ]  )

///@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ////
/** @name Auto releseable initiators.
 */
///@{ 

/**
 * Shortcut to initiate an autoreleseable NSNumber.
 * @param __anValue__ an <b>int</b> number
 * @return An retained NSNumber object.
 */
#define NSAInt( __anValue__ ) [NSInt( __anValue__ ) autorelease]

/**
 * Shortcut to initiate an autoreleseable NSDouble.
 * @param __anValue__ an <b>double</b> number
 * @return An retained NSDouble object.
 */
#define NSADouble( __anValue__ ) [NSDouble( __anValue__ ) autorelease]

/**
 * Shortcut to initiate an autoreleseable NSDecimal.
 * @param __anValue__ an <b>float</b> number
 * @return An retained NSDecimal object.
 */
#define NSADecimal( __anValue__ ) [NSDecimal( __anValue__ ) autorelease]

/**
 * Shortcut to initiate an autoreleseable NSNumber.
 * @param __anValue__ an <b>float</b> number
 * @return An retained NSNumber object.
 */
#define NSAFloat( __anValue__ ) [NSFloat( __anValue__ ) autorelease]

/**
 * Shortcut to initiate an autoreleseable NSNumber boolean representation.
 * @param __anValue__ an <b>BOOL</b> value.
 * @return An retained NSNumber object.
 */
#define NSABOOL( __anValue__ ) [NSBOOL( __anValue__ ) autorelease]

///@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// ////


/**
 * Shortcut to safely release an object. This macro function send an <b>release</b> 
 * message to the object and then nullify him. This is a safe technique because when we release an
 * Objective-C object and then call him you have an exception.
 */
#define NSReleaseSafely(__POINTER) { [__POINTER release]; __POINTER = nil; }  
