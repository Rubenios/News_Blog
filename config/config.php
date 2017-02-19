
<?php
ini_set( "display_errors", true );
date_default_timezone_set( "Europe/Minsk" );
define('DB_DSN', 'mysql:host=localhost;dbname=projecthtp');
define('DB_USER', 'root');
define('DB_PASSWORD', 'Pass_not_Weak');
define('ENCODING', 'utf8');
define('TEMPLATE_PATH', 'template');
define('HOMEPAGE_NUM_ARTICLES', 6);
define('ADMIN_USERNAME', 'admin');
define('ADMIN_PASSWORD', 'mypass');


function handleException( $exception ) {
echo "Sorry, a problem occurred. Please try later.";
error_log( $exception->getMessage() );
}
set_exception_handler('handleException');