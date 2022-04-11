# Ray Tracing in One Weekend in V

![Output from ray tracing](/output.png)

This is a ray tracing implementation in V, pretty much a re-implementation of an [earlier attempt](https://github.com/shovon/raytracing-golang) in Go

All implementation was translated from the minibook _[Ray Tracing In One Weekend](https://www.amazon.ca/Ray-Tracing-Weekend-Minibooks-Book-ebook/dp/B01B5AODD8)_. The book opted for C++, but I figured a good way to try out V.

## Running the ray tracer

Be sure to have [V](https://vlang.io/) installed. Then, from this directory, just run:

```
v . -prod
./raytracing-vlang run . > img.ppm
```

The program outputs portable pixmap format to the console/stdout, and so, the `>` symbol writes the output to a file.

Rendering a whole 1024 by 576 image takes around an 3 minutes, 10 seconds on my 2020 M1 MacBook Pro. If you want something rendered quicker, change the `nx` and `ny` variables in `main()`, in `main.v` to something smaller than 1024 by 576 (perhaps 200 and 100, respectively).

### Even more optimization

You can use link-time optimization (LTO) and profiler-guided optimization (PGO) to make things even faster. I managed to shave the render time down from ~3:10, down to ~2:50, on the same 2020 M1 MacBook Pro.

Here are the steps.

**1. Transpile (rather than compile) the program to C**

```shell
v . -o raytracing-vlang.c
```

**2. Compile the program, with PGO instrumentation added to the binary (NOT THE FINAL BUILD!)**

```shell
clang \
  -D_DEFAULT_SOURCE \
  -DNDEBUG \
  -O3 \
  -flto \
  -fprofile-instr-generate \
  raytracing-vlang.c -o raytracing-vlang
```

**3. Run the program a bunch of times**

I ran it 4 times, but the more the merrier

```shell
LLVM_PROFILE_FILE="raytracing-vlang-%p.profraw" ./raytracing-vlang > /dev/null
```

**4. Merge the profiler data**

```shell
xcrun \
  llvm-profdata merge \
  -output=raytracing-vlang.profdata \
  raytracing-vlang-*.profraw
```

**5. Tell clang to optimize according to whatever profiler data that was collected**

```shell
clang \
 -D_DEFAULT_SOURCE \
 -DNDEBUG \
 -O3 \
 -flto \
 -fprofile-instr-use=raytracing-vlang.profdata \
 raytracing-vlang.c -o raytracing-vlang
```

**6. Run the program like usual**

```shell
./raytracing-vlang run . > img.ppm
```
