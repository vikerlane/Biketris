randomize();

audio_play_sound(engineSnd, 1, true);

Level = 1;
LevelBlocks = 16;

TimePassed = 0.0;
TimeMax = 1000000.0 / 6.7;

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