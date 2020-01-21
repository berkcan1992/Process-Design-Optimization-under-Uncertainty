# Process-Design-Optimization-under-Uncertainty
This paper develops a computational framework to optimize the process parameters such that the bond quality between extruded polymer filaments is maximized in fused filament fabrication (FFF). A one-dimensional heat transfer analysis providing an estimate of the temperature profile of the filaments is coupled with a sintering neck growth model to assess the bond quality that occurs at the interfaces between adjacent filaments. Predicting the variability in the FFF process is essential for achieving proactive quality control of the manufactured part; however, the models used to predict the variability are affected by assumptions and approximations. This paper systematically quantifies the uncertainty in the bond quality model prediction due to various sources of uncertainty, both aleatory and epistemic, and includes the uncertainty in the process parameter optimization. Variance-based sensitivity analysis based on Sobol' indices is used to quantify the relative contributions of the different uncertainty sources to the uncertainty in the bond quality. A Gaussian process (GP) surrogate model is constructed to compute and include the model error within the optimization. Physical experiments are conducted to show that the proposed formulation for process parameter optimization under uncertainty results in high bond quality between adjoining filaments of the FFF product.
