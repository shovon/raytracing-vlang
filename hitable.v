struct HitRecord {
mut:
	t f32
	p Vec3
	normal Vec3
	mat Material
}

fn new_hit_record() HitRecord {
	return HitRecord{
		0,
		Vec3{0,0,0},
		Vec3{0,0,0},
		Lambertian{}
	}
}

interface Hitable {
	hit(r Ray, t_min f32, t_max f32, mut rec HitRecord) bool
}