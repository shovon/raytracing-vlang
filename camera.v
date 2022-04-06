import math

struct Camera {
	origin Vec3
	lower_left_corner Vec3
	horizontal Vec3
	vertical Vec3
}

fn new_camera(vfov f32, aspect f32) Camera {
	theta := vfov*math.pi/180
	half_height := f32(math.tan(theta/2))
	half_width := aspect * half_height

	return Camera{
		Vec3{0, 0, 0},
		Vec3{-half_width, -half_height, -1.0},
		Vec3{2*half_width, 0, 0},
		Vec3{0, 2*half_height, 0}
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
