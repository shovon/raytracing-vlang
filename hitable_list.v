struct HitableList {
	list []Hitable
}

fn (h HitableList) hit(r Ray, t_min f32, t_max f32, mut rec HitRecord) bool {
	mut temp_rec := HitRecord{}
	mut hit_anything := false
	closest_so_far := f64(t_max)
	for i := 0; i < h.list.len; i++ {
		if h.list[i].hit(r, t_min, closest_so_far, temp_rec) {
			hit_anything = true
			closest_so_far = temp_rec.t
			rec = temp_rec
		}
	}
	return hit_anything
}
