using Plots

include("Physiologisch")
phys_time = time_points
phys_tumor = total_cells
EP_Phys = state1_hits

include("Radiotherapie")
radio_time = time_points
radio_tumor = total_cells
EP_radio = state1_hits

include("ROCK1 Inhibition")
rock1_time = time_points
rock1_tumor = total_cells
EP_rock1 = state1_hits

plot1 = plot(phys_time, phys_tumor, label="Physiological", xlabel="Time in hours", ylabel="Tumorsize", title="Tumorsize vs. Time", lw=2)
plot!(radio_time, radio_tumor, label="Radiotherapy", lw=2)
plot!(rock1_time, rock1_tumor, label="ROCK1 Inhibition", lw=2)


plot2 = plot(phys_time, EP_Phys, label="Physiological", xlabel="Time in hours", ylabel="# of EP's", title="# of EP's vs. Time", lw=2)
plot!(radio_time, EP_radio, label="Radiotherapy", lw=2)
plot!(rock1_time, EP_rock1, label="ROCK1 Inhibition", lw=2)

display(plot1)
display(plot2)