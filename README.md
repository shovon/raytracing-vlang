# Ray Tracing in One Weekend in V

![Output from ray tracing](/output.png)

This is a ray tracing implementation in V, pretty much a re-implementation of an [earlier attempt](https://github.com/shovon/raytracing-golang) in Go

All implementation was translated from the minibook _[Ray Tracing In One Weekend](https://www.amazon.ca/Ray-Tracing-Weekend-Minibooks-Book-ebook/dp/B01B5AODD8)_. The book opted for C++, but I figured a good way to try out V.

## Running the ray tracer

Be sure to have [V](https://vlang.io/) installed. Then, from this directory, just run:

```
v . -prod
./raytracer-vlang run . > img.ppm
```

The program outputs portable pixmap format to the console/stdout, and so, the `>` symbol writes the output to a file.

Rendering a whole 1024 by 576 image takes around an 3 minutes on my 2019 M1 MacBook Pro. If you want something rendered quicker, change the `nx` and `ny` variables in `main()`, in `main.v` to something smaller than 1024 by 576 (perhaps 200 and 100, respectively).
