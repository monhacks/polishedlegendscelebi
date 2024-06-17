AnarresStockroom_MapScriptHeader:
	def_scene_scripts


	def_callbacks


	def_warp_events 
	warp_event  3,  7, ANARRES_TOWN, 6
	warp_event  3,  7, ANARRES_TOWN, 6

	def_coord_events


	def_bg_events 
	bg_event 8,  2, BGEVENT_READ, ASApricornBenchScript

	def_object_events 
	mart_clerk_event  2,  3, MARTTYPE_STANDARD, MART_ANARRES
	object_event 2, 5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, jumptextfaceplayer, AnarresStockroomNPC1Script, -1 ;
	object_event 5, 2, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, AnarresStockroomNPC2Text, -1 ;
	object_event 7, 2, SPRITE_MATRON, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, AnarresStockroomNPC3Text, -1 ;


	object_const_def
	const ANARRES_STOCKROOM_BERRY_GRAMPS


AnarresStockroomNPC1Script:
	checkevent EVENT_GOT_ANARRES_BERRY ;;TO ADD
	iftrue_jumptextfaceplayer GiveAnarresBerryText
	faceplayer
	opentext	
	writetext AnarresBerryGiftText
	promptbutton
	verbosegiveitem SITRUS_BERRY
	iffalse_endtext
	setevent EVENT_GOT_ANARRES_BERRY 
	jumpopenedtext GiveAnarresBerryText 

AnarresBerryGiftText: 
	text "Our ceremonies"
	line "remind us that"
	cont "it's natural to"
	cont "change. A season"
	cont "for Sitrus Berry"
	cont "Jam, a season to"
	cont "gather honey."
	cont "Hey, I'm hungry!"
	cont "Share a berry?"
	done
	
GiveAnarresBerryText: ;;
	text "Different"
	line "berries are good"
	cont "for different"
	cont "environments!"
	done

AnarresStockroomNPC2Text:
	text "We nearly hunted"
	line "Farfetch'd to"
	cont "extinction in"
	cont "Johto, but there"
	cont "are still some"
	cont "left."
	done

AnarresStockroomNPC3Text:
	text "Why does the"
	line "Elder use bug"
	cont "#mon? To"
	cont "remind us that"
	cont "nature isn’t"
	cont "just cute"
	cont "Pikachu, but"
	cont "also scary"
	cont "Ariados."
	done

ASApricornBenchScript:
	opentext
	writetext ASCheckForApricornsText
	promptbutton
	checkevent EVENT_GAVE_KURT_RED_APRICORN
	iftrue .GiveLevelBall
	checkevent EVENT_GAVE_KURT_BLU_APRICORN
	iftrue .GiveLureBall
	checkevent EVENT_GAVE_KURT_YLW_APRICORN
	iftrue .GiveMoonBall
	checkevent EVENT_GAVE_KURT_GRN_APRICORN
	iftrue .GiveFriendBall
	checkevent EVENT_GAVE_KURT_WHT_APRICORN
	iftrue .GiveFastBall
	checkevent EVENT_GAVE_KURT_BLK_APRICORN
	iftrue .GiveHeavyBall
	checkevent EVENT_GAVE_KURT_PNK_APRICORN
	iftrue .GiveLoveBall
	callasm .CheckHaveAnyApricorns
	iftrue .AskApricorn
	jumpopenedtext ASKurtsHouseKurtThatsALetdownText

.CheckHaveAnyApricorns:
	xor a
	ld hl, wApricorns
	or [hl]
rept NUM_APRICORNS - 1
	inc hl
	or [hl]
endr
	ldh [hScriptVar], a
	ret

.AskApricorn:
	writetext ASKurtsHouseKurtAskYouHaveAnApricornText
	promptbutton
	special Special_SelectApricornForKurt
	iffalse_jumpopenedtext ASKurtsHouseKurtThatsALetdownText
	ifequal BLU_APRICORN, .Blu
	ifequal YLW_APRICORN, .Ylw
	ifequal GRN_APRICORN, .Grn
	ifequal WHT_APRICORN, .Wht
	ifequal BLK_APRICORN, .Blk
	ifequal PNK_APRICORN, .Pnk
; .Red
	setevent EVENT_GAVE_KURT_RED_APRICORN
	sjump .GaveKurtApricorns

.Blu:
	setevent EVENT_GAVE_KURT_BLU_APRICORN
	sjump .GaveKurtApricorns

.Ylw:
	setevent EVENT_GAVE_KURT_YLW_APRICORN
	sjump .GaveKurtApricorns

.Grn:
	setevent EVENT_GAVE_KURT_GRN_APRICORN
	sjump .GaveKurtApricorns

.Wht:
	setevent EVENT_GAVE_KURT_WHT_APRICORN
	sjump .GaveKurtApricorns

.Blk:
	setevent EVENT_GAVE_KURT_BLK_APRICORN
	sjump .GaveKurtApricorns

.Pnk:
	setevent EVENT_GAVE_KURT_PNK_APRICORN
.GaveKurtApricorns:
	writetext ASKurtsHouseKurtGetStartedText
	waitbutton
	closetext
	sjump ASApricornBenchScript;Kurt1

.ThatTurnedOutGreat:
	jumpopenedtext ASKurtsHouseKurtTurnedOutGreatText

.GiveLevelBall:
	writetext ASKurtsHouseKurtJustFinishedYourBallText
	promptbutton
	verbosegiveitemvar LEVEL_BALL, VAR_KURT_APRICORNS
	iffalse_endtext
	clearevent EVENT_GAVE_KURT_RED_APRICORN
	sjump .ThatTurnedOutGreat

.GiveLureBall:
	writetext ASKurtsHouseKurtJustFinishedYourBallText
	promptbutton
	verbosegiveitemvar LURE_BALL, VAR_KURT_APRICORNS
	iffalse_endtext
	clearevent EVENT_GAVE_KURT_BLU_APRICORN
	sjump .ThatTurnedOutGreat

.GiveMoonBall:
	writetext ASKurtsHouseKurtJustFinishedYourBallText
	promptbutton
	verbosegiveitemvar MOON_BALL, VAR_KURT_APRICORNS
	iffalse_endtext
	clearevent EVENT_GAVE_KURT_YLW_APRICORN
	sjump .ThatTurnedOutGreat

.GiveFriendBall:
	writetext ASKurtsHouseKurtJustFinishedYourBallText
	promptbutton
	verbosegiveitemvar FRIEND_BALL, VAR_KURT_APRICORNS
	iffalse_endtext
	clearevent EVENT_GAVE_KURT_GRN_APRICORN
	sjump .ThatTurnedOutGreat

.GiveFastBall:
	writetext ASKurtsHouseKurtJustFinishedYourBallText
	promptbutton
	verbosegiveitemvar FAST_BALL, VAR_KURT_APRICORNS
	iffalse_endtext
	clearevent EVENT_GAVE_KURT_WHT_APRICORN
	sjump .ThatTurnedOutGreat

.GiveHeavyBall:
	writetext ASKurtsHouseKurtJustFinishedYourBallText
	promptbutton
	verbosegiveitemvar HEAVY_BALL, VAR_KURT_APRICORNS
	iffalse_endtext
	clearevent EVENT_GAVE_KURT_BLK_APRICORN
	sjump .ThatTurnedOutGreat

.GiveLoveBall:
	writetext ASKurtsHouseKurtJustFinishedYourBallText
	promptbutton
	verbosegiveitemvar LOVE_BALL, VAR_KURT_APRICORNS
	iffalse_endtext
	clearevent EVENT_GAVE_KURT_PNK_APRICORN
	sjump .ThatTurnedOutGreat

ASKurtsHouseKurtGetStartedText:
	text "Time to work on"
	line "this apricorn."
	done

ASKurtsHouseKurtJustFinishedYourBallText:
	text "All done!"
	done

ASKurtsHouseKurtTurnedOutGreatText:
	text "Looks like a"
	line "good one!"
	done
	
ASKurtsHouseKurtThatsALetdownText:
	text "Too bad. Need"
	line "To find some!"
	done

ASKurtsHouseKurtAskYouHaveAnApricornText:
	text "Which one?"
	done

ASCheckForApricornsText:
	text "Any apricorns"
	line "in the bag?"
	done
