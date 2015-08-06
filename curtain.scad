include <lib.scad>


$fn=128;

/*
difference(){
    
    translate([0,0,-10]) 
        rollerGear(h=h,r=r);
    
    translate([0,0,h]) 
        *cube([r*2,r*2,h],center=true);
}
*/
bracket();

mirror([0,0,1])
    translate([0,0,-230])
    bracket();

color("grey")
translate([0,0,10])
cylinder( 200, d=32 );

translate([0,0,18])
gear();



module bracket(h=10, ){
    
    union(){
        d=60;
        
        difference(){
            translate([-d/2,-d/2,0])
            union(){
                cube( [60,100,h]);
                cube( [d,d,30] );
            }
            translate([0,0,h])
                cylinder( 41,r=26 );
            
            translate([0,-26,h])
                cube( [30+PF,52,20+PF] );
        }
        translate([0,0,h])
        cylinder( 20,r=8);
        
    }
    
    
}

module gear(){
h=4.5;
r=25;
    rotate([180,0,0])
    translate([0,0,-h])
    rollerGear(h=h,r=r);
    
    mirror([0,0,1])
    rotate([180,0,0])
    translate([0,0,-h])
    !rollerGear(h=h,r=r);
}

module rollerGear(h=4,r=25,ir=16.3,tooth=4.5, nTeeth=28,wall=2 ){
    
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


















/*

// tube=32, ball=4
baseHeight=3;
tube=33;
gearR=25;
noBalls=30;
$fn=noBalls;

module base(){
    cylinder(baseHeight,27,27);
}

module gear(){
    ball=4.5;
    ballR=ball/2;
    h=6;
    
    inset=4;
    ballInset=gearR-((ball/2)*1.2)-1;
    
     difference(){
        
        
        union(){
            translate([0,0,baseHeight]) cylinder(h,gearR,gearR, $fn=noBalls);
        }
    
        //tube cut away
        cylinder(h+1000,d=tube+inset,d=tube+inset);
      
        
        //flange join
        //translate([0,0,baseHeight]) cylinder(h,d=tube+inset,d=tube+inset);
       
        translate([0,0,baseHeight]) tube(1, gearR,gearR-3);
        // ball cut aways
        for(n=[0:noBalls]){
            
            rotate((360/noBalls)*n)
            translate([ballInset,0,baseHeight+(h/2)]) 
            union(){
                sphere(d=ball, $fn=16);
                
                rotate([0,90,0])
                cylinder( 5,d=ball,$fn=16 );
                
                translate([-2,0,0]) 
                rotate([0,90,0]) 
                *cylinder(ball+10,ball/2,ball/2);
                
                
                
                translate([0,0,1])
                rotate([0,90,0])
                *cube([2,3,10],center=true); 
                
                
            }
          /*  
            rotate([0,0,(360/noBalls)*n-5] )
            translate([ballInset,-6,baseHeight+(h/2)-.5]) 
            rotate([0,90,0])
            %cube([20,2,1]); 
            
            */
            /*
            rotate([0,0,(360/noBalls)*n+5] )
            translate([ballInset,-9,baseHeight+(h/2)]) 
            cylinder(1,2,1); 
            
            rotate([0,0,(360/noBalls)*n+5] )
            translate([ballInset,-9,baseHeight+(h/2)-1]) 
            cylinder(1,1,2); 
            ---* /---
            
        }
    }
}


module flange(){
    difference(){
        
        h=3;
        
        union(){
            cylinder(h,18,18);
            translate([0,0,h])base();
        }
        
        cylinder(h+1000,d=tube,d=tube);
    }
}

rotate([0,180,0])
//translate([0,0,5]) 
*flange(); 


*gear();

translate([0,0,8]) 
rotate([0,180,0])
*flange(); 



difference(){
    h=6;
    r=25;
    //translate([0,0,-10]) 
        rollerGear(h=h,r=r);
    
    translate([0,0,h]) 
        cube([r*2,r*2,h],center=true);
}



module rollerGear(h=6,r=25,tooth=4.5, nTeeth=28,wall=2 ){
    
    toothInset = r-tooth;
    rTooth = tooth/2;
    $fn=nTeeth;
    difference(){
        tube(6,r, r-(tooth+(wall*2)));  
        
        // chain cutaway
        translate([0,0,h/2-(.5)]) 
        rotate(6.43)
        tube(1,r+PF, toothInset+.12);  
        
        //teeth
        for(n=[0:nTeeth]){
            
            rotate([0,0,(360/nTeeth)*n])
            translate( [toothInset,0, h/2] )
            union(){
                
                //square teeth
                translate([0,-rTooth,-rTooth])
                cube([tooth+r,tooth,tooth]); 
                
                // sphere teeth
                translate([rTooth,0,0])
                *union(){
                    sphere(d=tooth);
                    rotate([0,90,0]) 
                    cylinder(rTooth+gearR,d=tooth);
                }
            }
            
        }
    }
}
*/


