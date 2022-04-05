import math

fn refract(v Vec3, n Vec3, ni_over_nt f32, mut refracted Vec3) bool {
	uv := v.unit_vector()
	dt := uv.dot(n)
	discriminant := 1.0 - ni_over_nt*ni_over_nt*(1-dt*dt)
	if discriminant > 0 {
		refracted = uv.sub(n.scalar_mul(dt)).scalar_mul(ni_over_nt).sub(n.scalar_mul(f32(math.sqrt(discriminant))))
		return true
	}
	return false
}

struct Dialectric {
	ref_idx f32
}

fn (d Dialectric) scatter(r_in Ray, rec HitRecord, mut attenuation Vec3, mut scattered Ray) bool {
	mut outward_normal := Vec3{}
	reflected := reflect(r_in.direction(), rec.normal)
	mut ni_over_nt := f32(0.0)
	attenuation = Vec3{1.0, 1.0, 0.0}
	mut refracted := Vec3{0, 0, 0}
	if r_in.direction().dot(rec.normal) > 0 {
		outward_normal = rec.normal.scalar_mul(-1)
		ni_over_nt = d.ref_idx
	} else {
		outward_normal = rec.normal
		ni_over_nt = 1.0 / d.ref_idx
	}
	if refract(r_in.direction(), outward_normal, ni_over_nt, mut refracted) {
		scattered = Ray{rec.p, reflected}
	} else {
		scattered = Ray{rec.p, reflected}
		return false
	}
	return true
}
