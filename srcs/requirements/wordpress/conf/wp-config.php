<?php
function getsecret($path) {
    if (file_exists($path))
        return (trim(file_get_contents($path)));
    return ('');
}

/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the website, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', getenv('DB_NAME') );

/** Database username */
define( 'DB_USER', getenv('DB_USER') );

/** Database password */
define( 'DB_PASSWORD', getsecret('/run/secrets/db_pwd') );

/** Database hostname */
define( 'DB_HOST', getenv('DB_HOST') );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '8?;Vl-drCHkC*a2:vW.C:,u5;eFRP}_DCeffeMhRL>m7WJdfWb C_(L3?p/90y0?');
define('SECURE_AUTH_KEY',  'gdihXe/:v|zud9rds<}&n>}c0+R -esRS6K+OZ8`MT=)#(PV=i-!gmR+pG/kQp%q');
define('LOGGED_IN_KEY',    'tYRgI7yB||*r^%M|}0jQ)_oT?9d%$3odU_w)mOZQtTy|$qCLPXlF6,lY-;rgU7d,');
define('NONCE_KEY',        '}2eI|B5rO#sde~G--LL.W}i;t&9~z]yN8+bFjSzoN&$mMfq=]KbG7b(]S|7>y+d&');
define('AUTH_SALT',        'I0nIK#9H}cz@)J;Mz5+5kqWZ|q|G.QX8EX)8,`]bg-jm+7;a|nL^zqf)>;xNsC`P');
define('SECURE_AUTH_SALT', 'ht|(DE #68iKOz8lC_suGiWg,XRv?%R.R0TD=|Byjx{d7<a5QQ:@wDc%{+h&FGk:');
define('LOGGED_IN_SALT',   'vd/I``+4:|9[D>Hhj}^:OV-=rVWCCK3FzdI_UtXf{Z+_L9!#W:=G!O_=|pP}*(A4');
define('NONCE_SALT',       '}`hkY6YyCp9,5.K3*3npHe|-qgcQ3(tU=<]MI-4}=71oaBI[CBsV/&?4D!;=paY_');

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 *
 * At the installation time, database tables are created with the specified prefix.
 * Changing this value after WordPress is installed will make your site think
 * it has not been installed.
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/#table-prefix
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://developer.wordpress.org/advanced-administration/debug/debug-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
        define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
?>
