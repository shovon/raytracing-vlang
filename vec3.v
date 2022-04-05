import math

struct Vec3 {
mut:
	e []f32
}

fn (v Vec3) x() f32 { return v.e[0] }
fn (v Vec3) y() f32 { return v.e[1] }
fn (v Vec3) z() f32 { return v.e[2] }
fn (v Vec3) r() f32 { return v.e[0] }
fn (v Vec3) g() f32 { return v.e[1] }
fn (v Vec3) b() f32 { return v.e[2] }

fn (v Vec3) get(index int) f32 { return v.e[index] }
fn (mut v Vec3) set(index int, value f32) { v.e[index] = value }

fn (v Vec3) length() f32 {
	return f32(math.sqrt(v.dot(v)))
}
fn (v1 Vec3) add(v2 Vec3) Vec3 {
	return Vec3{[v1.x() + v2.x(), v1.y() + v2.y(), v1.z() + v1.z()]}
}
fn (v1 Vec3) sub(v2 Vec3) Vec3 {
	return Vec3{[v1.x() - v2.x(), v1.y() - v2.y(), v1.z() - v1.z()]}
}
fn (v1 Vec3) div(v2 Vec3) Vec3 {
	return Vec3{[v1.x() / v2.x(), v1.y() / v2.y(), v1.z() / v1.z()]}
}
fn (v1 Vec3) mul(v2 Vec3) Vec3 {
	return Vec3{[v1.x() * v2.x(), v1.y() * v2.y(), v1.z() * v1.z()]}
}
fn (v Vec3) scalar_mul(t f32) Vec3 {
	return Vec3{[v.x() * t, v.y() * t, v.z() * t]}
}
fn (v Vec3) scalar_div(t f32) Vec3 {
	return Vec3{[v.x() / t, v.y() / t, v.z() / t]}
}
fn (v1 Vec3) dot(v2 Vec3) f32 {
	return v1.x()*v2.x() + v1.y()*v2.y() + v1.z()*v2.z()
}
fn (v1 Vec3) cross(v2 Vec3) Vec3 {
	return Vec3{
		[
			v1.y()*v2.z() - v1.z()*v2.y(),
			v1.x()*v2.z() - v1.z()*v2.x(),
			v1.x()*v2.y() - v1.y()*v2.x()
		]
	}
}
fn (v Vec3) unit_vector() Vec3 {
	return v.scalar_div(v.length())
}
