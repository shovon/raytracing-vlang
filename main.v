import math
import rand

fn color(r Ray, world Hitable, depth int) Vec3 {
	mut rec := new_hit_record()
	if world.hit(r, 0.001, math.max_f32, mut rec) {
		mut scattered := Ray{}
		mut attenuation := Vec3{}
		if depth < 50 && rec.mat.scatter(r, rec, mut attenuation, mut scattered) {
			return color(scattered, world, depth+1)
		}
		return Vec3{}
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
	ns := 100

	print('P3\n$nx $ny\n255\n')

	mut list := []Hitable{}
	list << &Sphere{Vec3{0,0,-1}, 0.5, Lambertian{Vec3{0.8, 0.3, 0.3}}}
	list << &Sphere{Vec3{0,-100.5,-1}, 100, Lambertian{Vec3{0.8, 0.8, 0.0}}}
	list << &Sphere{Vec3{1,0,-1}, 0.5, Metal{Vec3{0.8, 0.6, 0.2}}}
	list << &Sphere{Vec3{-1,0,-1}, 0.5, Metal{Vec3{0.8, 0.8, 0.8}}}

	world := HitableList{list}

	cam := new_camera()

	for j := ny-1; j >= 0; j-- {
		for i := 0; i < nx; i++ {
			mut col := Vec3{0, 0, 0}
			for s := 0; s < ns; s++ {
				u := (i + rand.f32()) / f32(nx)
				v := (j + rand.f32()) / f32(ny)
				r := cam.get_ray(u, v)
				col = col.add(color(r, world, 0))
			}
			col = col.scalar_div(f32(ns))
			col = Vec3{
				f32(math.sqrt(col.e0)),
				f32(math.sqrt(col.e1)),
				f32(math.sqrt(col.e2))
			}
			ir := int(255.99*col.x())
			ig := int(255.99*col.y())
			ib := int(255.99*col.z())

			println('$ir $ig $ib')
		}
	}
}
