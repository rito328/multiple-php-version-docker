# multiple-php-version-docker
Starter to build Docker PHP execution environment with multiple PHP versions.

## introduction
This is useful when you want to check one PHP executable with multiple PHP versions.

## Getting started
### 1. Enter the PHP version you want to launch, separated by spaces
```bash:order.sh
PHP_VERSIONS=(7.4 7.3 7.2 7.1 7.0 5.6)
```
- Only one version should work.

### 2. to Start
```bash
sh order.sh start
```
- If the image does not exist, it will take a while to download, but it will start up faster from the second time.
- Containers are started up by the number of versions.

### 3. A message is displayed on the console and can be accessed from a browser.
```bash
+-----------------------------------+
      PHP Container is Started.
  [PHP 7.4]  http://localhost:8074
  [PHP 7.3]  http://localhost:8073
  [PHP 7.2]  http://localhost:8072
  [PHP 7.1]  http://localhost:8071
  [PHP 7.0]  http://localhost:8070
  [PHP 5.6]  http://localhost:8056
+-----------------------------------+
```

## How to use
`src/` is the document root. Just put the PHP file.

### Commands
```bash
start   : Starting Image & Container
stop    : Stop the container.
restart : Reboot the container.
destroy : Delete containers and images.
conn    : Connect to app container.
   args : [Required] In the second parameter, enter the PHP version (number) of the container you want to connect to
          exp.) PHP7.4 => 74 / `sh order.sh conn 74`
help    : Display help.
```