fn reflect(v Vec3, n Vec3) Vec3 {
	return v.sub(n.scalar_mul(2 * v.dot(n)))
}

struct Metal {
	albedo Vec3
}

fn (l Metal) scatter(r_in Ray, rec HitRecord, mut attenuation Vec3, mut scattered Ray) bool {
	reflected := reflect(r_in.direction().unit_vector(), rec.normal)
	scattered = Ray{rec.p, reflected}
	attenuation = l.albedo
	return true
}
