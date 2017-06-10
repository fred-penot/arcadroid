cd /var/www/html
git clone https://github.com/fred-penot/arcadroid.git
cd /var/www/html/arcadroid
/usr/local/zend/bin/php composer install
rm -f /var/www/html/arcadroid/vendor/knplabs/console-service-provider/Knp/Provider/ConsoleServiceProvider.php
cp /var/www/html/arcadroid/app/doc/ConsoleServiceProvider.php /var/www/html/arcadroid/vendor/knplabs/console-service-provider/Knp/Provider/
chmod -Rf 777 /var/www/html/arcadroid