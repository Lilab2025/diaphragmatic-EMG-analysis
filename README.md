##dEMG Analysis
Reads and normalizes raw diaphragm EMG (dEMG) recordings, then extracts respiratory parameters including burst frequency, burst duration, and burst amplitude using the dEMG_analysis pipeline. The functions butterworth_filter and find_burst_duration are called internally for signal filtering and burst detection.
##Contour Maps
Generates signal density maps and contour plots based on image intensity, allowing visualization of spatial signal distributions.
##PMN Heatmap
Constructs spatiotemporal heatmaps of spinal cord neuronal activity based on dEMG recordings, enabling visualization of firing patterns across time and spinal segments.
##Cluster Plot
Visualizes the effects of different neuronal subpopulations on respiratory parameters, facilitating comparisons of their contributions to distinct respiratory outputs.
