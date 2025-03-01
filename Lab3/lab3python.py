import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import sys, time
import serial

xsize = 100

# Global statistics
min_val = float('inf')
max_val = float('-inf')
sum_val = 0.0
count_val = 0

# Configure the serial port
ser = serial.Serial(
    port='COM4',
    baudrate=115200,
    parity=serial.PARITY_NONE,
    stopbits=serial.STOPBITS_TWO,
    bytesize=serial.EIGHTBITS,
    timeout=0.5
)
ser.isOpen()

def data_gen():
    t = data_gen.t
    while True:
        t += 1
        try:
            strin = ser.readline().decode('utf-8').strip()
            print(f"COM data: '{strin}'")  # Debug print
            if strin:
                val = float(strin)
                yield t, val
            else:
                time.sleep(0.2)
        except ValueError:
            time.sleep(0.2)
            continue
        except Exception as e:
            print(f"Error: {e}")
            break

def run(data):
    global min_val, max_val, sum_val, count_val

    t, y = data
    if t > -1:
        # Append new data
        xdata.append(t)
        ydata.append(y)

        # Update statistics
        min_val = min(min_val, y)
        max_val = max(max_val, y)
        sum_val += y
        count_val += 1
        avg_val = sum_val / count_val

        # Scroll window if needed
        if t > xsize:
            ax.set_xlim(t - xsize, t)

        # Update the line data
        line_temp.set_data(xdata, ydata)

        # Change color of entire curve based on latest temperature
        if y > 50:
            line_temp.set_color('red')
        elif y > 30:
            line_temp.set_color('orange')
        else:
            line_temp.set_color('blue')

        # Update the stats text
        stats_text.set_text(
            f"Min: {min_val:.2f} °C\n"
            f"Max: {max_val:.2f} °C\n"
            f"Avg: {avg_val:.2f} °C\n"
            f"Cur: {y:.2f} °C"
        )

    return line_temp, stats_text

def on_close_figure(event):
    sys.exit(0)

# Initialize data generator
data_gen.t = -1
xdata, ydata = [], []

# Setup figure and axis
fig = plt.figure()
fig.canvas.mpl_connect('close_event', on_close_figure)
ax = fig.add_subplot(111)

# Plot limits and grid
ax.set_xlim(0, xsize)
ax.set_ylim(10, 60)
ax.grid()

# Fixed title
ax.set_title("Real Time Temperature")

# Create the single line that will actually be updated
line_temp, = ax.plot([], [], lw=2, color='blue')

# Create dummy lines so the legend always shows the 3 color thresholds
import matplotlib.lines as mlines
blue_line = mlines.Line2D([], [], color='blue', label='≤ 30 °C')
orange_line = mlines.Line2D([], [], color='orange', label='30–50 °C')
red_line = mlines.Line2D([], [], color='red', label='> 50 °C')

# Build the legend on the upper-right
ax.legend(handles=[blue_line, orange_line, red_line], loc='upper right')
    
# Stats text on the left with a bounding box (white background, black edge)
stats_text = ax.text(
    0.02, 0.95, '', 
    transform=ax.transAxes, 
    va='top', fontsize=9,
    bbox=dict(facecolor='white', alpha=0.7, edgecolor='black')
)

# Animation
ani = animation.FuncAnimation(
    fig, run, data_gen,
    blit=False, interval=10, repeat=False, cache_frame_data=False
)

plt.show()
