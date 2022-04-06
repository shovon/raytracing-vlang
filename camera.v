import math

struct Camera {
	origin Vec3
	lower_left_corner Vec3
	horizontal Vec3
	vertical Vec3
	u Vec3
	v Vec3
	w Vec3
	lens_radius f32
}

fn new_camera(lookfrom Vec3, lookat Vec3, vup Vec3, vfov f32, aspect f32, aperture f32, focus_dist f32) Camera {
	lens_radius := aperture / 2

	theta := vfov*math.pi/180
	half_height := f32(math.tan(theta/2))
	half_width := aspect * half_height

	origin := lookfrom

	w := lookfrom.sub(lookat).unit_vector()
	u := vup.cross(w).unit_vector()
	v := w.cross(u)

	mut lower_left_corner := Vec3{-half_width, -half_height, -1.0}
	lower_left_corner = origin
		.sub(u.scalar_mul(half_width * focus_dist))
		.sub(v.scalar_mul(half_height * focus_dist))
		.sub(w.scalar_mul(focus_dist))
	
	horizontal := u.scalar_mul(2 * half_width * focus_dist)
	vertical := v.scalar_mul(2 * half_height * focus_dist)

	return Camera{
		origin,
		lower_left_corner,
		horizontal,
		vertical,
		u,
		v,
		w,
		lens_radius
	}
}

fn (c Camera) get_ray(u f32, v f32) Ray {
	rd := random_in_unit_sphere().scalar_mul(c.lens_radius)
	offset := c.u.scalar_mul(rd.x()).add(c.v.scalar_mul(rd.y()))

	return Ray{
		c.origin.add(offset),
		c.lower_left_corner
			.add(c.horizontal.scalar_mul(u))
			.add(c.vertical.scalar_mul(v))
			.sub(c.origin)
			.sub(offset)
	}
}
