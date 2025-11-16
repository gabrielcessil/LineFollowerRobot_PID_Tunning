# Control System Optimization for a Line-Following Robot

## Overview

This project implements a comprehensive optimization framework for tuning a PID controller applied to a line-following robot. The system employs both Genetic Algorithm (GA) and Simulated Annealing (SA) optimization techniques to find optimal controller parameters that minimize tracking errors across multiple test tracks.

## Theoretical Methodology

### Control System Design

The system employs a PID controller with the following structure:

**Control Law:**


Where:
- `Kp`, `Ki`, `Kd` are the proportional, integral, and derivative gains respectively
- `e(t)` is the tracking error at time t

The set controller commands the wheel motors, affecting two error aspects:
1. **Rotational error**: Angular deviation from the reference path
2. **Translational error**: Positional deviation from the reference path

### Optimization Approach

The optimization problem is formulated as:

**Objective:** Minimize J(Kp, Ki, Kd) = w_rot * J_rot + w_trans * J_trans

Where:
- J_rot = ∫ f(e_rot(t), t) dt
- J_trans = ∫ f(e_trans(t), t) dt
- w_rot, w_trans are weighting factors (0.4 and 0.3 respectively)
- f(·) is a cost function (ITSE - Integral of Time multiplied by Squared Error)

## Simulation Environment

The simulation environment consists of:

1. **Six different tracks** for comprehensive testing
2. **Complete dynamical model** including:
   - Electrical motor dynamics
   - Mechanical system dynamics
   - Sensor quantization effects
   - Sampling limitations

3. **Performance metrics**:
   - Maximum expected rotation error: π/2 rad
   - Maximum expected translation error: 0.2 m
   - Infeasibility thresholds (for early termination):
     - Rotation: π rad
     - Translation: 10 m

## Code Structure

### Main Functions

#### Optimization Drivers
- `rodaGA(fitfcn)`: Executes Genetic Algorithm optimization
- `rodaSA(xInit, fitfcn)`: Executes Simulated Annealing optimization

#### Simulation Functions
- `SimulaModeloCompleto(solucao, Pista)`: Runs complete simulation
- `SimulaModelo(solucao, Pista)`: Runs simplified simulation
- `fcusto_completa(x)`: Complete cost function for optimization

#### Setup Functions
- `setupSimulinkConstantes()`: Defines system constants
- `setupSimulinkSolucao(solucao, Pista)`: Configures solution parameters
- `setupGA()`: Configures Genetic Algorithm parameters
- `setupSA(xInit)`: Configures Simulated Annealing parameters

#### Validation
- `ValidaResultado(solucao)`: Tests and validates a solution
- `TestaResultado(solucao)`: Tests results and generates plots

### Inputs and Outputs


#### Plant Model Inputs

The system is a differential-driven robot, where the differential tension on the motor make the car rotate while the offset applied to both motor make the car go straight. The car's physics is built in Simulink as modelled by: Dhaouadi, Rached, and A. Abu Hatab. *"Dynamic modelling of differential-drive mobile robots using lagrange and newton-euler methodologies: A unified framework."* Advances in robotics & automation 2.2 (2013): 1-7.

The following parameters must be set in  `setupSimulinkConstantes.m`:

##### Mechanical Properties
- Wheel radius (R): 0.05 m
- Distance between wheels/2 (L): 0.1 m
- Distance from wheel axis to center of mass (d): 0.01 m
- Moment of inertia (J): 0.0015 kg·m²
- Total mass (M): 0.25 kg
- Gear reduction ratio (N): 30:1

##### Electrical Properties
- Armature resistance (Ra): 5 mΩ
- Armature inductance (La): 1 μH
- Back EMF constant (Kb): 0.4 V·s/rad
- Torque constant (Kt): 0.4 N·m/A
- Converter gain (Kc): 4 V/V
- Average controller voltage (Va_med): 2.5 V

##### Sensor System
- Angular quantization interval: π/16 rad
- Sampling time: 0.01 s

Observation: Many Line-Following cars do not have angular levels equally distributed, for example, when the sensors are placed in a rectangular/straight board or when the sensors are closer in the central part of the car.  

#### Optimization Inputs
- `solucao`: Vector [Kp, Ki, Kd] containing controller parameters
- `Pista`: Integer (0-6) specifying which track to simulate
  - 0: Validation track (used in `ValidaResultado`)
  - 1-6: Training tracks (used in optimization)

#### Simulation Outputs
- `teta_ref`, `teta_out`: Reference and actual rotation angles
- `pos_ref`, `pos_out`: Reference and actual positions (2D)
- `erro_rot`, `erro_trans`: Rotation and translation errors
- `tempo`: Time vector for simulation data

#### Optimization Outputs
- `xFinal`: Optimized solution vector [Kp, Ki, Kd]
- `fval`: Final objective function value
- `exitFlag`: Optimization termination reason
- `output`: Optimization process information




## Usage Guide

### Running Optimization

1. **Genetic Algorithm**:
```matlab
% Define cost function
fitfcn = @fcusto_completa;

% Run optimization
optimized_params = rodaGA(fitfcn);
```
2. **Simulated Annealing**:
```matlab
% Define initial guess and cost function
xInit = [1000, 1000, 1000];
fitfcn = @fcusto_completa;

% Run optimization
optimized_params = rodaSA(xInit, fitfcn);
```


```matlab
% Test a solution
TestaResultado([Kp, Ki, Kd]);

% Validate results comprehensively
ValidaResultado([Kp, Ki, Kd]);
```

# Configuration
## The system behavior can be modified by adjusting constants in `setupSimulinkConstantes()`:

 - Simulation time (simuTime): Default 27 seconds, must be long enough for a complete lap.  

 - Cost function formula (custoFormula): Default 'itse'

 - Error weights (peso_Rotacao, peso_Translacao)

 - Performance thresholds (erroMax_rotacao, erroMax_translacao)

## The Optimization can be modified by the following parameters:
### Genetic Algorithm
 - Population size: How many solutions are evaluated and compared in each step/generation (Ex: 30) 

 - Maximum generations: How many times it generates new solutions, compares them, and takes the best ones (Ex: 20)

 - Maximum time: Timeout to avoid exhaustive search (Ex: 6 hours) 

 - Bounds: Minimmum and Maximmum controller grains (Ex: [0, 0, 0] to [10000, 10000, 10000])

 - Selection: Method to select the best solutions in a population, i.e, the ones that remain to the next generation (Ex: Roulette wheel)

 - Crossover: Method to exchange informations that compose two solutions, creating a combination of them. (Ex: Heuristic)

 - Mutation: Mehtod to randomly change the solution's parameters, creating new ones (Adaptive feasible)

### Simulated Annealing
 - Temperature decay: The way that the temperature that drives the acception probability decays (Ex: Exponential)

 - Initial temperature: Automatically calculated

 - Reannealing: Every 1/5 of maximum iterations

 - Bounds: Minimum and Maximum controller grains (Ex: [0, 0, 0] to [10000, 10000, 10000])

# Implementation Notes
 - The simulation employs normalized errors relative to expected maximum values

 - Infeasible solutions (early termination) receive infinite cost

 - The complete cost function evaluates performance across all six tracks

 - Results validation includes both numerical metrics and graphical plots

 - The optimization process includes visualization of convergence metrics

# Detailed Function Documentation

## setupSimulinkConstantes()
Defines all constants used in the simulation model.

**Constants Set:**
- Mechanical parameters (R, M, L, d, J, N)
- Electrical parameters (Ra, La, Kb, Kt, Kc, Va_med)
- Simulation parameters (simuTime)
- Cost function parameters (custoFormula, peso_Translacao, peso_Rotacao)
- Performance thresholds (erroMax_translacao, erroMax_rotacao)
- Infeasibility thresholds (erroInviavel_translacao, erroInviavel_rotacao)
- Control parameters (intervalo_quantizacao_sensor, tempo_de_amostragem)

## setupSimulinkSolucao(solucao, Pista)
Configures the solution parameters for simulation.

**Parameters:**
- `solucao`: Vector containing [Kp, Ki, Kd] controller gains
- `Pista`: Integer specifying which track to simulate (0-6)

## setupGA()
Configures the Genetic Algorithm optimization parameters.

**Returns:**
- `options`: Optimization options structure
- `lowBound`: Lower bounds for parameters [Kp, Ki, Kd]
- `highBound`: Upper bounds for parameters [Kp, Ki, Kd]

**Algorithm Settings:**
- PopulationSize: 30
- MaxGenerations: 20
- MaxTime: 6 hours
- Bounds: [0, 0, 0] to [10000, 10000, 10000]
- Selection: Roulette wheel
- Crossover: Heuristic
- Mutation: Adaptive feasible

## setupSA(xInit)
Configures the Simulated Annealing optimization parameters.

**Parameters:**
- `xInit`: Initial solution vector [Kp, Ki, Kd]

**Returns:**
- `options`: Optimization options structure
- `lowBound`: Lower bounds for parameters
- `highBound`: Upper bounds for parameters

**Algorithm Settings:**
- Temperature decay: Exponential
- Initial temperature: Automatically calculated based on energy variation
- Reannealing interval: 1/5 of maximum iterations
- Bounds: Unconstrained ([-Inf, -Inf, -Inf] to [Inf, Inf, Inf])

## rodaGA(fitfcn)
Executes the Genetic Algorithm optimization.

**Parameters:**
- `fitfcn`: Handle to the fitness function (typically @fcusto_completa)

**Returns:**
- `xFinal`: Optimized solution vector [Kp, Ki, Kd]

## rodaSA(xInit, fitfcn)
Executes the Simulated Annealing optimization.

**Parameters:**
- `xInit`: Initial solution vector [Kp, Ki, Kd]
- `fitfcn`: Handle to the fitness function (typically @fcusto_completa)

**Returns:**
- `xFinal`: Optimized solution vector [Kp, Ki, Kd]
- `fval`: Final objective function value
- `exitFlag`: Optimization termination reason
- `output`: Optimization process information

## fcusto_completa(x)
Complete cost function for optimization evaluates performance across all six tracks.

**Parameters:**
- `x`: Solution vector [Kp, Ki, Kd]

**Returns:**
- `custo`: Total cost value (sum of costs across all tracks)

**Process:**
1. For each track (1-6), runs simulation with given parameters
2. Calculates rotation and translation costs using ITSE formula
3. Applies weighting factors (0.4 for rotation, 0.3 for translation)
4. Returns Inf for infeasible solutions (early termination)

## SimulaModeloCompleto(solucao, Pista)
Runs the complete simulation model.

**Parameters:**
- `solucao`: Solution vector [Kp, Ki, Kd]
- `Pista`: Track selection (0-6)

**Returns:**
- `teta_ref`, `teta_out`: Reference and actual rotation angles
- `pos_ref`, `pos_out`: Reference and actual positions
- `erro_rot`, `erro_trans`: Rotation and translation errors
- `tempo`: Time vector

## ValidaResultado(solucao)
Comprehensive validation of a solution.

**Parameters:**
- `solucao`: Solution vector [Kp, Ki, Kd] to validate

**Output:**
- Displays numerical performance metrics
- Generates plots of rotational response and positional tracking
- Provides cost breakdown (rotation cost, translation cost, total cost)

# Practical Examples

## Example 1: Basic Optimization with GA
```matlab
% Set up the optimization
fitfcn = @fcusto_completa;

% Run Genetic Algorithm optimization
optimized_params = rodaGA(fitfcn);

% Validate the results
ValidaResultado(optimized_params);
```

## Example 2: Optimization with Simulated Annealing

```matlab
% Set initial guess
initial_guess = [1000, 500, 200];

% Set up the optimization
fitfcn = @fcusto_completa;

% Run Simulated Annealing optimization
[optimized_params, cost, exitflag, output] = rodaSA(initial_guess, fitfcn);

% Display optimization results
disp('Optimized parameters:');
disp(['Kp = ', num2str(optimized_params(1))]);
disp(['Ki = ', num2str(optimized_params(2))]);
disp(['Kd = ', num2str(optimized_params(3))]);
disp(['Final cost: ', num2str(cost)]);
disp(['Exit condition: ', num2str(exitflag)]);

% Validate the results
TestaResultado(optimized_params);
```

## Example 3: Testing a Specific Controller Design

```matlab
% Test a specific controller design
test_params = [1500, 800, 300];

% Run comprehensive validation
ValidaResultado(test_params);

% Test on a specific track
Pista = 3; % Track 3
[teta_ref, teta_out, pos_ref, pos_out, erro_rot, erro_trans, tempo] = ...
    SimulaModeloCompleto(test_params, Pista);

% Plot results
figure;
subplot(2,1,1);
plot(tempo, teta_ref, 'b--', tempo, teta_out, 'r-');
legend('Reference', 'Actual');
title('Rotational Response');
xlabel('Time (s)');
ylabel('Angle (rad)');

subplot(2,1,2);
plot(pos_ref(1,:), pos_ref(2,:), 'b--', pos_out(1,:), pos_out(2,:), 'r-');
legend('Reference', 'Actual');
title('Position Tracking');
xlabel('X Position (m)');
ylabel('Y Position (m)');
axis equal;
```


Performance Tips
For initial testing, use the simplified model:
```matlab
% Use simplified simulation for faster evaluation
[teta_ref, teta_out, pos_ref, pos_out, erro_rot, erro_trans, tempo] = SimulaModelo(solucao, Pista);
```

Custom Cost Functions
You can implement custom cost functions by modifying the calculation in CalculaCusto.m:

```matlab
function custo = CalculaCusto(erro, tempo, formula)
    switch formula
        case 'itse' % Integral of Time multiplied by Squared Error
            custo = trapz(tempo, tempo .* erro.^2);
        case 'ise'  % Integral of Squared Error
            custo = trapz(tempo, erro.^2);
        case 'iae'  % Integral of Absolute Error
            custo = trapz(tempo, abs(erro));
        case 'itae' % Integral of Time multiplied by Absolute Error
            custo = trapz(tempo, tempo .* abs(erro));
        otherwise
            error('Unknown cost formula: %s', formula);
    end
end
```

## Adding New Tracks
To add a new track to the simulation environment:

1. Create the track definition in the Simulink model
2. Update the track selection mechanism in setupSimulinkSolucao.m
3. Modify fcusto_completa.m to include the new track in the optimization loop

### Step-by-Step Guide:

**1. Adding Track Definition in Simulink Model:**
- Open the Simulink model (ModeloCompleto.slx or Modelo.slx)
- Locate the track generation subsystem
- Add a new case to the track selection switch block:
```matlab
case 7  % New track ID
    % Define your track parameters here
    track_geometry = [x1, y1; x2, y2; ...; xn, yn]; % Coordinates
    track_curvature = [c1, c2, ..., cn]; % Curvature values
    track_speed_profile = [v1, v2, ..., vn]; % Speed profile
```

2. Modifying setupSimulinkSolucao.m:

Update the Pista parameter validation:

```matlab
function setupSimulinkSolucao(solucao, Pista)
    % Validate track selection
    if Pista < 0 || Pista > 7  % Updated from 6 to 7
        error('Pista must be between 0 and 7');
    end
    
    % Existing code...
    assignin('base', 'Pista', Pista);
end
```

3. Updating fcusto_completa.m:

Extend the loop to include the new track:

```matlab
function custo = fcusto_completa(x) 
    % Existing code...
    for i = 1:7  % Changed from 6 to 7
        Pista = i;
        % Simulation and cost calculation...
    end
end
```

4. Creating Track Configuration File (Optional):
Create a separate function to manage track parameters:

```matlab
function track_params = getTrackParameters(Pista)
    switch Pista
        case 1
            % Existing track 1 parameters
        case 2
            % Existing track 2 parameters
        % ... existing cases ...
        case 7
            track_params.name = 'NewCustomTrack';
            track_params.geometry = [0,0; 10,5; 20,2; 30,8]; % Example coordinates
            track_params.max_speed = 2.5; % m/s
            track_params.curvature_limit = 0.15; % Maximum curvature
        otherwise
            error('Invalid track selection');
    end
end
```

5. Validation and Testing:
After adding the new track, validate its performance:

```matlab
% Test the new track specifically
test_solution = [Kp, Ki, Kd];
Pista = 7; % New track ID

% Run simulation
[teta_ref, teta_out, pos_ref, pos_out, erro_rot, erro_trans, tempo] = ...
    SimulaModeloCompleto(test_solution, Pista);

% Analyze results
figure;
plot(pos_ref(1,:), pos_ref(2,:), 'b-', pos_out(1,:), pos_out(2,:), 'r--');
title('New Track Performance');
legend('Reference Path', 'Actual Path');
xlabel('X Position (m)');
ylabel('Y Position (m)');
grid on;
```

Track Design Considerations:

 - Ensure smooth curvature transitions to avoid controller instability, for example, ramp or parabolic change in angular reference.

 - Maintain reasonable maximum curvature values

 - Consider adding varying difficulty levels (straight sections, sharp turns, S-curves)

## Discussions and Limitation:

The simulation of the car and controller could be done in proper software as ROS or others. However, this simplistic Matlab enables to customizations easily in the controller and optimization process. Here, we approximate the error signal, since the main objective of this work is to tune the car controller, and such tuned controlled can be resimulated in other environments for validation. So this approach is beneficial to the development with proper validation.


The approximation is that the angular reference signal changes independent to the car action. The angular reference changes with a preset timing, not accounting on the car. For example, the car can move perpendicular to the line, but the signal of a curve will happen even though the car is far away not following the line anymore. We can visualize this approximation as not following a statical line in the ground, but as blindly mimicking the angular signal coming from a reference car that follows the line perfectly. 

With this, we expect that the better the designed controller is able to follow the dynamic of the this refence car, the better the controller will be when finally following the physical line or in the validation simulation in ROS or others.




## File Dependencies
The implementation uses the following dependency structure:

## Prerequisites

 - MATLAB R2018b or later

 - Simulink

 - Global Optimization Toolbox

 - Control System Toolbox
