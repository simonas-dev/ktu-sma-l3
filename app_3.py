#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.image as img
from numpy.fft import *
import math

T = math.pi * 2
PI = math.pi

## Signal
def fn_G(t):
  return np.sign((2 * PI) * (t / T)) * math.cos((2 * PI) * ((3 * t) / T)) + 0.1

## Noise
def fn_R(t):
  return 0.05 * math.cos((2 * PI) * ((130 * t) / T)) + 0.018 * math.cos((2 * PI) * ((40 * t) / T)) 

if __name__ == "__main__":
  x = np.linspace(-10,10,1000)

  plt.figure()

  g_vec = np.vectorize(fn_G)(x)
  plt.plot(x, g_vec)

  r_vec = np.vectorize(fn_R)(x)
  plt.plot(x, r_vec)

  N = 1001
  m=(N+1)/2

  yyy=fft(r_vec)/N;
  print yyy
  spektras=abs(2*yyy[1:m])    #harmoniku amplitudes 
  spektras[1]=spektras[1]/2   # pastovi dedamoji 

  plt.plot(range(len(spektras)), spektras)

  spektras_c0=np.real(yyy[1]) # pastovi dedamoji
  spektras_c=np.real(2*yyy[2:m]) # cos amplitudes 
  spektras_s=-np.imag(2*yyy[2:m]) # sin amplitudes

  plt.legend(['G fn(signal)', 'R fn(noise)', 'F fn(fixed)', 'True'],loc='best')
  plt.axis([-10, 10, -1, 1])
  plt.grid(True)
  plt.aa = True
  plt.savefig("app_3.png")

