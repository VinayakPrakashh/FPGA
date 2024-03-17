Hello everyone, so this project basically implements an alarm clock using Verilog HDL.
We are generating a clock with 7 output signals including Alarm signal, Hour, Minute, and seconds.
The input clock given as input is 10Hz.
## Features
1. Initializing clock time to a particular value.

2. Setting time for alarm.

3. Enabling and disabling alarm.

3. Stopping alarm.

## Block Diagram
![Block diagram](https://github.com/VinayakPrakashh/FPGA/assets/101159818/03efefad-8776-47cd-89e0-6d55b5de7e83)
Input Signals: reset : Active high reset pulse, to set the time to the input hour and minute (as defined by the H_in1, H_in0, M_in1, and M_in0 inputs) and the second to 00. It should also set the alarm value to 0.00.00, and to set the Alarm (output) low.For normal operation, this input pin should be 0

clk : A 10Hz input clock. This should be used to generate each real-time second H_in1 : A 2-bit input used to set the most significant hour digit of the clock (if LD_time=1),or the most significant hour digit of the alarm (if LD_alarm=1). Valid values are 0 to 2.

H_in0 : A 4-bit input used to set the least significant hour digit of the clock (if LD_time=1) or the least significant hour digit of the alarm (if LD_alarm=1). Valid values are 0 to 9.

M_in1 : A 4-bit input used to set the most significant minute digit of the clock (if LD_time=1),or the most significant minute digit of the alarm (if LD_alarm=1). Valid values are 0 to 5.

M_in0 : A 4-bit input used to set the least significant minute digit of the clock (if LD_time=1),or the least significant minute digit of the alarm (if LD_alarm=1). Valid values are 0 to 9.

LD_time : If LD_time=1, the time should be set to the values on the inputs H_in1, H_in0, M_in1, and M_in0. The second time should be set to 0.If LD_time=0, the clock should act normally (i.e. second should be incremented every 10 clock cycles).

LD_alarm : If LD_alarm=1, the alarm time should be set to the values on the inputs H_in1, H_in0, M_in1, and M_in0.If LD_alarm=0, the clock should act normally.

STOP_al : If the Alarm (output) is high, then STOP_al=1 will bring the output back low.

AL_ON : If high, the alarm is ON (and Alarm will go high if the alarm time equals the real time). If low the the alarm function is OFF.

Output Signals:

Alarm : This will go high if the alarm time equals the current time, and AL_ON is high. This will remain high, until STOP_al goes high, which will bring Alarm back low.

H_out1 : The most significant digit of the hour. Valid values are 0 to 2.

H_out0 : The least significant digit of the hour. Valid values are 0 to 9.

M_out1 : The most significant digit of the minute. Valid values are 0 to 5.

M_out0 : The least significant digit of the minute. Valid values are 0 to 9.

S_out1 : The most significant digit of the minute. Valid values are 0 to 5.

S_out0 : The least significant digit of the minute. Valid values are 0 to 9.

Internal Signals:

clk_1s : 1-s clock

tmp_1s : count for creating 1-s clock

tmp_hour, tmp_minute, tmp_second : counter for clock hour, minute and second

c_hour1,a_hour1 : The most significant hour digit of the temp clock and alarm.

c_hour0,a_hour0 : The least significant hour digit of the temp clock and alarm.

c_min1,a_min1 : The most significant minute digit of the temp clock and alarm.

c_min0,a_min0 : The least significant minute digit of the temp clock and alarm.

c_sec1,a_sec1 : The most significant second digit of the temp clock and alarm.

c_sec0,a_sec0 : The least significant minute digit of the temp clock and alarm.
