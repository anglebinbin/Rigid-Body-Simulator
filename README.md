# Rigid-Body-Simulator
This is a simple rigid body simulator, an assignment for the course 3D Modeling and Simulation in UMass Amherst.

## Part 1: Plane Pendulum
We use a plane pendulum model to implement 3 basic integration methods: Euler's Method, Improved Euler's Method and Runge-Kutte Integation Method.
From the animation and the plot, we can compare the performance of these 3 methods.

## Part 2: Simple Rigid Body Simulator
We implement a basic simulation model in file "simulation.m". 
There are 2 tori in the model, the orange one is still as a reference and the yellow one moves under linear forces or torques.
We use the simplest Euler's Integration Method here. You can modify the parameters and generate an animation in avi format.
The demo "demo.avi" shows the result of the yellow torus' flight with random external forces and torques.
