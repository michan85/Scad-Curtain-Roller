include <lib.scad>




module bracket(h=3, h2=10){
    d=60;
    union(){
        
        
        difference(){
            translate([-d/2,-d/2,0])
            union(){
                cube( [60,60,h]);
                translate([0,0,h])
                cube( [d,d,h2] );
                translate([0,0,h+10])
                    cube( [60,60,h]);
            }
            translate([0,0,h])
                cylinder( 10,r=26 );
            
            translate([0,0,h+10])
                cylinder( 15,r=18 );
            
            translate([0,-26,h])
                cube( [30+PF,52,10+PF] );
        }
        translate([0,0,h])
        cylinder( h2,r=15.5);
        
    }
    
    
}

module gear(){
h=4.5;
r=25;
    rotate([180,0,0])
    translate([0,0,-h])
    rollerGear(h=h,r=r,male=true);
    
    mirror([0,0,1])
    rotate([180,0,0])
    translate([0,0,-h])
    rollerGear(h=h,r=r,male=false);
}

module rollerGear(h=4,r=25,ir=16.3,tooth=4.5, nTeeth=28,wall=2, male=true ){
    
    toothInset = r-tooth;
    rTooth = tooth/2;
    $fn=nTeeth;
    union(){
        difference(){
            //ir=r-(tooth+(wall*2));
            tube(h,r, ir);  
            
            // track
            translate([0,0,h-rTooth-1])
            tube(rTooth+1+PF,r+PF, toothInset);  
            
            if(!male){
                for(n=[0:4]){
                    rotate([0,0,(360/4)*n])
                    translate( [ir-1,-.5, 0-PF] )
                    cube([4,4,h+(PF*2)]); 
                }
            }
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
        
        if(male){
             for(n=[0:4]){
                rotate([0,0,(360/4)*n])
                translate( [ir,0, h] )
                cube([3,3,h]); 
            }
        }
        
    }
}









$fn=128;



color("white")
translate([-50,55,0]) cube([1000,10,1000]);
bracket();

mirror([0,0,1])
    translate([0,0,-730])
    bracket();

color("grey")
translate([0,0,10])
cylinder( 700, d=32 );

translate([0,0,9])
gear();









