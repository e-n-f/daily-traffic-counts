set terminal postscript


a               = 21875.9
u               = 10.1276
o               = 0.673317
a1              = 4426.42
u1              = 8.70235
o1              = 1.29859

f(x) = a * (.5 + .5 * erf((log(x) - u) / (sqrt(2) * o))) + a1 * (.5 + .5 * erf((log(x) - u1) / (sqrt(2) * o1)))

fit f(x) "car-walk" using 1:0 via a, u, o, a1, u1, o1

set logscale x
plot "car-walk" using 1:0, f(x)
unset logscale x

print a, u, o, a1, u1, o1




g(x) = a3 * (.5 + .5 * erf((x - u3) / (sqrt(2) * o3)))

a3               = 6.24312e+07 
u3               = 16164.3     
o3               = 8294.44    

fit g(x) "car-walk-sum" using 0:4 via a3, u3, o3

plot "car-walk-sum" using 0:4, g(x)

print a3, u3, o3



h(x) = a3 / (o3 * sqrt(2 * pi)) * exp(- (x - u3) ** 2 / (2 * o3 ** 2))

set logscale y
plot "car-walk" using 1:4 with dots, h(f(x)) lt 3
