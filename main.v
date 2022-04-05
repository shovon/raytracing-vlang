fn main() {
	nx := 200
	ny := 100

	print('P3\n$nx $ny\n255\n')

	for j := ny-1; j >= 0; j-- {
		for i := 0; i < nx; i++ {
			col := Vec3{[f32(i) / f32(nx), f32(j) / f32(ny), 0.2]}
			ir := int(255.99*col.r())
			ig := int(255.99*col.g())
			ib := int(255.99*col.b())
			println('$ir $ig $ib')
		}
	}
}