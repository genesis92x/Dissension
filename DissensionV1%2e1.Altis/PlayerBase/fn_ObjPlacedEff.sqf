_F = "#particlesource" createvehiclelocal (getposATL _this);
_F setParticleParams
/*Sprite*/		[["\A3\data_f\ParticleEffects\Universal\Mud",1,0,1,0],"true",// File,Ntieth,Index,Count,Loop(Bool)
/*Type*/			"spaceobject",
/*TimmerPer*/		1,
/*Lifetime*/		8,
/*Position*/		[0,0,0.25],
/*MoveVelocity*/	[0,0,5],
/*Simulation*/		9,10,2,1,//rotationVel,weight,volume,rubbing
/*Scale*/		[0.1,0.1,0],
/*Color*/		[[1, 1, 1, 1], [1, 1, 1, 0.5], [1, 1, 1, 0]],
/*AnimSpeed*/		[1,1],
/*randDirPeriod*/	0,
/*randDirIntesity*/	0,
/*onTimerScript*/	"",
/*DestroyScript*/	"",
/*Follow*/		nil,
/*Angle*/              0,
/*onSurface*/          true,
/*bounceOnSurface*/    0,
/*emissiveColor*/      [[0,0,0,0]]];


// RANDOM / TOLERANCE PARAMS
_F setParticleRandom
/*LifeTime*/		[0,
/*Position*/		[1,1,0],
/*MoveVelocity*/	[3,3,5],
/*rotationVel*/		10,
/*Scale*/		0.1,
/*Color*/		[0,0,0,0],
/*randDirPeriod*/	0,
/*randDirIntesity*/	10,
/*Angle*/		360];
_F setParticleCircle [1,[3,3,5]];
_F setDropInterval 0.001;

_F spawn
{
sleep 0.25;
deleteVehicle _this;
};



_F = "#particlesource" createvehiclelocal (getposATL _this);
_F setParticleParams
/*Sprite*/		[["\A3\data_f\ParticleEffects\Universal\StoneSmall",1,0,1,0],"true",// File,Ntieth,Index,Count,Loop(Bool)
/*Type*/			"spaceobject",
/*TimmerPer*/		1,
/*Lifetime*/		8,
/*Position*/		[0,0,0.25],
/*MoveVelocity*/	[0,0,5],
/*Simulation*/		9,10,2,1,//rotationVel,weight,volume,rubbing
/*Scale*/		[0.1,0.1,0],
/*Color*/		[[1, 1, 1, 1], [1, 1, 1, 0.5], [1, 1, 1, 0]],
/*AnimSpeed*/		[1,1],
/*randDirPeriod*/	0,
/*randDirIntesity*/	0,
/*onTimerScript*/	"",
/*DestroyScript*/	"",
/*Follow*/		nil,
/*Angle*/              0,
/*onSurface*/          true,
/*bounceOnSurface*/    0,
/*emissiveColor*/      [[0,0,0,0]]];


// RANDOM / TOLERANCE PARAMS
_F setParticleRandom
/*LifeTime*/		[0,
/*Position*/		[1,1,0],
/*MoveVelocity*/	[3,3,5],
/*rotationVel*/		10,
/*Scale*/		0.1,
/*Color*/		[0,0,0,0],
/*randDirPeriod*/	0,
/*randDirIntesity*/	10,
/*Angle*/		360];

_F setParticleCircle [1,[3,3,5]]; 
_F setDropInterval 0.001;

_F spawn
{
sleep 0.25;
deleteVehicle _this;
};

