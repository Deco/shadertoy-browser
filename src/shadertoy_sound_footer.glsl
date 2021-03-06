layout(location = 0) in vec2 inFragCoord;
layout(location = 0) out vec4 outFragColor;

void main() 
{
   // compute time `t` based on the pixel we're about to write
   // the 512.0 means the texture is 512 pixels across so it's
   // using a 2 dimensional texture, 512 samples per row
   float t = iBlockOffset + ((inFragCoord.x-0.5) + (inFragCoord.y-0.5)*512.0)/iSampleRate;

   // Get the 2 values for left and right channels
   vec2 y = mainSound( t );

   // convert them from -1 to 1 to 0 to 65536
   vec2 v  = floor((0.5+0.5*y)*65536.0);

   // separate them into low and high bytes
   vec2 vl = mod(v,256.0)/255.0;
   vec2 vh = floor(v/256.0)/255.0;

   // write them out where 
   // RED   = channel 0 low byte
   // GREEN = channel 0 high byte
   // BLUE  = channel 1 low byte
   // ALPHA = channel 2 high byte
   outFragColor = vec4(vl.x,vh.x,vl.y,vh.y);
}
