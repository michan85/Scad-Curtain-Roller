PF=1;//preview fix

module tube(h=1,r=2,ir=1){
    
    difference(){
        cylinder(h,r=r);
        translate([0,0,-1*PF]) cylinder(h+(PF*2),r=ir);
    }
   
}


module rollerGear(h=4,r=25,tooth=4.5, nTeeth=28,wall=2 ){
    
    toothInset = r-tooth;
    rTooth = tooth/2;
    $fn=nTeeth;
    union(){
        difference(){
            tube(h,r, r-(tooth+(wall*2)));  
            
            // track
            translate([0,0,h-rTooth-1])
            tube(rTooth+1+PF,r+PF, toothInset);  
        }
        
        //teeth
        for(n=[0:nTeeth]){
            
            rotate([0,0,(360/nTeeth)*n])
            translate( [toothInset,0, h-rTooth-1] )
            union(){
                
                //square teeth
                //translate([0,-rTooth,-rTooth])
                cube([4,1,(tooth/2)]); 
            }
            
        }
    }
}