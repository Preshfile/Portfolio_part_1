<h1>Welcome to My Tetris Game</h1>

<p>My Tetris is a classic tile-matching puzzle video game, where the player has to arrange falling tetrominoes to form a complete row without gaps. This project is a demonstration of JavaScript skills, and it only uses pure JavaScript without any libraries except Math.</p>

<h2>Technical Details</h2>

<p>The game logic is based on the game architecture and is separated from rendering. The player interacts with the game using the arrow keys of the keyboard, and the game world calls it "the controller." The Tetris playfield is 10×40, where rows above 20 are hidden or obstructed by the field frame to deceive the player into thinking it's 10×20. If the hardware permits, a few pixels of row 21 will be visible. Tetriminoes have distinct hues and patterns to differentiate themselves in versions that use monochrome screens or when hardware limitations disallow all colors to be used. Tetromino start locations are as follows:</p>
<ul>
<li>The I and O spawn in the middle columns</li>
<li>The rest spawn in the left-middle columns</li>
<li>The tetriminoes spawn horizontally with J, L, and T spawning flat-side first.</li>
<li>Spawn above playfield, row 21 for I, and 21/22 for all other tetriminoes.</li>
<li>Immediately drop one space if no existing Block is in its path</li>
<li>The Initial rotation and movement follow the Super Rotation System/Standard Rotation System (SRS), which specifies tetrimino rotation. </li>
<li>Standard mappings for console and handheld gamepads, computer keyboards, number pad controls, and cellphones are provided for rotation, hard and soft drop, hold, and pause functionalities.</li>
</ul>

<h2>Usage</h2>

<p>To run the game, open the index.html file in your web browser. The game interface consists of a canvas tag, a CSS file, and multiple JavaScript files with explicit names such as controller, renderer, and tetris_logic.</p>

<h2>Style Guide</h2>
This project follows the Airbnb JavaScript Style Guide, which can be found at https://github.com/airbnb/javascript.

<h2>The Core Team</h2>
<p>Authored by <strong>Precious Oranye</strong></p>