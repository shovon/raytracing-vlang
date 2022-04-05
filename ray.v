struct Ray {
	a Vec3
	b Vec3
}

fn (v Vec3) origin() Vec3 { return v.a }
fn (v Vec3) direction() Vec3 { return v.b }
fn (v Vec3) point_at_parameter(t f32) { return v.a.add(v.b.scalar_mul(t)) }