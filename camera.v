import math

struct Camera {
	origin Vec3
	lower_left_corner Vec3
	horizontal Vec3
	vertical Vec3
}

fn new_camera(lookfrom Vec3, lookat Vec3, vup Vec3, vfov f32, aspect f32) Camera {
	mut u := Vec3{}
	mut v := Vec3{}
	mut w := Vec3{}

	theta := vfov*math.pi/180
	half_height := f32(math.tan(theta/2))
	half_width := aspect * half_height

	origin := lookfrom

	w = lookfrom.sub(lookat).unit_vector()
	u = vup.cross(w).unit_vector()
	v = w.cross(u)

	mut lower_left_corner := Vec3{-half_width, -half_height, -1.0}
	lower_left_corner = origin
		.sub(u.scalar_mul(half_width))
		.sub(v.scalar_mul(half_height))
		.sub(w)
	
	horizontal := u.scalar_mul(2 * half_width)
	vertical := v.scalar_mul(2 * half_height)

	return Camera{
		origin,
		lower_left_corner,
		horizontal,
		vertical
	}
}

fn (c Camera) get_ray(u f32, v f32) Ray {
	return Ray{
		c.origin,
		c.lower_left_corner
			.add(c.horizontal.scalar_mul(u))
			.add(c.vertical.scalar_mul(v))
			.sub(c.origin)
	}
}
