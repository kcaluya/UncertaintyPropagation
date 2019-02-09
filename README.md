# User Guide

## Introduction 

This is a Fokker-Planck-Kolmogorov PDE solver for 1D Ornstein Uhlenbeck System and 
a 2D Potential Nonlinear System.

**NOTE**: This solver only supports the above systems currently. There is on-going work on applications to more general systems.


## Example:

This are a sample plots for a 1D system. The required inputs are explained below in further details.

The use is recommended to edit the file Main.m to see the entire file and change some of the inputs. 

The first figure creates 6 subplots of the transient PDFs at different time specified by the user. 
![1DLinearSystem](Figs/Ex1DLinear.jpg)

The second figure compares the analytical mean with the numerical mean.
![1DLinearSystem](Figs/ExMean1D.jpg)

The third figure compares the analytical variance with the numerical variance.
![1DLinearSystem](Figs/ExVariance1D.jpg)

The last figure plots the transients in one plot. 
![1DLinearSystem](Figs/TransientPlot.jpg)




