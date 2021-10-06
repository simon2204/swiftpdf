struct FontMetrics {
	let unitsPerEm: Int
	let ascender: Int
	let descender: Int
	let xMin: Int
	let yMin: Int
	let xMax: Int
	let yMax: Int
	let advanceWidthMax: Int
}

struct Font {
	
	let metrics: FontMetrics?
}
