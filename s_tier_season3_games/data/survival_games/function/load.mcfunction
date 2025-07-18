# load function for survival games

# this function creates all local scoreboards (which will be subsequently removed in /reset)

# since survival games has multiple rounds, this function will NOT tp @a to the dimension
# that will happen in the stage immediately after when the round1 thread begins

# create scoreboards
# tracks the current stage of the game
scoreboard objectives add sg.stage dummy
# stores if the player is currently alive or not
scoreboard objectives add sg.alive dummy
# tracks the number of kills a player has gotten
scoreboard objectives add sg.kills dummy
# tracks the current number of players alive
scoreboard objectives add sg.players_alive dummy
# tracks the current number of teams alive
scoreboard objectives add sg.teams_alive dummy
# tracks the individual points a player has earned [is then stored in global indiv as well]
scoreboard objectives add sg.points.indiv dummy
# tracks the points each team has earned this game [is not stored anywhere else]
# this value is only attributed to the sg.TEAM players
scoreboard objectives add sg.points.team dummy
# tracks the rank of each player
scoreboard objectives add sg.points.player.rank dummy
# tracks the rank of each team
scoreboard objectives add sg.points.team.rank dummy
# stores which quadrant the border will end in
scoreboard objectives add sg.borderEnd dummy
# point constants
# how many points each kill is worth
scoreboard objectives add sg.points.killValue dummy
# how many points each placement is worth
scoreboard objectives add sg.points.topTwentyValue dummy
scoreboard objectives add sg.points.topSixteenValue dummy
scoreboard objectives add sg.points.topTwelveValue dummy
scoreboard objectives add sg.points.topEightValue dummy
scoreboard objectives add sg.points.topFourValue dummy
scoreboard objectives add sg.points.topThreeValue dummy
scoreboard objectives add sg.points.topTwoValue dummy
scoreboard objectives add sg.points.topOneValue dummy
# how many points each team placement is worth
scoreboard objectives add sg.points.topSixTeamValue dummy
scoreboard objectives add sg.points.topFiveTeamValue dummy
scoreboard objectives add sg.points.topFourTeamValue dummy
scoreboard objectives add sg.points.topThreeTeamValue dummy
scoreboard objectives add sg.points.topTwoTeamValue dummy
scoreboard objectives add sg.points.topOneTeamValue dummy
# constant of 4 (for team placement split calculation)
scoreboard objectives add sg.points.teamSplitFour dummy

# create round thread variables (so that it will run even before round/load is called)
scoreboard objectives add sg.r1.stage dummy
scoreboard objectives add sg.r2.stage dummy
scoreboard objectives add sg.r3.stage dummy

# and reset their values (so that old assigned values don't interfere)
scoreboard players reset sg.r1.handler sg.r1.stage
scoreboard players reset sg.r2.handler sg.r2.stage
scoreboard players reset sg.r3.handler sg.r3.stage

# set point constants
scoreboard players set sg.handler sg.points.killValue 30
scoreboard players set sg.handler sg.points.topTwentyValue 10
scoreboard players set sg.handler sg.points.topSixteenValue 10
scoreboard players set sg.handler sg.points.topTwelveValue 10
scoreboard players set sg.handler sg.points.topEightValue 10
scoreboard players set sg.handler sg.points.topFourValue 10
scoreboard players set sg.handler sg.points.topThreeValue 10
scoreboard players set sg.handler sg.points.topTwoValue 15
scoreboard players set sg.handler sg.points.topOneValue 25
scoreboard players set sg.handler sg.points.topSixTeamValue 0
scoreboard players set sg.handler sg.points.topFiveTeamValue 40
scoreboard players set sg.handler sg.points.topFourTeamValue 100
scoreboard players set sg.handler sg.points.topThreeTeamValue 160
scoreboard players set sg.handler sg.points.topTwoTeamValue 260
scoreboard players set sg.handler sg.points.topOneTeamValue 400
scoreboard players set sg.handler sg.points.teamSplitFour 4

# now, we set stage to 0
scoreboard players set sg.handler sg.stage 0

# and set some default values
scoreboard players set sg.handler sg.teams_alive 6

# and set some necessary values for our players
scoreboard players set @a sg.kills 0
scoreboard players set @a sg.alive 1
scoreboard players set @a[team=SPECTATORS] sg.alive 0
scoreboard players set @a sg.points.indiv 0

# set the sidebar
scoreboard objectives setdisplay sidebar sg.sidebar