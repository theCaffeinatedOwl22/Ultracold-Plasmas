function [t] = defineTransitions()
%% Program Notes
% This program simply defines the transitions involved in our Sr+ imaging
% scheme.

% There are no inputs. The output is a structure (q) that contains the
% quantum numbers associated with each state |n l s j m_j>

%% Define quantum states
% Pi Minus transition
t(1).name = '\pi_-';
t(1).upper = [5 1 1/2 1/2 -1/2];
t(1).lower = [5 0 1/2 1/2 -1/2];
t(1).color = [0.3010, 0.7450, 0.9330];
% Pi Plus transition
t(2).name = '\pi_+';
t(2).upper = [5 1 1/2 1/2 1/2];
t(2).lower = [5 0 1/2 1/2 1/2];
t(2).color = [1, 0, 0];
% Sigma plus transition
t(3).name = '\sigma_+';
t(3).upper = [5 1 1/2 1/2 1/2];
t(3).lower = [5 0 1/2 1/2 -1/2];
t(3).color = [0.47,0.67,0.19];
% Sigma minus transition
t(4).name = '\sigma_-';
t(4).upper = [5 1 1/2 1/2 -1/2];
t(4).lower = [5 0 1/2 1/2 1/2];
t(4).color = [0.4940, 0.1840, 0.5560];

end

