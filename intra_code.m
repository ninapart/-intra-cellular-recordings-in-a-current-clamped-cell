clear all
close all
clc

load('S1'); Si = S1; N_steps = 17;
%load('S2'); Si = S2; N_steps = 21;

fs = 10000; % sampling rate
dt = 1/fs; % time step

N = length(Si); % number of components in S
t = dt*(1:N); % time vector

figure('Color','w','Name','Voltage as a function of time' )

plot(t,Si)
grid on
set(gca,'FontSize',24);
xlabel('t (sec)')
ylabel('V (mV)')


t_start = 0.3*(0:(N_steps-1)) + 0.02;
t_end = t_start + 0.2;

n_start = ceil(t_start*fs);
n_end = ceil(t_end*fs);
I1 = zeros(1,N);

for k = 1:N_steps
    I1(n_start(k):n_end(k)) = 10;
end
hold on
plot(t,I1,'r-')

%% Ex1
TH = -30;

% Find the indexes of the values that rise above the threshold, and
% find where it crosses the threshold in the positive and negative directions. 
SaTH = Si>=TH;
changes = diff(SaTH);
L2H = find(changes==1);
H2L = find(changes==-1);

LM = zeros(size(L2H));
for i = 1:length(LM)
    [M,I] = max(Si(L2H(i):H2L(i))); % find the peaks
    LM(i)=L2H(i)+I-1; % summing the indexes increases the wanted index by 1, so were substracting 1
end
%%

TXT_HEIGHT=max(Si)+10;

% DC step = 200 ms
DC_STEP = 0.2;
% spikes count per DC step
SC = zeros(size(n_start));
% rates calculation
R = zeros(size(n_start));

for i = 1:length(n_start)
    SC(i) = sum(LM>n_start(i) & LM<=n_end(i));    
    if SC(i)~=0
        R(i) = SC(i)/DC_STEP;
    end
    
    % Write the rate above the middle of the DC step.
    step_mark = n_start(i)/fs + DC_STEP/2;
    rate = num2str(R(i),3);
    text(step_mark, TXT_HEIGHT, rate);
    
end

% Mark LM, H2L, L2H
plot(t,Si,'-o','MarkerIndices',LM,'MarkerEdgeColor','black')
plot(t,Si,'-o','MarkerIndices',H2L,'MarkerEdgeColor','red')
plot(t,Si,'-o','MarkerIndices',L2H,'MarkerEdgeColor','green','Color','blue')
