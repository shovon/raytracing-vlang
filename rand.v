import rand

fn rand_f32_min_max(min f32, max f32) f32 {
	return min + rand.f32() * (max - min)
}
