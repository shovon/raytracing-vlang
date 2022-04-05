struct Lambertian {
	albedo Vec3
}

fn (l Lambertian) scatter(r_in Ray, rec HitRecord, mut attenuation Vec3, mut scattered Ray) bool {
	target := rec.p.add(rec.normal).add(random_in_unit_sphere())
	scattered = Ray{rec.p, target.sub(rec.p)}
	attenuation = l.albedo
	return true
}
