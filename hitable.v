struct HitRecord {
	t f32
	p Vec3
	normal Vec3
}

interface Hitable {
	hit(r Ray, t_min f32, t_max f32, rec HitRecord) bool
}