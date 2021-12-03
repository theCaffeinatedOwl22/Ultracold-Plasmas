clc, clear, close all

datadir = 'C:\Users\grant\Documents\GitHub\mhd\ucnp.settings';
file = readtext(datadir,'string',{',','='});
loc = strfindfirst(datadir,'\');