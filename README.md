# PHPUnit with Xdebug 

### Testing and debugging PHP in a Docker Container

![Docker Stars](https://img.shields.io/docker/stars/fatindeed/phpunit.svg) ![Docker Pulls](https://img.shields.io/docker/pulls/fatindeed/phpunit.svg) ![Docker Automated build](https://img.shields.io/docker/automated/fatindeed/phpunit.svg) ![Docker Build Status](https://img.shields.io/docker/build/fatindeed/phpunit.svg)

## Supported platforms

![](https://img.shields.io/badge/windows-tested-brightgreen.svg) ![](https://img.shields.io/badge/macos-tested-brightgreen.svg) ![](https://img.shields.io/badge/linux-not%20tested-red.svg)

## PHPUnit 8 ![](https://img.shields.io/badge/image%20tag-8-blue.svg) ![](https://img.shields.io/badge/image%20tag-latest-blue.svg)

![](https://img.shields.io/microbadger/image-size/fatindeed/phpunit/8.svg) ![](https://img.shields.io/microbadger/layers/fatindeed/phpunit/8.svg)

## PHPUnit 5 ![](https://img.shields.io/badge/image%20tag-5-blue.svg)

![](https://img.shields.io/microbadger/image-size/fatindeed/phpunit/5.svg) ![](https://img.shields.io/microbadger/layers/fatindeed/phpunit/5.svg)

## VS Code User Guide

1.  [PHP Debug](https://marketplace.visualstudio.com/items?itemName=felixfbecker.php-debug) extension is required.

2.  Read [Debugging in Visual Studio Code](https://code.visualstudio.com/docs/editor/debugging) first.

3.  Open your project. Here we open the [demo](https://github.com/fatindeed/docker-phpunit/blob/master/demo/) folder for example.

    ```sh
    cd demo
    code .
    ```

4.  Assign execute permission to shell scripts.

    ```sh
    chmod a+x scripts/*.sh
    ```

4.  **Run tests for currently open script**

    Open any test file, like `tests/BankAccountTest.php`. Pressing <kbd>Ctrl</kbd> / <kbd>⌘</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> and typing `Run Test Task`.

5.  **Run tests for workspace**.

    Pressing <kbd>Ctrl</kbd> / <kbd>⌘</kbd> + <kbd>Shift</kbd> + <kbd>B</kbd>.

6.  **Debugging**

    Pressing <kbd>F5</kbd> to start debugging.

*PS: All these hot keys may be different on your machine.*

## Configurations

Edit [config.sh](https://github.com/fatindeed/docker-phpunit/blob/master/demo/scripts/config.sh) file to change your settings.

*   IMAGE_TAG

    use tags provided above

*   LOCALHOST

    Your host ip address.
    If you are using **Docker Desktop for Windows/Mac**, `host.docker.internal` should work.
    If you are using **Docker Toolbox**, `192.168.99.1` should work if you havn't change VirtualBox network configuration.

*   TIMEZONE

    Your own timezone.

## Reference

- [PHP Debugging with PHP Debug and XDebug](https://github.com/Microsoft/vscode-recipes/tree/master/PHP)
- [Visual Studio Code Variables Reference](https://code.visualstudio.com/docs/editor/variables-reference)