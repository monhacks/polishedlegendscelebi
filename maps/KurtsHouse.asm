KurtsHouse_MapScriptHeader: ; todo add the ability to make apricorns here at the bench
	def_scene_scripts

	def_callbacks


	def_warp_events
	warp_event  3,  7, AZALEA_TOWN, 4
	warp_event  4,  7, AZALEA_TOWN, 4
	
	def_coord_events
	coord_event 7, 2, 0, KurtTrigger1 ; you have to hit this square due to where the pokemon is

	def_bg_events;done
;	bg_event  6,  1, BGEVENT_JUMPSTD, radio2 ; this is fine for later
	bg_event  6,  1, BGEVENT_READ, DebugRadio ;this line for debug
	bg_event  8,  0, BGEVENT_JUMPTEXT, KurtsHouseOakPhotoText ;revised
	bg_event  9,  0, BGEVENT_JUMPTEXT, KurtsHouseOakPhotoText ;revised
	bg_event  5,  1, BGEVENT_READ, PokemonJournalProfWestwoodScript ; revised
	bg_event  2,  1, BGEVENT_READ, PokemonJournalProfWestwoodScript
	bg_event  3,  1, BGEVENT_READ, PokemonJournalProfWestwoodScript
	bg_event  4,  1, BGEVENT_JUMPTEXT, KurtsHouseCelebiStatueText

	def_object_events
	object_event  6,  3, SPRITE_KURT, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, KurtScript, EVENT_KURTS_HOUSE_KURT_0 ;
	object_event  6,  3, SPRITE_KURT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, KurtScript, EVENT_KURTS_HOUSE_KURT_2 ;
	pokemon_event  8,  1, SHUCKLE, -1, -1, PAL_NPC_RED, KurtsHouseShuckleText, -1
; kurt is at the celebi shrine if you visit later

	object_const_def
	const KURTSHOUSE_KURT
	
KurtTrigger1: ; when you walk to 7, 2
	playmusic MUSIC_PROF_OAK
	turnobject KURTSHOUSE_KURT, UP
	applymovement KURTSHOUSE_KURT, .kurt_walks_to_you
	turnobject PLAYER, LEFT
	sjump KurtEventScript

.kurt_walks_to_you:
	step_up
	turn_head_right
	step_end

KurtEventScript:
	opentext
	writetext KurtIntroText
	promptbutton
	getstring GearName, $1
	callstd receiveitem
	setflag ENGINE_POKEGEAR
	setflag ENGINE_PHONE_CARD
	addcellnum PHONE_MOM
	setscene $1
	setevent EVENT_KURTS_HOUSE_KURT_0 ; changed from mom
	clearevent EVENT_PLAYERS_HOUSE_KURT_2 ; may not need this line? 
	writetext KurtsHouseApricornBox
	promptbutton
	verbosegivekeyitem APRICORN_BOX
	promptbutton
	writetext MomPokegearText
	promptbutton
	special Special_SetDayOfWeek
.InitialSetDSTFlag:
	writetext MomDSTText
	yesorno
	iffalse .NotDST
	special Special_InitialSetDSTFlag
	yesorno
	iffalse .InitialSetDSTFlag
	sjump .InitializedDSTFlag
.NotDST:
	special Special_InitialClearDSTFlag
	yesorno
	iffalse .InitialSetDSTFlag
.InitializedDSTFlag:
	writetext MomRunningShoesText
	yesorno
	iftrue .NoInstructions
	writetext MomInstructionsText
	promptbutton
.NoInstructions:
	writetext MomOutroText
	promptbutton
	special SpecialNameRival
	writetext KurtOutroText	
	waitbutton
	closetext
	applymovement KURTSHOUSE_KURT, .kurt_walks_back
	special RestartMapMusic
	end

.kurt_walks_back:
	step_down
	turn_head_right
	step_end

KurtIntroText: 
	text "Oh, <PLAYER>!"
	line "It's almost time."
	
	para "Before we go, I"
	line "want to give you"
	cont "a gift..."
	done

MomPokegearText:
	text "#mon Gear, or"
	line "just #gear."

	para "It's essential if"
	line "you want to be a"
	cont "good trainer."

	para "Oh, the day of the"
	line "week isn't set."

	para "You mustn't forget"
	line "that!"
	done

MomDSTText:
	text "Is it Daylight"
	line "Saving Time now?"
	done

GearName:
	db "#gear@"

MomRunningShoesText:
	text "Isn't it so"
	line "convenient?"

	para "By the way, do"
	line "you know how to"

	para "use your new"
	line "Running Shoes?"
	done

MomInstructionsText:
	text "Just hold down the"
	line "B Button to run."
	done

MomOutroText:
	text "We're waiting on"
	line "the charcoal fam-"
	cont "ily. Do you know"
	cont "the boy's name?"
	done

KurtOutroText:
	text "Can you go see"
	line "what is taking"
	cont "them so long?"
	done

KurtScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_A_POKEMON
	iftrue_jumpopenedtext KurtNeedsAlphText
	jumpthisopenedtext

	text "Where is the "
	line "charcoal family?"
	done

KurtNeedsAlphText:
	text "I need samples"
	line "from the Ruins"
	cont "of Alph."
	
	para "Can you get"
	line "the UNOWN"
	cont "Report for me?"
	done
	
KurtsHouseShuckleText:
	text "Shuckle:"
	line "Shucka!"
	done
	
PokemonJournalProfWestwoodScript:
	setflag ENGINE_READ_PROF_WESTWOOD_JOURNAL ; revised this? 
	jumpthistext

	text "Apricorn Journal"

	para "What else can"
	line "be used like"
	cont "Apricorns?"
	
	para "Maybe hollow"
	line "rocks like a"
	cont "geode could be"
	
	para "used to catch"
	line "rock types."
	done

KurtsHouseOakPhotoText:
	text "It's Grandpa,"
	line "Dad, and a"
	cont "happy Snubbull."
	done

KurtsHouseCelebiStatueText:
	text "It's a statue of"
	line "the forest's pro-"
	cont "tector."
	done

KurtsHouseApricornBox:
	text "Oh, I finished"
	line "fixing your Apri-"
	cont "corn box. Here!"
	done

DebugRadio:
	opentext
	setflag ENGINE_POKEGEAR
	setflag ENGINE_PHONE_CARD
	setflag ENGINE_MAP_CARD
	setflag ENGINE_RADIO_CARD
	setflag ENGINE_EXPN_CARD
	; pokedex
	setflag ENGINE_POKEDEX
	; all key items
for x, NUM_KEY_ITEMS
if x != MACHINE_PART
	givekeyitem x
endc
endr
	; all tms+hms
for x, NUM_TMS + NUM_HMS
	givetmhm x
endr
	; useful items
for x, POKE_BALL, CHERISH_BALL + 1
if x != PARK_BALL && x != SAFARI_BALL
	giveitem x, 99
endc
endr
	giveitem MAX_POTION, 99
	giveitem FULL_RESTORE, 99
	giveitem MAX_REVIVE, 99
	giveitem MAX_ELIXIR, 99
	giveitem HP_UP, 99
	giveitem PROTEIN, 99
	giveitem IRON, 99
	giveitem CARBOS, 99
	giveitem CALCIUM, 99
	giveitem ZINC, 99
	giveitem RARE_CANDY, 99
	giveitem PP_UP, 99
	giveitem PP_MAX, 99
	giveitem SACRED_ASH, 99
	giveitem MAX_REPEL, 99
	giveitem MAX_REPEL, 99
	giveitem ESCAPE_ROPE, 99
	giveitem ABILITY_CAP, 99
	giveitem LEAF_STONE, 99
	giveitem FIRE_STONE, 99
	giveitem WATER_STONE, 99
	giveitem THUNDERSTONE, 99
	giveitem MOON_STONE, 99
	giveitem SUN_STONE, 99
	giveitem DUSK_STONE, 99
	giveitem DAWN_STONE, 99
	giveitem SHINY_STONE, 99
	giveitem EXP_SHARE, 99
	giveitem LEFTOVERS, 99
	giveitem BIG_NUGGET, 99
	giveitem SILVER_LEAF, 99
	giveitem GOLD_LEAF, 99
	giveitem BOTTLE_CAP, 99
	giveitem MULCH, 99
	giveitem MINT_LEAF, 99
	giveitem ODD_SOUVENIR, 10
	; all decorations except Diploma
for x, EVENT_DECO_BED_1, EVENT_DECO_BIG_LAPRAS_DOLL + 1
	setevent x
endr
	; max money
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 999999
	givecoins 50000
;	loadmem wBattlePoints+0, 0
;	loadmem wBattlePoints+1, 250
	; all badges
	setflag ENGINE_ZEPHYRBADGE
	setflag ENGINE_HIVEBADGE
	setflag ENGINE_PLAINBADGE
	setflag ENGINE_FOGBADGE
	setflag ENGINE_STORMBADGE
	setflag ENGINE_MINERALBADGE
	setflag ENGINE_GLACIERBADGE
	setflag ENGINE_RISINGBADGE
	setflag ENGINE_BOULDERBADGE
	setflag ENGINE_CASCADEBADGE
	setflag ENGINE_THUNDERBADGE
	setflag ENGINE_RAINBOWBADGE
	setflag ENGINE_MARSHBADGE
	setflag ENGINE_SOULBADGE
	setflag ENGINE_VOLCANOBADGE
	setflag ENGINE_EARTHBADGE
	setevent EVENT_BEAT_FALKNER
	setevent EVENT_BEAT_BUGSY
	setevent EVENT_BEAT_WHITNEY
	setevent EVENT_BEAT_MORTY
	setevent EVENT_BEAT_CHUCK
	setevent EVENT_BEAT_JASMINE
	setevent EVENT_BEAT_PRYCE
	setevent EVENT_BEAT_CLAIR
	setevent EVENT_BEAT_HOLLIS
	setevent EVENT_BEAT_MISTY
	setevent EVENT_BEAT_LTSURGE
	setevent EVENT_BEAT_ERIKA
	setevent EVENT_BEAT_JANINE
	setevent EVENT_BEAT_SABRINA
	setevent EVENT_BEAT_BLAINE
	setevent EVENT_BEAT_BLUE
	setevent EVENT_BEAT_ELITE_FOUR
	setevent EVENT_BEAT_ELITE_FOUR_AGAIN
	setevent EVENT_BATTLE_TOWER_OPEN
	clearevent EVENT_BATTLE_TOWER_CLOSED
	; fly anywhere
	setflag ENGINE_FLYPOINT_VIOLET
	setflag ENGINE_FLYPOINT_UNION_CAVE
	setflag ENGINE_FLYPOINT_AZALEA
	setflag ENGINE_FLYPOINT_GOLDENROD
	setflag ENGINE_FLYPOINT_ECRUTEAK
	setflag ENGINE_FLYPOINT_OLIVINE
	setflag ENGINE_FLYPOINT_CIANWOOD
	setflag ENGINE_FLYPOINT_MAHOGANY
	setflag ENGINE_FLYPOINT_LAKE_OF_RAGE
	; post-e4
	setflag ENGINE_HAVE_SHINY_CHARM
	; good party
	givepoke ROTOM, NO_FORM, 100, BRIGHTPOWDER
	loadmem wPartyMon1EVs+0, 252
	loadmem wPartyMon1EVs+1, 252
	loadmem wPartyMon1EVs+2, 252
	loadmem wPartyMon1EVs+3, 252
	loadmem wPartyMon1EVs+4, 252
	loadmem wPartyMon1EVs+5, 252
	loadmem wPartyMon1DVs+0, $ff
	loadmem wPartyMon1DVs+1, $ff
	loadmem wPartyMon1DVs+2, $ff
	loadmem wPartyMon1Personality, ABILITY_2 | NAT_SATK_UP_ATK_DOWN
	loadmem wPartyMon1Stats+0, HIGH(999)
	loadmem wPartyMon1Stats+1, LOW(999)
	loadmem wPartyMon1Stats+2, HIGH(999)
	loadmem wPartyMon1Stats+3, LOW(999)
	loadmem wPartyMon1Stats+4, HIGH(999)
	loadmem wPartyMon1Stats+5, LOW(999)
	loadmem wPartyMon1Stats+6, HIGH(999)
	loadmem wPartyMon1Stats+7, LOW(999)
	loadmem wPartyMon1Stats+8, HIGH(999)
	loadmem wPartyMon1Stats+9, LOW(999)
	; hm slaves
	givepoke FROSLASS, NO_FORM, 100, LEFTOVERS
	givepoke URSALUNA, NO_FORM, 100, LEFTOVERS
	loadmem wPartyMon2Moves+0, FLY
	loadmem wPartyMon2Moves+1, SURF
	loadmem wPartyMon2Moves+2, STRENGTH
	loadmem wPartyMon2Moves+3, MAGMA_STORM
	loadmem wPartyMon2PP+0, 15
	loadmem wPartyMon2PP+1, 15
	loadmem wPartyMon2PP+2, 15
	loadmem wPartyMon2PP+3, 30
	loadmem wPartyMon3Moves+0, FLASH
	loadmem wPartyMon3Moves+1, ROCK_SMASH
	loadmem wPartyMon3Moves+2, HEADBUTT
	loadmem wPartyMon3Moves+3, WATERFALL
	loadmem wPartyMon3PP+0, 20
	loadmem wPartyMon3PP+1, 15
	loadmem wPartyMon3PP+2, 15
	loadmem wPartyMon3PP+3, 15
	; fill pokedex
	callasm FillPokedex
	closetext
	end

FillPokedex:
	ld a, 1
	ld hl, wPokedexSeen
	call .Fill
	ld hl, wPokedexCaught
.Fill:
	ld a, %11111111
	ld bc, 31 ; 001-248
	rst ByteFill
	ld [hl], %00111111 ; 249-254
	ret
