<?php if (count($currencies) > 1) { ?>
<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-currency">
  <div class="box-currency">
  <!--<label><?php echo $text_currency; ?></label>-->
    <div class="list-inline">
    
    <?php foreach ($currencies as $currency) { ?>
    <?php if ($currency['symbol_left']) { ?>
    <button class="currency-select" name="<?php echo $currency['code']; ?>" type="button"><?php echo $currency['symbol_left']; ?> </button>
    <?php } else { ?>
    <button class="currency-select" name="<?php echo $currency['code']; ?>" type="button"><?php echo $currency['symbol_right']; ?> </button>
    <?php } ?>
    <?php } ?>
   
    <input type="hidden" name="code" value= "" />
    <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
    </div>
  </div>
</form>
<?php } ?>