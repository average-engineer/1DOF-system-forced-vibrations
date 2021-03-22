function [dwdt] = state_space_func(w,t,force,mass,stiffness,damping,ang_freq)
w1 = w(1);
w2 = w(2);
dw1dt = w2;
dw2dt = (force/mass)*cos(ang_freq*t) - (damping/mass)*w2 - (stiffness/mass)*w1;
dwdt = [dw1dt;dw2dt];

end