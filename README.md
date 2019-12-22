# -intra-cellular-recordings-in-a-current-clamped-cell


You are given 2 mat files to be loaded by your MATLAB script:
    - When loading the files, you should see 2 vectors (S1, S2) in your workspace.
    - Another option is to use the MATLAB whos command to see the workspace
      variables and their dimensions.
 The given vectors are a product of intra cellular recordings performed in vitro:
    o The stimulus protocol in the experiment was a sequence of current steps (“0→dc
    step→0”) for duration of 200 mSec repeated every 300 mSec with an increasing
    current step from segment to segment.
    o The recordings measure the membrane potential (in mV) as a function of the
    experiment time with a sampling rate of 10 KHz.
    
Coding requirements

 Please use the suggested variable names whenever given (in brackets)
      o Note, that all mentioned variables are vectors.
      
 Write a “generic code”, i.e., the code should process a chosen recording (Si) and the
  actual choice means a simple setting at the beginning of the code, e.g.:
  load ('S1');
  load ('S2');
    % change the following line to Si = S2 to process the 2nd vector
    Si = S1; % the remaining of the code processes Si
    
1. Qualitative observation of the given signals

 Methodological remark: this guidelines section is designed for the environment
  preparation and mind setup on the targeted data analysis. Whenever you encounter a new
  experimental dataset the first important action is to observe and understand the nature of
  it. In the submitted solution, you are not asked to address this section.
  
 Use the sampling rate to prepare a corresponding time vector, e.g.:
    fs = 10000; % sampling rate
    dt = 1/fs; % time step
    N = length (Si); % number of components in Si
    t = dt*(1:N); % time vector
    
 Use plot(t,Si) to view the signals.

 Make sure you understand the events of start/stop times of the repeated current steps.

 Bonus: find the "unexpected" segments in each of the recordings and suggest an
  explanation for it.
  
  
2. Finding the spike times

 Methodological remark: this algorithm is explored step by step in the lesson slides.

 Choose a voltage threshold and create a binary “above threshold” signal (SaTH).

 Use diff(SaTH) to mark the state changes of SaTH.

 Use find on the resulting vector to detect “threshold crossing events”:
    o “low to high” (L2H) events are the positions of 1
    o “high to low” (H2L) events are the positions of -1
    
 Find “Local maxima” (LM) between consecutive events of L2H and H2L. Use the
  max() function
  
  
3. Finding the spike rate per segment


 Methodological remark: the pros and cons of each different methods for the rate
  calculations is discussed in the lesson slides. The slides also discuss the way to evaluate
  rate measurement error. In this assignment we will focus on only one method.
  
 For convenience use LM as the spike times for such calculations (without getting into the
  debate where the exact spike time should be measured).
  
 Count the spike events (SC) per dc step segment.
    o Note, that the exact position of the 200 mSec window of DC current inside the
    300 mSec from segment to segment changes between the 2 recordings.
    o Nevertheless, this note should not influence your calculations, which should split
    the spikes according to the 300 mSec cycle.
    
 Translate into rate (R) in spikes/sec, by dividing the spike count by the duration of the
current step (200 mSec)
