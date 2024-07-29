class_name Const

enum CollisionType {ASTEROID, REPAIR_KIT, BIG_ASTEROID, SPEED_BOOST}

const OVERHEAT = {
	CollisionType.ASTEROID: 0.1,
	CollisionType.REPAIR_KIT: -0.2,
	CollisionType.BIG_ASTEROID: 0.2,
	CollisionType.SPEED_BOOST: 0.0
}

const PROGRESS_SPEED_BOOST = 0.15
