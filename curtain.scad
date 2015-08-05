// tube=32, ball=4
baseHeight=3;
tube=33;
gearR=25;
noBalls=32;
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
        %cylinder(h+1000,d=tube+inset,d=tube+inset);
      
        
        //flange join
        //translate([0,0,baseHeight]) cylinder(h,d=tube+inset,d=tube+inset);
       
        // ball cut aways
        for(n=[0:noBalls]){
            
            
            rotate((360/noBalls)*n)
            translate([ballInset,0,baseHeight+(h/2)]) 
            union(){
                *sphere(d=ball, $fn=16);
                
                rotate([0,90,0])
                *cylinder( 2,1,2,$fn=16 );
                
                %translate([-2,0,0]) rotate([0,90,0]) cylinder(ball+10,ball/2,ball/2);
                
                translate([-3,-5,1])
                rotate([0,90,0])
                %cube([2,3,10]); 
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
            */
            
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


gear();

translate([0,0,8]) 
rotate([0,180,0])
*flange(); 
