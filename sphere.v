import math

struct Sphere {
mut:
	center Vec3
	radius f32
}

fn (s Sphere) hit(r Ray, t_min f32, t_max f32, mut rec HitRecord) bool {
	oc := r.origin().sub(s.center)
	a := r.direction().dot(r.direction())
	b := oc.dot(r.direction())
	c := oc.dot(oc) - s.radius * s.radius
	discriminant := b*b - a*c
	if discriminant > 0 {
		mut temp := -b - math.sqrt((b*b) - (a*c))/a
		if temp < t_max && temp > t_min {
			rec.t = f32(temp)
			rec.p = r.point_at_parameter(rec.t)
			rec.normal = rec.p.sub(s.center).scalar_div(s.radius)
			return true
		}
		temp = (-b + math.sqrt((b*b) - (a*c)))/a
		if temp < t_max && temp > t_min {
			rec.t = f32(temp)
			rec.p = r.point_at_parameter(rec.t)
			rec.normal = rec.p.sub(s.center).scalar_div(s.radius)
			return true
		}
	}
	return false
}
