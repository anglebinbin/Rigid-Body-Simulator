function drawPendulum(theta)
  
  axis([-8 8 -8 8])
  axis ij
  top = [0 0];
  length = 5;
  
  pos = top + length * [sin(theta), cos(theta)];
  
  line([top(1),pos(1)],[top(2),pos(2)])
  
  drawBox(top(1),top(2));
  
  drawCircle(pos(1),pos(2),.5);
  
function drawBox(x,y)
  
  w = 2;
  h = .5;

  patch([x-w,x-w,x+w,x+w],[y-h,y+h,y+h,y-h],'blue')
  
  
function drawCircle(x,y,r)
  
  t=0:.1:2*pi;
  
  patch(x+r*sin(t),y+r*cos(t),'blue')