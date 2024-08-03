using Plots

include("Physiologisch")
phys_time = time_points
phys_tumor = total_cells

include("Radiotherapie")
radio_time = time_points
radio_tumor = total_cells

include("ROCK1 Inhibition")
rock1_time = time_points
rock1_tumor = total_cells

plot(phys_time, phys_tumor, label="Physiological", xlabel="Time in hours", ylabel="tumorsize", title="Tumorsize vs. Time", lw=2)
plot!(radio_time, radio_tumor, label="Radiotherapy", lw=2)
plot!(rock1_time, rock1_tumor, label="ROCK1 Inhibition", lw=2)