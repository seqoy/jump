#!/bin/bash
#
# Automatically Link Header Files
#

# if Headers Directory doesn't exist...
if [ ! -d "Headers" ]; then
    echo "Creating Main Headers Directory..."
	mkdir Headers
fi

echo "Acessing Main Headers Directory..."
cd Headers

######## ######## ######## ######## ######## ######## ########  
# if JUMPCore Directory exist...
if [ -d "../JUMPCore/Headers" ]; then
	echo "Linking JUMPCore Headers..."
	ln -s ../JUMPCore/Headers/* .
fi

######## ######## ######## ######## ######## ######## ########  
# if JUMPCore Directory exist...
if [ -d "../JUMPData/Headers" ]; then
	echo "Linking JUMPData Headers..."
	ln -s ../JUMPData/Headers/* .
fi

######## ######## ######## ######## ######## ######## ########  
# if JUMPCore Directory exist...
if [ -d "../JUMPDatabase/Headers" ]; then
	echo "Linking JUMPDatabase Headers..."
	ln -s ../JUMPDatabase/Headers/* .
fi

######## ######## ######## ######## ######## ######## ########  
# if JUMPCore Directory exist...
if [ -d "../JUMPNetwork/Headers" ]; then
	echo "Linking JUMPNetwork Headers..."
	ln -s ../JUMPNetwork/Headers/* .
fi

######## ######## ######## ######## ######## ######## ########  
# if JUMPCore Directory exist...
if [ -d "../JUMPUserInterface/Headers" ]; then
	echo "Linking JUMPUserInterface Headers..."
	ln -s ../JUMPUserInterface/Headers/* .
fi

######## ######## ######## ######## ######## ######## ########  
# if JUMPCore Directory exist...
if [ -d "../JUMPLogger/Headers" ]; then
	echo "Linking JUMPLogger Headers (Includes Log4CocoaTouch and NSLogger..."
	ln -s ../JUMPLogger/Headers/* .
	ln -s ../JUMPLogger/Libraries/Log4CocoaTouch/Headers/* .
	ln -s ../JUMPLogger/Libraries/NSLogger/Headers/* .
fi