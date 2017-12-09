#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as plt
import math
import tempfile

# cos(2 * x) * (sin(2 * x) + 1.5) + cos(x); -2 <= x <= 3; Vienanariu

MIN = -2
MAX = 3
COUNT = 5 # Interpolated point count

def problem_eval_fn(x):
    return math.cos(2 * x) * (math.sin(2 * x) + 1.5) + math.cos(x)

# FINAL PRIVATE

RANGE = range(COUNT+1)

def get_lagrange_poly(interp_points,fn_to_eval):
    def lagrange_poly(eval_point):
        val = 0
        for cur_interp_point in interp_points:
            weight = 1
            # Construct weight
            for other_interp_point in interp_points:
                if other_interp_point != cur_interp_point:
                    weight *= eval_point - other_interp_point
                    weight /= (cur_interp_point - other_interp_point)
            # Function eval
            val += weight*fn_to_eval(cur_interp_point)
        return val 
    return lagrange_poly 

def plot_lagrange_polys(x,n_points_range,lagrange_poly,y_exact,ax):
    lines = []

    # Plot Estimate Fn
    y = [ lagrange_poly(pt) for pt in x ]
    line, = ax.plot(x,y,label="Estimate " + str(n_points_range))
    lines.append(line)

    # Compute diff of estimate and real value 
    error_range = range(0,len(y))
    abs_errors = [ y[i] - y_exact(x[i]) for i in error_range ]
    line, = ax.plot(x,abs_errors,label="Error")
    lines.append(line)

    # Plot Real Fn 
    x_large = np.linspace(MIN,MAX,1000)
    y_arr = np.vectorize(y_exact)(x_large)
    line, = ax.plot(x_large,y_arr,label="Exact Fn")
    lines.append(line)

    return lines

if __name__ == "__main__":
    x = np.linspace(MIN,MAX,1000)
    f1,(ax1,ax2) = plt.subplots(1,2,sharey=True)
    ax1.set_ylim(ymin=-2.5,ymax=3.0)
    ax1.set_title("Equally-Spaced")
    ax1.grid(True)
    ax2.set_title("Chebyshev")
    ax2.grid(True)

    EVEN_SETS = np.linspace(MIN,MAX,COUNT)

    # Equally spaced points
    evenly_spaced_poly = get_lagrange_poly(EVEN_SETS,problem_eval_fn)
    lines = plot_lagrange_polys(x,EVEN_SETS,evenly_spaced_poly,problem_eval_fn,ax1)
    
    # Chebyshev points
    CP_SETS = [ math.cos((float(2*cnt - 1)/(2*COUNT))*math.pi) for cnt in range(1,COUNT+1) ]
    TCP_SETS = [ 0.5*((MAX - MIN)*pt + MIN + MAX) for pt in CP_SETS ]
    chebyshev_point_polys = get_lagrange_poly(TCP_SETS,problem_eval_fn)
    lines = plot_lagrange_polys(x,RANGE,chebyshev_point_polys,problem_eval_fn,ax2)

    f1.legend(lines ,["Points " + str(COUNT), "Error", "Exact Fn"],loc="upper right")

    plt.grid(True)
    plt.savefig("app_1_points_" + str(COUNT)+ ".png")

