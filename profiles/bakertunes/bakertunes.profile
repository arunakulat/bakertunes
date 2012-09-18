<?php
/**
 * @file
 * Enables modules and site configuration for a minimal site installation, ready
 * for migration tasks.
 */

/**
 * Implements hook_form_FORM_ID_alter() for install_configure_form().
 *
 * Allows the profile to alter the site configuration form.
 */
function bakertunes_form_install_configure_form_alter(&$form, $form_state) {
  // Pre-populate the site name with the server name.
  $form['site_information']['site_name']['#default_value'] = 'Bakertunes';
}


function bakertunes_install_tasks() {
  $tasks['features_pass_one'] = array(
    'display_name' => st('Enable first wave of modules and features'),
    'display' => TRUE,
    'type' => 'normal',
    'run' => INSTALL_TASK_RUN_IF_NOT_COMPLETED,
    'function' => 'bakertunes_enable_features_pass_one',
  );

  $tasks['features_pass_two'] = array(
    'display_name' => st('Enable second wave of modules and features'),
    'display' => TRUE,
    'type' => 'normal',
    'run' => INSTALL_TASK_RUN_IF_NOT_COMPLETED,
    'function' => 'bakertunes_enable_features_pass_two',
  );

  $tasks['features_pass_three'] = array(
    'display_name' => st('Enable third wave of modules and features'),
    'display' => TRUE,
    'type' => 'normal',
    'run' => INSTALL_TASK_RUN_IF_NOT_COMPLETED,
    'function' => 'bakertunes_enable_features_pass_three',
  );

 return $tasks;
}

function bakertunes_enable_features_pass_one() {
  $module_list = array(
    'custom_breadcrumbs_views',
    'custom_breadcrumbs_paths',
    'custom_breadcrumbs_taxonomy',

    );
  module_enable($module_list);
}

function bakertunes_enable_features_pass_two() {

}

function bakertunes_enable_features_pass_three() {
  // @see http://www.computerminds.co.uk/articles/setting-default-theme-during-installation
  // Any themes without keys here will get numeric keys and so will be enabled,
  // but not placed into variables.
  $enable = array(
    'theme_default' => 'tuner',
    'admin_theme' => 'seven',
  );
  // enable themes
  theme_enable($enable);

  // set variables for enabled themes
  foreach ($enable as $var => $theme) {
    if (!is_numeric($var)) {
      variable_set($var, $theme);
    }
  }

  // Disable the default Bartik theme
  theme_disable(array('bartik'));
}