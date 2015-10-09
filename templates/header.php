<?php if(is_page('home')) return; ?>

<div id="nav">
  <div class="logo">
    <img src="<?php bloginfo('stylesheet_directory'); ?>/img/nav-logo.png" />
  </div>

  <div class="menu">
    <ul>
      <li>
        <a href="/games"
          <?php if(is_page('games')) { ?>class="active"<? } ?>>Games</a>
        <a href="/about"
          <?php if(is_page('about')) { ?>class="active"<? } ?>>About</a>
        <a href="/blog">Blog</a>
      </li>
    </ul>
  </div>

</div>
