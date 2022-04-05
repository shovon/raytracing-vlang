fn reflect(v Vec3, n Vec3) Vec3 {
	return v.sub(n.scalar_mul(2 * v.dot(n)))
}

struct Metal {
	albedo Vec3
	fuzz f32
}

fn (l Metal) scatter(r_in Ray, rec HitRecord, mut attenuation Vec3, mut scattered Ray) bool {
	reflected := reflect(r_in.direction().unit_vector(), rec.normal)
	scattered = Ray{rec.p, reflected.add(random_in_unit_sphere().scalar_mul(l.fuzz))}
	attenuation = l.albedo
	return true
}
