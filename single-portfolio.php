<?php get_template_part('templates/custom-sidebar'); ?>
<div class="portfolio-wrap">
  <h1><?php echo the_title(); ?></h1>
  <div class="portfolio-content"><?php echo the_content(); ?></div><?php if($value = get_field('vimeo_url')) : ?>
  <iframe src="https://player.vimeo.com/video/<?php echo $value; ?>?&color=ffffff&byline=0&portrait=0" width="900" height="470" frameborder="0" webkitallowfullscreen="webkitallowfullscreen" mozallowfullscreen="mozallowfullscreen" allowfullscreen="allowfullscreen"></iframe><?php endif; ?><?php if($value = get_field('flash_url')) : ?>
  <object type="application/x-shockwave-flash" id="fm_MirrorMen_1997309846" name="fm_MirrorMen_1997309846" data="<?php echo $value; ?>" class="aligncenter"></object><?php endif; ?><?php if($value = get_field('embed_url')) : ?>
  <iframe src="<?php echo $value; ?>" class="external"></iframe><?php endif; ?><?php for($i = 1; $i<6; $i++): ?><?php if($value = get_field('image_'.$i)) : ?><img src="<?php echo $value; ?>"/><?php endif; ?><?php endfor; ?>
</div>