interface Material {
	scatter(r_in Ray, rec HitRecord, mut attenuation Vec3, mut scattered Ray) bool
}