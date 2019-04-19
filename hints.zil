"HINTS for CHEAPO ZORK - (VIA SHERLOCK)
(c) Copyright 1987 Infocom, Inc. All Rights Reserved."

<FILE-FLAGS CLEAN-STACK?>

<GLOBAL HINT-WARNING <>>

<GLOBAL HINTS-OFF <>>

<ROUTINE V-HINT ("AUX" CHR MAXC (C <>) Q WHO)
	<COND (,HINTS-OFF
	       <TELL "Hints have been disabled for this session." CR>
	       <RFATAL>)
	      (<NOT ,HINT-WARNING>
	       <SETG HINT-WARNING T>
	       <TELL
"[Warning: It is recognized that the temptation for help may at times be so
exceedingly strong that you might fetch hints prematurely. Therefore, you may
at any time during the story type HINTS OFF, and this will disallow the
seeking out of help for the present session of the story. If you still want a
hint now, indicate HINT.]" CR>
	       <RFATAL>)>
	<SET MAXC <GET ,HINTS 0>>
	<INIT-HINT-SCREEN>
	<CURSET 5 1>
	<PUT-UP-CHAPTERS>
	<SETG CUR-POS <- ,CHAPT-NUM 1>> ;"ie, 0"
	;<SETG CHAPT-NUM 1>
	;<CURSET 5 2>
	<NEW-CURSOR>
	;<PRINTI ">">
	<REPEAT ()
		<SET CHR <INPUT 1>>
		<COND (<EQUAL? .CHR %<ASCII !\Q> %<ASCII !\q>>
		       <SET Q T>
		       <RETURN>)
		      (<EQUAL? .CHR %<ASCII !\N> %<ASCII !\n>>
		       <COND (<EQUAL? ,CHAPT-NUM .MAXC>
			      <ERASE-CURSOR>
			      <SETG CUR-POS 0>
			      <SETG CHAPT-NUM 1>
			      <NEW-CURSOR>
			      <SETG QUEST-NUM 1>)
			     (T   ;<NOT <EQUAL? ,CHAPT-NUM .MAXC>>
			      <ERASE-CURSOR>
			      <SETG CUR-POS <+ ,CUR-POS 1>>
			      <SETG CHAPT-NUM <+ ,CHAPT-NUM 1>>
			      <NEW-CURSOR>
			      <SETG QUEST-NUM 1>)>)
		      (<EQUAL? .CHR %<ASCII !\P> %<ASCII !\p>>
		       <COND (<EQUAL? ,CHAPT-NUM 1>
			      <ERASE-CURSOR>
			      <SETG CHAPT-NUM .MAXC>
			      <SETG CUR-POS <- ,CHAPT-NUM 1>>
			      <NEW-CURSOR>
			      <SETG QUEST-NUM 1>)
			     (T  ;<NOT <EQUAL? ,CHAPT-NUM 1>>
			      <ERASE-CURSOR>
			      <SETG CUR-POS <- ,CUR-POS 1>>
			      <SETG CHAPT-NUM <- ,CHAPT-NUM 1>>
			      <NEW-CURSOR>
			      <SETG QUEST-NUM 1>)>)
		      (<EQUAL? .CHR 13 10>
		       ;<PUTP ,SCENE ,P?SCENE-CUR ,CUR-POS>
		       <PICK-QUESTION>
		       <RETURN>)>>
	<COND (<NOT .Q>
	       <AGAIN>	;"AGAIN does whole routine?")>
	;<SETG CUR-POS 0>
	;<SETG CHAPT-NUM 1>
	;<PUTP ,SCENE ,P?SCENE-CUR ,CUR-POS>
	<SPLIT 0>
	<CLEAR -1>
	<INIT-STATUS-LINE>
	<RFATAL>>

<ROUTINE PICK-QUESTION ("AUX" CHR MAXQ (Q <>))
	<INIT-HINT-SCREEN <>>
	<LEFT-LINE 3 " RETURN = see hint" %<LENGTH " RETURN = see hint">>
	<RIGHT-LINE 3 "Q = main menu" %<LENGTH "Q = main menu">>
	<SET MAXQ <- <GET <GET ,HINTS ,CHAPT-NUM> 0> 1>>
	<CURSET 5 1>
	<PUT-UP-QUESTIONS>
	<SETG CUR-POS <- ,QUEST-NUM 1>>
	;<SETG QUEST-NUM 1>
	;<CURSET 5 2>
	<NEW-CURSOR>
	;<PRINTI ">">
	<REPEAT ()
		<SET CHR <INPUT 1>>
		<COND (<EQUAL? .CHR %<ASCII !\Q> %<ASCII !\q>>
		       <SET Q T>
		       <RETURN>)
		      (<EQUAL? .CHR %<ASCII !\N> %<ASCII !\n>>
		       <COND (<EQUAL? ,QUEST-NUM .MAXQ>
			      <ERASE-CURSOR>
			      <SETG CUR-POS 0>
			      <SETG QUEST-NUM 1>
			      <NEW-CURSOR>)
			     (T  ;<NOT <EQUAL? ,QUEST-NUM .MAXQ>>
			      <ERASE-CURSOR>
			      <SETG CUR-POS <+ ,CUR-POS 1>>
			      <SETG QUEST-NUM <+ ,QUEST-NUM 1>>
			      <NEW-CURSOR>)>)
		      (<EQUAL? .CHR %<ASCII !\P> %<ASCII !\p>>
		       <COND (<EQUAL? ,QUEST-NUM 1>
			      <ERASE-CURSOR>
			      <SETG QUEST-NUM .MAXQ>
			      <SETG CUR-POS <- ,QUEST-NUM 1>>
			      <NEW-CURSOR>)
			     (T
			      <ERASE-CURSOR>
			      <SETG CUR-POS <- ,CUR-POS 1>> 
			      <SETG QUEST-NUM <- ,QUEST-NUM 1>>
			      <NEW-CURSOR>)>)
		      (<EQUAL? .CHR 13 10>
		       <DISPLAY-HINT>
		       <RETURN>)>>
	<COND (<NOT .Q>
	       <AGAIN>)>>

;"zeroth (first) element is 5"
<GLOBAL LINE-TABLE
	<PTABLE
		5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21
		5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21>>

;"zeroth (first) element is 4"
<GLOBAL COLUMN-TABLE
	<PTABLE
		 4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4
		24 24 24 24 24 24 24 24 24 24 24 24 24 24 24 24 24>>

;"four and nineteen are where the text of questions start"

<GLOBAL CUR-POS 0>	;"determines where to place the highlight cursor
			  Can go up to 34, that is 17 slots in each row"

<GLOBAL QUEST-NUM 1> ;"shows in HINT-TBL ltable which QUESTION it's on"

<GLOBAL CHAPT-NUM 1>	;"shows in HINT-TBL ltable which CHAPTER it's on"

<ROUTINE ERASE-CURSOR ()
	<CURSET <GET ,LINE-TABLE ,CUR-POS>
		<- <GET ,COLUMN-TABLE ,CUR-POS> 2 ;1>>
	<TELL " ">	;"erase previous highlight cursor">

;"go back 2 spaces from question text, print cursor and flash is between
the cursor and text"

<ROUTINE NEW-CURSOR ()
	<CURSET <GET ,LINE-TABLE ,CUR-POS>
		<- <GET ,COLUMN-TABLE ,CUR-POS> 2 ;1>>
	<TELL ">">	;"print the new cursor">

<ROUTINE INVERSE-LINE ("AUX" (CENTER-HALF <>)) 
	<HLIGHT ,H-INVERSE>
	<PRINT-SPACES <LOWCORE SCRH>>
	<HLIGHT ,H-NORMAL>>

;"cnt (3) is where in table answers begin. (2) in table is # of hints-seen"
<ROUTINE DISPLAY-HINT ("AUX" H MX (CNT 3 ;2 ;,HINT-HINTS) CHR (FLG T) N)
	<SPLIT 0>
	<CLEAR -1>
	<SPLIT 3>
	<SCREEN ,S-WINDOW>
	<CURSET 1 1>
	<INVERSE-LINE>
	<CENTER-LINE 1 "INVISICLUES (tm)" %<LENGTH "INVISICLUES (tm)">>
	<CURSET 3 1>
	<INVERSE-LINE>
	;<COND (,WIDE
	       <TELL " ">)>
	<LEFT-LINE 3 "RETURN = see new hint">
	<RIGHT-LINE 3 "Q = see hint menu" %<LENGTH "Q = see hint menu">>
	<CURSET 2 1>
	<INVERSE-LINE>
	<HLIGHT ,H-BOLD>
	<SET H <GET <GET ,HINTS ,CHAPT-NUM> <+ ,QUEST-NUM 1>>>
	<CENTER-LINE 2 <GET .H 2 ;1 ;,HINT-QUESTION>>
	<HLIGHT ,H-NORMAL>
	<SET MX <GET .H 0>>
	;<CURSET 5 2>	;"instead of CRLF"
	<SCREEN ,S-TEXT>
	<CRLF>
	<REPEAT ()
		 <COND (<EQUAL? .CNT <GET .H 1 ;,HINT-SEEN>>
			<RETURN>)
		       (T
			<TELL <GET .H .CNT> CR CR>
			<SET CNT <+ .CNT 1>>)>>
	<REPEAT ()
		<COND (<AND .FLG <G? .CNT .MX>>
		       <SET FLG <>>
		       <TELL "[That's all.]" CR>)
		      (.FLG
		       <SET N <+ <- .MX .CNT> 1>> ;"added +1 - Jeff"
		       <TELL "[" N .N " hint">
		       <COND (<NOT <EQUAL? .N 1>>
			      <TELL "s">)>
		       <TELL " left.]" CR CR " -> ">
		       <SET FLG <>>)>
		<SET CHR <INPUT 1>>
		<COND (<EQUAL? .CHR %<ASCII !\Q> %<ASCII !\q>>
		       <PUT .H 1 ;,HINT-SEEN .CNT>
		       ;<SETG CUR-POS <GET ,SCENE ,P?SCENE-CUR>>
		       <RETURN>)
		      (<EQUAL? .CHR 13 10>
		       <COND (<NOT <G? .CNT .MX>>
			      <SET FLG T>	;".cnt starts as 3 ;2" 
			      <TELL <GET .H .CNT>>
			      <CRLF>
			      <CRLF>
			      <SET CNT <+ .CNT 1>>
			      ;<CURSET <+ <* .CNT 2> 1> 2>
			      ;"3rd = line 7, 4th = line 9, ect"
			      <COND (<G? .CNT .MX>
				     <SET FLG <>>
				     <TELL "[That's all.]" CR>
				     ;<CURSET <* .CNT 2> 1>)>)>)>>>

<ROUTINE PUT-UP-QUESTIONS ("AUX" (ST 1) MXQ MXL)
	<SET MXQ <- <GET <GET ,HINTS ,CHAPT-NUM> 0> 1>>
	<SET MXL <- <LOWCORE SCRV> 1>>
	<REPEAT ()
		<COND (<G? .ST .MXQ>
		       ;<TELL CR "[Last question]" CR>
		       <RETURN>)
		      (T                        ;"zeroth"
		       <CURSET <GET ,LINE-TABLE <- .ST 1>>
			       <- <GET ,COLUMN-TABLE <- .ST 1>> 1>>) 
		      ;(<G? .LN .MXL>
		       <TELL CR "[More questions follow]" CR>
		       <RETURN <- .ST 1>>)>
		<TELL " " <GET <GET <GET ,HINTS ,CHAPT-NUM> <+ .ST 1>> 2 ;1>>
		;<CRLF>	;"above curset will do the trick?"
		<SET ST <+ .ST 1>>>>

<ROUTINE PUT-UP-CHAPTERS ("AUX" (ST 1) MXC MXL)
	<SET MXC <GET ,HINTS 0>>
	<SET MXL <- <LOWCORE SCRV> 1>>
	<REPEAT ()
		<COND (<G? .ST .MXC>
		       ;<TELL CR "[Last chapter]" CR>
		       <RETURN>)
		      (T                        ;"zeroth"
		       <CURSET <GET ,LINE-TABLE <- .ST 1>>
			       <- <GET ,COLUMN-TABLE <- .ST 1>> 1>>) 
		      ;(<G? .LN .MXL>
		       <TELL CR "[More chapters follow]" CR>
		       <RETURN <- .ST 1>>)>
		<TELL " " <GET <GET ,HINTS .ST> 1 ;,HINT-QUEST>>
		;<CRLF>	;"above curset will do the trick?"
		<SET ST <+ .ST 1>>>>

;"longest hint topic can be 17 chars"
<GLOBAL HINTS
	<PLTABLE
	 <PLTABLE "Above Ground"
		  <LTABLE 3 "Where do I find a machete?"
			   "There is none. The game must have SOME limitations. You can't expect to walk to the nearest airport and fly to London to see the British Museum.">
		  <LTABLE 3 "How do I cross the mountains?"
			   "Play ZORK II.">
		  <LTABLE 3 "How do I kill the songbird?"
			   "What a concept! You need a psychiatrist.">
		  <LTABLE 3 "Is the nest useful for anything?"
			   "In China you might make bird's nest soup."
			   "This is not China."
			   "In other words, no.">
		  <LTABLE 3 "How do I safely open the egg?"
			   "You don't."
			   "Have you tried saying OPEN EGG?"
			   "It takes a great deal of manual dexterity and the
proper tools."
			   "Someone else in the game can do it."
			   "Only the Thief can open the egg. Give it to him or leave it underground where he will find it.">
		  <LTABLE 3 "How do I fix the broken canary?"
			   "It is broken beyond repair."
			   "No one can fix it. Really!">
		  <LTABLE 3 "Are the leaves useful for anything?"
			   "They're great for hiding gratings."
			   "They can be taken, counted, or burned.">
		  <LTABLE 3 "I'm lost in the Forest."
			   "There are actually just four different locations named \"Forest.\" But the connections between them are usually not straight lines. To add to the confusion, there are also two locations named \"Clearing.\""
			   "From \"Forest Path,\" you can go south to \"North of House\"">  
		  <LTABLE 3 "How do I open the grating?"
			   "You must unlock it."
			   "You need the skeleton key."
			   "It can be unlocked only from below."
			   "The grating and key can be found in the Maze.">
		  <LTABLE 3 "How do I get off the house's roof?"
			   "How did you get up there?"
			   "Someone from Infocom would love to hear how you did it."
"This is a actually a dummy question. Do not use
the presence or absence of a question on a certain
topic as an indication of what is important.">
		  <LTABLE 3 "Of what use is the canary?"
			   "It must be undamaged, of course."
			   "Something is attracted to its singing."
			   "It is also a treasure."
			   "Try winding it in the forest.">
		  <LTABLE 3 "How do I get the brass bauble?"
			   "You must open the egg first."
			   "See the previous question.">
		  <LTABLE 3 "How do I open the front door?"
			   "It cannot be knocked down."
			   "It cannot be destroyed."
			   "It cannot be opened.">
		  <LTABLE 3 "How do I get into the house?"
			   "Have you checked all sides?"
			   "There's a window in the back which is partly open."
			   "Open it and climb through.">
		  <LTABLE 3 "Can I eat the lunch?"
			   "Try it."
			   "Try the water, too."
			   "You can't be afraid to try anything in ZORK I (but it may make sense to SAVE your state first).">
		  <LTABLE 3 "How do I get into the dungeons?"
			   "The entrance is in the house."
			   "Trapdoors can be hidden."
			   "Move the rug.">
		  <LTABLE 3 "What is a grue?"
			   "Type, WHAT IS A GRUE.">>
	 <PLTABLE "The Cellar Area"
		  <LTABLE 3 "Can I open the trapdoor from below?"
			   "No. The only way to keep the trapdoor from closing behind you is to find another exit (other than the chimney, which is very limited).">
		  <LTABLE 3 "Can I get up the Cellar ramp?"
			   "The ramp is too slippery to climb."
			   "Is there a way to make it less slippery?"
			   "No. You won't ever get up the ramp.">
		  <LTABLE 3 "How do I negotiate with the Troll?"
			   "Trolls tend not to be conversational. They require a much more direct approach."
			   "You won't get past the Troll while he is conscious."
			   "Kill him with the sword.">
		  <LTABLE 3 "What do I do with the axe?"
			   "It can be used as a weapon, but isn't really necessary for anything."
			   "This space intentionally left blank.">
		  <LTABLE 3 "What's the studio paint all about?"
			   "The artist was sloppy.">>
	 <PLTABLE "The Maze"
		  <LTABLE 3 "How do I get through the Maze?"
			   "It is essential that you make a map of the Maze."
			   "All ten directions are used: N, S, E, W, NE, NW, SE, SW, UP and DOWN."
			   "Some passages lead back to the same room."
"Rooms can be marked by dropping objects. (However,
the Thief can be a pain.)" 
"There are 22 rooms west of the Troll Room.">
		  <LTABLE 3 "Still, how do I get through the Maze?"
			   "From the Troll Room to the Grating Room:"
			   "W. W. W. U. SW. U. D. NE."
			   "From the Grating Room to the Troll Room:"
			   "SW. D. E. N. D. N. N. N. E."
			   "From the Troll Room to the Cyclops Room:"
			   "W. W. W. U. SW. E. S. SE."
			   "From the Cyclops Room to the Troll Room:"
 			   "NW. S. W. D. N. N. N. E."
			   "From the Grating Room to the Cyclops Room:"
			   "SW. D. E. N. E. S. SE."
			   "From the Cyclops Room to the Grating Room:"
			   "NW. S. W. U. D. NE.">
		  <LTABLE 3 "What do I do with the rusty knife?"
			   "If you had your sword when you took it, the pulse of blinding light should have served as a warning."
			   "Try throwing the knife or attacking someone with it.">
		  <LTABLE 3 "What do I do with the skeleton?"
			   "Let the dead rest in peace."
			   "This space intentionally left blank.">
		  <LTABLE 3 "Can I use the broken lantern?"
"If you think it's useful, there's this bridge you
might be interested in.">
		  <LTABLE 3 "How do I get past the Cyclops?"
			   "Fighting isn't always the answer."
			   "There are two solutions."
			   "First, the first solution:"
"What happens if you hang around too long, or give something to the Cyclops?"
"He's hungry, isn't he?"
"Feed him the lunch and water."
"Now, the alternative solution:"
"Do you remember your mythology?"
"Take a very close look at the commandment in the black book."
"The Cyclops is scared silly of the name of his father's
nemesis, ODYSSEUS (first letter of each line in commandment -- some computer screens are narrow and make this more difficult to see)."
"The Latin version of the name, ULYSSES, is also accepted."
"For fun, try saying ODYSSEUS elsewhere.">>
	 <PLTABLE "The Round Room Area"
		  <LTABLE 3 "How do I get the platinum bar?"
			   "There are actually two solutions."
			   "What is causing the loud roar?"
			   "Is there a way to control the flow of water?"
			   "Solve the puzzle of the dam."
			   "Does opening or closing the dam gates affect anything downstream?"
			   "Open the dam gates."
			   "Wait until the reservoir is empty, then close the gates."
			   "Take advantage of the silence in the Loud Room while the reservoir fills."
			   "Here's the alternative solution:"
			   "This solution to the Loud Room requires no object or information from elsewhere in the game."
			   "The solution has something to do with the room's acoustics."
			   "What happens when you type something ... something
... something?"
			   "Type ECHO.">
		  <LTABLE 3 "How do I kill the rock?"
			   "How silly!"
			   "The term \"living rock\" is metaphorical, and should not be taken literally.">
		  <LTABLE 3 "Anything special about the mirror?"
			   "Breaking it is not a good idea."
			   "Looking into it can be fun."
			   "Did you ever try touching or rubbing it?"
 			   "There are two Mirror Rooms."
			   "Touching the mirror in one transports you to the other.">
		  <LTABLE 3 "How do I enter Hades?"
			   "You must exorcise the evil spirits."
			   "For a hint, turn the page in the black book."
			   "It requires the bell, book, and candles."
			   "Ring the bell, light the candles, and read the black book."
			   "The order in which you perform the ceremony is very important."
			   "Also, you must be holding the candles when you light them."
			   "Speed is of the essence, too -- don't waste any more time than is necessary between steps.">
		  <LTABLE 3 "Can I go down from the Dome Room?"
			   "Yes."
			   "It is likely that you have seen the necessary
equipment."
			   "It is found in the Attic."
			   "Tie the rope to the railing.">
		  <LTABLE 3 "Can I go up from the Torch Room?"
			   "No.">
		  <LTABLE 3 "How do I get out of the Temple area?"
			   "You'll never reach the rope."
			   "You can leave from the altar end by going down, but you \"haven't a prayer\" of getting the coffin down that hole."
			   "Or solve the puzzle of the granite walls."
			   "The altar has magical powers."
			   "What is usually done at altars?"
			   "Try praying.">>
	 <PLTABLE "The Dam Area"
		  <LTABLE 3 "How do I blow up the dam?"
			   "What a concept!"
			   "This space intentionally left blank.">
		  <LTABLE 3 "How is the control panel operated?"
			   "You can turn the bolt."
			   "You need the wrench."
			   "You must activate the panel. (Green bubble lights up).">
		  <LTABLE 3 "What is the green bubble for?"
			   "It indicates that the control panel is activated."
			   "Use the buttons in the Maintenance Room.">
		  <LTABLE 3 "What do I do with the tube?"
			   "Read the tube."
			   "Brushing your teeth with it is not sensible."
			   "It doesn't oil the bolt well."
			   "Gooey gunk like this is good for patching leaks in water pipes or boats.">
		  <LTABLE 3 "What is the screwdriver for?"
			   "You'll know when the time comes.">
		  <LTABLE 3 "What about Maintenance Room buttons?"
			   "Try them all. You should be able to find out."
			   "The blue button causes a water pipe to burst."
			   "The red button turns the lights on and off."
			   "The yellow button activates the control panel at the dam. (The green bubble is now glowing.)"
			   "The brown bubble deactivates the control panel.">
		  <LTABLE 3 "Can I stop the leak?"
			   "Yes, but not with your finger."
			   "Isn't there some sort of glop you could apply?"
			   "Use the gunk in the tube.">
		  <LTABLE 3 "What is the pile of plastic good for?"
			   "What is the valve for?"
			   "Did you try blowing into it?"
			   "You need the air pump, which is north of the Reservoir."
			   "Solve the dam problem, or figure out the mirror.">>
		  <PLTABLE "Old Man River"
			   <LTABLE 3 "Can the river be crossed?"
				    "Not without a boat.">
			   <LTABLE 3 "What will placate the River God?"
				    "What have you tried to throw into the river?"
				    "There is no River God. Anything thrown in is lost forever.">
			   <LTABLE 3 "Can I get back across the river?"
				    "If you launch the boat from Sandy Beach, you can cross the river to the west to White Cliffs South."
				   "It is also possible to cross the rainbow.">
			   <LTABLE 3 "How do I control the boat?"
				    "Read the label."
				    "You can say BOARD (or GET IN), DISEMBARK (or GET OUT), LAUNCH, and LAND (or a direction towards a landing area). You can also let the current carry you.">
			   <LTABLE 3 "I popped the boat!"
				    "Pointy objects can puncture a plastic boat. You should not carry them on. Put them in the boat before boarding or put them into a container, such as the brown sack, first.">
			   <LTABLE 3 "How do I go over the falls?"
				    "Just stay in the boat and wait."
				    "Well, what did you expect?"
				    "I see no intelligence here."
				    "By the way, have you ever taken a close look at the word ARAGAIN?">
			   <LTABLE 3 "Is the rainbow significant?"
				    "You can cross it and get the pot of gold."
				    "You do not click your heels together three times while saying \"There's no place like home.\""
				    "The description of one of the treasures, and the result of manipulating it properly were meant to be subtle hints."
				    "Raise or wave the sceptre while standing at the end of the rainbow.">
			   <LTABLE 3 "Can I go through the Damp Cave crack?"
				    "\"It's too narrow for most insects.\""
				    "You can't.">
			   <LTABLE 3 "How do I turn myself into an insect?"
				    "Build a cocoon?"
				    "Not bloody likely.">>
		  <PLTABLE "The Coal Mine Area"
			   <LTABLE 3 "What do I do about the bat?"
				    "It's a vampire bat."
				    "Have you never watched an old horror movie?"
				    "Use the garlic.">
			   <LTABLE 3 "How do I get by the Smelly Room?"
				    "If your lantern battery is dead, forget it.">
			   <LTABLE 3 "What's the best coal mine route?"
				    "From the Gas Room to Ladder Top:"
				    "E. NE. SE. SW. D."
				    "From Ladder Top to the Gas Room:"
				    "U. N. E. S. N.">
			   <LTABLE 3 "Is the basket on the chain useful?"
				    "Anything in ZORK I is useful.">
			   <LTABLE 3 "Can I get through the narrow passage?"
				    "\"You cannot fit through this passage with that load.\""
				    "Did you try dropping everything?">
			   <LTABLE 3 "Need a Drafty Room light source?"
				    "Matches."
				    "(Well, no one said they would work in a draft.) You can't carry a light source in. There is another way."
				    "Why might the room be drafty?"
				    "Did you ever wonder where the shaft with the basket led?"
				    "Objects, including light sources, can be placed in the basket. The basket can be lowered and raised.">
			   <LTABLE 3 "What is the timber for?"
				    "It makes the room more interesting and the adventurer more confused.">
			   <LTABLE 3 "How do I use the machine?"
				    "The switch description should remind you of something."
				    "Try putting something inside and turning the machine on with the screwdriver. Have a dictionary handy."
				    "You can make a diamond out of coal.">
			   <LTABLE 3 "What's the Granite Wall about?"
				    "Evidently the ancient Zorkers did not have strong truth-in-advertising laws. Take nothing for granite.">
			   <LTABLE 3 "Is the coal good for anything?"
				    "It is a source of carbon."
				    "One of the most valuable gems is made of carbon."
				    "Diamonds are pure carbon in a crystalline form. They are created under tremendous heat and pressure.">
			   <LTABLE 3 "Is the gas of any use?"
				    "It's great for blowing up dim-witted adventurers who wander into a coal mine with an open flame.">>
		  <PLTABLE "The Land Beyond the Chasm"
			   <LTABLE 3 "How do I cross the chasm?"
				    "There's no bridge.">
			   <LTABLE 3 "How do I build a bridge?"
				    "An interesting idea..."
				    "The timber might be useful."
				    "But then again, maybe not."
				    "A valiant attempt, but this is getting you nowhere.">>
		  <PLTABLE "General Questions"
			   <LTABLE 3 "Why does the sword glow?"
				    "Elvish swords are magical, and glow with a blue light when dangers (particularly dangerous beings) are near.">
			   <LTABLE 3 "What do I do about the Thief?"
				    "Discretion is the better part of valor."
				    "You can almost always avoid a confrontation by walking away. Although you may be robbed, at least you won't be killed.">
			   <LTABLE 3 "How may total points are there?"
				    "350. Any time you say QUIT, RESTART, or SCORE, this is pointed out.">
			   <LTABLE 3 "How do I get out of the dungeons?"
				    "There are six exits."
				    "The chimney will allow you to carry one object at a time in addition to your lamp."
				    "Once you find an exit other than the chimney, the trap door will not close behind you."
				    "Probably the easiest exit (conceptually) is by way of the grating. You will probably come across the other three exits while solving some of the harder problems, but it is not necessary to find more than one to complete the game.">
			   <LTABLE 3 "What do the engravings mean?"
				    "The knowledgeable critic, I.Q. Roundhead, wrote a ten-volume study of the engravings of the ancient Zorkers. To make a long story short, he concluded that the Zorkers were very strange people.">
			   <LTABLE 3 "How do I kill the Thief?"
				    "The Thief is a cunning and dangerous opponent, skilled in the martial arts. Novice Zorkers would do well to avoid him."
				    "It is possible to distract him for one move by giving him something of value."
				    "The nasty knife is a marginally more effective weapon to use against him."
				    "As you gain in points, you become a better match.">
			   <LTABLE 3 "How can I recharge my lamp?"
				    "What makes you think you can?"
				    "It is always best to conserve resources. You can prolong its life by turning it off whenever you can and using alternate light sources.">
			   <LTABLE 3 "What happens when you die?"
				    "You may appear in the forest with your belongings scattered (valuables below ground, nonvaluables above)."
				    "You may wander as a spirit until you find a way to resurrect yourself."
				    "ZORK I is as fair as baseball. Three strikes and you're out."
				    "You become a spirit if you have visited a certain location before death."
				    "The location is the altar in the South Temple."
				    "Try praying at the altar.">
			   <LTABLE 3 "Who is the \"Other Occupant\"?"
				    "\"He of the large bag.\""
				    "The Thief, of course.">
			   <LTABLE 3 "Where is HELLO SAILOR useful?"
				    "Are you sure you want to know?"
				    "Absolutely certain?"
				    "To quote the black book, Oh ye who go about saying unto each: 'Hello Sailor': Dost thou know the magnitude of thy sin before the gods? ... Surely thou shalt repent of thy cunning."
				    "Nowhere. (You were warned.)">>
		  <PLTABLE "More General Questions"
			   <LTABLE 3 "Objects seem to move or disappear."
				    "The Thief is constantly moving about."
				    "There is a high probability that he will take valuable objects (except the gold coffin) which you have seen. There is a much lower probability that he will take a nonvaluable object (again, only if you have seen it), and he may later decide to drop it.">
			   <LTABLE 3 "Where are my stolen treasures?"
				    "As the Thief wanders about stealing things, he puts them in his bag. Whenever he stops in his Treasure Room, he drops off the valuables he has collected."
				    "You can get the contents of the bag by defeating him in a fight."
				    "The Treasure Room is guarded by the Cyclops.">
			   <LTABLE 3 "What do I do with the stiletto?"
				    "Congratulations! Getting the stiletto is rare. If you keep it away from the Thief, he won't attack you."
				    "It is a weapon, nothing more.">
			   <LTABLE 3 "Who is the lean and hungry gentleman?"
				    "The Thief.">
			   <LTABLE 3 "Where can I use the shovel?"
				    "It will dig only into very soft soil."
				    "Try it in the sand."
				    "The sand in the Sandy Cave is most promising.">
			   <LTABLE 3 "What's with the granite walls?"
				    "There are only two true granite walls."
				    "While next to a real granite wall, you can transport yourself to the location of the other by saying the name of the room."
				    "The two granite walls are in the Temple and the Treasure Room.">
			   <LTABLE 3 "What's the best image-caster?"
				    "What are you talking about?"
				    "This space intentionally left blank.">
			   <LTABLE 3 "Can I get into the Strange Passage?"
				    "This is not necessary to complete the game."
				    "See the alternative Cyclops answer.">
			   <LTABLE 3 "How do I get into the Stone Barrow?"
				    "You'll know when the time comes."
				    "When you have all 350 points, you'll be able to enter the Barrow.">
			   <LTABLE 3 "How Points are Scored."
				    "(Use only as a last resort.)"
				    "You get 10 points for getting into the house, 25 for getting into the Cellar, 5 for getting past the Troll, 13 for getting to the Drafty Room, and 25 for getting to the Treasure Room."
				    "These points plus all the treasure points make 350. When you have all 350 points, the twentieth treasure will appear in the case -- a map which leads (indirectly) to 400 more points (ZORK II).">
			   <LTABLE 3 "Treasures: Their Values, Locations."
				    "(Use only as a last resort.)"
				    "(The treasure will be listed, followed by the points for taking it, the points for putting it in the trophy case, then the place it is found.)"
				    "jewel-encrusted egg - 5 - 5 - in nest in tree"
				    "clockwork canary - 6 - 4 - in the egg"
				    "beautiful painting - 4 - 6 - Gallery"
				    "platinum bar - 10 - 5 - Loud Room"
				    "ivory torch - 14 - 6 - Torch Room"
				    "gold coffin - 10 - 15 - Egypt Room"
				    "Egyptian sceptre - 4 - 6 - in the coffin"
				    "trunk of jewels - 15 - 5 - Reservoir"
				    "crystal trident - 4 - 11 - Atlantis Room"
				    "jade figurine - 5 - 5 - Bat Room"
				    "sapphire bracelet - 5 - 5 - Gas Room"
				    "huge diamond - 10 - 10 - you create it"
				    "bag of coins - 10 - 5 - in the Maze"
				    "crystal skull - 10 - 10 - Land of Living Dead"
				    "jeweled scarab - 5 - 5 - buried in Sandy Cave"
				    "large emerald - 5 - 10 - in the buoy"
				    "silver chalice - 10 - 5 - Treasure Room"
				    "pot of gold - 10 - 10 - End of Rainbow"
				    "brass bauble - 1 - 1 - the songbird has it">
			   <LTABLE 3 "For Your Amusement"
				    "(Read only after you've finished the game.)"
				    "Have you ever:"
				    "... opened the grating from beneath while the leaves were still on it?"
				    "... tried swearing at ZORK I?"
				    "... waved the sceptre while standing on the rainbow?"
				    "... tried anything nasty with the bodies in Hades?"
				    "... burned the black book?"
				    "... damaged the painting?"
				    "... lit the candles with the torch?"
				    "... read the matchbook?"
				    "... tried to take yourself (or the Thief, Troll or Cyclops)?"
				    "... tried cutting things with the knife or sword?"
				    "... poured water on something burning?"
				    "... said WAIT or SCORE while dead (as a spirit)?">
			   ;<LTABLE 3 "Words you have not have tried:
				    HELLO (to Troll, Thief, Cyclops)
 ZORK
 OIL (lubricate)
 XYZZY
 WALK AROUND (in forest, outside house, or inside house
 PLUGH
 FIND (especially with house, hands, teeth, me)
 CHOMP
 COUNT (candles, leaves, matches)
 WIN
 MUMBLE (or SIGH)
 LISTEN (especially to the Troll, Thief, or Cyclops)
 REPENT
 WHAT IS (grue, zorkmid,... )
 YELL (or SCREAM)
 SMELL">>>>

<ROUTINE INIT-HINT-SCREEN ("OPTIONAL" (THIRD T) "AUX" WID LEN)
	<SET WID <GETB 0 33>>
	<SPLIT 0>
	<CLEAR -1>
	<SPLIT <- <GETB 0 32> 1>>
	<SCREEN ,S-WINDOW>
	<CURSET 1 1>
	<INVERSE-LINE>
	<CURSET 2 1>
	<INVERSE-LINE>
	<CURSET 3 1>
	<INVERSE-LINE>
	<CENTER-LINE 1 "INVISICLUES (tm)" 16>
	<LEFT-LINE 2 " N = next">
	<RIGHT-LINE 2 "P = previous" %<LENGTH "P = previous">>
	<COND (<T? .THIRD>
	       <LEFT-LINE 3 " RETURN = See hint">
	       <RIGHT-LINE 3 "Q = Resume story" %<LENGTH "Q = Resume story">>)>>

;<CONSTANT HINT-COUNT 0>
;<CONSTANT HINT-QUESTION 1>
;<CONSTANT HINT-SEEN 2>
;<CONSTANT HINT-OFF 3>
;<CONSTANT HINT-HINTS 4>

;<DEFINE NEW-HINT (NAME Q "ARGS" HINTS)
	<SETG .NAME 1>
	<COND (<G? <LENGTH .Q> 39>
	       <ERROR QUESTION-TOO-LONG!-ERRORS NEW-HINT .Q>)>
	<LTABLE .Q
		4
		.NAME
		!.HINTS>>

;<GLOBAL HINT-FLAG-TBL
	<TABLE 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>>

<ROUTINE CENTER-LINE (LN STR "OPTIONAL" (LEN 0) (INV T))
	<COND (<ZERO? .LEN>
	       <DIROUT ,D-TABLE-ON ,DIROUT-TBL ;,SLINE>
	       <TELL .STR>
	       <DIROUT ,D-TABLE-OFF>
	       <SET LEN <GET ,DIROUT-TBL ;,SLINE 0>>)>
	<CURSET .LN <+ </ <- <LOWCORE SCRH> .LEN> 2> 1>>
	<COND (.INV
	       <HLIGHT ,H-INVERSE>)>
	<TELL .STR>
	<COND (.INV
	       <HLIGHT ,H-NORMAL>)>>

<ROUTINE LEFT-LINE (LN STR "OPTIONAL" (INV T))
	<CURSET .LN 1>
	<COND (.INV
	       <HLIGHT ,H-INVERSE>)>
	<TELL .STR>
	<COND (.INV
	       <HLIGHT ,H-NORMAL>)>>

<ROUTINE RIGHT-LINE (LN STR "OPTIONAL" (LEN 0) (INV T))
	<COND (<ZERO? .LEN>
	       <DIROUT 3 ,DIROUT-TBL ;,SLINE>
	       <TELL .STR>
	       <DIROUT -3>
	       <SET LEN <GET ,DIROUT-TBL ;,SLINE 0>>)>
	<CURSET .LN <- <LOWCORE SCRH> .LEN>>
	<COND (.INV
	       <HLIGHT ,H-INVERSE>)>
	<TELL .STR>
	<COND (.INV
	       <HLIGHT ,H-NORMAL>)>>

<GLOBAL DIROUT-TBL
	<TABLE
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0>>
