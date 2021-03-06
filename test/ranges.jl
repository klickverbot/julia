# This file is a part of Julia. License is MIT: http://julialang.org/license

# ranges
@test size(10:1:0) == (0,)
@test length(1:.2:2) == 6
@test length(1.:.2:2.) == 6
@test length(2:-.2:1) == 6
@test length(2.:-.2:1.) == 6
@test length(2:.2:1) == 0
@test length(2.:.2:1.) == 0

@test length(1:0) == 0
@test length(0.0:-0.5) == 0
@test length(1:2:0) == 0
L32 = linspace(Int32(1), Int32(4), 4)
L64 = linspace(Int64(1), Int64(4), 4)
@test L32[1] == 1 && L64[1] == 1
@test L32[2] == 2 && L64[2] == 2
@test L32[3] == 3 && L64[3] == 3
@test L32[4] == 4 && L64[4] == 4

r = 5:-1:1
@test r[1]==5
@test r[2]==4
@test r[3]==3
@test r[4]==2
@test r[5]==1

@test length(.1:.1:.3) == 3
@test length(1.1:1.1:3.3) == 3
@test length(1.1:1.3:3) == 2
@test length(1:1:1.8) == 1

@test (1:5)[1:4] == 1:4
@test (2:6)[1:4] == 2:5
@test (1:6)[2:5] == 2:5
@test typeof((1:6)[2:5]) == typeof(2:5)
@test (1:6)[2:2:5] == 2:2:4
@test typeof((1:6)[2:2:5]) == typeof(2:2:4)
@test (1:2:13)[2:6] == 3:2:11
@test typeof((1:2:13)[2:6]) == typeof(3:2:11)
@test (1:2:13)[2:3:7] == 3:6:13
@test typeof((1:2:13)[2:3:7]) == typeof(3:6:13)

@test isempty((1:4)[5:4])
@test_throws BoundsError (1:10)[8:-1:-2]

let
    span = 5:20
    r = -7:3:42
    @test findin(r, span) == 5:10
    r = 15:-2:-38
    @test findin(r, span) == 1:6
end
#@test isempty(findin(5+0*(1:6), 2:4))
#@test findin(5+0*(1:6), 2:5) == 1:6
#@test findin(5+0*(1:6), 2:7) == 1:6
#@test findin(5+0*(1:6), 5:7) == 1:6
#@test isempty(findin(5+0*(1:6), 6:7))
#@test findin(5+0*(1:6), 5:5) == 1:6

@test reverse(reverse(1:10)) == 1:10

@test reverse(reverse(typemin(Int):typemax(Int))) == typemin(Int):typemax(Int)
@test reverse(reverse(typemin(Int):2:typemax(Int))) == typemin(Int):2:typemax(Int)

@test intersect(1:5, 2:3) == 2:3
@test intersect(-3:5, 2:8) == 2:5
@test intersect(-8:-3, -8:-3) == -8:-3
@test intersect(1:5, 5:13) == 5:5
@test isempty(intersect(-8:-3, -2:2))
@test isempty(intersect(-3:7, 2:1))
@test intersect(1:11, -2:3:15) == 1:3:10
@test intersect(1:11, -2:2:15) == 2:2:10
@test intersect(1:11, -2:1:15) == 1:11
@test intersect(1:11, 15:-1:-2) == 1:11
@test intersect(1:11, 15:-4:-2) == 3:4:11
@test intersect(-20:-5, -10:3:-2) == -10:3:-7
@test isempty(intersect(-5:5, -6:13:20))
@test isempty(intersect(1:11, 15:4:-2))
@test isempty(intersect(11:1, 15:-4:-2))
#@test intersect(-5:5, 1+0*(1:3)) == 1:1
#@test isempty(intersect(-5:5, 6+0*(1:3)))
@test intersect(-15:4:7, -10:-2) == -7:4:-3
@test intersect(13:-2:1, -2:8) == 7:-2:1
@test isempty(intersect(13:2:1, -2:8))
@test isempty(intersect(13:-2:1, 8:-2))
#@test intersect(5+0*(1:4), 2:8) == 5+0*(1:4)
#@test isempty(intersect(5+0*(1:4), -7:3))
@test intersect(0:3:24, 0:4:24) == 0:12:24
@test intersect(0:4:24, 0:3:24) == 0:12:24
@test intersect(0:3:24, 24:-4:0) == 0:12:24
@test intersect(24:-3:0, 0:4:24) == 24:-12:0
@test intersect(24:-3:0, 24:-4:0) == 24:-12:0
@test intersect(1:3:24, 0:4:24) == 4:12:16
@test intersect(0:6:24, 0:4:24) == 0:12:24
@test isempty(intersect(1:6:2400, 0:4:2400))
@test intersect(-51:5:100, -33:7:125) == -26:35:79
@test intersect(-51:5:100, -32:7:125) == -11:35:94
#@test intersect(0:6:24, 6+0*(0:4:24)) == 6:6:6
#@test intersect(12+0*(0:6:24), 0:4:24) == Range(12, 0, 5)
#@test isempty(intersect(6+0*(0:6:24), 0:4:24))
@test intersect(-10:3:24, -10:3:24) == -10:3:23
@test isempty(intersect(-11:3:24, -10:3:24))
@test intersect(typemin(Int):2:typemax(Int),1:10) == 2:2:10
@test intersect(1:10,typemin(Int):2:typemax(Int)) == 2:2:10

@test intersect(reverse(typemin(Int):2:typemax(Int)),typemin(Int):2:typemax(Int)) == reverse(typemin(Int):2:typemax(Int))
@test intersect(typemin(Int):2:typemax(Int),reverse(typemin(Int):2:typemax(Int))) == typemin(Int):2:typemax(Int)

@test 0 in UInt(0):100:typemax(UInt)
@test last(UInt(0):100:typemax(UInt)) in UInt(0):100:typemax(UInt)
@test -9223372036854775790 in -9223372036854775790:100:9223372036854775710
@test -9223372036854775690 in -9223372036854775790:100:9223372036854775710
@test -90 in -9223372036854775790:100:9223372036854775710
@test 10 in -9223372036854775790:100:9223372036854775710
@test 110 in -9223372036854775790:100:9223372036854775710
@test 9223372036854775610 in -9223372036854775790:100:9223372036854775710
@test 9223372036854775710 in -9223372036854775790:100:9223372036854775710


@test !(3.5 in 1:5)
@test (3 in 1:5)
@test (3 in 5:-1:1)
#@test (3 in 3+0*(1:5))
#@test !(4 in 3+0*(1:5))

r = 0.0:0.01:1.0
@test (r[30] in r)
r = (-4*Int64(maxintfloat(is(Int,Int32) ? Float32 : Float64))):5
@test (3 in r)
@test (3.0 in r)

@test !(1 in 1:0)
@test !(1.0 in 1.0:0.0)

# indexing range with empty range (#4309)
@test (3:6)[5:4] == 7:6
@test_throws BoundsError (3:6)[5:5]
@test_throws BoundsError (3:6)[5]
@test (0:2:10)[7:6] == 12:2:10
@test_throws BoundsError (0:2:10)[7:7]

# indexing with negative ranges (#8351)
for a=Range[3:6, 0:2:10], b=Range[0:1, 2:-1:0]
    @test_throws BoundsError a[b]
end

# avoiding intermediate overflow (#5065)
@test length(1:4:typemax(Int)) == div(typemax(Int),4) + 1

# overflow in length
@test_throws OverflowError length(0:typemax(Int))
@test_throws OverflowError length(typemin(Int):typemax(Int))
@test_throws OverflowError length(-1:typemax(Int)-1)

let s = 0
    # loops ending at typemax(Int)
    for i = (typemax(Int)-1):typemax(Int)
        s += 1
        @test s <= 2
    end
    @test s == 2

    s = 0
    for i = (typemax(Int)-2):(typemax(Int)-1)
        s += 1
        @test s <= 2
    end
    @test s == 2

    s = 0
    for i = typemin(Int):(typemin(Int)+1)
        s += 1
        @test s <= 2
    end
    @test s == 2

    # loops covering the full range of smaller integer types
    s = 0
    for i = typemin(UInt8):typemax(UInt8)
        s += 1
    end
    @test s == 256

    # loops past typemax(Int)
    n = 0
    s = Int128(0)
    for i = typemax(UInt64)-2:typemax(UInt64)
        n += 1
        s += i
    end
    @test n == 3
    @test s == 3*Int128(typemax(UInt64)) - 3

    # loops over empty ranges
    s = 0
    for i = 0xff:0x00
        s += 1
    end
    @test s == 0

    s = 0
    for i = Int128(typemax(Int128)):Int128(typemin(Int128))
        s += 1
    end
    @test s == 0
end

# sums of ranges
@test sum(1:100) == 5050
@test sum(0:100) == 5050
@test sum(-100:100) == 0
@test sum(0:2:100) == 2550

# overflowing sums (see #5798)
if WORD_SIZE == 64
    @test sum(Int128(1):10^18) == div(10^18 * (Int128(10^18)+1), 2)
    @test sum(Int128(1):10^18-1) == div(10^18 * (Int128(10^18)-1), 2)
else
    @test sum(Int64(1):10^9) == div(10^9 * (Int64(10^9)+1), 2)
    @test sum(Int64(1):10^9-1) == div(10^9 * (Int64(10^9)-1), 2)
end

# Tricky sums of FloatRange #8272
@test sum(10000.:-0.0001:0) == 5.00000005e11
@test sum(0:0.001:1) == 500.5
@test sum(0:0.000001:1) == 500000.5
@test sum(0:0.1:10) == 505.

# operations with scalars
@test (1:3) - 2 == -1:1
@test (1:3) - 0.25 == 1-0.25:3-0.25
@test (1:3) + 2 == 3:5
@test (1:3) + 0.25 == 1+0.25:3+0.25
@test (1:2:6) + 1 == 2:2:6
@test (1:2:6) + 0.3 == 1+0.3:2:5+0.3
@test (1:2:6) - 1 == 0:2:4
@test (1:2:6) - 0.3 == 1-0.3:2:5-0.3

# operations between ranges and arrays
@test all(([1:5;] + (5:-1:1)) .== 6)
@test all(((5:-1:1) + [1:5;]) .== 6)
@test all(([1:5;] - (1:5)) .== 0)
@test all(((1:5) - [1:5;]) .== 0)

# tricky floating-point ranges

@test [0.1:0.1:0.3;]   == [linspace(0.1,0.3,3);]     == [1:3;]./10
@test [0.0:0.1:0.3;]   == [linspace(0.0,0.3,4);]     == [0:3;]./10
@test [0.3:-0.1:-0.1;] == [linspace(0.3,-0.1,5);]    == [3:-1:-1;]./10
@test [0.1:-0.1:-0.3;] == [linspace(0.1,-0.3,5);]    == [1:-1:-3;]./10
@test [0.0:0.1:1.0;]   == [linspace(0.0,1.0,11);]    == [0:10;]./10
@test [0.0:-0.1:1.0;]  == [linspace(0.0,1.0,0);]     == []
@test [0.0:0.1:-1.0;]  == [linspace(0.0,-1.0,0);]    == []
@test [0.0:-0.1:-1.0;] == [linspace(0.0,-1.0,11);]   == [0:-1:-10;]./10
@test [1.0:1/49:27.0;] == [linspace(1.0,27.0,1275);] == [49:1323;]./49
@test [0.0:0.7:2.1;]   == [linspace(0.0,2.1,4);]     == [0:7:21;]./10
@test [0.0:1.1:3.3;]   == [linspace(0.0,3.3,4);]     == [0:11:33;]./10
@test [0.1:1.1:3.4;]   == [linspace(0.1,3.4,4);]     == [1:11:34;]./10
@test [0.0:1.3:3.9;]   == [linspace(0.0,3.9,4);]     == [0:13:39;]./10
@test [0.1:1.3:4.0;]   == [linspace(0.1,4.0,4);]     == [1:13:40;]./10
@test [1.1:1.1:3.3;]   == [linspace(1.1,3.3,3);]     == [11:11:33;]./10
@test [0.3:0.1:1.1;]   == [linspace(0.3,1.1,9);]     == [3:1:11;]./10
@test [0.0:1.0:0.0;]   == [linspace(0.0,0.0,1);]     == [0.0]
@test [0.0:-1.0:0.0;]  == [linspace(0.0,0.0,1);]     == [0.0]

@test [0.0:1.0:5.5;]   == [0:10:55;]./10
@test [0.0:-1.0:0.5;]  == []
@test [0.0:1.0:0.5;]   == [0.0]

@test [prevfloat(0.1):0.1:0.3;] == [prevfloat(0.1), 0.2, 0.3]
@test [nextfloat(0.1):0.1:0.3;] == [nextfloat(0.1), 0.2]
@test [prevfloat(0.0):0.1:0.3;] == [prevfloat(0.0), 0.1, 0.2]
@test [nextfloat(0.0):0.1:0.3;] == [nextfloat(0.0), 0.1, 0.2]
@test [0.1:0.1:prevfloat(0.3);] == [0.1, 0.2]
@test [0.1:0.1:nextfloat(0.3);] == [0.1, 0.2, nextfloat(0.3)]
@test [0.0:0.1:prevfloat(0.3);] == [0.0, 0.1, 0.2]
@test [0.0:0.1:nextfloat(0.3);] == [0.0, 0.1, 0.2, nextfloat(0.3)]
@test [0.1:prevfloat(0.1):0.3;] == [0.1, 0.2, 0.3]
@test [0.1:nextfloat(0.1):0.3;] == [0.1, 0.2]
@test [0.0:prevfloat(0.1):0.3;] == [0.0, prevfloat(0.1), prevfloat(0.2), 0.3]
@test [0.0:nextfloat(0.1):0.3;] == [0.0, nextfloat(0.1), nextfloat(0.2)]

for T = (Float32, Float64,),# BigFloat),
    a = -5:25, s = [-5:-1;1:25;], d = 1:25, n = -1:15
    den   = convert(T,d)
    start = convert(T,a)/den
    step  = convert(T,s)/den
    stop  = convert(T,(a+(n-1)*s))/den
    vals  = T[a:s:a+(n-1)*s;]./den
    r = start:step:stop
    @test [r;] == vals
    @test [linspace(start, stop, length(r));] == vals
    # issue #7420
    n = length(r)
    @test [r[1:n];] == [r;]
    @test [r[2:n];] == [r;][2:end]
    @test [r[1:3:n];] == [r;][1:3:n]
    @test [r[2:2:n];] == [r;][2:2:n]
    @test [r[n:-1:2];] == [r;][n:-1:2]
    @test [r[n:-2:1];] == [r;][n:-2:1]
end

# linspace & ranges with very small endpoints
for T = (Float32, Float64)
    z = zero(T)
    u = eps(z)
    @test first(linspace(u,u,0)) == u
    @test last(linspace(u,u,0)) == u
    @test first(linspace(-u,u,0)) == -u
    @test last(linspace(-u,u,0)) == u
    @test [linspace(-u,u,0);] == []
    @test [linspace(-u,-u,1);] == [-u]
    @test [linspace(-u,u,2);] == [-u,u]
    @test [linspace(-u,u,3);] == [-u,0,u]
    @test [linspace(-u,u,4);] == [-u,0,0,u]
    @test [linspace(-u,u,4);][2] === -z
    @test [linspace(-u,u,4);][3] === z
    @test first(linspace(-u,-u,0)) == -u
    @test last(linspace(-u,-u,0)) == -u
    @test first(linspace(u,-u,0)) == u
    @test last(linspace(u,-u,0)) == -u
    @test [linspace(u,-u,0);] == []
    @test [linspace(u,u,1);] == [u]
    @test [linspace(u,-u,2);] == [u,-u]
    @test [linspace(u,-u,3);] == [u,0,-u]
    @test [linspace(u,-u,4);] == [u,0,0,-u]
    @test [linspace(u,-u,4);][2] === z
    @test [linspace(u,-u,4);][3] === -z
    v = [linspace(-u,u,12);]
    @test length(v) == 12
    @test issorted(v) && unique(v) == [-u,0,0,u]
    @test [-3u:u:3u;] == [linspace(-3u,3u,7);] == [-3:3;].*u
    @test [3u:-u:-3u;] == [linspace(3u,-3u,7);] == [3:-1:-3;].*u
end

# linspace with very large endpoints
for T = (Float32, Float64)
    a = realmax()
    for i = 1:5
        @test [linspace(a,a,1);] == [a]
        @test [linspace(-a,-a,1);] == [-a]
        b = realmax()
        for j = 1:5
            @test [linspace(-a,b,0);] == []
            @test [linspace(-a,b,2);] == [-a,b]
            @test [linspace(-a,b,3);] == [-a,(b-a)/2,b]
            @test [linspace(a,-b,0);] == []
            @test [linspace(a,-b,2);] == [a,-b]
            @test [linspace(a,-b,3);] == [a,(a-b)/2,-b]
            for c = maxintfloat(T)-3:maxintfloat(T)
                s = linspace(-a,b,c)
                @test first(s) == -a
                @test last(s) == b
                c <= typemax(Int) && @test length(s) == c
                @test s.len == c
                s = linspace(a,-b,c)
                @test first(s) == a
                @test last(s) == -b
                c <= typemax(Int) && @test length(s) == c
                @test s.len == c
            end
            b = prevfloat(b)
        end
        a = prevfloat(a)
    end
end

# near-equal ranges
@test 0.0:0.1:1.0 != 0.0f0:0.1f0:1.0f0

# comparing and hashing ranges
let
    Rs = Range[1:2, map(Int32,1:3:17), map(Int64,1:3:17), 1:0, 17:-3:0,
               0.0:0.1:1.0, map(Float32,0.0:0.1:1.0),
               linspace(0, 1, 20), map(Float32, linspace(0, 1, 20))]
    for r in Rs
        ar = collect(r)
        @test r != ar
        @test !isequal(r,ar)
        for s in Rs
            as = collect(s)
            @test !isequal(r,s) || hash(r)==hash(s)
            @test (r==s) == (ar==as)
        end
    end
end

# issue #2959
@test 1.0:1.5 == 1.0:1.0:1.5 == 1.0:1.0
#@test 1.0:(.3-.1)/.1 == 1.0:2.0

let r = typemin(Int64):2:typemax(Int64), s = typemax(Int64):-2:typemin(Int64)
    @test first(r) == typemin(Int64)
    @test last(r) == (typemax(Int64)-1)
    @test_throws OverflowError length(r)

    @test first(s) == typemax(Int64)
    @test last(s) == (typemin(Int64)+1)
    @test_throws OverflowError length(s)
end

@test length(typemin(Int64):3:typemax(Int64)) == 6148914691236517206
@test length(typemax(Int64):-3:typemin(Int64)) == 6148914691236517206

for s in 3:100
    @test length(typemin(Int):s:typemax(Int)) == length(big(typemin(Int)):big(s):big(typemax(Int)))
    @test length(typemax(Int):-s:typemin(Int)) == length(big(typemax(Int)):big(-s):big(typemin(Int)))
end

@test length(UInt(1):UInt(1):UInt(0)) == 0
@test length(typemax(UInt):UInt(1):(typemax(UInt)-1)) == 0
@test length(typemax(UInt):UInt(2):(typemax(UInt)-1)) == 0
@test length((typemin(Int)+3):5:(typemin(Int)+1)) == 0

# issue #6364
@test length((1:64)*(pi/5)) == 64

# issue #6973
let r1 = 1.0:0.1:2.0, r2 = 1.0f0:0.2f0:3.0f0, r3 = 1:2:21
    @test r1 + r1 == 2*r1
    @test r1 + r2 == 2.0:0.3:5.0
    @test (r1 + r2) - r2 == r1
    @test r1 + r3 == convert(FloatRange{Float64}, r3) + r1
    @test r3 + r3 == 2 * r3
end

# issue #7114
r = -0.004532318104333742:1.2597349521122731e-5:0.008065031416788989
@test length(r[1:end-1]) == length(r) - 1
@test isa(r[1:2:end],Range) && length(r[1:2:end]) == div(length(r)+1, 2)
@test_approx_eq r[3:5][2] r[4]
@test_approx_eq r[5:-2:1][2] r[3]
@test_throws BoundsError r[0:10]
@test_throws BoundsError r[1:10000]

r = linspace(1/3,5/7,6)
@test length(r) == 6
@test r[1] == 1/3
@test abs(r[end] - 5/7) <= eps(5/7)
r = linspace(0.25,0.25,1)
@test length(r) == 1
@test_throws Exception linspace(0.25,0.5,1)

# issue #7426
@test [typemax(Int):1:typemax(Int);] == [typemax(Int)]

#issue #7484
r7484 = 0.1:0.1:1
@test [reverse(r7484);] == reverse([r7484;])

# issue #7387
for r in (0:1, 0.0:1.0)
    @test r+im == [r;]+im
    @test r-im == [r;]-im
    @test r*im == [r;]*im
    @test r/im == [r;]/im
end

# issue #7709
@test length(map(identity, 0x01:0x05)) == 5
@test length(map(identity, 0x0001:0x0005)) == 5
@test length(map(identity, UInt64(1):UInt64(5))) == 5
@test length(map(identity, UInt128(1):UInt128(5))) == 5

# mean/median
for f in (mean, median)
    for n = 2:5
        @test f(2:n) == f([2:n;])
        @test_approx_eq f(2:0.1:n) f([2:0.1:n;])
    end
end

# issue #8531
let smallint = (Int === Int64 ?
                (Int8,UInt8,Int16,UInt16,Int32,UInt32) :
                (Int8,UInt8,Int16,UInt16))
    for T in smallint
        @test length(typemin(T):typemax(T)) == 2^(8*sizeof(T))
    end
end

# issue #8584
@test (0:1//2:2)[1:2:3] == 0:1//1:1

# issue #12278
@test length(1:UInt(0)) == 0

# zip
let i = 0
x = 1:2:8
y = 2:2:8
xy = 1:8
for (thisx, thisy) in zip(x, y)
    @test thisx == xy[i+=1]
    @test thisy == xy[i+=1]
end
end

# issue #9962
@test eltype(0:1//3:10) <: Rational
@test (0:1//3:10)[1] == 0
@test (0:1//3:10)[2] == 1//3

# converting ranges (issue #10965)
@test promote(0:1, UInt8(2):UInt8(5)) === (0:1, 2:5)
@test convert(UnitRange{Int}, 0:5) === 0:5
@test convert(UnitRange{Int128}, 0:5) === Int128(0):Int128(5)

@test promote(0:1:1, UInt8(2):UInt8(1):UInt8(5)) === (0:1:1, 2:1:5)
@test convert(StepRange{Int,Int}, 0:1:1) === 0:1:1
@test convert(StepRange{Int128,Int128}, 0:1:1) === Int128(0):Int128(1):Int128(1)

@test promote(0:1:1, 2:5) === (0:1:1, 2:1:5)
@test convert(StepRange{Int128,Int128}, 0:5) === Int128(0):Int128(1):Int128(5)
@test convert(StepRange, 0:5) === 0:1:5
@test convert(StepRange{Int128,Int128}, 0.:5) === Int128(0):Int128(1):Int128(5)

@test promote(0f0:inv(3f0):1f0, 0.:2.:5.) === (0:1/3:1, 0.:2.:5.)
@test convert(FloatRange{Float64}, 0:1/3:1) === 0:1/3:1
@test convert(FloatRange{Float64}, 0f0:inv(3f0):1f0) === 0:1/3:1

@test promote(0:1/3:1, 0:5) === (0:1/3:1, 0.:1.:5.)
@test convert(FloatRange{Float64}, 0:5) === 0.:1.:5.
@test convert(FloatRange{Float64}, 0:1:5) === 0.:1.:5.
@test convert(FloatRange, 0:5) === 0.:1.:5.
@test convert(FloatRange, 0:1:5) === 0.:1.:5.

# Issue #11245
let io = IOBuffer()
    show(io, linspace(1, 2, 3))
    str = takebuf_string(io)
    @test str == "linspace(1.0,2.0,3)"
end

# issue 10950
r = 1//2:3
@test length(r) == 3
i = 1
for x in r
    @test x == i//2
    i += 2
end
@test i == 7

# stringmime/writemime should display the range or linspace nicely
# to test print_range in range.jl
replstr(x) = stringmime("text/plain", x)
@test replstr(1:4) == "4-element UnitRange{$Int}:\n 1,2,3,4"
@test replstr(linspace(1,5,7)) == "7-element LinSpace{Float64}:\n 1.0,1.66667,2.33333,3.0,3.66667,4.33333,5.0"
@test replstr(0:100.) == "101-element FloatRange{Float64}:\n 0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,…,94.0,95.0,96.0,97.0,98.0,99.0,100.0"
# next is to test a very large range, which should be fast because print_range
# only examines spacing of the left and right edges of the range, sufficient
# to cover the designated screen size.
@test replstr(0:10^9) == "1000000001-element UnitRange{$Int}:\n 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,…,999999998,999999999,1000000000"

# Issue 11049 and related
@test promote(linspace(0f0, 1f0, 3), linspace(0., 5., 2)) ===
    (linspace(0., 1., 3), linspace(0., 5., 2))
@test convert(LinSpace{Float64}, linspace(0., 1., 3)) === linspace(0., 1., 3)
@test convert(LinSpace{Float64}, linspace(0f0, 1f0, 3)) === linspace(0., 1., 3)

@test promote(linspace(0., 1., 3), 0:5) === (linspace(0., 1., 3),
                                             linspace(0., 5., 6))
@test convert(LinSpace{Float64}, 0:5) === linspace(0., 5., 6)
@test convert(LinSpace{Float64}, 0:1:5) === linspace(0., 5., 6)
@test convert(LinSpace, 0:5) === linspace(0., 5., 6)
@test convert(LinSpace, 0:1:5) === linspace(0., 5., 6)

function test_range_index(r, s)
    @test typeof(r[s]) == typeof(r)
    @test [r;][s] == [r[s];]
end
test_range_index(linspace(0.1, 0.3, 3), 1:2)
test_range_index(linspace(0.1, 0.3, 3), 1:0)
test_range_index(linspace(1.0, 1.0, 1), 1:1)
test_range_index(linspace(1.0, 1.0, 1), 1:0)
test_range_index(linspace(1.0, 2.0, 0), 1:0)

function test_linspace_identity{T}(r::LinSpace{T}, mr::LinSpace{T})
    @test -r == mr
    @test -collect(r) == collect(mr)
    @test isa(-r, LinSpace)

    @test 1 + r + (-1) == r
    @test 1 + collect(r) == collect(1 + r) == collect(r + 1)
    @test isa(1 + r + (-1), LinSpace)
    @test 1 - r - 1 == mr
    @test 1 - collect(r) == collect(1 - r) == collect(1 + mr)
    @test collect(r) - 1 == collect(r - 1) == -collect(mr + 1)
    @test isa(1 - r - 1, LinSpace)

    @test 1 * r * 1 == r
    @test 2 * r * T(0.5) == r
    @test isa(1 * r * 1, LinSpace)
    @test r / 1 == r
    @test r / 2 * 2 == r
    @test r / T(0.5) * T(0.5) == r
    @test isa(r / 1, LinSpace)

    @test (2 * collect(r) == collect(r * 2) == collect(2 * r) ==
           collect(r * T(2.0)) == collect(T(2.0) * r) ==
           collect(r / T(0.5)) == -collect(mr * T(2.0)))
end

test_linspace_identity(linspace(1.0, 27.0, 10), linspace(-1.0, -27.0, 10))
test_linspace_identity(linspace(1f0, 27f0, 10), linspace(-1f0, -27f0, 10))

test_linspace_identity(linspace(1.0, 27.0, 0), linspace(-1.0, -27.0, 0))
test_linspace_identity(linspace(1f0, 27f0, 0), linspace(-1f0, -27f0, 0))

test_linspace_identity(linspace(1.0, 1.0, 1), linspace(-1.0, -1.0, 1))
test_linspace_identity(linspace(1f0, 1f0, 1), linspace(-1f0, -1f0, 1))

@test reverse(linspace(1.0, 27.0, 1275)) == linspace(27.0, 1.0, 1275)
@test [reverse(linspace(1.0, 27.0, 1275));] ==
    reverse([linspace(1.0, 27.0, 1275);])

# PR 12200 and related
for _r in (1:2:100, 1:100, 1f0:2f0:100f0, 1.0:2.0:100.0,
           linspace(1, 100, 10), linspace(1f0, 100f0, 10))
    float_r = float(_r)
    big_r = big(_r)
    @test typeof(big_r).name === typeof(_r).name
    if eltype(_r) <: AbstractFloat
        @test isa(float_r, typeof(_r))
        @test eltype(big_r) === BigFloat
    else
        @test isa(float_r, Range)
        @test eltype(float_r) <: AbstractFloat
        @test eltype(big_r) === BigInt
    end
end

@test_throws DimensionMismatch linspace(1.,5.,5) + linspace(1.,5.,6)
@test_throws DimensionMismatch linspace(1.,5.,5) - linspace(1.,5.,6)
@test_throws DimensionMismatch linspace(1.,5.,5) .* linspace(1.,5.,6)
@test_throws DimensionMismatch linspace(1.,5.,5) ./ linspace(1.,5.,6)

@test_throws DimensionMismatch (1:5) + (1:6)
@test_throws DimensionMismatch (1:5) - (1:6)
@test_throws DimensionMismatch (1:5) .* (1:6)
@test_throws DimensionMismatch (1:5) ./ (1:6)

@test_throws DimensionMismatch (1.:5.) + (1.:6.)
@test_throws DimensionMismatch (1.:5.) - (1.:6.)
@test_throws DimensionMismatch (1.:5.) .* (1.:6.)
@test_throws DimensionMismatch (1.:5.) ./ (1.:6.)

function test_range_sum_diff(r1, r2, r_sum, r_diff)
    @test r1 + r2 == r_sum
    @test r2 + r1 == r_sum
    @test r1 - r2 == r_diff
    @test r2 - r1 == -r_diff

    @test collect(r1) + collect(r2) == collect(r_sum)
    @test collect(r2) + collect(r1) == collect(r_sum)
    @test collect(r1) - collect(r2) == collect(r_diff)
    @test collect(r2) - collect(r1) == collect(-r_diff)
end

test_range_sum_diff(1:5, 0:2:8, 1:3:13, 1:-1:-3)
test_range_sum_diff(1.:5., 0.:2.:8., 1.:3.:13., 1.:-1.:-3.)
test_range_sum_diff(linspace(1.,5.,5), linspace(0.,-4.,5),
                    linspace(1.,1.,5), linspace(1.,9.,5))

test_range_sum_diff(1:5, 0.:2.:8., 1.:3.:13., 1.:-1.:-3.)
test_range_sum_diff(1:5, linspace(0, 8, 5),
                    linspace(1, 13, 5), linspace(1, -3, 5))
test_range_sum_diff(1.:5., linspace(0, 8, 5),
                    linspace(1, 13, 5), linspace(1, -3, 5))

# Issue #12388
let r = 0x02:0x05
    @test r[2:3] == 0x03:0x04
end

# Issue #13738
for r in (big(1):big(2), UInt128(1):UInt128(2), 0x1:0x2)
    rr = r[r]
    @test typeof(rr) == typeof(r)
    @test r[r] == r
    # these calls to similar must not throw:
    @test size(similar(r, size(r))) == size(similar(r, length(r)))
end
