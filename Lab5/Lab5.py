import time
import serial
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import sys, math

# Number of lines to keep in the serial viewer
MAX_SERIAL_LINES = 10

# Global variables to store the latest measurements
t_ref = 0.01
t_mea = 0.01
vp_ref = 0
vp_mea = 0
phase  = 0

# Buffer for recent serial lines
lines_buffer = []

def on_close_figure(event):
    sys.exit(0)

def update(frame):
    global t_ref, t_mea, vp_ref, vp_mea, phase, lines_buffer
    
    # Read and decode serial data
    try:
        strin = ser.readline()
        line_str = strin.decode("utf-8").rstrip()  # remove trailing newline
        if line_str:
            # Store the line in our buffer
            lines_buffer.append(line_str)
            # Keep only the last MAX_SERIAL_LINES
            if len(lines_buffer) > MAX_SERIAL_LINES:
                lines_buffer.pop(0)
        
        # Attempt to parse the data if there are at least 5 values
        datain = line_str.split(",")
        if len(datain) >= 5:
            t_ref = float(datain[0])
            t_mea = float(datain[1])
            vp_ref = float(datain[2])
            vp_mea = float(datain[3])
            phase = float(datain[4])
    except Exception as e:
        # If there's an error (e.g., bad formatting), ignore and move on
        pass
    
    # Generate waveforms based on the new data
    y_ref = vp_ref * np.cos(2 * np.pi / t_ref * x)
    y_mea = vp_mea * np.cos(2 * np.pi / t_ref * x - phase * np.pi / 180)
    y_ref_rms = len(x) * [vp_ref / np.sqrt(2)]
    y_mea_rms = len(x) * [vp_mea / np.sqrt(2)]
    
    # Update waveform lines
    line1.set_data(x, y_ref)
    line2.set_data(x, y_mea)
    line3.set_data(x, y_ref_rms)
    line4.set_data(x, y_mea_rms)
    
    # Update measurement info text
    if phase < -360:
        line2.set_alpha(0)
        text_info.set_text(
            f"Measurements\n\n"
            f"Frequencies:\n"
            f"Freq_ref:  {1/t_ref:.3f} Hz\n"
            f"Freq_mea:  {1/t_mea:.3f} Hz\n\n"
            f"Voltages (peak):\n"
            f"Vp_ref: {vp_ref:.2f} V\n"
            f"Vp_mea: {vp_mea:.2f} V\n\n"
            f"Voltages (rms):\n"
            f"Vr_ref: {vp_ref/np.sqrt(2):.2f} V\n"
            f"Vr_mea: {vp_mea/np.sqrt(2):.2f} V\n\n"
            f"Phase Difference:\n"
            f"Phase:  Nah"
        )
    else:
        line2.set_alpha(1)
        text_info.set_text(
            f"Measurements\n\n"
            f"Frequencies:\n"
            f"Freq_ref:  {1/t_ref:.3f} Hz\n"
            f"Freq_mea:  {1/t_mea:.3f} Hz\n\n"
            f"Voltages (peak):\n"
            f"Vp_ref: {vp_ref:.2f} V\n"
            f"Vp_mea: {vp_mea:.2f} V\n\n"
            f"Voltages (rms):\n"
            f"Vr_ref: {vp_ref/np.sqrt(2):.2f} V\n"
            f"Vr_mea: {vp_mea/np.sqrt(2):.2f} V\n\n"
            f"Phase Difference:\n"
            f"Phase:  {phase}°"
        )
    
    # Update serial viewer text (show the last lines read)
    text_serial.set_text("Serial Data (last 10 lines):\n" + "\n".join(lines_buffer))
    
    # Return updated artists for blitting
    return line1, line2, line3, line4, text_info, text_serial

# -----------------------------------
# Configure the serial port
# -----------------------------------
ser = serial.Serial(
    port='COM3',
    baudrate=115200,
    parity=serial.PARITY_NONE,
    stopbits=serial.STOPBITS_TWO,
    bytesize=serial.EIGHTBITS
)
ser.isOpen()

# Generate the time axis for the waveform
x = np.linspace(0, 0.1, 100000)

# Create a figure with a GridSpec layout: top row for waveform and info, bottom row for serial viewer
fig = plt.figure(figsize=(15, 8))
gs = fig.add_gridspec(2, 2, height_ratios=[3, 1])
ax_waveform = fig.add_subplot(gs[0, 0])   # Top-left: waveform plot
ax_info = fig.add_subplot(gs[0, 1])         # Top-right: measurement info
ax_serial = fig.add_subplot(gs[1, :])        # Bottom: serial viewer (spanning both columns)

# 1) Waveform Plot
line1, = ax_waveform.plot([], [], label="Reference", color=(0.5,0.7,1))
line2, = ax_waveform.plot([], [], label="Measured",  color="orange")
line3, = ax_waveform.plot([], [], linestyle='--', color=(0.5,0.7,1))
line4, = ax_waveform.plot([], [], linestyle='--', color="orange")

ax_waveform.set_xlim(0, 0.1)
ax_waveform.set_ylim(-5, 5)
ax_waveform.set_xlabel("Time (s)")
ax_waveform.set_ylabel("Amplitude (V)")
ax_waveform.set_title("Simple OSCILLOSCOPE")
ax_waveform.legend()
ax_waveform.grid()

# 2) Measurement Info
ax_info.set_xticks([])
ax_info.set_yticks([])
text_info = ax_info.text(
    0.05, 0.95, "", 
    fontsize=12, 
    verticalalignment='top', 
    family="monospace"
)
ax_info.set_title("Measurement Info")

# 3) Serial Data Viewer (Bottom full-width)
ax_serial.set_xticks([])
ax_serial.set_yticks([])
text_serial = ax_serial.text(
    0.01, 0.95, "", 
    fontsize=10, 
    verticalalignment='top', 
    family="monospace"
)
ax_serial.set_title("Serial Viewer (Full Width)")

# Create the animation (if you encounter issues with blit, try setting blit=False)
ani = animation.FuncAnimation(
    fig, 
    update, 
    interval=50,  # update every 50 ms
    blit=True
)

plt.tight_layout()
plt.show()

ser.close()
