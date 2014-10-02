set terminal postscript


a               = 19486.7 
u               = 10.1206 
o               = 0.680603
a1              = 11600.6 
u1              = 10.5469 
o1              = 2.06621 
a2              = -2146.35
u2              = 11.3069 
o2              = 0.311625

f(x) = a * (.5 + .5 * erf((log(x) - u) / (sqrt(2) * o))) + a1 * (.5 + .5 * erf((log(x) - u1) / (sqrt(2) * o1))) + a2 * (.5 + .5 * erf((log(x) - u2) / (sqrt(2) * o2)))

fit f(x) "car-walk" using 1:0 via a, u, o, a1, u1, o1

set logscale x
plot "car-walk" using 1:0 with dots, f(x)
unset logscale x

print a, u, o, a1, u1, o1

# f(x) is vehicle rank of intersection with vehicle volume x




g(x) = a3 * (.5 + .5 * erf((x - u3) / (sqrt(2) * o3)))

a3               = 6.24312e+07 
u3               = 16164.3     
o3               = 8294.44    

fit g(x) "car-walk-sum" using 0:4 via a3, u3, o3

plot "car-walk-sum" using 0:4, g(x)

print a3, u3, o3

# g(x) is accumulation of pedestrian volume at intersections with vehicle rank x and below



h(x) = a3 / (o3 * sqrt(2 * pi)) * exp(- (x - u3) ** 2 / (2 * o3 ** 2))

set logscale xy
set xrange [1000:200000]
set yrange [10:100000]
plot "car-walk" using 1:4 with dots, h(f(x)) lt 3


# h(x) is pedestrian volume at intersections with vehicle volume x
