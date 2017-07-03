"""
Generate data for better
understanding alternative
routes to GaMD
author: Steven(Yuhang) Wang
date: 07/01/2017
license: MIT/X11
"""
import numpy
import os


def LJ(x, eps=4, sigma=1):
    """Return Lennard-Jones potential"""
    r = sigma/x
    return 4*eps*(numpy.power(r, 12) - numpy.power(r, 6))


def raw(n, start=0.99, stop=3):
    """Return (x, y)"""
    x = numpy.linspace(start, stop, num=n)
    y = LJ(x)
    return (x, y)


def flatten(const_y, E):
    """
    flatten out the potential under threshold E
    """
    y = numpy.copy(const_y)
    ids = numpy.argwhere(y <= E)
    y[ids] += (E - y[ids])
    return y


def squared(const_y, E):
    y = numpy.copy(const_y)
    ids = numpy.argwhere(y <= E)
    y[ids] += (E - y[ids])**2
    return y


def dampened(const_y, E, k):
    y = numpy.copy(const_y)
    ids = numpy.argwhere(y <= E)
    y[ids] += k * (E - y[ids])**2
    return y


def combine(xs):
    return numpy.vstack(xs).T

def main():
    n = 200
    E = -2
    x, y = raw(n)
    f_out1 = os.path.join("data", "raw.data")
    numpy.savetxt(f_out1, combine((x, y)))

    f_out2 = os.path.join("data", "flat.data")
    numpy.savetxt(f_out2, combine((x, flatten(y, E))))


    f_out3 = os.path.join("data", "squared.data")
    numpy.savetxt(f_out3, combine((x, squared(y, E))))


    for k in [0.5, 0.4, 0.3, 0.2, 0.1]:
        f_out4 = os.path.join("data", "dampened_{}.data".format(k))
        numpy.savetxt(f_out4, combine((x, dampened(y, E, k))))

if __name__ == '__main__':
    main()