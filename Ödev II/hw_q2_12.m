x = [14.8 11.1 7.4 3.7 0 0 0 0 0 0 3.7 7.4 11.1 14.8 18.5 18.5 18.5 18.5 18.5 18.5];
y = [0 0 0 0 0 3.7 7.4 11.1 14.8 18.5 18.5 18.5 18.5 18.5 18.5 14.8 11.1 7.4 3.7 0];

u = [2293 1833 1365 893 441 437 437 441 441 449 903 1373 1831 2289 2745 2753 2749 2755 2751 2751];
v = [3981 3985 3985 3989 3993 3529 3069 2601 2125 1701 1695 1695 1699 1699 1707 2131 2599 3064 3524 3970];

M = [
    x(1) y(1) 1 0 0 0 -u(1)*x(1) -u(1)*y(1)
    0 0 0 x(1) y(1) 1 -v(1)*x(1) -v(1)*y(1)
    
    x(2) y(2) 1 0 0 0 -u(2)*x(2) -u(2)*y(2)
    0 0 0 x(2) y(2) 1 -v(2)*x(2) -v(2)*y(2)
    
    x(3) y(3) 1 0 0 0 -u(3)*x(3) -u(3)*y(3)
    0 0 0 x(3) y(3) 1 -v(3)*x(3) -v(3)*y(3)
    
    x(4) y(4) 1 0 0 0 -u(4)*x(4) -u(4)*y(4)
    0 0 0 x(4) y(4) 1 -v(4)*x(4) -v(4)*y(4)
    
    x(5) y(5) 1 0 0 0 -u(5)*x(5) -u(5)*y(5)
    0 0 0 x(5) y(5) 1 -v(5)*x(5) -v(5)*y(5)
    
    x(6) y(6) 1 0 0 0 -u(6)*x(6) -u(6)*y(6)
    0 0 0 x(6) y(6) 1 -v(6)*x(6) -v(6)*y(6)
    
    x(7) y(7) 1 0 0 0 -u(7)*x(7) -u(7)*y(7)
    0 0 0 x(7) y(7) 1 -v(7)*x(7) -v(7)*y(7)
    
    x(8) y(8) 1 0 0 0 -u(8)*x(8) -u(8)*y(8)
    0 0 0 x(8) y(8) 1 -v(8)*x(8) -v(8)*y(8)
    
    x(9) y(9) 1 0 0 0 -u(9)*x(9) -u(9)*y(9)
    0 0 0 x(9) y(9) 1 -v(9)*x(9) -v(9)*y(9)
    
    x(10) y(10) 1 0 0 0 -u(10)*x(10) -u(10)*y(10)
    0 0 0 x(10) y(10) 1 -v(10)*x(10) -v(10)*y(10)
    
    x(11) y(11) 1 0 0 0 -u(11)*x(11) -u(11)*y(11)
    0 0 0 x(11) y(11) 1 -v(11)*x(11) -v(11)*y(11)
    
    x(12) y(12) 1 0 0 0 -u(12)*x(12) -u(12)*y(12)
    0 0 0 x(12) y(12) 1 -v(12)*x(12) -v(12)*y(12)
    
    x(13) y(13) 1 0 0 0 -u(13)*x(13) -u(13)*y(13)
    0 0 0 x(13) y(13) 1 -v(13)*x(13) -v(13)*y(13)
    
    x(14) y(14) 1 0 0 0 -u(14)*x(14) -u(14)*y(14)
    0 0 0 x(14) y(14) 1 -v(14)*x(14) -v(14)*y(14)
    
    x(15) y(15) 1 0 0 0 -u(15)*x(15) -u(15)*y(15)
    0 0 0 x(15) y(15) 1 -v(15)*x(15) -v(15)*y(15)
    
    x(16) y(16) 1 0 0 0 -u(16)*x(16) -u(16)*y(16)
    0 0 0 x(16) y(16) 1 -v(16)*x(16) -v(16)*y(16)
    
    x(17) y(17) 1 0 0 0 -u(17)*x(17) -u(17)*y(17)
    0 0 0 x(17) y(17) 1 -v(17)*x(17) -v(17)*y(17)
    
    x(18) y(18) 1 0 0 0 -u(18)*x(18) -u(18)*y(18)
    0 0 0 x(18) y(18) 1 -v(18)*x(18) -v(18)*y(18)
    
    x(19) y(19) 1 0 0 0 -u(19)*x(19) -u(19)*y(19)
    0 0 0 x(19) y(19) 1 -v(19)*x(19) -v(19)*y(19)
    
    x(20) y(20) 1 0 0 0 -u(20)*x(20) -u(20)*y(20)
    0 0 0 x(20) y(20) 1 -v(20)*x(20) -v(20)*y(20)
    ];

c = [
    u(1);v(1);u(2);v(2);u(3);v(3);u(4);v(4);u(5);v(5);u(6);v(6);u(7);v(7);u(8);v(8);u(9);v(9);u(10);v(10);
    u(11);v(11);u(12);v(12);u(13);v(13);u(14);v(14);u(15);v(15);u(16);v(16);u(17);v(17);u(18);v(18);u(19);v(19);u(20);v(20);
    ];

sonuc = M\c;
sonuc = [sonuc;1];
sonuc = reshape(sonuc,[],3)';

[u,v] = world2Cam2D(sonuc, 11.1, 11.1);

disp(u);
disp(v);