<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE function PUBLIC "-//XINS//DTD Function 2.2//EN" "http://www.xins.org/dtd/function_2_2.dtd">

<function name="assignGender"
rcsversion="$Revision$" rcsdate="$Date$">

	<description>The simplest variant of the api: single name -> single gender tag</description>

	<input>
		<param name="inputName" required="true" type="_text">
			<description>Input example</description>
		</param>
		<param name="languageTag" required="true" type="_text">
			<description>Input example</description>
		</param>
	</input>
	<output>
		<param name="gender" required="true" type="_text">
			<description>Output gender</description>
		</param>
	</output>
</function>
