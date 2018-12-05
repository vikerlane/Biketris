randomize();

audio_play_sound(engineSnd, 1, true);

BaseLevel = 6;
Level = 1;
MaxLevel = 11;
LevelBlockReset = 25;
LevelBlocks = LevelBlockReset;

TimePassed = 0.0;
TimeBase = 6500;
TimeMax = (BaseLevel + MaxLevel - Level) * TimeBase;

PreviousKeypress = false;
KeypressCooldown = -1;

PalmsMoved = false;

Score = 0;
DisplayScore = 0;
ScoreDelta = 0;
Fuel = 80;
MaxFuel = 100;

BikerY = 0;
BikerMovesLeft = 8;
Crash = false;

Piece = -1;
PieceRotation = -1;

CamPosX = 0;
CamPosY = 0;

MinX = CamPosX + 8 * 15;
MaxX = 0;

depth = -850;

UpdatePiece = false;
RecalculateShadow = false;
DropPiece = false;

if (!audio_is_playing(backgroundMsc)) {
	audio_play_sound(backgroundMsc, 4, true);
}

RestartCooldown = 100;

HighScore = false;
PreviousHighScore = highscore_value(1);
TwitterHTMLElement = false;

TreeCounter = 0;