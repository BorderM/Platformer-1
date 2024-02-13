# **Platformer**

30/01 - Started the platformer by following https://www.youtube.com/watch?v=S8lMTwSRoRg 

31/01 - Updated save game and load game features

02/02 - Added level up feature (max hp increases with levels), fixed resolution scaling, added player damage and monster health, limited hp gained from cherries to max hp, updated buttons with themes.  

03/02 - Added large portions to the map. Implemented ladders and climbing. Added match system for cherry and frog spawning (to be changed later to a more efficient method)

08/02 - Adjusted frog models to flip correctly when changing direction. Frogs now flip on ledges and when hitting walls. Changed player detection to a polygon to stop seeing below itself. Fixed the spawn method, now using multiple path2D for both frog and cherry spawners (much easier to adjust when needed). Working on updating the load function. Frogs also have a health label for later updates. 

09/02 - Frogs will now jump toward the player if they encounter a ledge while chasing. Added some aesthetic to the background. Added a game over scene with fade in and fade out. Save file is now deleted upon death (previously it would load the most recent save with player hp above 0). Adjusted frog player detection system. Added platforms the player can jump on (some are hidden :D )

10/02 - Pause menu can be opened and closed with the escape key.

11/02 - Added health bars.

12/02 - Updated health bars. 
