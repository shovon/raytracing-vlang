fn color(r Ray) Vec3 {
	if hit_sphere(Vec3{[f32(0.0),f32(0.0),f32(-1.0)]}, 0.5, r) {
		return Vec3{[f32(-1.0),f32(0.0),f32(0.0)]}
	}
	unit_direction := r.direction().unit_vector()
	t := 0.5*(unit_direction.y() + 1.0)
	return Vec3{[f32(1.0),f32(1.0),f32(1.0)]}
		.scalar_mul(1.0-t)
		.add(Vec3{[f32(0.5),f32(0.7),f32(1.0)]}.scalar_mul(t))
}

fn hit_sphere(center Vec3, radius f32, r Ray) bool {
	oc := r.origin().sub(center)
	a := r.direction().dot(r.direction())
	b := oc.dot(r.direction()) * 2.0
	c := oc.dot(oc) - radius * radius
	discriminant := b*b - 4*a*c
	return discriminant > 0
}

fn main() {
	nx := 200
	ny := 100

	print('P3\n$nx $ny\n255\n')

	lower_left_corner := Vec3{[f32(-2.0), f32(-1.0), f32(-1.0)]}
	horizontal := Vec3{[f32(4.0), f32(0.0), f32(0.0)]}
	vertical := Vec3{[f32(0.0), f32(2.0), f32(0.0)]}
	origin := Vec3{[f32(0.0), f32(0.0), f32(0.0)]}
	for j := ny-1; j >= 0; j-- {
		for i := 0; i < nx; i++ {
			u := f32(i) / f32(nx)
			v := f32(j) / f32(ny)
			r := Ray{
				origin,
				lower_left_corner
					.add(horizontal.scalar_mul(u))
					.add(vertical.scalar_mul(v))
			}
			col := color(r)
			ir := int(255.99*col.x())
			ig := int(255.99*col.y())
			ib := int(255.99*col.z())

			println('$ir $ig $ib')
		}
	}
}