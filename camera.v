struct Camera {
	origin Vec3
	lower_left_corner Vec3
	horizontal Vec3
	vertical Vec3
}

fn new_camera() Camera {
	return Camera{
		Vec3{0, 0, 0},
		Vec3{-2, -1, -1},
		Vec3{4, 0, 0},
		Vec3{0, 2, 0}
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
