<div class="page-heading">
  <h1><?php the_title(); ?></h1>
</div>


<div class="game-listing">


  <?php
    $args = array(
      'post_type' => 'game',
      'posts_per_page' => -1,
      'orderby' => 'desc' );

    $items = new WP_Query( $args );
    if($items->have_posts()) :
      while( $items->have_posts() ) : $items->the_post();
  ?>

    <a class="game-item" href="<?php the_permalink(); ?>">

      <div class="game-image" style="background-image: url('<?php the_field('featured_image'); ?>');">

      </div>
      <div class="game-title">
        <?php the_title();?>
      </div>

    </a>


  <?php
      endwhile;
    endif;

    wp_reset_query();

  ?>
</div>
