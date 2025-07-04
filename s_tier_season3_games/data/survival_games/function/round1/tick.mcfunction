# thread handler for survival games round 1

# stage key:
# 0- 20s delay to allow all players to teleport
# 1- explanation of game
# 2- 10s delay with countdown at 5 seconds
# 3- round start; round_timer begins
# 4- round end; 15 second delay to announce winners before resetting & updating sg.stage to next round

# manually force iron_blocks
execute unless score sg.r1.handler sg.borderEnd matches 1 in survival_games:sg1 run setblock -50 108 -50 minecraft:iron_block
execute unless score sg.r1.handler sg.borderEnd matches 2 in survival_games:sg1 run setblock 50 111 -50 minecraft:iron_block
execute unless score sg.r1.handler sg.borderEnd matches 3 in survival_games:sg1 run setblock -50 110 50 minecraft:iron_block
execute unless score sg.r1.handler sg.borderEnd matches 4 in survival_games:sg1 run setblock 50 107 50 minecraft:iron_block

# update points every tick (regardless of stage)
function survival_games:round1/points_update

# first, we call our load function if this is the first time we're here
execute unless score sg.r1.handler sg.r1.stage matches 0.. run function survival_games:round1/load

# if we're in stage 0, we only need to increment our timer & check if 20 seconds have elapsed
# and then update our stage to 1
execute if score sg.r1.handler sg.r1.stage matches 0 run scoreboard players add sg.r1.handler sg.r1.timer.delay1 1
execute if score sg.r1.handler sg.r1.stage matches 0 if score sg.r1.handler sg.r1.timer.delay1 matches 400.. run scoreboard players set sg.r1.handler sg.r1.stage 1

# if we're in stage 1, we need to increment the timer, call our explanation function, & check if 30 seconds have elapsed
execute if score sg.r1.handler sg.r1.stage matches 1 run scoreboard players add sg.r1.handler sg.r1.timer.explanation 1
execute if score sg.r1.handler sg.r1.stage matches 1 run function survival_games:round1/explanation
execute if score sg.r1.handler sg.r1.stage matches 1 if score sg.r1.handler sg.r1.timer.explanation matches 800.. run scoreboard players set sg.r1.handler sg.r1.stage 2

# if we're in stage 2, we just need to increment the timer & update the actionbar
execute if score sg.r1.handler sg.r1.stage matches 2 run scoreboard players add sg.r1.handler sg.r1.timer.delay2 1
execute if score sg.r1.handler sg.r1.stage matches 2 if score sg.r1.handler sg.r1.timer.delay2 matches 300 run title @a actionbar {text:"5 seconds!",bold:true,color:"gold"}
execute if score sg.r1.handler sg.r1.stage matches 2 if score sg.r1.handler sg.r1.timer.delay2 matches 320 run title @a actionbar {text:"4 seconds!",bold:true,color:"gold"}
execute if score sg.r1.handler sg.r1.stage matches 2 if score sg.r1.handler sg.r1.timer.delay2 matches 340 run title @a actionbar {text:"3 seconds!",bold:true,color:"gold"}
execute if score sg.r1.handler sg.r1.stage matches 2 if score sg.r1.handler sg.r1.timer.delay2 matches 360 run title @a actionbar {text:"2 seconds!",bold:true,color:"gold"}
execute if score sg.r1.handler sg.r1.stage matches 2 if score sg.r1.handler sg.r1.timer.delay2 matches 380 run title @a actionbar {text:"1 seconds!",bold:true,color:"gold"}
execute if score sg.r1.handler sg.r1.stage matches 2 if score sg.r1.handler sg.r1.timer.delay2 matches 400.. run scoreboard players set sg.r1.handler sg.r1.stage 3

# if we're in stage 3, we need to increment the timer & call the round_tick function (a lot happens in there)
# round_tick will automatically update the stage when the round ends
execute if score sg.r1.handler sg.r1.stage matches 3 run scoreboard players add sg.r1.handler sg.r1.timer.round 1
execute if score sg.r1.handler sg.r1.stage matches 3 run function survival_games:round1/round_tick

# if we're in stage 4, we just need to increment its timer [points are not announced after this round]
# and then update sg.stage to 1
execute if score sg.r1.handler sg.r1.stage matches 4 run scoreboard players add sg.r1.handler sg.r1.timer.delay3 1
execute if score sg.r1.handler sg.r1.stage matches 4 if score sg.r1.handler sg.r1.timer.delay3 matches 200.. run scoreboard players set sg.handler sg.stage 1