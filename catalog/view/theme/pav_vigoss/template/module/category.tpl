<div class="box category highlights">
  <div class="box-heading"><span><?php echo $heading_title; ?></span></div>
  <div class="box-content   tree-menu">
    <ul id="accordion" class="box-category box-panel js-hover">
      <?php 
        $k=0;
        $parents = array();
  

		foreach ($categories as $key => $category) 
        {   
        	$parents[$key] = $category['category_id'];
            $parentId=$category['category_id'];
            if( sizeof($category['children'] )>0 )
            {
            	foreach($category['children'] as $k=>$val)
                {
                	$children[$parentId][] = $category['children'][$k]['category_id'];
                  }
            }
            
            
        }

  
        foreach ($categories as $key => $category) {        
        $class = "";
          if( $category["children"] ){
          $class = "haschild";
        }
        $name = str_replace("", '<span class="">',  $category['name'] );
        $category['name'] = str_replace("", '</span>', $name); 
      ?>
      
      <li class="<?php echo $class; ?>">
        <?php 
       # echo $category['category_id'].":".$category_id; 
      
         if ($category['category_id'] == $category_id) { ?>
       
         <a  <?php if (!$category['children']) { ?> href="<?php echo $category['href']; ?>"<?PHP } ?> data-id="<?php echo $key; ?>" style="cursor:pointer" class="active item categ_accord"><?php echo $category['name']; ?></a>
        <?php } else { ?>
        
          <a  <?php if (!$category['children']) { ?> href="<?php echo $category['href']; ?>"<?PHP } ?>  data-id="<?php echo $key; ?>" style="cursor:pointer"  class="item categ_accord"><?php echo $category['name']; ?></a>
        <?php } ?>
        <?php if ($category['children']) {  $k++;   ?>               
        <span class="caret">
          <a href="#collapse<?php echo $key ;?>" class="accordion-toggle <?php echo $category_id==0?($k==1?'':'collapsed'):($category['category_id'] == $category_id?'':'collapsed') ?>" data-toggle="collapse" data-parent="#cat-accordion" >
          <i class="icon-collapse collapse-<?php echo $key; ?>"></i></a></span>       
       <!-- <ul id="collapseOne<?php echo $k ;?>" class="collapse <?php echo $category_id==0?($k==1?'in':''):($category['category_id'] == $category_id?'in':'') ; ?>">-->
       
       <ul id="collapse<?php echo $key ;?>" class="collapse <?PHP if(  $category_id==$categories[$key]['category_id'] ) echo "in"; ?> ">
       
       
          <?php 
          
          
          foreach ($category['children'] as $child) { ?>
          <?php
            $child['name'] = str_replace("", '<span class="">',  $child['name'] );
            $child['name'] = str_replace("", '</span>', $child['name']);  
          ?>
          <li>
            <a href="<?php echo $child['href']; ?>" id="selcate_<?PHP echo $child['category_id'] ?>" class="subcategs"> <?php echo $child['name']; ?></a>
           
          </li>
          <?php } ?>
        </ul>
        <?php } ?>
      </li>
      <?php } ?>
    </ul>
  </div>
</div>
<script>
  $(document).on('click', '#cat-accordion .accordion-toggle', function(event) {
        event.stopPropagation();
        var $this = $(this);
        var parent = $this.data('parent');
        var actives = parent && $(parent).find('.collapse.in');
        var target = $this.attr('data-target') || (href = $this.attr('href')) && href.replace(/.*(?=#[^\s]+$)/, ''); 
        if (actives && actives.length) {
            actives.collapse('hide');
            $(parent).find('.accordion-toggle').not($(event.target)).addClass('collapsed');
      }
        $(this).removeClass('collapsed');
        $(target).collapse('show');
        $(target).addClass('collapse','1000');
        $(target).css('height','auto');
        $(target).animate({height:"auto"});
});
</script>

<script>
$(document).ready(function()
{
	var selectedCateg = $("#selectedCateg").attr('selectedCateg');

	$(".subcategs").each(function()
	{
		if( $(this).attr('id') == "selcate_"+selectedCateg )
		$(this).addClass('active');
		
	});
	
	
	$(".categ_accord").on('click',function()
	{
	
		/* 

		var itemno ='';
		
		
		$(".categ_accord").each(function()
		{
			if($(this).hasClass('active'))
			{
				itemno = $(this).attr('data-id');
				itemno = parseInt(itemno);
				itemno = itemno+1;
			}
			
		});
		
		
		if( $(this).hasClass('active') )
		{
		}
		else
			{
				
				var newitemno = parseInt($(this).attr('data-id'));
				
				newitemno = newitemno+1;
				
				$(".categ_accord").removeClass('active');
				$(".categ_accord").parent().removeClass('haschild');
				$("#collapseOne"+itemno).removeClass('in');				
				
				$(this).parent().addClass('haschild');	
				$(this).addClass('active');	
				$("#collapseOne"+newitemno).addClass('in');
				
			}
			
	 */
	 
	 	var accord = $(this).attr('data-id');
			
			$(".categ_accord").removeClass('active');
			$(this).addClass('active');
			
			$(".collapse").removeClass('in');
			
			$("#collapse"+accord).addClass('in');

	 
	 
	 
	 
	
	
	});
	
});
</script>
