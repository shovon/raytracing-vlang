struct Ray {
	a Vec3
	b Vec3
}

fn (r Ray) origin() Vec3 { return r.a }
fn (r Ray) direction() Vec3 { return r.b }
fn (r Ray) point_at_parameter(t f32) Vec3 { return r.a.add(r.b.scalar_mul(t)) }