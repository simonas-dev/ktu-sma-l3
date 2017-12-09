#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.image as img
import math
from scipy import interpolate


if __name__ == "__main__":

  image_mat = img.imread("masina_20.png")
  x_len = len(image_mat)
  y_len = len(image_mat[0])
  b_w_mat = np.zeros((x_len, y_len))

  # Parse image into binary white and black pixel martix.
  for r_index, row in enumerate(image_mat):
    for c_index, col in enumerate(row):
      # white pixel
      if (np.sum(col) > 2.5):
        b_w_mat[r_index][c_index] = 1
      # black pixel
      else:
        b_w_mat[r_index][c_index] = 0

  # Transpose so Martix rows and cols would switch places.
  b_w_mat = b_w_mat.T

  edge_arr = np.zeros((y_len))

  edge_hit_arr = []

  print("x: " + str(len(b_w_mat)))
  print("y: " + str(len(b_w_mat[0])))

  STEP_SIZE = 10

  for y_index in range(y_len-1, 0, -STEP_SIZE):
    for x_index in range(0, x_len):
      # car edge hit
      # Martix is transposed
      if (b_w_mat[y_index][x_index] == 0):
        # Martix is transposed
        # And Y axis is counted down from MAX to MIN
        edge_hit_arr.append((y_index, x_len - x_index))
        break

  edge_hit_arr = np.array(edge_hit_arr)

  # MAGIC SOURCE https://github.com/kawache/Python-B-spline-examples

  x=edge_hit_arr[:,0]
  y=edge_hit_arr[:,1]

  # Find the B-spline representation of an N-dimensional curve.
  #
  # PARAMS
  # k - Degree of the spline. Cubic splines are recommended.
  # Even values of k should be avoided especially with
  # a small s-value. 1 <= k <= 5, default is 3.
  #
  # s - A smoothing condition.
  #
  # RETURN
  # u - An array of the values of the parameter.
  #
  # tck - knots, coefficients, and degree of the spline.
  #
  tck, u = interpolate.splprep([x,y], k=3, s=0)
  u=np.linspace(0, 1, num=50, endpoint=True)

  # Evaluate a B-spline or its derivatives.
  # Given the knots and coefficients of a B-spline representation, evaluate the
  # value of thesmoothing polynomial and its derivatives. This is a wrapper
  # around the FORTRAN routines splev and splder of FITPACK.
  #
  # PARAMS
  # u - A 1-D array of points at which to return the value of the smoothed 
  # spline or its derivatives. If tck was returned from splprep, then the 
  # parameter values, u should be given.
  #
  # tck - A sequence of length 3 returned by splrep or splprep containing the
  # knots, coefficients, and degree of the spline.
  # 
  # RETURN
  # out - An array of values representing the spline function evaluated at
  # the points in x. If tck was returned from splprep, then this is a list
  # of arrays representing the curve in N-dimensional space.
  #
  print tck
  out = interpolate.splev(u, tck)

  plt.figure()
  plt.plot(x, y, 'ro', out[0], out[1], 'b')
  plt.legend(['Points', 'Interpolated B-spline', 'True'],loc='best')
  plt.axis([0, y_len, 0, x_len])
  plt.title('B-Spline interpolation')
  plt.grid(True)
  plt.aa = True
  plt.savefig("app_2_points.png")