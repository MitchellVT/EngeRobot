% EngE 1215 Line Following Robots
%
% This program is used to help a Line-Following Robot follow the line.  
% The first several sections set up the constants used in the communcation
% between this program and the arduino.  
% Each student will add his/her own code to the User Code section with the
% logic to follow the line.  

% This program assumes that a connection has been established to the
% arduino using the program Robot_Connect. 
% The variable 'a' must be established in the command window using the
% 'Robot_Connect' command.
%
% This code has been updated from previous versions to accomodate the motor
% controller backpack board for the Arduinos.  Specifically the left and
% right motor pins have been switched so that the left motor attaches to
% the left terminal block and the right motor attaches to the right
% terminal block.  If the robot is oriented with the USB plug on the bottom
% and the optical sensors on the top, then the black motor wires should
% connect to the left side of the terminal blocks and the red motor wires
% should conenct to the right side of the terminal blocks. Under this
% orientation with the following nomenclature
%
%   +L    Left Motor Red Positive Wire
%   -L    Left Motor Black Negative Wire
%   +R    Right Motor Red Positive Wire
%   -R    Right Motor Black Negative Wire
%
% the wires should be plugged into the terminal blocks in the following
% left to right order
%
%   -L  +L    -R  +R
%
% The wires can be inserted into the terminal blocks by pushing the orange
% tabs backwards away from the front wire holes, inserting the wires, and
% then releasing the orange tabs.  The wires should be firmly held in place
% without any of the exposed electrodes visible.
%
% Authors: Unknown and Rod La Foy
% Last Modified On: 16 July 2018

%% Constants for reading sensors - do not change statements in this block 
% unless there is a change to the physical robot
SENSOR_PIN = 'D13';     % sensor control pin (all sensors)
LEFT_SENSOR_PIN = 'A0';  % pin to read left sensor values from
CENTER_SENSOR_PIN = 'A2';% pin to read center sensor values from
RIGHT_SENSOR_PIN = 'A4'; % pint to read right sensor values from

%% Changes and Additions
% pins have digital and analog designations, ex 13 => 'D13', 2 => 'A2'
% pinMode setup
a.pinMode(SENSOR_PIN,'DigitalOutput');
a.pinMode(LEFT_SENSOR_PIN,'AnalogInput');
a.pinMode(CENTER_SENSOR_PIN,'AnalogInput');
a.pinMode(RIGHT_SENSOR_PIN,'AnalogInput');

%% Constants for motor control - Change lmHigh and rmHigh based on testing
%your robot.  Do not change other statements in this block 
% unless there is a change to the physical robot
LEFT_MOTOR = 'D6';      % set pin 6 as the pin to control the left motor 
RIGHT_MOTOR = 'D5';     % set pin 5 as the pin to control the right motor 
OFF = 0;            % motor speed of 0, 0 is off
lmHigh = .9;       % left motor speed, range of acceptable values 0-1
rmHigh = 1;       % right motor speed, range of acceptable values 0-1

%% USER CODE SECTION - Your code begins down here - Use the constants above
% to keep your program clear and easy to understand.  Use: 
%   a.digitalWrite(SENSOR_PIN,1) %to turn sensors on
%   left = a.analogRead(LEFT_SENSOR_PIN); %input value from the left sensor
%   - use similar command for the right and center sensors.
%   a.digitalWrite(SENSOR_PIN,0) %output to turn off sensors make sure you
%   turn the sensor off after set of readings. 
%   a.analogWrite(LEFT_MOTOR,lmHigh) %to turn left motor on
%   a.analogWrite(LEFT_MOTOR,OFF) %to turn left motor off - use similar
%   command for the right motor.

%Eugene
whiteReadings = 0;
THRESH = 2.8;
while (whiteReadings < 10)
    a.digitalWrite(SENSOR_PIN,1);
    left = a.analogRead(LEFT_SENSOR_PIN);
    right = a.analogRead(RIGHT_SENSOR_PIN);
    center = a.analogRead(CENTER_SENSOR_PIN);
    a.digitalWrite(SENSOR_PIN,0);
    if(left>right && left>center && right<THRESH)
        %turn off left
    end
    
    if(right>left && right>center && left<THRESH)
        %turn off right
    end
    
    if(left<THRESH && right<THRESH && center<THRESH)
        whiteReadings = whiteReadings + 1;
    end
       
end
%turn motors off

%% The section makes sure the motor and sensors are off when the program stops.
a.analogWrite(LEFT_MOTOR,OFF) %to turn left motor off 
a.analogWrite(RIGHT_MOTOR,OFF) %to turn left motor off 
a.digitalWrite(SENSOR_PIN,0) %output to turn off sensors