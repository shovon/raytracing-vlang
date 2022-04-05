import math
import rand

struct Vec3 {
mut:
	e0 f32
	e1 f32
	e2 f32
}

fn random_vec3() Vec3 {
	return Vec3{rand.f32(), rand.f32(), rand.f32()}
}

fn random_vec3_min_max(min f32, max f32) Vec3 {
	return Vec3{
		rand_f32_min_max(min, max),
		rand_f32_min_max(min, max),
		rand_f32_min_max(min, max)
	}
}

fn random_in_unit_sphere() Vec3 {
	mut p := Vec3{}
	for {
		p = random_vec3_min_max(-1, 1)
		if p.dot(p) >= 1 {
			continue
		}
		break
	}
	return p
}

fn (v Vec3) x() f32 { return v.e0 }
fn (v Vec3) y() f32 { return v.e1 }
fn (v Vec3) z() f32 { return v.e2 }
fn (v Vec3) r() f32 { return v.e0 }
fn (v Vec3) g() f32 { return v.e1 }
fn (v Vec3) b() f32 { return v.e2 }

fn (v Vec3) length() f32 {
	return f32(math.sqrt(v.dot(v)))
}
fn (v1 Vec3) add(v2 Vec3) Vec3 {
	return Vec3{v1.x() + v2.x(), v1.y() + v2.y(), v1.z() + v2.z()}
}
fn (v1 Vec3) sub(v2 Vec3) Vec3 {
	return Vec3{v1.x() - v2.x(), v1.y() - v2.y(), v1.z() - v2.z()}
}
fn (v1 Vec3) div(v2 Vec3) Vec3 {
	return Vec3{v1.x() / v2.x(), v1.y() / v2.y(), v1.z() / v2.z()}
}
fn (v1 Vec3) mul(v2 Vec3) Vec3 {
	return Vec3{v1.x() * v2.x(), v1.y() * v2.y(), v1.z() * v2.z()}
}
fn (v Vec3) scalar_mul(t f32) Vec3 {
	return Vec3{v.x() * t, v.y() * t, v.z() * t}
}
fn (v Vec3) scalar_div(t f32) Vec3 {
	return Vec3{v.x() / t, v.y() / t, v.z() / t}
}
fn (v1 Vec3) dot(v2 Vec3) f32 {
	return v1.x()*v2.x() + v1.y()*v2.y() + v1.z()*v2.z()
}
fn (v1 Vec3) cross(v2 Vec3) Vec3 {
	return Vec3{
			v1.y()*v2.z() - v1.z()*v2.y(),
			v1.x()*v2.z() - v1.z()*v2.x(),
			v1.x()*v2.y() - v1.y()*v2.x()
	}
}
fn (v Vec3) unit_vector() Vec3 {
	return v.scalar_div(v.length())
}
