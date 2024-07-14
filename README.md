# ALEMO: Machine Learning-Accelerated Multi-Objective Design of Fractured Geothermal Systems

[Guodong Chen](https://scholar.google.com/citations?user=U2YFkAgAAAAJ&hl=zh-TW&oi=ao), [Jiu Jimmy Jiao*](https://scholar.google.com/citations?user=t7zybZUAAAAJ&hl=zh-TW&oi=ao), [Qiqi Liu](https://scholar.google.com.hk/citations?user=BDKEG8QAAAAJ&hl=en&oi=ao), [Zhongzheng Wang](https://scholar.google.com.hk/citations?user=WSH0zQsAAAAJ&hl=en&oi=ao), [Yaochu Jin](https://scholar.google.com.hk/citations?user=B5WAkz4AAAAJ&hl=en&oi=ao)

We propose an Active Learning enhanced Evolutionary Multi-objective Optimization (ALEMO) algorithm, integrated with hydrothermal simulations in fractured media, to enable efficient optimization of fractured geothermal systems using few model evaluations. We demonstrate its effectiveness by conducting extensive experimental tests of the integrated framework, including multi-objective benchmark functions, a fractured geothermal model and a large-scale enhanced geothermal system. Results demonstrate that the ALEMO approach achieves a remarkable reduction in required simulations, with a speed-up of 1-2 orders of magnitude (10-100 times faster), thereby enabling accelerated decision-making.

This file provides the instruction of the software operation to reproduce the figures&results of our work “Machine Learning-Accelerated Discovery of Optimal Multi-Objective Fractured Geothermal System Design”.
## Installation


1. Operation software of evolutionary computation.
   Software: MATLAB R2021a
   The source code has been tested on MATLAB R2021a and it could work normally. Note that, the other MATLAB versions may have unexpected problems, probably due to different specifications or versions of system functions.

2. Evolutionary multi-objective optimization platform.
   The open-source evolutionary multi-objective optimization platform PlatEMO is publicly available at https://github.com/BIMK/PlatEMO. Experiments on multi-objective benchmark functions are conducted on the platform.

3. Simulation software.
   Software: COMSOL (COMSOL Multiphysics with MATLAB) and open-source software packages MATLAB Reservoir Simulation Toolbox (MRST) for reservoir modelling and simulation is publicly available at https://www.sintef.no/projectweb/mrst/.

Workflow of ALEMO:

![Workflow of ALEMO](https://github.com/JellyChen7/ALEMO/raw/main/Assets/Fig_1.png "Workflow of ALEMO")

Framework of ALEMO:

![Framework of ALEMO](https://github.com/JellyChen7/ALEMO/raw/main/Assets/Fig_2.png "Framework of ALEMO")

Accelerated multi-objective fractured geothermal energy system design results:

![results](https://github.com/JellyChen7/ALEMO/raw/main/Assets/Fig4.jpg "results")

Accelerated discovery of optimal field-scale multi-objective fractured geothermal energy system design:

![system design](https://github.com/JellyChen7/ALEMO/raw/main/Assets/Fig5.jpg "system design")




## Citation
If you find our work and/or our code useful, please cite us via:

```bibtex
@article{Chen2024,
  title={Machine Learning-Accelerated Discovery of Optimal Multi-Objective Fractured Geothermal System Design},
  author={Guodong Chen and Jiu Jimmy Jiao and Qiqi Liu and Zhongzheng Wang and Yaochu Jin},
  year={2024}
}
```
