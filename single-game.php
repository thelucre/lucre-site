<div class="page-heading">
  <h1>Games</h1>
</div>

<?php if (have_posts()) : while (have_posts()) : the_post(); ?>
<div class="game-detail">
  <img src="<?php the_field('logo'); ?>" />
  <?php the_content(); ?>
</div>

<?php
endwhile;
endif;
?>
