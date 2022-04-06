import math
import rand

fn color(r Ray, world Hitable, depth int) Vec3 {
	mut rec := new_hit_record()
	if world.hit(r, 0.001, math.max_f32, mut rec) {
		mut scattered := Ray{}
		mut attenuation := Vec3{}
		if depth < 50 && rec.mat.scatter(r, rec, mut attenuation, mut scattered) {
			return attenuation.mul(color(scattered, world, depth+1))
		}
		return Vec3{}
	}

	unit_direction := r.direction().unit_vector()
	t := (unit_direction.y() + 1.0)*0.5
	return Vec3{1,1,1}
		.scalar_mul(1.0-t)
		.add(Vec3{0.5, 0.7, 1.0}.scalar_mul(t))
}

fn random_scene() Hitable {
	// n := 500
	mut list := []Hitable{}
	
	mat1 := &Lambertian{Vec3{0.5, 0.5, 0.5}}
	list << &Sphere{Vec3{0, -1000, 0}, 1000, mat1}

	for a := -11; a < 11; a++ {
		for b := -11; b < 11; b++ {
			choose_mat := rand.f32()
			center := Vec3{a+0.9*rand.f32(),0.2,b+0.9*rand.f32()}
			if center.sub(Vec3{4,0.2,0}).length() > 0.9 {
				if choose_mat < 0.8 {
					mat := &Lambertian{Vec3{
						rand.f32()*rand.f32(),
						rand.f32()*rand.f32(),
						rand.f32()*rand.f32()
					}}
					list << &Sphere{center, 0.2, mat}
				} else if choose_mat < 0.95 {
					mat := &Metal{
						Vec3{
							0.5*(1+rand.f32()),
							0.5*(1+rand.f32()),
							0.5*(1+rand.f32())
						},
						0.5*rand.f32()
					}
					list << &Sphere{center, 0.2, mat}
				} else {
					mat := &Dialectric{1.5}
					list << &Sphere{center, 0.2, mat}
				}
			}
		}
	}

	mat2 := &Dialectric{1.5}
	list << &Sphere{Vec3{0, 1, 0}, 1, mat2}
	
	mat3 := &Lambertian{Vec3{0.4,0.2,0.1}}
	list << &Sphere{Vec3{-4, 1, 0}, 1, mat3}

	mat4 := &Metal{Vec3{0.7,0.6,0.5},0.0}
	list << &Sphere{Vec3{5, 1, 0}, 1, mat4}

	return &HitableList{list}
}

fn main() {
	nx := 1024
	ny := 576
	ns := 100

	print('P3\n$nx $ny\n255\n')

	// mut list := []Hitable{}
	// vec1 := Vec3{0.1, 0.2, 0.5}
	// mat1 := &Lambertian{vec1}
	// list << &Sphere{Vec3{0,0,-1}, 0.5, mat1}

	// vec2 := Vec3{0.8, 0.8, 0.0}
	// mat2 := &Lambertian{vec2}
	// list << &Sphere{Vec3{0,-100.5,-1}, 100, mat2}

	// vec3 := Vec3{0.8, 0.6, 0.2}
	// mat3 := &Metal{vec3, 0.3}
	// list << &Sphere{Vec3{1,0,-1}, 0.5, mat3}

	// mat4 := &Dialectric{1.5}
	// list << &Sphere{Vec3{-1,0,-1}, 0.5, mat4}

	// mat5 := &Dialectric{1.5}
	// list << &Sphere{Vec3{-1,0,-1}, -0.45, mat5}

	// radius := f32(math.cos(math.pi / 4))
	// vec1 := Vec3{0, 0, 1}
	// mat1 := &Lambertian{vec1}
	// list << &Sphere{Vec3{-radius,0,-1}, radius, mat1}

	// vec2 := Vec3{1, 0, 0}
	// mat2 := &Lambertian{vec2}
	// list << &Sphere{Vec3{radius,0,-1}, radius, mat2}

	// world := HitableList{list}
	world := random_scene()

	lookfrom := Vec3{12, 2, 4}
	lookat := Vec3{0, 1, 0}
	dist_to_focus := lookfrom.sub(lookat).length()
	aperture := f32(0.2)
	cam := new_camera(lookfrom, lookat, Vec3{0, 1, 0}, 20, f32(nx)/f32(ny), aperture, dist_to_focus)

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
				math.sqrtf(col.e0),
				math.sqrtf(col.e1),
				math.sqrtf(col.e2)
			}
			ir := int(255.99*col.x())
			ig := int(255.99*col.y())
			ib := int(255.99*col.z())

			println('$ir $ig $ib')
		}
	}
}
