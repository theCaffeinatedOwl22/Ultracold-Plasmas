clc, clearvars

% return the name of a class object
fun = @(x) x;
classname = class(fun);

% access properties of constant classes
import constants.cgs;
test();
cgs.kB