import math

fn color(r Ray, world Hitable) Vec3 {
	mut rec := new_hit_record()
	if world.hit(r, 0.0, math.max_f32, mut rec) {
		return Vec3{1, 1, 1}.add(rec.normal).scalar_mul(0.5)
	}

	unit_direction := r.direction().unit_vector()
	t := (unit_direction.y() + 1.0)*0.5
	return Vec3{1,1,1}
		.scalar_mul(1.0-t)
		.add(Vec3{0.5, 0.7, 1.0}.scalar_mul(t))
}

fn main() {
	nx := 200
	ny := 100

	print('P3\n$nx $ny\n255\n')

	lower_left_corner := Vec3{-2.0, -1.0, -1.0}
	horizontal := Vec3{4.0, 0.0, 0.0}
	vertical := Vec3{0.0, 2.0, 0.0}
	origin := Vec3{0.0, 0.0, 0.0}

	mut list := []Hitable{}
	list << &Sphere{Vec3{0,0,-1}, 0.5}
	list << &Sphere{Vec3{0,-100.5,-1}, 100}

	world := HitableList{list}

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
			col := color(r, world)
			ir := int(255.99*col.x())
			ig := int(255.99*col.y())
			ib := int(255.99*col.z())

			println('$ir $ig $ib')
		}
	}
}
