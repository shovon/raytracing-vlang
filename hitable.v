struct HitRecord {
mut:
	t f32
	p Vec3
	normal Vec3
}

fn new_hit_record() HitRecord {
	return HitRecord{
		0,
		Vec3{[f32(0),f32(0),f32(0)]},
		Vec3{[f32(0),f32(0),f32(0)]}
	}
}

interface Hitable {
	hit(r Ray, t_min f32, t_max f32, mut rec HitRecord) bool
}