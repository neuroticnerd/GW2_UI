$(document).ready(on_page_load);

function on_page_load()
{
   
    register_sprite_frame('#classpower',150,4,'images/classpower.png');    
    register_sprite_frame('#targetframe',150,1,'images/targetframe.png');    
    
     $('.stars').animate({marginTop:($(window).scrollTop()*0.2) +'px'},10)
    $(window).scroll(function(){
       $('.stars').animate({marginTop:($(window).scrollTop()*0.2) +'px'},10)
    });
}

function register_sprite_frame(element,height,index,image)
{  
    var e = $(element+' > .img1')
    var e2 = $(element+' > .img2')

    e.css('background-image','url('+image+')')
    e2.css('background-image','url('+image+')')
    e2.css('opacity','0')
    update_sprite_frame(e,e2,height,index,0)
}

function update_sprite_frame(e,e2,height,index,c,c2)
{

    var current = c + 1;
    var current2 = c2 + 2;

    if (current>index)
    {
        current = 0;
    }
    if (current2>index)
    {
        current2 = 0;
    }
    console.log(150*current)
   
    e.css('background-position','0px '+150*current+'px')
    
    e.animate({opacity: 1},1000);
    e2.animate({opacity: 0},1000,function(){
      
          e2.css('background-position','0px '+150*current+'px')
    });

    setTimeout(function(){ update_sprite_frame(e2,e,height,index,current,current2)},3000)
}