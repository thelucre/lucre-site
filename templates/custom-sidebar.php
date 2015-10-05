
<div class="custom-sidebar"><a href="<?= esc_url(home_url('/')); ?>"><img src="<?php bloginfo('stylesheet_directory'); ?>/img/logo.jpg"/></a><?php $args = array( 'post_type' => 'portfolio', 'posts_per_page' => -1 ); ?><?php $items = new WP_Query( $args ); ?>
  <div></div><?php while( $items->have_posts() ) : $items->the_post(); ?><?php $randomclass = 'random-'.mt_rand(0,20); ?><a href="<?php echo the_permalink();?>" class="<?php echo $randomclass; ?>"><?php echo the_title(); ?></a><?php endwhile; ?>
</div><?php wp_reset_query() ?>